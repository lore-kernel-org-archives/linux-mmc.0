From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: mediatek: add 64G DRAM DMA support
Date: Fri, 27 Apr 2018 14:05:08 +0200
Message-ID: <CAPDyKFocJrbH2AGER3mwdCyzOnRfNC6peG_ZeHrKUA_voxM=dQ@mail.gmail.com>
References: <1524640743-11732-1-git-send-email-chaotian.jing@mediatek.com> <1524640743-11732-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524640743-11732-2-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Phong LE <ple@baylibre.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Heiner Kallweit <hkallweit1@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, yong mao <yong.mao@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On 25 April 2018 at 09:19, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> MT2712 MSDC supports 64G DRAM DMA access, it needs update
> gpd/bd structure.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 56 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index d642e11..0484138 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -71,6 +71,7 @@
>  #define SDC_ADV_CFG0     0x64
>  #define EMMC_IOCON       0x7c
>  #define SDC_ACMD_RESP    0x80
> +#define DMA_SA_H4BIT     0x8c
>  #define MSDC_DMA_SA      0x90
>  #define MSDC_DMA_CTRL    0x98
>  #define MSDC_DMA_CFG     0x9c
> @@ -195,6 +196,9 @@
>  /* SDC_ADV_CFG0 mask */
>  #define SDC_RX_ENHANCE_EN      (0x1 << 20)     /* RW */
>
> +/* DMA_SA_H4BIT mask */
> +#define DMA_ADDR_HIGH_4BIT      (0xf << 0)      /* RW */
> +
>  /* MSDC_DMA_CTRL mask */
>  #define MSDC_DMA_CTRL_START     (0x1 << 0)     /* W */
>  #define MSDC_DMA_CTRL_STOP      (0x1 << 1)     /* W */
> @@ -228,6 +232,7 @@
>
>  #define MSDC_PATCH_BIT2_CFGRESP   (0x1 << 15)   /* RW */
>  #define MSDC_PATCH_BIT2_CFGCRCSTS (0x1 << 28)   /* RW */
> +#define MSDC_PB2_SUPPORT_64G      (0x1 << 1)    /* RW */
>  #define MSDC_PB2_RESPWAIT         (0x3 << 2)    /* RW */
>  #define MSDC_PB2_RESPSTSENSEL     (0x7 << 16)   /* RW */
>  #define MSDC_PB2_CRCSTSENSEL      (0x7 << 29)   /* RW */
> @@ -281,6 +286,8 @@ struct mt_gpdma_desc {
>  #define GPDMA_DESC_BDP         (0x1 << 1)
>  #define GPDMA_DESC_CHECKSUM    (0xff << 8) /* bit8 ~ bit15 */
>  #define GPDMA_DESC_INT         (0x1 << 16)
> +#define GPDMA_DESC_NEXT_H4     (0xf << 24)
> +#define GPDMA_DESC_PTR_H4      (0xf << 28)
>         u32 next;
>         u32 ptr;
>         u32 gpd_data_len;
> @@ -297,6 +304,8 @@ struct mt_bdma_desc {
>  #define BDMA_DESC_CHECKSUM     (0xff << 8) /* bit8 ~ bit15 */
>  #define BDMA_DESC_BLKPAD       (0x1 << 17)
>  #define BDMA_DESC_DWPAD                (0x1 << 18)
> +#define BDMA_DESC_NEXT_H4      (0xf << 24)
> +#define BDMA_DESC_PTR_H4       (0xf << 28)
>         u32 next;
>         u32 ptr;
>         u32 bd_data_len;
> @@ -335,6 +344,7 @@ struct mtk_mmc_compatible {
>         bool busy_check;
>         bool stop_clk_fix;
>         bool enhance_rx;
> +       bool support_64g;
>  };
>
>  struct msdc_tune_para {
> @@ -404,6 +414,7 @@ struct msdc_host {
>         .busy_check = false,
>         .stop_clk_fix = false,
>         .enhance_rx = false,
> +       .support_64g = false,
>  };
>
>  static const struct mtk_mmc_compatible mt8173_compat = {
> @@ -415,6 +426,7 @@ struct msdc_host {
>         .busy_check = false,
>         .stop_clk_fix = false,
>         .enhance_rx = false,
> +       .support_64g = false,
>  };
>
>  static const struct mtk_mmc_compatible mt2701_compat = {
> @@ -426,6 +438,7 @@ struct msdc_host {
>         .busy_check = false,
>         .stop_clk_fix = false,
>         .enhance_rx = false,
> +       .support_64g = false,
>  };
>
>  static const struct mtk_mmc_compatible mt2712_compat = {
> @@ -437,6 +450,7 @@ struct msdc_host {
>         .busy_check = true,
>         .stop_clk_fix = true,
>         .enhance_rx = true,
> +       .support_64g = true,
>  };
>
>  static const struct mtk_mmc_compatible mt7622_compat = {
> @@ -448,6 +462,7 @@ struct msdc_host {
>         .busy_check = true,
>         .stop_clk_fix = true,
>         .enhance_rx = true,
> +       .support_64g = false,
>  };
>
>  static const struct of_device_id msdc_of_ids[] = {
> @@ -557,7 +572,12 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
>                 /* init bd */
>                 bd[j].bd_info &= ~BDMA_DESC_BLKPAD;
>                 bd[j].bd_info &= ~BDMA_DESC_DWPAD;
> -               bd[j].ptr = (u32)dma_address;
> +               bd[j].ptr = lower_32_bits(dma_address);
> +               if (host->dev_comp->support_64g) {
> +                       bd[j].bd_info &= ~BDMA_DESC_PTR_H4;
> +                       bd[j].bd_info |= (upper_32_bits(dma_address) & 0xf)
> +                                        << 28;
> +               }
>                 bd[j].bd_data_len &= ~BDMA_DESC_BUFLEN;
>                 bd[j].bd_data_len |= (dma_len & BDMA_DESC_BUFLEN);
>
> @@ -576,7 +596,10 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
>         dma_ctrl &= ~(MSDC_DMA_CTRL_BRUSTSZ | MSDC_DMA_CTRL_MODE);
>         dma_ctrl |= (MSDC_BURST_64B << 12 | 1 << 8);
>         writel_relaxed(dma_ctrl, host->base + MSDC_DMA_CTRL);
> -       writel((u32)dma->gpd_addr, host->base + MSDC_DMA_SA);
> +       if (host->dev_comp->support_64g)
> +               sdr_set_field(host->base + DMA_SA_H4BIT, DMA_ADDR_HIGH_4BIT,
> +                             upper_32_bits(dma->gpd_addr) & 0xf);
> +       writel(lower_32_bits(dma->gpd_addr), host->base + MSDC_DMA_SA);
>  }
>
>  static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
> @@ -1367,6 +1390,9 @@ static void msdc_init_hw(struct msdc_host *host)
>                              MSDC_PATCH_BIT2_CFGCRCSTS);
>         }
>
> +       if (host->dev_comp->support_64g)
> +               sdr_set_bits(host->base + MSDC_PATCH_BIT2,
> +                            MSDC_PB2_SUPPORT_64G);
>         if (host->dev_comp->data_tune) {
>                 sdr_set_bits(host->base + tune_reg,
>                              MSDC_PAD_TUNE_RD_SEL | MSDC_PAD_TUNE_CMD_SEL);
> @@ -1408,19 +1434,32 @@ static void msdc_init_gpd_bd(struct msdc_host *host, struct msdc_dma *dma)
>  {
>         struct mt_gpdma_desc *gpd = dma->gpd;
>         struct mt_bdma_desc *bd = dma->bd;
> +       dma_addr_t dma_addr;
>         int i;
>
>         memset(gpd, 0, sizeof(struct mt_gpdma_desc) * 2);
>
> +       dma_addr = dma->gpd_addr + sizeof(struct mt_gpdma_desc);
>         gpd->gpd_info = GPDMA_DESC_BDP; /* hwo, cs, bd pointer */
> -       gpd->ptr = (u32)dma->bd_addr; /* physical address */
>         /* gpd->next is must set for desc DMA
>          * That's why must alloc 2 gpd structure.
>          */
> -       gpd->next = (u32)dma->gpd_addr + sizeof(struct mt_gpdma_desc);
> +       gpd->next = lower_32_bits(dma_addr);
> +       if (host->dev_comp->support_64g)
> +               gpd->gpd_info |= (upper_32_bits(dma_addr) & 0xf) << 24;
> +
> +       dma_addr = dma->bd_addr;
> +       gpd->ptr = lower_32_bits(dma->bd_addr); /* physical address */
> +       if (host->dev_comp->support_64g)
> +               gpd->gpd_info |= (upper_32_bits(dma_addr) & 0xf) << 28;
> +
>         memset(bd, 0, sizeof(struct mt_bdma_desc) * MAX_BD_NUM);
> -       for (i = 0; i < (MAX_BD_NUM - 1); i++)
> -               bd[i].next = (u32)dma->bd_addr + sizeof(*bd) * (i + 1);
> +       for (i = 0; i < (MAX_BD_NUM - 1); i++) {
> +               dma_addr = dma->bd_addr + sizeof(*bd) * (i + 1);
> +               bd[i].next = lower_32_bits(dma_addr);
> +               if (host->dev_comp->support_64g)
> +                       bd[i].bd_info |= (upper_32_bits(dma_addr) & 0xf) << 24;
> +       }
>  }
>
>  static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> @@ -1913,7 +1952,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         mmc->max_blk_size = 2048;
>         mmc->max_req_size = 512 * 1024;
>         mmc->max_blk_count = mmc->max_req_size / 512;
> -       host->dma_mask = DMA_BIT_MASK(32);
> +       if (host->dev_comp->support_64g)
> +               host->dma_mask = DMA_BIT_MASK(36);
> +       else
> +               host->dma_mask = DMA_BIT_MASK(32);
>         mmc_dev(mmc)->dma_mask = &host->dma_mask;
>
>         host->timeout_clks = 3 * 1048576;
> --
> 1.8.1.1.dirty
>
