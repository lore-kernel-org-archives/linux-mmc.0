From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v5 2/4] mmc: dw_mmc: Add exynos resume_noirq callback to
 clear WAKEUP_INT
Date: Mon, 12 Aug 2013 16:21:48 +0900
Message-ID: <000e01ce972c$9be7d4a0$d3b77de0$%jun@samsung.com>
References: <1375825071-20922-1-git-send-email-dianders@chromium.org>
 <1376066000-5495-1-git-send-email-dianders@chromium.org>
 <1376066000-5495-3-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1376066000-5495-3-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Olof Johansson' <olof@lixom.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Doug,
Looks good to me except for minor comment.

On Sat, August 10, 2013, Doug Anderson wrote:
> If the WAKEUP_INT is asserted at wakeup and not cleared, we'll end up
> looping around forever.  This has been seen to happen on exynos5420
> silicon despite the fact that we haven't enabled any wakeup events due
> to a silicon errata.  It is safe to do on all exynos variants.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v5:
> - Cleaned up dw_mci_exynos_resume_noirq() comment as per Seungwon.
> - Don't memcpy dev_pm_ops structure, define a new one.
> 
> Changes in v4:
> - Take Seungwon's suggestion and don't add any dw_mmc-pltfm code.
> 
> Changes in v3:
> - Add freeze/thaw and poweroff/restore noirq entries.
> 
> Changes in v2:
> - Use suspend_noirq as per James Hogan.
> 
>  drivers/mmc/host/dw_mmc-exynos.c | 56 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 866edef..7d88583 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -30,6 +30,7 @@
>  #define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
>  					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
>  					SDMMC_CLKSEL_CCLK_DIVIDER(z))
> +#define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
> 
>  #define EXYNOS4210_FIXED_CIU_CLK_DIV	2
>  #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
> @@ -100,6 +101,52 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
>  	return 0;
>  }
> 
> +#ifdef CONFIG_PM_SLEEP
> +/*
> + * TODO: we should probably disable the clock to the card in the suspend path.
In suspend, clock is gated, isn't it?
Rather, no comment looks better, if intention is not clear.

Thanks,
Seungwon Jeon

> + */
> +static int dw_mci_exynos_suspend(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +
> +	return dw_mci_suspend(host);
> +}
> +
> +static int dw_mci_exynos_resume(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +
> +	return dw_mci_resume(host);
> +}
> +
> +/**
> + * dw_mci_exynos_resume_noirq - Exynos-specific resume code
> + *
> + * On exynos5420 there is a silicon errata that will sometimes leave the
> + * WAKEUP_INT bit in the CLKSEL register asserted.  This bit is 1 to indicate
> + * that it fired and we can clear it by writing a 1 back.  Clear it to prevent
> + * interrupts from going off constantly.
> + *
> + * We run this code on all exynos variants because it doesn't hurt.
> + */
> +
> +static int dw_mci_exynos_resume_noirq(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	u32 clksel;
> +
> +	clksel = mci_readl(host, CLKSEL);
> +	if (clksel & SDMMC_CLKSEL_WAKEUP_INT)
> +		mci_writel(host, CLKSEL, clksel);
> +
> +	return 0;
> +}
> +#else
> +#define dw_mci_exynos_suspend		NULL
> +#define dw_mci_exynos_resume		NULL
> +#define dw_mci_exynos_resume_noirq	NULL
> +#endif /* CONFIG_PM_SLEEP */
> +
>  static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>  {
>  	/*
> @@ -187,13 +234,20 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
>  	return dw_mci_pltfm_register(pdev, drv_data);
>  }
> 
> +const struct dev_pm_ops dw_mci_exynos_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend, dw_mci_exynos_resume)
> +	.resume_noirq = dw_mci_exynos_resume_noirq,
> +	.thaw_noirq = dw_mci_exynos_resume_noirq,
> +	.restore_noirq = dw_mci_exynos_resume_noirq,
> +};
> +
>  static struct platform_driver dw_mci_exynos_pltfm_driver = {
>  	.probe		= dw_mci_exynos_probe,
>  	.remove		= __exit_p(dw_mci_pltfm_remove),
>  	.driver		= {
>  		.name		= "dwmmc_exynos",
>  		.of_match_table	= dw_mci_exynos_match,
> -		.pm		= &dw_mci_pltfm_pmops,
> +		.pm		= &dw_mci_exynos_pmops,
>  	},
>  };
> 
> --
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
