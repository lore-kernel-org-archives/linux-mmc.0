From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH 2/3] mmc: sdhci-s3c: Fix crash on module insertion for
 second time
Date: Fri, 14 Sep 2012 16:16:22 +0530
Message-ID: <CAGxe1ZHT6R8DwqOiR3MXzPO97j=6-fw-6q1PtTZ3kA0E4iGvFw@mail.gmail.com>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org>
	<1347613731-29428-3-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1347613731-29428-3-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

good catch
Reviewed by: Girish K S <girish.shivananjappa@linaro.org>

On 14 September 2012 14:38, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> If sdhci-s3c driver is built as module, it gives following error if inserted
> again after removing. This was happening as pm_runtime_use_autosuspend() is
> called in sdhci_s3c_probe() function but in sdhci_s3c_remove() its complementry
> pm_runtime_dont_use_autosuspend() is not called.
>
> BUG: spinlock bad magic on CPU#1, insmod/955
>  lock: 0xee771368, .magic: 00000000, .owner: insmod/955, .owner_cpu: 1
> [<c00147e0>] (unwind_backtrace+0x0/0xf8) from [<c0136b40>] (do_raw_spin_unlock+0xa4/0xe4)
> [<c0136b40>] (do_raw_spin_unlock+0xa4/0xe4) from [<c01be508>] (_raw_spin_unlock_irqrestore+0xc/0x38)
> [<c01be508>] (_raw_spin_unlock_irqrestore+0xc/0x38) from [<c01a9334>] (sdhci_runtime_suspend_host+0x54/0x80)
> [<c01a9334>] (sdhci_runtime_suspend_host+0x54/0x80) from [<bf0060a8>] (sdhci_s3c_runtime_suspend+0x14/0x38 [sdhci_s3c])
> [<bf0060a8>] (sdhci_s3c_runtime_suspend+0x14/0x38 [sdhci_s3c]) from [<c016cb00>] (pm_generic_runtime_suspend+0x2c/0x40)
> [<c016cb00>] (pm_generic_runtime_suspend+0x2c/0x40) from [<c0170090>] (__rpm_callback+0x70/0x98)
> [<c0170090>] (__rpm_callback+0x70/0x98) from [<c01703f0>] (rpm_suspend+0xf0/0x534)
> [<c01703f0>] (rpm_suspend+0xf0/0x534) from [<c0171670>] (__pm_runtime_suspend+0x5c/0x74)
> [<c0171670>] (__pm_runtime_suspend+0x5c/0x74) from [<c016d018>] (pm_generic_runtime_idle+0x44/0x4c)
> [<c016d018>] (pm_generic_runtime_idle+0x44/0x4c) from [<c0170090>] (__rpm_callback+0x70/0x98)
> [<c0170090>] (__rpm_callback+0x70/0x98) from [<c0170984>] (rpm_idle+0xdc/0x18c)
> [<c0170984>] (rpm_idle+0xdc/0x18c) from [<c0171608>] (pm_runtime_set_autosuspend_delay+0x30/0x3c)
> [<c0171608>] (pm_runtime_set_autosuspend_delay+0x30/0x3c) from [<bf0069c4>] (sdhci_s3c_probe+0x35c/0x52c [sdhci_s3c])
> [<bf0069c4>] (sdhci_s3c_probe+0x35c/0x52c [sdhci_s3c]) from [<c016a014>] (platform_drv_probe+0x18/0x1c)
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 0cbb4c2..3f4518d 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -658,6 +658,7 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>
>         sdhci_remove_host(host, 1);
>
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>
>         clk_disable(sc->clk_bus[sc->cur_clk]);
> --
> 1.7.9.5
>
