From: Yixun Lan <yixun.lan@gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: add support for descriptor chain mode
Date: Sun, 16 Apr 2017 21:18:27 +0800
Message-ID: <CALecT5hwLLk36c58MJs3q3NJdYr20sU6nMpxw3vkVjEcs_AVXw@mail.gmail.com>
References: <214d58f4-9368-8cea-4f30-841dfaae780e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34066 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754961AbdDPNS3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2017 09:18:29 -0400
Received: by mail-qt0-f194.google.com with SMTP id y33so1874670qta.1
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2017 06:18:28 -0700 (PDT)
In-Reply-To: <214d58f4-9368-8cea-4f30-841dfaae780e@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org, Helmut Klein <hgkr.klein@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, Apr 8, 2017 at 3:22 AM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> So far a bounce buffer is used to serialize the scatterlist(s).
> This overhead can be avoided by switching to descriptor chain mode.
> As result the performance is drastically improved. On a Odroid-C2 with
> a 128 GB eMMC module raw reads reach 140 MB/s.
>
> Prerequisite for descriptor chain mode is that all scatterlist buffers
> are 8 byte aligned for 64-bit DMA. That's not always the case, at least
> the brcmfmac SDIO WiFi driver is known to cause problems.
>
> Therefore, for each request, check upfront whether all scatterlist
> buffers are 8 byte aligned and fall back to bounce buffer mode if
> that's not the case.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 172 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 156 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index eb5ee68d..1842ed34 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -111,6 +111,11 @@
>  #define SD_EMMC_CMD_TIMEOUT 1024 /* in ms */
>  #define SD_EMMC_CMD_TIMEOUT_DATA 4096 /* in ms */
>  #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
> +#define SD_EMMC_DESC_BUF_LEN PAGE_SIZE
> +
> +#define SD_EMMC_PRE_REQ_DONE BIT(0)
> +#define SD_EMMC_DESC_CHAIN_MODE BIT(1)
> +
>  #define MUX_CLK_NUM_PARENTS 2
>
>  struct meson_tuning_params {
> @@ -119,6 +124,13 @@ struct meson_tuning_params {
>         u8 rx_phase;
>  };
>
> +struct sd_emmc_desc {
> +       u32 cmd_cfg;
> +       u32 cmd_arg;
> +       u32 cmd_data;
> +       u32 cmd_resp;
> +};
> +
>  struct meson_host {
>         struct  device          *dev;
>         struct  mmc_host        *mmc;
> @@ -137,18 +149,13 @@ struct meson_host {
>         unsigned int bounce_buf_size;
>         void *bounce_buf;
>         dma_addr_t bounce_dma_addr;
> +       struct sd_emmc_desc *descs;
> +       dma_addr_t descs_dma_addr;
>
>         struct meson_tuning_params tp;
>         bool vqmmc_enabled;
>  };
>
> -struct sd_emmc_desc {
> -       u32 cmd_cfg;
> -       u32 cmd_arg;
> -       u32 cmd_data;
> -       u32 cmd_resp;
> -};
> -
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
>  #define CMD_CFG_BLOCK_MODE BIT(9)
>  #define CMD_CFG_R1B BIT(10)
> @@ -195,6 +202,66 @@ static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
>                 return NULL;
>  }
>
> +static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
> +                                       struct mmc_request *mrq)
> +{
> +       struct mmc_data *data = mrq->data;
> +       struct scatterlist *sg;
> +       int i;
> +       bool use_desc_chain_mode = true;
> +
> +       for_each_sg(data->sg, sg, data->sg_len, i)
> +               /* check for 8 byte alignment */
> +               if (sg->offset & 7) {
> +                       WARN_ONCE(1, "unaligned scatterlist buffer\n");
> +                       use_desc_chain_mode = false;
> +                       break;
> +               }
> +
> +       if (use_desc_chain_mode)
> +               data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
> +}
> +
> +static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
> +{
> +       return data->host_cookie & SD_EMMC_DESC_CHAIN_MODE;
> +}
> +
> +static inline bool meson_mmc_bounce_buf_read(const struct mmc_data *data)
> +{
> +       return data && data->flags & MMC_DATA_READ &&
> +              !meson_mmc_desc_chain_mode(data);
> +}
> +
> +static void meson_mmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct mmc_data *data = mrq->data;
> +
> +       if (!data)
> +               return;
> +
> +       meson_mmc_get_transfer_mode(mmc, mrq);
> +       data->host_cookie |= SD_EMMC_PRE_REQ_DONE;
> +
> +       if (!meson_mmc_desc_chain_mode(data))
> +               return;
> +
> +       data->sg_count = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
> +                                   mmc_get_dma_dir(data));
> +       if (!data->sg_count)
> +               dev_err(mmc_dev(mmc), "dma_map_sg failed");
> +}
> +
> +static void meson_mmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
> +                              int err)
> +{
> +       struct mmc_data *data = mrq->data;
> +
> +       if (data && meson_mmc_desc_chain_mode(data) && data->sg_count)
> +               dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
> +                            mmc_get_dma_dir(data));
> +}
> +
>  static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
>  {
>         struct mmc_host *mmc = host->mmc;
> @@ -509,6 +576,44 @@ static void meson_mmc_set_response_bits(struct mmc_command *cmd, u32 *cmd_cfg)
>         }
>  }
>
> +static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
> +{
> +       struct meson_host *host = mmc_priv(mmc);
> +       struct sd_emmc_desc *desc = host->descs;
> +       struct mmc_data *data = host->cmd->data;
> +       struct scatterlist *sg;
> +       u32 start;
> +       int i;
> +
> +       if (data->flags & MMC_DATA_WRITE)
> +               cmd_cfg |= CMD_CFG_DATA_WR;
> +
> +       if (data->blocks > 1) {
> +               cmd_cfg |= CMD_CFG_BLOCK_MODE;
> +               meson_mmc_set_blksz(mmc, data->blksz);
> +       }
> +
> +       for_each_sg(data->sg, sg, data->sg_count, i) {
> +               unsigned int len = sg_dma_len(sg);
> +
> +               if (data->blocks > 1)
> +                       len /= data->blksz;
> +
> +               desc[i].cmd_cfg = cmd_cfg;
> +               desc[i].cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK, len);
> +               if (i > 0)
> +                       desc[i].cmd_cfg |= CMD_CFG_NO_CMD;
> +               desc[i].cmd_arg = host->cmd->arg;
> +               desc[i].cmd_resp = 0;
> +               desc[i].cmd_data = sg_dma_address(sg);
> +       }
> +       desc[data->sg_count - 1].cmd_cfg |= CMD_CFG_END_OF_CHAIN;
> +
> +       dma_wmb(); /* ensure descriptor is written before kicked */
> +       start = host->descs_dma_addr | START_DESC_BUSY;
> +       writel(start, host->regs + SD_EMMC_START);
> +}
> +
>  static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>         struct meson_host *host = mmc_priv(mmc);
> @@ -519,6 +624,8 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>         /* Setup descriptors */
>         dma_rmb();
>
> +       host->cmd = cmd;
> +
>         cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>         cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>
> @@ -526,10 +633,16 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>
>         /* data? */
>         if (data) {
> +               data->bytes_xfered = 0;
>                 cmd_cfg |= CMD_CFG_DATA_IO;
>                 cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,
>                                       ilog2(meson_mmc_get_timeout_msecs(data)));
>
> +               if (meson_mmc_desc_chain_mode(data)) {
> +                       meson_mmc_desc_chain_transfer(mmc, cmd_cfg);
> +                       return;
> +               }
> +
>                 if (data->blocks > 1) {
>                         cmd_cfg |= CMD_CFG_BLOCK_MODE;
>                         cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK,
> @@ -539,7 +652,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>                         cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK, data->blksz);
>                 }
>
> -               data->bytes_xfered = 0;
>                 xfer_bytes = data->blksz * data->blocks;
>                 if (data->flags & MMC_DATA_WRITE) {
>                         cmd_cfg |= CMD_CFG_DATA_WR;
> @@ -555,8 +667,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>                                       ilog2(SD_EMMC_CMD_TIMEOUT));
>         }
>
> -       host->cmd = cmd;
> -
>         /* Last descriptor */
>         cmd_cfg |= CMD_CFG_END_OF_CHAIN;
>         writel(cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
> @@ -569,14 +679,25 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct meson_host *host = mmc_priv(mmc);
> +       bool needs_pre_post_req = mrq->data &&
> +                       !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
> +
> +       if (needs_pre_post_req) {
> +               meson_mmc_get_transfer_mode(mmc, mrq);
> +               if (!meson_mmc_desc_chain_mode(mrq->data))
> +                       needs_pre_post_req = false;
> +       }
> +
> +       if (needs_pre_post_req)
> +               meson_mmc_pre_req(mmc, mrq);
>
>         /* Stop execution */
>         writel(0, host->regs + SD_EMMC_START);
>
> -       if (mrq->sbc)
> -               meson_mmc_start_cmd(mmc, mrq->sbc);
> -       else
> -               meson_mmc_start_cmd(mmc, mrq->cmd);
> +       meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> +
> +       if (needs_pre_post_req)
> +               meson_mmc_post_req(mmc, mrq, 0);
>  }
>
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
> @@ -654,7 +775,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
>                 if (data && !cmd->error)
>                         data->bytes_xfered = data->blksz * data->blocks;
> -               ret = IRQ_WAKE_THREAD;
> +               if (meson_mmc_bounce_buf_read(data) ||
> +                   meson_mmc_get_next_command(cmd))
> +                       ret = IRQ_WAKE_THREAD;
>         } else {
>                 dev_warn(host->dev, "Unknown IRQ! status=0x%04x: MMC CMD%u arg=0x%08x flags=0x%08x stop=%d\n",
>                          status, cmd->opcode, cmd->arg,
> @@ -691,7 +814,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>                 return IRQ_NONE;
>
>         data = cmd->data;
> -       if (data && data->flags & MMC_DATA_READ) {
> +       if (meson_mmc_bounce_buf_read(data)) {
>                 xfer_bytes = data->blksz * data->blocks;
>                 WARN_ON(xfer_bytes > host->bounce_buf_size);
>                 sg_copy_from_buffer(data->sg, data->sg_len,
> @@ -760,6 +883,8 @@ static const struct mmc_host_ops meson_mmc_ops = {
>         .request        = meson_mmc_request,
>         .set_ios        = meson_mmc_set_ios,
>         .get_cd         = meson_mmc_get_cd,
> +       .pre_req        = meson_mmc_pre_req,
> +       .post_req       = meson_mmc_post_req,
>         .execute_tuning = meson_mmc_execute_tuning,
>  };
>
> @@ -845,6 +970,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         mmc->caps |= MMC_CAP_CMD23;
>         mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
>         mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
> +       mmc->max_segs = SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
> +       mmc->max_seg_size = mmc->max_req_size;
>
>         /* data bounce buffer */
>         host->bounce_buf_size = mmc->max_req_size;
> @@ -857,11 +984,22 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 goto err_div_clk;
>         }
>
> +       host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
> +                     &host->descs_dma_addr, GFP_KERNEL);
> +       if (!host->descs) {
> +               dev_err(host->dev, "Allocating descriptor DMA buffer failed\n");
> +               ret = -ENOMEM;
> +               goto err_bounce_buf;
> +       }
> +
>         mmc->ops = &meson_mmc_ops;
>         mmc_add_host(mmc);
>
>         return 0;
>
> +err_bounce_buf:
> +       dma_free_coherent(host->dev, host->bounce_buf_size,
> +                         host->bounce_buf, host->bounce_dma_addr);
>  err_div_clk:
>         clk_disable_unprepare(host->cfg_div_clk);
>  err_core_clk:
> @@ -880,6 +1018,8 @@ static int meson_mmc_remove(struct platform_device *pdev)
>         /* disable interrupts */
>         writel(0, host->regs + SD_EMMC_IRQ_EN);
>
> +       dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
> +                         host->descs, host->descs_dma_addr);
>         dma_free_coherent(host->dev, host->bounce_buf_size,
>                           host->bounce_buf, host->bounce_dma_addr);
>
> --
> 2.12.2
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

hello all:

  will this patch be merged (or was this already done)?

  I think "the descriptor chain mode" will significant improve the
performance as it avoid bounce buffer at most cases, although
we still carry code which handle <8bytes alignment (we should have no
problem with it)..
   thanks

Yixun
