Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F941DE4CD
	for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170483; cv=none; b=Zce3Cukud7ulqSV+7AA4uhcVsJMiPzsKd7ocs9DaLxCY+JBRbgIYGyPg4vKBU2WMJu41fVPEj+miQ3EqevK3O+jTsIndm4VL3dNbK2jpI+to+kuTaNjVtDVuMHsvWvrrkFqPDczzwR/tTts/eeNGULzKmpwASJmO3PpdnK/fwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170483; c=relaxed/simple;
	bh=c0bfB1CKojeKX92hRJPTg5p5/+lQ8IefKxOSkHcyjO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5o25H0xvZYAqWqWwAbEg4Sqx3nLB9PqEN21bdd9FhovdRFfpElwI3kD60hGj02a800rYx+G3Ay4oG6onR+p4HA/w1VrcQkkDHx3tFo42Xk8VHVoKU6cZLQ6Vh4Mjej2U+rivqGBnkR+9nL1cH8Ui9VOx0QidCIoBW7V/O3HB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qEw5DLXG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEw5DLXG"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e2772f7df9so8749527b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2024 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729170478; x=1729775278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZazD9r+QSLhnAO9QyZ44wGVSQLeXIw2HIXMUQofmO6w=;
        b=qEw5DLXGznRdbFqkSd1ii9xqzJaKiG0n4TIn7Lf0XvMDHHQxWs6Fsp4+3HI8kP1l8H
         MTg2LT1Zr6Izvtx/U+GyGUOJuYNwVSJa/pxCqT20JL8e0mbHSJDAsCFiegMyAiWdotgk
         I6OzWank3tVFYzfyi1ma8wV+7b7qm0x4Fs+azVruIc5mKa21vIatjyFmGbEcW28Stdm2
         rOhwhapUY/K9pq85vz9OR8c3ejTbA2GmpK7z/AiGR5REsi0RCdzU7MrF+pTfz/Mwr9Xk
         zC/3JSnwQY7TeVlPeFO/zDCZ4ghgoYIAQknI1nXA9dlp+nhZe+8IY2NZ3n4eW+2ZUW7I
         Xu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170478; x=1729775278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZazD9r+QSLhnAO9QyZ44wGVSQLeXIw2HIXMUQofmO6w=;
        b=j1pLSN7u202tekmpY46YbbX8EhdXsRLojcbUpKOBK2STDTdPuKIVJu3RPh99WTFU7N
         R8mb7+BQpHB92B3gx14lX9xzFLWAM7odhzBM926UCX0HkCpmF/wK9rZRSHnLGluFZF1Y
         G4h55batLwr1mcGrcFXzZdPoAvpwnMsfxyw6RXJ8Lakc6vEuvPtnFbH/DUNPFbGEYIeE
         2OVpPicptnIVdPZsBCWupaXYDnHShuTVIzzIveI+dKEermVScaEPIS3ZvHH/6i57ynLm
         FEcDgYSnA3GXahdJEIDryuCeVS20fJ2M2PcM8vl8XbnM/3lOYAjpftdbtP0AULK/xPnq
         cv5w==
X-Forwarded-Encrypted: i=1; AJvYcCX5rHB91SrvdwQLaGjYYNa+66NZ4lkln+HwMY2Tj6vsg4aOeX4cg45GwT3hXxLFOtDcx5MmjUoaYug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQJmcO70Dhj8/TsffF5qvcG1sWfwpc60W+nYi5N00tRP99O+2
	KLv3YyvBJoLTkpLon9v8/k8DIY1kqje9KDr5q2em5NzkLt1VtzeAFGL8GXmbQatBa3y9TYPEvTz
	X8ZxDIaDFl9CCoT8rBw0hWbaoNuu7NpUTOt9caQ==
X-Google-Smtp-Source: AGHT+IFD/gjUzQbbNJWQ5oL5BN76j/UHFd9jGMXlet0DrOEnAF5gNXy8XvWpGdFQ9Exj+PRU+DXn5f1++kiRqKhMIr0=
X-Received: by 2002:a05:690c:389:b0:64b:5cc7:bcbc with SMTP id
 00721157ae682-6e347c48627mr218937157b3.32.1729170478430; Thu, 17 Oct 2024
 06:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014060130.1162629-1-haibo.chen@nxp.com> <20241014060130.1162629-3-haibo.chen@nxp.com>
In-Reply-To: <20241014060130.1162629-3-haibo.chen@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 17 Oct 2024 15:07:22 +0200
Message-ID: <CAPDyKFr37wLYxdFJ-Lgbq7PbWyiQz+CuwMxwgeeP3QpMvdyjqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the system PM logic
To: haibo.chen@nxp.com
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 08:00, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Current suspend/resume logic has one issue. in suspend, will config
> register when call sdhci_suspend_host(), but at this time, can't
> guarantee host in runtime resume state. if not, the per clock is gate
> off, access register will hung.
>
> Now use pm_runtime_force_suspend/resume() in NOIRQ_SYSTEM_SLEEP_PM,
> add in NOIRQ stage can cover SDIO wakeup feature, because in interrupt
> handler, there is register access, need the per clock on.
>
> In sdhci_esdhc_suspend/sdhci_esdhc_resume, remove sdhci_suspend_host()
> and sdhci_resume_host(), all are handled in runtime PM callbacks except
> the wakeup irq setting.
>
> Remove pinctrl_pm_select_default_state() in sdhci_esdhc_resume, because
> pm_runtime_force_resume() already config the pinctrl state according to
> ios timing, and here config the default pinctrl state again is wrong for
> SDIO3.0 device if it keep power in suspend.

I had a look at the code - and yes, there are certainly several
problems with PM support in this driver.

>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 39 +++++++++++++++---------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c7582ad45123..18febfeb60cf 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1871,11 +1871,13 @@ static int sdhci_esdhc_suspend(struct device *dev)
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> -       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> -               ret = cqhci_suspend(host->mmc);
> -               if (ret)
> -                       return ret;
> -       }
> +       /*
> +        * Switch to runtime resume for two reasons:
> +        * 1, there is register access, so need to make sure gate on ipg clock.

You are right that we need to call pm_runtime_get_sync() for this reason.

However, the real question is rather; Under what circumstances do we
really need to make a register access beyond this point?

If the device is already runtime suspended, I am sure we could just
leave it in that state without having to touch any of its registers.

As I understand it, there are mainly two reasons why the device may be
runtime resumed at this point:
*) The runtime PM usage count has been bumped in
sdhci_enable_sdio_irq(), since the SDIO irqs are enabled and it's
likely that we will configure them for system wakeup too.
*) The device has been used, but nothing really prevents it from being
put into a low power state via the ->runtime_suspend() callback.

> +        * 2, make sure the pm_runtime_force_suspend() in NOIRQ stage really
> +        *    invoke its ->runtime_suspend callback.
> +        */

Rather than using the *noirq-callbacks, we should be able to call
pm_runtime_force_suspend() from sdhci_esdhc_suspend(). And vice versa
for sdhci_esdhc_resume().

Although, according to my earlier comment above, we also need to take
into account the SDIO irq. If it's being enabled for system wakeup, we
must not put the controller into low power mode by calling
pm_runtime_force_suspend(), otherwise we will not be able to deliver
the wakeup, right?

> +       pm_runtime_get_sync(dev);
>
>         if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
>                 (host->tuning_mode != SDHCI_TUNING_MODE_1)) {
> @@ -1883,12 +1885,11 @@ static int sdhci_esdhc_suspend(struct device *dev)
>                 mmc_retune_needed(host->mmc);
>         }
>
> -       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> -               mmc_retune_needed(host->mmc);
> -
> -       ret = sdhci_suspend_host(host);
> -       if (ret)
> -               return ret;
> +       if (device_may_wakeup(dev)) {
> +               ret = sdhci_enable_irq_wakeups(host);
> +               if (!ret)
> +                       dev_warn(dev, "Failed to enable irq wakeup\n");
> +       }
>
>         ret = pinctrl_pm_select_sleep_state(dev);
>         if (ret)
> @@ -1904,22 +1905,18 @@ static int sdhci_esdhc_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         int ret;
>
> -       ret = pinctrl_pm_select_default_state(dev);
> +       ret = mmc_gpio_set_cd_wake(host->mmc, false);
>         if (ret)
>                 return ret;
>
>         /* re-initialize hw state in case it's lost in low power mode */
>         sdhci_esdhc_imx_hwinit(host);

This looks like another special use-case. If I understand correctly,
on some platforms some additional re-initialization of the controller
may be needed at system resume.

If you want to move towards using pm_runtime_force_suspend|resume(), I
suggest moving the above call into the ->runtime_resume() callback. To
allow the ->runtime_resume() callback to know when this
re-initialization is needed, we can use a flag that we set here and
clear in the ->runtime_resume() callback.

>
> -       ret = sdhci_resume_host(host);
> -       if (ret)
> -               return ret;
> -
> -       if (host->mmc->caps2 & MMC_CAP2_CQE)
> -               ret = cqhci_resume(host->mmc);
> +       if (host->irq_wake_enabled)
> +               sdhci_disable_irq_wakeups(host);
>
> -       if (!ret)
> -               ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);
>
>         return ret;
>  }
> @@ -2011,6 +2008,8 @@ static const struct dev_pm_ops sdhci_esdhc_pmops = {
>         SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
>         SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
>                                 sdhci_esdhc_runtime_resume, NULL)
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                                       pm_runtime_force_resume)
>  };
>
>  static struct platform_driver sdhci_esdhc_imx_driver = {
> --
> 2.34.1
>

Kind regards
Uffe
