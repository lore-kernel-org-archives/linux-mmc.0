From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 3/3] mmc: mediatek: Use data tune for CMD line tune
Date: Fri, 24 Mar 2017 08:18:19 +0100
Message-ID: <CAPDyKFqquui96rnhXnPcnSUk=oZKSNg1X-+CVZ24=hjfDZgGKQ@mail.gmail.com>
References: <1489562800-27431-1-git-send-email-yong.mao@mediatek.com> <1489562800-27431-4-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36198 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbdCXHSc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 03:18:32 -0400
Received: by mail-vk0-f46.google.com with SMTP id s68so6328728vke.3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 00:18:31 -0700 (PDT)
In-Reply-To: <1489562800-27431-4-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 15 March 2017 at 08:26, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> If we don't select a set of better parameters for our emmc host,
> It may easily occur CMD response CRC error. And also it may cause
> cannot boot up issue.
>
> Fot getting a set of better parameters, our emmc host supports
> data tune mechanism.Therefore, our emmc driver also should change
> to use data tune for CMD line.
>
> Because our emmc host use the different clock source to sample the
> CMD signal between HS200 and HS400 mode, the parameters are also
> different between these two modes.
> Separate cmd internal delay for HS200/HS400 mode.
>
> This change can fix "System can not boot up" issue.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>


Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c |  168 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 152 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 80ba034..07f3236 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -75,6 +75,7 @@
>  #define MSDC_PATCH_BIT1  0xb4
>  #define MSDC_PAD_TUNE    0xec
>  #define PAD_DS_TUNE      0x188
> +#define PAD_CMD_TUNE     0x18c
>  #define EMMC50_CFG0      0x208
>
>  /*--------------------------------------------------------------------------*/
> @@ -210,13 +211,18 @@
>  #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)  /* RW */
>  #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)  /* RW */
>
> +#define MSDC_PAD_TUNE_DATWRDLY   (0x1f <<  0)  /* RW */
>  #define MSDC_PAD_TUNE_DATRRDLY   (0x1f <<  8)  /* RW */
>  #define MSDC_PAD_TUNE_CMDRDLY    (0x1f << 16)  /* RW */
> +#define MSDC_PAD_TUNE_CMDRRDLY   (0x1f << 22)  /* RW */
> +#define MSDC_PAD_TUNE_CLKTDLY    (0x1f << 27)  /* RW */
>
>  #define PAD_DS_TUNE_DLY1         (0x1f << 2)   /* RW */
>  #define PAD_DS_TUNE_DLY2         (0x1f << 7)   /* RW */
>  #define PAD_DS_TUNE_DLY3         (0x1f << 12)  /* RW */
>
> +#define PAD_CMD_TUNE_RX_DLY3     (0x1f << 1)  /* RW */
> +
>  #define EMMC50_CFG_PADCMD_LATCHCK (0x1 << 0)   /* RW */
>  #define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)   /* RW */
>  #define EMMC50_CFG_CFCSTS_SEL     (0x1 << 4)   /* RW */
> @@ -284,12 +290,14 @@ struct msdc_save_para {
>         u32 patch_bit0;
>         u32 patch_bit1;
>         u32 pad_ds_tune;
> +       u32 pad_cmd_tune;
>         u32 emmc50_cfg0;
>  };
>
>  struct msdc_tune_para {
>         u32 iocon;
>         u32 pad_tune;
> +       u32 pad_cmd_tune;
>  };
>
>  struct msdc_delay_phase {
> @@ -331,6 +339,10 @@ struct msdc_host {
>         unsigned char timing;
>         bool vqmmc_enabled;
>         u32 hs400_ds_delay;
> +       u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104 */
> +       u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
> +       bool hs400_cmd_resp_sel_rising;
> +                                /* cmd response sample selection for HS400 */
>         bool hs400_mode;        /* current eMMC will run at hs400 mode */
>         struct msdc_save_para save_para; /* used when gate HCLK */
>         struct msdc_tune_para def_tune_para; /* default tune setting */
> @@ -600,8 +612,14 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>         } else {
>                 writel(host->saved_tune_para.iocon, host->base + MSDC_IOCON);
>                 writel(host->saved_tune_para.pad_tune, host->base + MSDC_PAD_TUNE);
> +               writel(host->saved_tune_para.pad_cmd_tune,
> +                      host->base + PAD_CMD_TUNE);
>         }
>
> +       if (timing == MMC_TIMING_MMC_HS400)
> +               sdr_set_field(host->base + PAD_CMD_TUNE,
> +                             MSDC_PAD_TUNE_CMDRRDLY,
> +                             host->hs400_cmd_int_delay);
>         dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);
>  }
>
> @@ -1302,7 +1320,7 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
>                         len_final = len;
>                 }
>                 start += len ? len : 1;
> -               if (len >= 8 && start_final < 4)
> +               if (len >= 12 && start_final < 4)
>                         break;
>         }
>
> @@ -1325,36 +1343,67 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>         struct msdc_host *host = mmc_priv(mmc);
>         u32 rise_delay = 0, fall_delay = 0;
>         struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
> +       struct msdc_delay_phase internal_delay_phase;
>         u8 final_delay, final_maxlen;
> +       u32 internal_delay = 0;
>         int cmd_err;
> -       int i;
> +       int i, j;
> +
> +       if (mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
> +           mmc->ios.timing == MMC_TIMING_UHS_SDR104)
> +               sdr_set_field(host->base + MSDC_PAD_TUNE,
> +                             MSDC_PAD_TUNE_CMDRRDLY,
> +                             host->hs200_cmd_int_delay);
>
>         sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>         for (i = 0 ; i < PAD_DELAY_MAX; i++) {
>                 sdr_set_field(host->base + MSDC_PAD_TUNE,
>                               MSDC_PAD_TUNE_CMDRDLY, i);
> -               mmc_send_tuning(mmc, opcode, &cmd_err);
> -               if (!cmd_err)
> -                       rise_delay |= (1 << i);
> +               /*
> +                * Using the same parameters, it may sometimes pass the test,
> +                * but sometimes it may fail. To make sure the parameters are
> +                * more stable, we test each set of parameters 3 times.
> +                */
> +               for (j = 0; j < 3; j++) {
> +                       mmc_send_tuning(mmc, opcode, &cmd_err);
> +                       if (!cmd_err) {
> +                               rise_delay |= (1 << i);
> +                       } else {
> +                               rise_delay &= ~(1 << i);
> +                               break;
> +                       }
> +               }
>         }
>         final_rise_delay = get_best_delay(host, rise_delay);
>         /* if rising edge has enough margin, then do not scan falling edge */
> -       if (final_rise_delay.maxlen >= 10 ||
> -           (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
> +       if (final_rise_delay.maxlen >= 12 && final_rise_delay.start < 4)
>                 goto skip_fall;
>
>         sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>         for (i = 0; i < PAD_DELAY_MAX; i++) {
>                 sdr_set_field(host->base + MSDC_PAD_TUNE,
>                               MSDC_PAD_TUNE_CMDRDLY, i);
> -               mmc_send_tuning(mmc, opcode, &cmd_err);
> -               if (!cmd_err)
> -                       fall_delay |= (1 << i);
> +               /*
> +                * Using the same parameters, it may sometimes pass the test,
> +                * but sometimes it may fail. To make sure the parameters are
> +                * more stable, we test each set of parameters 3 times.
> +                */
> +               for (j = 0; j < 3; j++) {
> +                       mmc_send_tuning(mmc, opcode, &cmd_err);
> +                       if (!cmd_err) {
> +                               fall_delay |= (1 << i);
> +                       } else {
> +                               fall_delay &= ~(1 << i);
> +                               break;
> +                       }
> +               }
>         }
>         final_fall_delay = get_best_delay(host, fall_delay);
>
>  skip_fall:
>         final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
> +       if (final_fall_delay.maxlen >= 12 && final_fall_delay.start < 4)
> +               final_maxlen = final_fall_delay.maxlen;
>         if (final_maxlen == final_rise_delay.maxlen) {
>                 sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>                 sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRDLY,
> @@ -1366,7 +1415,71 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>                               final_fall_delay.final_phase);
>                 final_delay = final_fall_delay.final_phase;
>         }
> +       if (host->hs200_cmd_int_delay)
> +               goto skip_internal;
> +
> +       for (i = 0; i < PAD_DELAY_MAX; i++) {
> +               sdr_set_field(host->base + MSDC_PAD_TUNE,
> +                             MSDC_PAD_TUNE_CMDRRDLY, i);
> +               mmc_send_tuning(mmc, opcode, &cmd_err);
> +               if (!cmd_err)
> +                       internal_delay |= (1 << i);
> +       }
> +       dev_dbg(host->dev, "Final internal delay: 0x%x\n", internal_delay);
> +       internal_delay_phase = get_best_delay(host, internal_delay);
> +       sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRRDLY,
> +                     internal_delay_phase.final_phase);
> +skip_internal:
> +       dev_dbg(host->dev, "Final cmd pad delay: %x\n", final_delay);
> +       return final_delay == 0xff ? -EIO : 0;
> +}
> +
> +static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
> +{
> +       struct msdc_host *host = mmc_priv(mmc);
> +       u32 cmd_delay = 0;
> +       struct msdc_delay_phase final_cmd_delay = { 0,};
> +       u8 final_delay;
> +       int cmd_err;
> +       int i, j;
> +
> +       /* select EMMC50 PAD CMD tune */
> +       sdr_set_bits(host->base + PAD_CMD_TUNE, BIT(0));
> +
> +       if (mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
> +           mmc->ios.timing == MMC_TIMING_UHS_SDR104)
> +               sdr_set_field(host->base + MSDC_PAD_TUNE,
> +                             MSDC_PAD_TUNE_CMDRRDLY,
> +                             host->hs200_cmd_int_delay);
> +
> +       if (host->hs400_cmd_resp_sel_rising)
> +               sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> +       else
> +               sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> +       for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> +               sdr_set_field(host->base + PAD_CMD_TUNE,
> +                             PAD_CMD_TUNE_RX_DLY3, i);
> +               /*
> +                * Using the same parameters, it may sometimes pass the test,
> +                * but sometimes it may fail. To make sure the parameters are
> +                * more stable, we test each set of parameters 3 times.
> +                */
> +               for (j = 0; j < 3; j++) {
> +                       mmc_send_tuning(mmc, opcode, &cmd_err);
> +                       if (!cmd_err) {
> +                               cmd_delay |= (1 << i);
> +                       } else {
> +                               cmd_delay &= ~(1 << i);
> +                               break;
> +                       }
> +               }
> +       }
> +       final_cmd_delay = get_best_delay(host, cmd_delay);
> +       sdr_set_field(host->base + PAD_CMD_TUNE, PAD_CMD_TUNE_RX_DLY3,
> +                     final_cmd_delay.final_phase);
> +       final_delay = final_cmd_delay.final_phase;
>
> +       dev_dbg(host->dev, "Final cmd pad delay: %x\n", final_delay);
>         return final_delay == 0xff ? -EIO : 0;
>  }
>
> @@ -1389,7 +1502,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>         }
>         final_rise_delay = get_best_delay(host, rise_delay);
>         /* if rising edge has enough margin, then do not scan falling edge */
> -       if (final_rise_delay.maxlen >= 10 ||
> +       if (final_rise_delay.maxlen >= 12 ||
>             (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
>                 goto skip_fall;
>
> @@ -1422,6 +1535,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>                 final_delay = final_fall_delay.final_phase;
>         }
>
> +       dev_dbg(host->dev, "Final data pad delay: %x\n", final_delay);
>         return final_delay == 0xff ? -EIO : 0;
>  }
>
> @@ -1430,7 +1544,10 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         struct msdc_host *host = mmc_priv(mmc);
>         int ret;
>
> -       ret = msdc_tune_response(mmc, opcode);
> +       if (host->hs400_mode)
> +               ret = hs400_tune_response(mmc, opcode);
> +       else
> +               ret = msdc_tune_response(mmc, opcode);
>         if (ret == -EIO) {
>                 dev_err(host->dev, "Tune response fail!\n");
>                 return ret;
> @@ -1443,6 +1560,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
>         host->saved_tune_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
> +       host->saved_tune_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
>         return ret;
>  }
>
> @@ -1477,6 +1595,25 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         .hw_reset = msdc_hw_reset,
>  };
>
> +static void msdc_of_property_parse(struct platform_device *pdev,
> +                                  struct msdc_host *host)
> +{
> +       of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
> +                            &host->hs400_ds_delay);
> +
> +       of_property_read_u32(pdev->dev.of_node, "mediatek,hs200-cmd-int-delay",
> +                            &host->hs200_cmd_int_delay);
> +
> +       of_property_read_u32(pdev->dev.of_node, "mediatek,hs400-cmd-int-delay",
> +                            &host->hs400_cmd_int_delay);
> +
> +       if (of_property_read_bool(pdev->dev.of_node,
> +                                 "mediatek,hs400-cmd-resp-sel-rising"))
> +               host->hs400_cmd_resp_sel_rising = true;
> +       else
> +               host->hs400_cmd_resp_sel_rising = false;
> +}
> +
>  static int msdc_drv_probe(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc;
> @@ -1548,10 +1685,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 goto host_free;
>         }
>
> -       if (!of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
> -                                 &host->hs400_ds_delay))
> -               dev_dbg(&pdev->dev, "hs400-ds-delay: %x\n",
> -                       host->hs400_ds_delay);
> +       msdc_of_property_parse(pdev, host);
>
>         host->dev = &pdev->dev;
>         host->mmc = mmc;
> @@ -1663,6 +1797,7 @@ static void msdc_save_reg(struct msdc_host *host)
>         host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
>         host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
>         host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
> +       host->save_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
>         host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
>  }
>
> @@ -1675,6 +1810,7 @@ static void msdc_restore_reg(struct msdc_host *host)
>         writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
>         writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
>         writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
> +       writel(host->save_para.pad_cmd_tune, host->base + PAD_CMD_TUNE);
>         writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
>  }
>
> --
> 1.7.9.5
>
