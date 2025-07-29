# import libraries

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

# read in rna and chipseq
rna_seq = pd.read_table("GSE75070_MCF7_shRUNX1_shNS_RNAseq_log2_foldchange.txt")
chip_seq = pd.read_table("./results/annotated_peaks.txt")

upreg_genes = list(rna_seq[(rna_seq["log2FoldChange"] > 1) & (rna_seq["padj"] < 0.01)]["genename"])
downreg_genes = list(rna_seq[(rna_seq["log2FoldChange"] < -1) & (rna_seq["padj"] < 0.01)]["genename"])

# filter up and downregulated genes in chipseq data
all_upreg = chip_seq.query("`Gene Name` in @upreg_genes")
all_downreg = chip_seq.query("`Gene Name` in @downreg_genes")

# TSS distance filtering
upreg_5 = all_upreg[(all_upreg["Distance to TSS"] > -5000) & (all_upreg["Distance to TSS"] < 5000)]
upreg_20 = all_upreg[(all_upreg["Distance to TSS"] > -20000) & (all_upreg["Distance to TSS"] < 20000)]
downreg_5 = all_downreg[(all_downreg["Distance to TSS"] > -5000) & (all_downreg["Distance to TSS"] < 5000)]
downreg_20 = all_downreg[(all_downreg["Distance to TSS"] > -20000) & (all_downreg["Distance to TSS"] < 20000)]

# total counts
total_up = len(all_upreg)
total_down = len(all_downreg)

# upregulated percentages
within_5_up = len(upreg_5)
within_20_up = len(upreg_20)
outside_5_up = total_up - within_5_up
outside_20_up = total_up - within_20_up

within_5_pct_up = 100 * within_5_up / total_up
outside_5_pct_up = 100 * outside_5_up / total_up
within_20_pct_up = 100 * within_20_up / total_up
outside_20_pct_up = 100 * outside_20_up / total_up

# downregulated percentages
within_5_down = len(downreg_5)
within_20_down = len(downreg_20)
outside_5_down = total_down - within_5_down
outside_20_down = total_down - within_20_down

within_5_pct_down = 100 * within_5_down / total_down
outside_5_pct_down = 100 * outside_5_down / total_down
within_20_pct_down = 100 * within_20_down / total_down
outside_20_pct_down = 100 * outside_20_down / total_down

labels = ['Up ±5kb', 'Down ±5kb', 'Up ±20kb', 'Down ±20kb']
within = [within_5_pct_up, within_5_pct_down, within_20_pct_up, within_20_pct_down]
outside = [outside_5_pct_up, outside_5_pct_down, outside_20_pct_up, outside_20_pct_down]
colors = ['blue', 'blue']

# plot
fig, ax = plt.subplots(figsize=(8, 6))
ax.bar(labels, within, color=colors * 2, label='RUNX1 bound')
ax.bar(labels, outside, bottom=within, color='lightgray', label='Not Bound')
ax.set_ylabel('% of Genes')
ax.set_title('TSS Proximity of Up/Downregulated Genes (ChIP-seq)')
ax.legend()
plt.ylim(0, 110)
plt.tight_layout()
plt.show()