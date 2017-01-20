From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 3/3] mmc: mediatek: Use data tune for CMD line tune
Date: Fri, 20 Jan 2017 09:22:04 +0100
Message-ID: <CAPDyKFrg1pgs9Kdx6Wia_Pb7fdBjO=mwfMTzicAOqx4CVrohLg@mail.gmail.com>
References: <1484821156-20565-1-git-send-email-yong.mao@mediatek.com> <1484821156-20565-4-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484821156-20565-4-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>  struct msdc_delay_phase {
> @@ -331,6 +339,9 @@ struct msdc_host {
>         unsigned char timing;
>         bool vqmmc_enabled;
>         u32 hs400_ds_delay;
> +       u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104 */
> +       u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
> +       u32 hs400_cmd_resp_sel;  /* cmd response sample selection for HS400 */

When you converted the DT binding, this should become bool instead.

>         bool hs400_mode;        /* current eMMC will run at hs400 mode */
>         struct msdc_save_para save_para; /* used when gate HCLK */
>         struct msdc_tune_para def_tune_para; /* default tune setting */

[...]

> +static void msdc_of_property_parse(struct platform_device *pdev,
> +                                  struct msdc_host *host)
> +{
> +       if (!of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
> +                                 &host->hs400_ds_delay))
> +               dev_dbg(&pdev->dev, "hs400-ds-delay: %x\n",
> +                       host->hs400_ds_delay);

Writing a dev_dbg for each parsed DT property, seems a bit silly. Can
you please remove that.

> +
> +       if (!of_property_read_u32(pdev->dev.of_node, "mtk-hs200-cmd-int-delay",
> +                                 &host->hs200_cmd_int_delay))
> +               dev_dbg(&pdev->dev, "host->hs200-cmd-int-delay: %x\n",
> +                       host->hs200_cmd_int_delay);
> +
> +       if (!of_property_read_u32(pdev->dev.of_node, "mtk-hs400-cmd-int-delay",
> +                                 &host->hs400_cmd_int_delay))
> +               dev_dbg(&pdev->dev, "host->hs400-cmd-int-delay: %x\n",
> +                       host->hs400_cmd_int_delay);
> +
> +       if (!of_property_read_u32(pdev->dev.of_node, "mtk-hs400-cmd-resp-sel",
> +                                 &host->hs400_cmd_resp_sel))
> +               dev_dbg(&pdev->dev, "host->hs200_cmd-resp-sel: %x\n",
> +                       host->hs400_cmd_resp_sel);
> +}
> +
>  static int msdc_drv_probe(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc;
> @@ -1497,7 +1635,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         ret = mmc_of_parse(mmc);
>         if (ret)
>                 goto host_free;
> -

Whitespace.

>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         host->base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(host->base)) {
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

Please also fold in the change suggested/reported by the kbuild test robot.

Besides the minor things, this looks good to me!

Kind regards
Uffe
