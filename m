From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [RFC PATCH] mmc: dw_mmc: remove the prefix "SDMMC_##" into mci_read/write
Date: Fri, 15 Jan 2016 18:50:48 +0530
Message-ID: <CAGOxZ53SsR6twPsAj==FJFj4-skbxV1FC1hfM2usioTEWM7cQQ@mail.gmail.com>
References: <569379BE.8070907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33163 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610AbcAONV3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2016 08:21:29 -0500
Received: by mail-io0-f181.google.com with SMTP id q21so486045564iod.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2016 05:21:28 -0800 (PST)
In-Reply-To: <569379BE.8070907@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>

Hi Jaehoon,

On Mon, Jan 11, 2016 at 3:15 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> It's fixed "SDMMC_##" as prefix into mci_read/write.
> So it's difficult to debug or read which offset is used.
> If it's passed by original defined register name, it can be checked
> which offset is used, and more readability than now.
>

>From commit message it is not clear what problem/difficulty you faced
with the current setup?
and how does this patch help to resolve the same?
Can you put some more light on the same?


> There is no benefit to use "SDMMC_##" into mci_read/write.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |  62 ++++-----
>  drivers/mmc/host/dw_mmc.c        | 268 +++++++++++++++++++--------------------
>  drivers/mmc/host/dw_mmc.h        |  16 +--
>  3 files changed, 172 insertions(+), 174 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 3a7e835..7f7246a 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -86,9 +86,9 @@ static inline u8 dw_mci_exynos_get_ciu_div(struct dw_mci *host)
>                 return EXYNOS4210_FIXED_CIU_CLK_DIV;
>         else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                         priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL64)) + 1;
> +               return SDMMC_CLKSEL_GET_DIV(mci_readl(host, SDMMC_CLKSEL64)) + 1;
>         else
> -               return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL)) + 1;
> +               return SDMMC_CLKSEL_GET_DIV(mci_readl(host, SDMMC_CLKSEL)) + 1;
>  }
>
>  static int dw_mci_exynos_priv_init(struct dw_mci *host)
> @@ -97,19 +97,19 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
> -               mci_writel(host, MPSBEGIN0, 0);
> -               mci_writel(host, MPSEND0, SDMMC_ENDING_SEC_NR_MAX);
> -               mci_writel(host, MPSCTRL0, SDMMC_MPSCTRL_SECURE_WRITE_BIT |
> +               mci_writel(host, SDMMC_MPSBEGIN0, 0);
> +               mci_writel(host, SDMMC_MPSEND0, SDMMC_ENDING_SEC_NR_MAX);
> +               mci_writel(host, SDMMC_MPSCTRL0, SDMMC_MPSCTRL_SECURE_WRITE_BIT |
>                            SDMMC_MPSCTRL_NON_SECURE_READ_BIT |
>                            SDMMC_MPSCTRL_VALID |
>                            SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
>         }
>
>         if (priv->ctrl_type >= DW_MCI_TYPE_EXYNOS5420) {
> -               priv->saved_strobe_ctrl = mci_readl(host, HS400_DLINE_CTRL);
> -               priv->saved_dqs_en = mci_readl(host, HS400_DQS_EN);
> +               priv->saved_strobe_ctrl = mci_readl(host, SDMMC_HS400_DLINE_CTRL);
> +               priv->saved_dqs_en = mci_readl(host, SDMMC_HS400_DQS_EN);
>                 priv->saved_dqs_en |= AXI_NON_BLOCKING_WR;
> -               mci_writel(host, HS400_DQS_EN, priv->saved_dqs_en);
> +               mci_writel(host, SDMMC_HS400_DQS_EN, priv->saved_dqs_en);
>                 if (!priv->dqs_delay)
>                         priv->dqs_delay =
>                                 DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
> @@ -134,17 +134,17 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
>
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               clksel = mci_readl(host, CLKSEL64);
> +               clksel = mci_readl(host, SDMMC_CLKSEL64);
>         else
> -               clksel = mci_readl(host, CLKSEL);
> +               clksel = mci_readl(host, SDMMC_CLKSEL);
>
>         clksel = (clksel & ~SDMMC_CLKSEL_TIMING_MASK) | timing;
>
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               mci_writel(host, CLKSEL64, clksel);
> +               mci_writel(host, SDMMC_CLKSEL64, clksel);
>         else
> -               mci_writel(host, CLKSEL, clksel);
> +               mci_writel(host, SDMMC_CLKSEL, clksel);
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> @@ -182,16 +182,16 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
>
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               clksel = mci_readl(host, CLKSEL64);
> +               clksel = mci_readl(host, SDMMC_CLKSEL64);
>         else
> -               clksel = mci_readl(host, CLKSEL);
> +               clksel = mci_readl(host, SDMMC_CLKSEL);
>
>         if (clksel & SDMMC_CLKSEL_WAKEUP_INT) {
>                 if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                         priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -                       mci_writel(host, CLKSEL64, clksel);
> +                       mci_writel(host, SDMMC_CLKSEL64, clksel);
>                 else
> -                       mci_writel(host, CLKSEL, clksel);
> +                       mci_writel(host, SDMMC_CLKSEL, clksel);
>         }
>
>         return 0;
> @@ -214,10 +214,10 @@ static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>          */
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
> -               if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL64)))
> +               if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, SDMMC_CLKSEL64)))
>                         *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>          } else {
> -               if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
> +               if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, SDMMC_CLKSEL)))
>                         *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>         }
>  }
> @@ -244,8 +244,8 @@ static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
>                 dqs &= ~DATA_STROBE_EN;
>         }
>
> -       mci_writel(host, HS400_DQS_EN, dqs);
> -       mci_writel(host, HS400_DLINE_CTRL, strobe);
> +       mci_writel(host, SDMMC_HS400_DQS_EN, dqs);
> +       mci_writel(host, SDMMC_HS400_DLINE_CTRL, strobe);
>  }
>
>  static void dw_mci_exynos_adjust_clock(struct dw_mci *host, unsigned int wanted)
> @@ -373,9 +373,9 @@ static inline u8 dw_mci_exynos_get_clksmpl(struct dw_mci *host)
>
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, CLKSEL64));
> +               return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, SDMMC_CLKSEL64));
>         else
> -               return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, CLKSEL));
> +               return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, SDMMC_CLKSEL));
>  }
>
>  static inline void dw_mci_exynos_set_clksmpl(struct dw_mci *host, u8 sample)
> @@ -385,15 +385,15 @@ static inline void dw_mci_exynos_set_clksmpl(struct dw_mci *host, u8 sample)
>
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               clksel = mci_readl(host, CLKSEL64);
> +               clksel = mci_readl(host, SDMMC_CLKSEL64);
>         else
> -               clksel = mci_readl(host, CLKSEL);
> +               clksel = mci_readl(host, SDMMC_CLKSEL);
>         clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               mci_writel(host, CLKSEL64, clksel);
> +               mci_writel(host, SDMMC_CLKSEL64, clksel);
>         else
> -               mci_writel(host, CLKSEL, clksel);
> +               mci_writel(host, SDMMC_CLKSEL, clksel);
>  }
>
>  static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
> @@ -404,18 +404,18 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
>
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               clksel = mci_readl(host, CLKSEL64);
> +               clksel = mci_readl(host, SDMMC_CLKSEL64);
>         else
> -               clksel = mci_readl(host, CLKSEL);
> +               clksel = mci_readl(host, SDMMC_CLKSEL);
>
>         sample = (clksel + 1) & 0x7;
>         clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
>
>         if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>                 priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
> -               mci_writel(host, CLKSEL64, clksel);
> +               mci_writel(host, SDMMC_CLKSEL64, clksel);
>         else
> -               mci_writel(host, CLKSEL, clksel);
> +               mci_writel(host, SDMMC_CLKSEL, clksel);
>
>         return sample;
>  }
> @@ -458,7 +458,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>         start_smpl = dw_mci_exynos_get_clksmpl(host);
>
>         do {
> -               mci_writel(host, TMOUT, ~0);
> +               mci_writel(host, SDMMC_TMOUT, ~0);
>                 smpl = dw_mci_exynos_move_next_clksmpl(host);
>
>                 if (!mmc_send_tuning(mmc, opcode, NULL))
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7128351..d887e0f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -270,9 +270,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>                  * ever called with a non-zero clock.  That shouldn't happen
>                  * until the voltage change is all done.
>                  */
> -               clk_en_a = mci_readl(host, CLKENA);
> +               clk_en_a = mci_readl(host, SDMMC_CLKENA);
>                 clk_en_a &= ~(SDMMC_CLKEN_LOW_PWR << slot->id);
> -               mci_writel(host, CLKENA, clk_en_a);
> +               mci_writel(host, SDMMC_CLKENA, clk_en_a);
>                 mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>                              SDMMC_CMD_PRV_DAT_WAIT, 0);
>         }
> @@ -352,7 +352,7 @@ static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
>          */
>         if ((cmd_flags & SDMMC_CMD_PRV_DAT_WAIT) &&
>             !(cmd_flags & SDMMC_CMD_VOLT_SWITCH)) {
> -               while (mci_readl(host, STATUS) & SDMMC_STATUS_BUSY) {
> +               while (mci_readl(host, SDMMC_STATUS) & SDMMC_STATUS_BUSY) {
>                         if (time_after(jiffies, timeout)) {
>                                 /* Command will fail; we'll pass error then */
>                                 dev_err(host->dev, "Busy; trying anyway\n");
> @@ -371,11 +371,11 @@ static void dw_mci_start_command(struct dw_mci *host,
>                  "start command: ARGR=0x%08x CMDR=0x%08x\n",
>                  cmd->arg, cmd_flags);
>
> -       mci_writel(host, CMDARG, cmd->arg);
> +       mci_writel(host, SDMMC_CMDARG, cmd->arg);
>         wmb(); /* drain writebuffer */
>         dw_mci_wait_while_busy(host, cmd_flags);
>
> -       mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
> +       mci_writel(host, SDMMC_CMD, cmd_flags | SDMMC_CMD_START);
>  }
>
>  static inline void send_stop_abort(struct dw_mci *host, struct mmc_data *data)
> @@ -409,20 +409,17 @@ static void dw_mci_dma_cleanup(struct dw_mci *host)
>  {
>         struct mmc_data *data = host->data;
>
> -       if (data)
> -               if (!data->host_cookie)
> -                       dma_unmap_sg(host->dev,
> -                                    data->sg,
> -                                    data->sg_len,
> -                                    dw_mci_get_dma_dir(data));
> +       if (data && !data->host_cookie)
> +               dma_unmap_sg(host->dev, data->sg, data->sg_len,
> +                               dw_mci_get_dma_dir(data));
>  }
>
>  static void dw_mci_idmac_reset(struct dw_mci *host)
>  {
> -       u32 bmod = mci_readl(host, BMOD);
> +       u32 bmod = mci_readl(host, SDMMC_BMOD);
>         /* Software reset of DMA */
>         bmod |= SDMMC_IDMAC_SWRESET;
> -       mci_writel(host, BMOD, bmod);
> +       mci_writel(host, SDMMC_BMOD, bmod);
>  }
>
>  static void dw_mci_idmac_stop_dma(struct dw_mci *host)
> @@ -430,16 +427,16 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
>         u32 temp;
>
>         /* Disable and reset the IDMAC interface */
> -       temp = mci_readl(host, CTRL);
> +       temp = mci_readl(host, SDMMC_CTRL);
>         temp &= ~SDMMC_CTRL_USE_IDMAC;
>         temp |= SDMMC_CTRL_DMA_RESET;
> -       mci_writel(host, CTRL, temp);
> +       mci_writel(host, SDMMC_CTRL, temp);
>
>         /* Stop the IDMAC running */
> -       temp = mci_readl(host, BMOD);
> +       temp = mci_readl(host, SDMMC_BMOD);
>         temp &= ~(SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB);
>         temp |= SDMMC_IDMAC_SWRESET;
> -       mci_writel(host, BMOD, temp);
> +       mci_writel(host, SDMMC_BMOD, temp);
>  }
>
>  static void dw_mci_dmac_complete_dma(void *arg)
> @@ -581,20 +578,20 @@ static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>         dw_mci_idmac_reset(host);
>
>         /* Select IDMAC interface */
> -       temp = mci_readl(host, CTRL);
> +       temp = mci_readl(host, SDMMC_CTRL);
>         temp |= SDMMC_CTRL_USE_IDMAC;
> -       mci_writel(host, CTRL, temp);
> +       mci_writel(host, SDMMC_CTRL, temp);
>
>         /* drain writebuffer */
>         wmb();
>
>         /* Enable the IDMAC */
> -       temp = mci_readl(host, BMOD);
> +       temp = mci_readl(host, SDMMC_BMOD);
>         temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
> -       mci_writel(host, BMOD, temp);
> +       mci_writel(host, SDMMC_BMOD, temp);
>
>         /* Start it running */
> -       mci_writel(host, PLDMND, 1);
> +       mci_writel(host, SDMMC_PLDMND, 1);
>
>         return 0;
>  }
> @@ -652,22 +649,22 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>
>         if (host->dma_64bit_address == 1) {
>                 /* Mask out interrupts - get Tx & Rx complete only */
> -               mci_writel(host, IDSTS64, IDMAC_INT_CLR);
> -               mci_writel(host, IDINTEN64, SDMMC_IDMAC_INT_NI |
> +               mci_writel(host, SDMMC_IDSTS64, IDMAC_INT_CLR);
> +               mci_writel(host, SDMMC_IDINTEN64, SDMMC_IDMAC_INT_NI |
>                                 SDMMC_IDMAC_INT_RI | SDMMC_IDMAC_INT_TI);
>
>                 /* Set the descriptor base address */
> -               mci_writel(host, DBADDRL, host->sg_dma & 0xffffffff);
> -               mci_writel(host, DBADDRU, (u64)host->sg_dma >> 32);
> +               mci_writel(host, SDMMC_DBADDRL, host->sg_dma & 0xffffffff);
> +               mci_writel(host, SDMMC_DBADDRU, (u64)host->sg_dma >> 32);
>
>         } else {
>                 /* Mask out interrupts - get Tx & Rx complete only */
> -               mci_writel(host, IDSTS, IDMAC_INT_CLR);
> -               mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI |
> +               mci_writel(host, SDMMC_IDSTS, IDMAC_INT_CLR);
> +               mci_writel(host, SDMMC_IDINTEN, SDMMC_IDMAC_INT_NI |
>                                 SDMMC_IDMAC_INT_RI | SDMMC_IDMAC_INT_TI);
>
>                 /* Set the descriptor base address */
> -               mci_writel(host, DBADDR, host->sg_dma);
> +               mci_writel(host, SDMMC_DBADDR, host->sg_dma);
>         }
>
>         return 0;
> @@ -705,7 +702,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
>         cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>
>         /* Match burst msize with external dma config */
> -       fifoth_val = mci_readl(host, FIFOTH);
> +       fifoth_val = mci_readl(host, SDMMC_FIFOTH);
>         cfg.dst_maxburst = mszs[(fifoth_val >> 28) & 0x7];
>         cfg.src_maxburst = cfg.dst_maxburst;
>
> @@ -898,7 +895,7 @@ static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
>          */
>  done:
>         fifoth_val = SDMMC_SET_FIFOTH(msize, rx_wmark, tx_wmark);
> -       mci_writel(host, FIFOTH, fifoth_val);
> +       mci_writel(host, SDMMC_FIFOTH, fifoth_val);
>  }
>
>  static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
> @@ -933,11 +930,11 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>          * Currently just choose blksz.
>          */
>         thld_size = blksz;
> -       mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(thld_size, 1));
> +       mci_writel(host, SDMMC_CDTHRCTL, SDMMC_SET_RD_THLD(thld_size, 1));
>         return;
>
>  disable:
> -       mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(0, 0));
> +       mci_writel(host, SDMMC_CDTHRCTL, SDMMC_SET_RD_THLD(0, 0));
>  }
>
>  static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
> @@ -976,15 +973,15 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>                 dw_mci_adjust_fifoth(host, data);
>
>         /* Enable the DMA interface */
> -       temp = mci_readl(host, CTRL);
> +       temp = mci_readl(host, SDMMC_CTRL);
>         temp |= SDMMC_CTRL_DMA_ENABLE;
> -       mci_writel(host, CTRL, temp);
> +       mci_writel(host, SDMMC_CTRL, temp);
>
>         /* Disable RX/TX IRQs, let DMA handle it */
>         spin_lock_irqsave(&host->irq_lock, irqflags);
> -       temp = mci_readl(host, INTMASK);
> +       temp = mci_readl(host, SDMMC_INTMASK);
>         temp  &= ~(SDMMC_INT_RXDR | SDMMC_INT_TXDR);
> -       mci_writel(host, INTMASK, temp);
> +       mci_writel(host, SDMMC_INTMASK, temp);
>         spin_unlock_irqrestore(&host->irq_lock, irqflags);
>
>         if (host->dma_ops->start(host, sg_len)) {
> @@ -1026,24 +1023,24 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
>                 host->part_buf_start = 0;
>                 host->part_buf_count = 0;
>
> -               mci_writel(host, RINTSTS, SDMMC_INT_TXDR | SDMMC_INT_RXDR);
> +               mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_TXDR | SDMMC_INT_RXDR);
>
>                 spin_lock_irqsave(&host->irq_lock, irqflags);
> -               temp = mci_readl(host, INTMASK);
> +               temp = mci_readl(host, SDMMC_INTMASK);
>                 temp |= SDMMC_INT_TXDR | SDMMC_INT_RXDR;
> -               mci_writel(host, INTMASK, temp);
> +               mci_writel(host, SDMMC_INTMASK, temp);
>                 spin_unlock_irqrestore(&host->irq_lock, irqflags);
>
> -               temp = mci_readl(host, CTRL);
> +               temp = mci_readl(host, SDMMC_CTRL);
>                 temp &= ~SDMMC_CTRL_DMA_ENABLE;
> -               mci_writel(host, CTRL, temp);
> +               mci_writel(host, SDMMC_CTRL, temp);
>
>                 /*
>                  * Use the initial fifoth_val for PIO mode.
>                  * If next issued data may be transfered by DMA mode,
>                  * prev_blksz should be invalidated.
>                  */
> -               mci_writel(host, FIFOTH, host->fifoth_val);
> +               mci_writel(host, SDMMC_FIFOTH, host->fifoth_val);
>                 host->prev_blksz = 0;
>         } else {
>                 /*
> @@ -1061,13 +1058,13 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>         unsigned long timeout = jiffies + msecs_to_jiffies(500);
>         unsigned int cmd_status = 0;
>
> -       mci_writel(host, CMDARG, arg);
> +       mci_writel(host, SDMMC_CMDARG, arg);
>         wmb(); /* drain writebuffer */
>         dw_mci_wait_while_busy(host, cmd);
> -       mci_writel(host, CMD, SDMMC_CMD_START | cmd);
> +       mci_writel(host, SDMMC_CMD, SDMMC_CMD_START | cmd);
>
>         while (time_before(jiffies, timeout)) {
> -               cmd_status = mci_readl(host, CMD);
> +               cmd_status = mci_readl(host, SDMMC_CMD);
>                 if (!(cmd_status & SDMMC_CMD_START))
>                         return;
>         }
> @@ -1089,7 +1086,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>                 sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>
>         if (!clock) {
> -               mci_writel(host, CLKENA, 0);
> +               mci_writel(host, SDMMC_CLKENA, 0);
>                 mci_send_cmd(slot, sdmmc_cmd_bits, 0);
>         } else if (clock != host->current_speed || force_clkinit) {
>                 div = host->bus_hz / clock;
> @@ -1110,14 +1107,14 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>                                  host->bus_hz, div);
>
>                 /* disable clock */
> -               mci_writel(host, CLKENA, 0);
> -               mci_writel(host, CLKSRC, 0);
> +               mci_writel(host, SDMMC_CLKENA, 0);
> +               mci_writel(host, SDMMC_CLKSRC, 0);
>
>                 /* inform CIU */
>                 mci_send_cmd(slot, sdmmc_cmd_bits, 0);
>
>                 /* set clock to desired speed */
> -               mci_writel(host, CLKDIV, div);
> +               mci_writel(host, SDMMC_CLKDIV, div);
>
>                 /* inform CIU */
>                 mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> @@ -1126,7 +1123,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>                 clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
>                 if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags))
>                         clk_en_a |= SDMMC_CLKEN_LOW_PWR << slot->id;
> -               mci_writel(host, CLKENA, clk_en_a);
> +               mci_writel(host, SDMMC_CLKENA, clk_en_a);
>
>                 /* inform CIU */
>                 mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> @@ -1138,7 +1135,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>         host->current_speed = clock;
>
>         /* Set the current slot bus width */
> -       mci_writel(host, CTYPE, (slot->ctype << slot->id));
> +       mci_writel(host, SDMMC_CTYPE, (slot->ctype << slot->id));
>  }
>
>  static void __dw_mci_start_request(struct dw_mci *host,
> @@ -1162,9 +1159,9 @@ static void __dw_mci_start_request(struct dw_mci *host,
>
>         data = cmd->data;
>         if (data) {
> -               mci_writel(host, TMOUT, 0xFFFFFFFF);
> -               mci_writel(host, BYTCNT, data->blksz*data->blocks);
> -               mci_writel(host, BLKSIZ, data->blksz);
> +               mci_writel(host, SDMMC_TMOUT, 0xFFFFFFFF);
> +               mci_writel(host, SDMMC_BYTCNT, data->blksz*data->blocks);
> +               mci_writel(host, SDMMC_BLKSIZ, data->blksz);
>         }
>
>         cmdflags = dw_mci_prepare_command(slot->mmc, cmd);
> @@ -1289,7 +1286,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 slot->ctype = SDMMC_CTYPE_1BIT;
>         }
>
> -       regs = mci_readl(slot->host, UHS_REG);
> +       regs = mci_readl(slot->host, SDMMC_UHS_REG);
>
>         /* DDR mode set */
>         if (ios->timing == MMC_TIMING_MMC_DDR52 ||
> @@ -1299,7 +1296,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         else
>                 regs &= ~((0x1 << slot->id) << 16);
>
> -       mci_writel(slot->host, UHS_REG, regs);
> +       mci_writel(slot->host, SDMMC_UHS_REG, regs);
>         slot->host->timing = ios->timing;
>
>         /*
> @@ -1324,9 +1321,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                         }
>                 }
>                 set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
> -               regs = mci_readl(slot->host, PWREN);
> +               regs = mci_readl(slot->host, SDMMC_PWREN);
>                 regs |= (1 << slot->id);
> -               mci_writel(slot->host, PWREN, regs);
> +               mci_writel(slot->host, SDMMC_PWREN, regs);
>                 break;
>         case MMC_POWER_ON:
>                 if (!slot->host->vqmmc_enabled) {
> @@ -1363,9 +1360,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                         regulator_disable(mmc->supply.vqmmc);
>                 slot->host->vqmmc_enabled = false;
>
> -               regs = mci_readl(slot->host, PWREN);
> +               regs = mci_readl(slot->host, SDMMC_PWREN);
>                 regs &= ~(1 << slot->id);
> -               mci_writel(slot->host, PWREN, regs);
> +               mci_writel(slot->host, SDMMC_PWREN, regs);
>                 break;
>         default:
>                 break;
> @@ -1384,7 +1381,7 @@ static int dw_mci_card_busy(struct mmc_host *mmc)
>          * Check the busy bit which is low when DAT[3:0]
>          * (the data lines) are 0000
>          */
> -       status = mci_readl(slot->host, STATUS);
> +       status = mci_readl(slot->host, SDMMC_STATUS);
>
>         return !!(status & SDMMC_STATUS_BUSY);
>  }
> @@ -1406,7 +1403,7 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>          * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
>          * does no harm but you need to set the regulator directly.  Try both.
>          */
> -       uhs = mci_readl(host, UHS_REG);
> +       uhs = mci_readl(host, SDMMC_UHS_REG);
>         if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
>                 uhs &= ~v18;
>         else
> @@ -1422,7 +1419,7 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>                         return ret;
>                 }
>         }
> -       mci_writel(host, UHS_REG, uhs);
> +       mci_writel(host, SDMMC_UHS_REG, uhs);
>
>         return 0;
>  }
> @@ -1438,7 +1435,8 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>                 read_only = gpio_ro;
>         else
>                 read_only =
> -                       mci_readl(slot->host, WRTPRT) & (1 << slot->id) ? 1 : 0;
> +                       mci_readl(slot->host, SDMMC_WRTPRT) & (1 << slot->id) ?
> +                       1 : 0;
>
>         dev_dbg(&mmc->class_dev, "card is %s\n",
>                 read_only ? "read-only" : "read-write");
> @@ -1461,7 +1459,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>         else if (!IS_ERR_VALUE(gpio_cd))
>                 present = gpio_cd;
>         else
> -               present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
> +               present = (mci_readl(slot->host, SDMMC_CDETECT) & (1 << slot->id))
>                         == 0 ? 1 : 0;
>
>         spin_lock_bh(&host->lock);
> @@ -1492,7 +1490,7 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>                 u32 clk_en_a_old;
>                 u32 clk_en_a;
>
> -               clk_en_a_old = mci_readl(host, CLKENA);
> +               clk_en_a_old = mci_readl(host, SDMMC_CLKENA);
>
>                 if (card->type == MMC_TYPE_SDIO ||
>                     card->type == MMC_TYPE_SD_COMBO) {
> @@ -1504,7 +1502,7 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>                 }
>
>                 if (clk_en_a != clk_en_a_old) {
> -                       mci_writel(host, CLKENA, clk_en_a);
> +                       mci_writel(host, SDMMC_CLKENA, clk_en_a);
>                         mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>                                      SDMMC_CMD_PRV_DAT_WAIT, 0);
>                 }
> @@ -1521,12 +1519,12 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>         spin_lock_irqsave(&host->irq_lock, irqflags);
>
>         /* Enable/disable Slot Specific SDIO interrupt */
> -       int_mask = mci_readl(host, INTMASK);
> +       int_mask = mci_readl(host, SDMMC_INTMASK);
>         if (enb)
>                 int_mask |= SDMMC_INT_SDIO(slot->sdio_id);
>         else
>                 int_mask &= ~SDMMC_INT_SDIO(slot->sdio_id);
> -       mci_writel(host, INTMASK, int_mask);
> +       mci_writel(host, SDMMC_INTMASK, int_mask);
>
>         spin_unlock_irqrestore(&host->irq_lock, irqflags);
>  }
> @@ -1613,12 +1611,12 @@ static int dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd)
>         /* Read the response from the card (up to 16 bytes) */
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136) {
> -                       cmd->resp[3] = mci_readl(host, RESP0);
> -                       cmd->resp[2] = mci_readl(host, RESP1);
> -                       cmd->resp[1] = mci_readl(host, RESP2);
> -                       cmd->resp[0] = mci_readl(host, RESP3);
> +                       cmd->resp[3] = mci_readl(host, SDMMC_RESP0);
> +                       cmd->resp[2] = mci_readl(host, SDMMC_RESP1);
> +                       cmd->resp[1] = mci_readl(host, SDMMC_RESP2);
> +                       cmd->resp[0] = mci_readl(host, SDMMC_RESP3);
>                 } else {
> -                       cmd->resp[0] = mci_readl(host, RESP0);
> +                       cmd->resp[0] = mci_readl(host, SDMMC_RESP0);
>                         cmd->resp[1] = 0;
>                         cmd->resp[2] = 0;
>                         cmd->resp[3] = 0;
> @@ -1685,7 +1683,7 @@ static void dw_mci_set_drto(struct dw_mci *host)
>         unsigned int drto_clks;
>         unsigned int drto_ms;
>
> -       drto_clks = mci_readl(host, TMOUT) >> 8;
> +       drto_clks = mci_readl(host, SDMMC_TMOUT) >> 8;
>         drto_ms = DIV_ROUND_UP(drto_clks, host->bus_hz / 1000);
>
>         /* add a bit spare time */
> @@ -2226,7 +2224,7 @@ static void dw_mci_read_data_pio(struct dw_mci *host, bool dto)
>                 offset = 0;
>
>                 do {
> -                       fcnt = (SDMMC_GET_FCNT(mci_readl(host, STATUS))
> +                       fcnt = (SDMMC_GET_FCNT(mci_readl(host, SDMMC_STATUS))
>                                         << shift) + host->part_buf_count;
>                         len = min(remain, fcnt);
>                         if (!len)
> @@ -2238,11 +2236,11 @@ static void dw_mci_read_data_pio(struct dw_mci *host, bool dto)
>                 } while (remain);
>
>                 sg_miter->consumed = offset;
> -               status = mci_readl(host, MINTSTS);
> -               mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
> +               status = mci_readl(host, SDMMC_MINTSTS);
> +               mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_RXDR);
>         /* if the RXDR is ready read again */
>         } while ((status & SDMMC_INT_RXDR) ||
> -                (dto && SDMMC_GET_FCNT(mci_readl(host, STATUS))));
> +                (dto && SDMMC_GET_FCNT(mci_readl(host, SDMMC_STATUS))));
>
>         if (!remain) {
>                 if (!sg_miter_next(sg_miter))
> @@ -2282,7 +2280,7 @@ static void dw_mci_write_data_pio(struct dw_mci *host)
>
>                 do {
>                         fcnt = ((fifo_depth -
> -                                SDMMC_GET_FCNT(mci_readl(host, STATUS)))
> +                                SDMMC_GET_FCNT(mci_readl(host, SDMMC_STATUS)))
>                                         << shift) - host->part_buf_count;
>                         len = min(remain, fcnt);
>                         if (!len)
> @@ -2294,8 +2292,8 @@ static void dw_mci_write_data_pio(struct dw_mci *host)
>                 } while (remain);
>
>                 sg_miter->consumed = offset;
> -               status = mci_readl(host, MINTSTS);
> -               mci_writel(host, RINTSTS, SDMMC_INT_TXDR);
> +               status = mci_readl(host, SDMMC_MINTSTS);
> +               mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_TXDR);
>         } while (status & SDMMC_INT_TXDR); /* if TXDR write again */
>
>         if (!remain) {
> @@ -2347,7 +2345,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>         u32 pending;
>         int i;
>
> -       pending = mci_readl(host, MINTSTS); /* read-only mask reg */
> +       pending = mci_readl(host, SDMMC_MINTSTS); /* read-only mask reg */
>
>         if (pending) {
>                 /* Check volt switch first, since it can look like an error */
> @@ -2355,7 +2353,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                     (pending & SDMMC_INT_VOLT_SWITCH)) {
>                         unsigned long irqflags;
>
> -                       mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
> +                       mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_VOLT_SWITCH);
>                         pending &= ~SDMMC_INT_VOLT_SWITCH;
>
>                         /*
> @@ -2370,7 +2368,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 }
>
>                 if (pending & DW_MCI_CMD_ERROR_FLAGS) {
> -                       mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
> +                       mci_writel(host, SDMMC_RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
>                         host->cmd_status = pending;
>                         smp_wmb(); /* drain writebuffer */
>                         set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
> @@ -2378,7 +2376,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>
>                 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
>                         /* if there is an error report DATA_ERROR */
> -                       mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
> +                       mci_writel(host, SDMMC_RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
>                         host->data_status = pending;
>                         smp_wmb(); /* drain writebuffer */
>                         set_bit(EVENT_DATA_ERROR, &host->pending_events);
> @@ -2389,7 +2387,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                         if (host->quirks & DW_MCI_QUIRK_BROKEN_DTO)
>                                 del_timer(&host->dto_timer);
>
> -                       mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
> +                       mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_DATA_OVER);
>                         if (!host->data_status)
>                                 host->data_status = pending;
>                         smp_wmb(); /* drain writebuffer */
> @@ -2402,24 +2400,24 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 }
>
>                 if (pending & SDMMC_INT_RXDR) {
> -                       mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
> +                       mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_RXDR);
>                         if (host->dir_status == DW_MCI_RECV_STATUS && host->sg)
>                                 dw_mci_read_data_pio(host, false);
>                 }
>
>                 if (pending & SDMMC_INT_TXDR) {
> -                       mci_writel(host, RINTSTS, SDMMC_INT_TXDR);
> +                       mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_TXDR);
>                         if (host->dir_status == DW_MCI_SEND_STATUS && host->sg)
>                                 dw_mci_write_data_pio(host);
>                 }
>
>                 if (pending & SDMMC_INT_CMD_DONE) {
> -                       mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
> +                       mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_CMD_DONE);
>                         dw_mci_cmd_interrupt(host, pending);
>                 }
>
>                 if (pending & SDMMC_INT_CD) {
> -                       mci_writel(host, RINTSTS, SDMMC_INT_CD);
> +                       mci_writel(host, SDMMC_RINTSTS, SDMMC_INT_CD);
>                         dw_mci_handle_cd(host);
>                 }
>
> @@ -2431,7 +2429,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                                 continue;
>
>                         if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
> -                               mci_writel(host, RINTSTS,
> +                               mci_writel(host, SDMMC_RINTSTS,
>                                            SDMMC_INT_SDIO(slot->sdio_id));
>                                 mmc_signal_sdio_irq(slot->mmc);
>                         }
> @@ -2444,19 +2442,19 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>
>         /* Handle IDMA interrupts */
>         if (host->dma_64bit_address == 1) {
> -               pending = mci_readl(host, IDSTS64);
> +               pending = mci_readl(host, SDMMC_IDSTS64);
>                 if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
> +                       mci_writel(host, SDMMC_IDSTS64, SDMMC_IDMAC_INT_TI |
>                                                         SDMMC_IDMAC_INT_RI);
> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> +                       mci_writel(host, SDMMC_IDSTS64, SDMMC_IDMAC_INT_NI);
>                         host->dma_ops->complete((void *)host);
>                 }
>         } else {
> -               pending = mci_readl(host, IDSTS);
> +               pending = mci_readl(host, SDMMC_IDSTS);
>                 if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
> +                       mci_writel(host, SDMMC_IDSTS, SDMMC_IDMAC_INT_TI |
>                                                         SDMMC_IDMAC_INT_RI);
> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> +                       mci_writel(host, SDMMC_IDSTS, SDMMC_IDMAC_INT_NI);
>                         host->dma_ops->complete((void *)host);
>                 }
>         }
> @@ -2636,7 +2634,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>         * simpler request/acknowledge handshake mechanism and both of them
>         * are regarded as external dma master for dw_mmc.
>         */
> -       host->use_dma = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
> +       host->use_dma = SDMMC_GET_TRANS_MODE(mci_readl(host, SDMMC_HCON));
>         if (host->use_dma == DMA_INTERFACE_IDMA) {
>                 host->use_dma = TRANS_MODE_IDMAC;
>         } else if (host->use_dma == DMA_INTERFACE_DWDMA ||
> @@ -2652,7 +2650,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>                 * Check ADDR_CONFIG bit in HCON to find
>                 * IDMAC address bus width
>                 */
> -               addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
> +               addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, SDMMC_HCON));
>
>                 if (addr_config == 1) {
>                         /* host supports IDMAC in 64-bit address mode */
> @@ -2715,13 +2713,13 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
>         unsigned long timeout = jiffies + msecs_to_jiffies(500);
>         u32 ctrl;
>
> -       ctrl = mci_readl(host, CTRL);
> +       ctrl = mci_readl(host, SDMMC_CTRL);
>         ctrl |= reset;
> -       mci_writel(host, CTRL, ctrl);
> +       mci_writel(host, SDMMC_CTRL, ctrl);
>
>         /* wait till resets clear */
>         do {
> -               ctrl = mci_readl(host, CTRL);
> +               ctrl = mci_readl(host, SDMMC_CTRL);
>                 if (!(ctrl & reset))
>                         return true;
>         } while (time_before(jiffies, timeout));
> @@ -2755,7 +2753,7 @@ static bool dw_mci_reset(struct dw_mci *host)
>                  * In all cases we clear the RAWINTS register to clear any
>                  * interrupts.
>                  */
> -               mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +               mci_writel(host, SDMMC_RINTSTS, 0xFFFFFFFF);
>
>                 /* if using dma we wait for dma_req to clear */
>                 if (host->use_dma) {
> @@ -2763,7 +2761,7 @@ static bool dw_mci_reset(struct dw_mci *host)
>                         u32 status;
>
>                         do {
> -                               status = mci_readl(host, STATUS);
> +                               status = mci_readl(host, SDMMC_STATUS);
>                                 if (!(status & SDMMC_STATUS_DMA_REQ))
>                                         break;
>                                 cpu_relax();
> @@ -2782,7 +2780,7 @@ static bool dw_mci_reset(struct dw_mci *host)
>                 }
>         } else {
>                 /* if the controller reset bit did clear, then set clock regs */
> -               if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET)) {
> +               if (!(mci_readl(host, SDMMC_CTRL) & SDMMC_CTRL_RESET)) {
>                         dev_err(host->dev,
>                                 "%s: fifo/dma reset bits didn't clear but ciu was reset, doing clock update\n",
>                                 __func__);
> @@ -2928,9 +2926,9 @@ static void dw_mci_enable_cd(struct dw_mci *host)
>                 return;
>
>         spin_lock_irqsave(&host->irq_lock, irqflags);
> -       temp = mci_readl(host, INTMASK);
> +       temp = mci_readl(host, SDMMC_INTMASK);
>         temp  |= SDMMC_INT_CD;
> -       mci_writel(host, INTMASK, temp);
> +       mci_writel(host, SDMMC_INTMASK, temp);
>         spin_unlock_irqrestore(&host->irq_lock, irqflags);
>  }
>
> @@ -3029,7 +3027,7 @@ int dw_mci_probe(struct dw_mci *host)
>          * Get the host data width - this assumes that HCON has been set with
>          * the correct values.
>          */
> -       i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
> +       i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, SDMMC_HCON));
>         if (!i) {
>                 host->push_data = dw_mci_push_data16;
>                 host->pull_data = dw_mci_pull_data16;
> @@ -3059,11 +3057,11 @@ int dw_mci_probe(struct dw_mci *host)
>         dw_mci_init_dma(host);
>
>         /* Clear the interrupts for the host controller */
> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
> -       mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> +       mci_writel(host, SDMMC_RINTSTS, 0xFFFFFFFF);
> +       mci_writel(host, SDMMC_INTMASK, 0); /* disable all mmc interrupt first */
>
>         /* Put in max timeout */
> -       mci_writel(host, TMOUT, 0xFFFFFFFF);
> +       mci_writel(host, SDMMC_TMOUT, 0xFFFFFFFF);
>
>         /*
>          * FIFO threshold settings  RxMark  = fifo_size / 2 - 1,
> @@ -3076,7 +3074,7 @@ int dw_mci_probe(struct dw_mci *host)
>                  * about to do, so if you know the value for your hardware, you
>                  * should put it in the platform data.
>                  */
> -               fifo_size = mci_readl(host, FIFOTH);
> +               fifo_size = mci_readl(host, SDMMC_FIFOTH);
>                 fifo_size = 1 + ((fifo_size >> 16) & 0xfff);
>         } else {
>                 fifo_size = host->pdata->fifo_depth;
> @@ -3084,17 +3082,17 @@ int dw_mci_probe(struct dw_mci *host)
>         host->fifo_depth = fifo_size;
>         host->fifoth_val =
>                 SDMMC_SET_FIFOTH(0x2, fifo_size / 2 - 1, fifo_size / 2);
> -       mci_writel(host, FIFOTH, host->fifoth_val);
> +       mci_writel(host, SDMMC_FIFOTH, host->fifoth_val);
>
>         /* disable clock to CIU */
> -       mci_writel(host, CLKENA, 0);
> -       mci_writel(host, CLKSRC, 0);
> +       mci_writel(host, SDMMC_CLKENA, 0);
> +       mci_writel(host, SDMMC_CLKSRC, 0);
>
>         /*
>          * In 2.40a spec, Data offset is changed.
>          * Need to check the version-id and set data-offset for DATA register.
>          */
> -       host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
> +       host->verid = SDMMC_GET_VERID(mci_readl(host, SDMMC_VERID));
>         dev_info(host->dev, "Version ID is %04x\n", host->verid);
>
>         if (host->verid < DW_MMC_240A)
> @@ -3111,18 +3109,18 @@ int dw_mci_probe(struct dw_mci *host)
>         if (host->pdata->num_slots)
>                 host->num_slots = host->pdata->num_slots;
>         else
> -               host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, HCON));
> +               host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, SDMMC_HCON));
>
>         /*
>          * Enable interrupts for command done, data over, data empty,
>          * receive ready and error such as transmit, receive timeout, crc error
>          */
> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
> -       mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
> -                  SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> -                  DW_MCI_ERROR_FLAGS);
> +       mci_writel(host, SDMMC_RINTSTS, 0xFFFFFFFF);
> +       mci_writel(host, SDMMC_INTMASK, SDMMC_INT_CMD_DONE |
> +                       SDMMC_INT_DATA_OVER | SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> +                       DW_MCI_ERROR_FLAGS);
>         /* Enable mci interrupt */
> -       mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
> +       mci_writel(host, SDMMC_CTRL, SDMMC_CTRL_INT_ENABLE);
>
>         dev_info(host->dev,
>                  "DW MMC controller at irq %d,%d bit host data width,%u deep fifo\n",
> @@ -3177,12 +3175,12 @@ void dw_mci_remove(struct dw_mci *host)
>                         dw_mci_cleanup_slot(host->slot[i], i);
>         }
>
> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
> -       mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> +       mci_writel(host, SDMMC_RINTSTS, 0xFFFFFFFF);
> +       mci_writel(host, SDMMC_INTMASK, 0); /* disable all mmc interrupt first */
>
>         /* disable clock to CIU */
> -       mci_writel(host, CLKENA, 0);
> -       mci_writel(host, CLKSRC, 0);
> +       mci_writel(host, SDMMC_CLKENA, 0);
> +       mci_writel(host, SDMMC_CLKSRC, 0);
>
>         if (host->use_dma && host->dma_ops->exit)
>                 host->dma_ops->exit(host);
> @@ -3226,17 +3224,17 @@ int dw_mci_resume(struct dw_mci *host)
>          * Restore the initial value at FIFOTH register
>          * And Invalidate the prev_blksz with zero
>          */
> -       mci_writel(host, FIFOTH, host->fifoth_val);
> +       mci_writel(host, SDMMC_FIFOTH, host->fifoth_val);
>         host->prev_blksz = 0;
>
>         /* Put in max timeout */
> -       mci_writel(host, TMOUT, 0xFFFFFFFF);
> +       mci_writel(host, SDMMC_TMOUT, 0xFFFFFFFF);
>
> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
> -       mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
> -                  SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> -                  DW_MCI_ERROR_FLAGS);
> -       mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
> +       mci_writel(host, SDMMC_RINTSTS, 0xFFFFFFFF);
> +       mci_writel(host, SDMMC_INTMASK, SDMMC_INT_CMD_DONE |
> +                       SDMMC_INT_DATA_OVER | SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> +                       DW_MCI_ERROR_FLAGS);
> +       mci_writel(host, SDMMC_CTRL, SDMMC_CTRL_INT_ENABLE);
>
>         for (i = 0; i < host->num_slots; i++) {
>                 struct dw_mci_slot *slot = host->slot[i];
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index f695b58..c92fcfa 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -190,22 +190,22 @@
>
>  /* Register access macros */
>  #define mci_readl(dev, reg)                    \
> -       readl_relaxed((dev)->regs + SDMMC_##reg)
> +       readl_relaxed((dev)->regs + reg)
>  #define mci_writel(dev, reg, value)                    \
> -       writel_relaxed((value), (dev)->regs + SDMMC_##reg)
> +       writel_relaxed((value), (dev)->regs + reg)
>
>  /* 16-bit FIFO access macros */
>  #define mci_readw(dev, reg)                    \
> -       readw_relaxed((dev)->regs + SDMMC_##reg)
> +       readw_relaxed((dev)->regs + reg)
>  #define mci_writew(dev, reg, value)                    \
> -       writew_relaxed((value), (dev)->regs + SDMMC_##reg)
> +       writew_relaxed((value), (dev)->regs + reg)
>
>  /* 64-bit FIFO access macros */
>  #ifdef readq
>  #define mci_readq(dev, reg)                    \
> -       readq_relaxed((dev)->regs + SDMMC_##reg)
> +       readq_relaxed((dev)->regs + reg)
>  #define mci_writeq(dev, reg, value)                    \
> -       writeq_relaxed((value), (dev)->regs + SDMMC_##reg)
> +       writeq_relaxed((value), (dev)->regs + reg)
>  #else
>  /*
>   * Dummy readq implementation for architectures that don't define it.
> @@ -216,9 +216,9 @@
>   * rest of the code free from ifdefs.
>   */
>  #define mci_readq(dev, reg)                    \
> -       (*(volatile u64 __force *)((dev)->regs + SDMMC_##reg))
> +       (*(volatile u64 __force *)((dev)->regs + reg))
>  #define mci_writeq(dev, reg, value)                    \
> -       (*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
> +       (*(volatile u64 __force *)((dev)->regs + reg) = (value))
>
>  #define __raw_writeq(__value, __reg) \
>         (*(volatile u64 __force *)(__reg) = (__value))
> --
> 1.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
