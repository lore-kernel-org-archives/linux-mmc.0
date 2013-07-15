From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 2/5] mmc: dw_mmc: Add suspend_noirq/resume_noirq
 callbacks for dw_mmc-pltfm
Date: Mon, 15 Jul 2013 21:09:53 +0900
Message-ID: <004001ce8154$36753510$a35f9f30$%jun@samsung.com>
References: <1373411961-23812-1-git-send-email-dianders@chromium.org>
 <1373470926-19314-1-git-send-email-dianders@chromium.org>
 <1373470926-19314-3-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1373470926-19314-3-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Olof Johansson' <olof@lixom.net>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, July 11, 2013, Doug Anderson wrote:
> On some devices (like exynos5420) the dw_mmc controller may be in a
> strange state after we wake up from sleep.  Add callbacks to allow for
> dealing with these quirks.  We use the "_noirq" versions of the
> callbacks since in the case of exynos5420 the strange state caused
> interrupts to fire so we need to deal with it while interrupts are
> still off.
> 
> At the moment this support is only added to dw_mmc-pltfm which calls
> straight to the callback, since nobody but exynos needs it.  We can
> add some levels of indirection (a call into the generic dw_mmc code)
> when someone finds a need.
I think It would be better to add _noirq only to dw_mmc-exynos.
That is we can add dev_pm_ops for dw_mmc-exynos's own.
As you recognize, there is no common routine which is not introduced for dw_mmc xxx_noirq now.
I feel like it is for handling quirk.
If we meet use case for that in some day, it could be added commonly.
How do you think?

Thanks,
Seungwon Jeon
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> ---
> Changes in v3:
> - Add freeze/thaw and poweroff/restore noirq entries.
> 
> Changes in v2:
> - Use suspend_noirq as per James Hogan.
> 
>  drivers/mmc/host/dw_mmc-pltfm.c | 41 ++++++++++++++++++++++++++++++++++++++---
>  drivers/mmc/host/dw_mmc.h       |  4 ++++
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 41c27b7..742ef76 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -105,12 +105,47 @@ static int dw_mci_pltfm_resume(struct device *dev)
> 
>  	return 0;
>  }
> +
> +static int dw_mci_pltfm_suspend_noirq(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +
> +	if (drv_data && drv_data->suspend_noirq)
> +		return drv_data->suspend_noirq(host);
> +
> +	return 0;
> +}
> +
> +static int dw_mci_pltfm_resume_noirq(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +
> +	if (drv_data && drv_data->resume_noirq)
> +		return drv_data->resume_noirq(host);
> +
> +	return 0;
> +}
> +
> +
>  #else
> -#define dw_mci_pltfm_suspend	NULL
> -#define dw_mci_pltfm_resume	NULL
> +#define dw_mci_pltfm_suspend		NULL
> +#define dw_mci_pltfm_resume		NULL
> +#define dw_mci_pltfm_suspend_noirq	NULL
> +#define dw_mci_pltfm_resume_noirq	NULL
>  #endif /* CONFIG_PM_SLEEP */
> 
> -SIMPLE_DEV_PM_OPS(dw_mci_pltfm_pmops, dw_mci_pltfm_suspend, dw_mci_pltfm_resume);
> +const struct dev_pm_ops dw_mci_pltfm_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_pltfm_suspend, dw_mci_pltfm_resume)
> +	.suspend_noirq = dw_mci_pltfm_suspend_noirq,
> +	.resume_noirq = dw_mci_pltfm_resume_noirq,
> +	.freeze_noirq = dw_mci_pltfm_suspend_noirq,
> +	.thaw_noirq = dw_mci_pltfm_resume_noirq,
> +	.poweroff_noirq = dw_mci_pltfm_suspend_noirq,
> +	.restore_noirq = dw_mci_pltfm_resume_noirq,
> +};
> +
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> 
>  static const struct of_device_id dw_mci_pltfm_match[] = {
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 0b74189..5d0398f 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -190,6 +190,8 @@ extern int dw_mci_resume(struct dw_mci *host);
>   * @prepare_command: handle CMD register extensions.
>   * @set_ios: handle bus specific extensions.
>   * @parse_dt: parse implementation specific device tree properties.
> + * @suspend_noirq: called late in the suspend process
> + * @resume_noirq: called early in the resume process
>   *
>   * Provide controller implementation specific extensions. The usage of this
>   * data structure is fully optional and usage of each member in this structure
> @@ -202,5 +204,7 @@ struct dw_mci_drv_data {
>  	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
>  	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
>  	int		(*parse_dt)(struct dw_mci *host);
> +	int		(*suspend_noirq)(struct dw_mci *host);
> +	int		(*resume_noirq)(struct dw_mci *host);
>  };
>  #endif /* _DW_MMC_H_ */
> --
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
