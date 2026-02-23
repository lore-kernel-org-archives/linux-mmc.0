Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0861BC46
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856018; cv=pass; b=GxXp5Aj31lnW1JZ0lrlmIO+Rjli1sNc5zqOhGgLvxIgO8chKvVeN171As1VvIp9FL36MYYf0W8AzodiwdVyDr50rsUi8DzP2EBkv2DYvrKx8xa7OmvkqwdMLVzN9Ejpt/U20S6gNLB/3hHZnf+NszgtsFEQR/pBoXhFfu5gD2CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856018; c=relaxed/simple;
	bh=lVzAKetV3kjvZsxfpFYPUnjLYpAZnA4ROKcACNVd6Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLnSoBNBWGrMlkAaQzuTBjiQFLi8/3KpKfNN4V0d7jBdmAVuhefEnsFN4r+ddZJ98DztYHKQJEUe92INVsnsvUTwgfPOKgb9uthSelqmEEwp0jzwkc51aTDquUoPLXhiztjIJnw1/ZHnHU0sWeICJI33ufHh5AQSulnYHF72b6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wz6eDIJk; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wz6eDIJk"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e63b427aaso4587211e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 06:13:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771856015; cv=none;
        d=google.com; s=arc-20240605;
        b=Ab3OoDoIUiZHpgZD0DjPhf3Mo8ojr+6iU45zRmFT8FC434ARHeMc3QEgikXBmoSoPZ
         Nb5let6PPgGc6pTm2mJ2yBfmsh6Msc/f/jQYz3oZfGUII/9Y8DWdFyDwZSJI69Au6j1D
         Y+Y6xtqPgkkJ4gVhdux+usxtcC1QrAiTbq/4sn7jw9PejoTEqIe4PQajhkFNGIOfSpZ7
         IFkOjUwrfnGLDrt5lK0vEJmDMBfm9f7llnI/G6qet9cISponiF7XS/YzHhfcawPA5Vbo
         TyB9T/j3w2DFdyeyRifuc7NlIRlzrzvhbvMDIGMq1t3hCBWftr8W+fyMgXKKsPeLagoQ
         nlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TmjBplTn8jYs+VwG3/g2W5Aubg2dV/4A2mYzzDQ5dvE=;
        fh=gecxUnJdZU9MwXiwHK5Fk5Qd/8fiMkSlBtSXNktKX6k=;
        b=CkhJHbcqsuRHpNuaBpPKdxdLdLWHeMKAW84XvHsWHxdAxlMU+7Fh91/41fTBmVsRoe
         zt2sIX+DNvIheiWQ2gTmaGK+Rvba13cF7Ab/CiBaRnMBdRM0pcKLedFg7HMB6rA8QGAf
         LuDyQTMWTcc2DhExtaumVawD+M5gLUfV6zzDwFRut330zKhRQX0eHbm0CrJnn8gzhuVA
         ckfh7xfgusyYFSDdEQJGuot1sapqrwWDnVmCNPcPPa4tQF4ioFIbtzENyX6ynwOEr4Xg
         QNlccKeET2U2+JeXn+qt2vGcZ+rda3pr83O5DSdjvhmmVHN8RJBYn8PYmvt9eaUp4fUb
         xsMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771856015; x=1772460815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmjBplTn8jYs+VwG3/g2W5Aubg2dV/4A2mYzzDQ5dvE=;
        b=Wz6eDIJkyowz2faq63xDlY6sgJbCE73JNKmz9fhZqgdLLmOhHcelRUT5pmPHdbJ2X/
         mhiy5J5qwZNUmuuFOfpdSbiotgBA+Q3zr/GvUtIwOXpU89QgFqd5JH+68ifwYsz7WlQX
         GQP0cmrue1oQXCYGCDM1j185uuWaLzwTLsxTK/eLXs92V/dkMwGRoz1PAjzQZv9H3nKe
         XK8hyQCDNaZbGJHztjDUUIz1Gcue0H9D5P831aVsu96p/h0FUFdRZuEcjkN6L/PbYvcX
         8EcrlxWBtuDtMsSxaK54F7xvxgoYanSqR7DOjj8jkm+M7L4t6HIJqoDzeOYvad02G1bH
         Mp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856015; x=1772460815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmjBplTn8jYs+VwG3/g2W5Aubg2dV/4A2mYzzDQ5dvE=;
        b=wbdIMYiFT2LEjxnJHq/6cSdlYWDM4KbDniFEXFMnLrQtWBos+bO8LINwyCa4p1W0yT
         QQqm+tY4bFm0m2Ge7ftMrti9Ak6THoIYWqSFAHcE1PvEFhmWRtIQI5J3rsIDF8tRJvBi
         ddYpDkVfhNo55jluQjyKyqqKjP+Ko1v5ebKw1MaNp2hJFn7SXYRFp8zcr9HLWMOcSWud
         z1OuNPlwhs6kwHJhu+aqjlOdCleCT2StHLwgfF4QXFP9FEZI7oEhmGpbhlEZbKToddqD
         4lYj0fCIUpYHt6Mdlq0mi49j+cH3HtvViijp+BtW5qshV7fVXhujNAk4jn/Zx26G0rvv
         6Hjw==
X-Gm-Message-State: AOJu0YxYhjv6DoyhfsQEIH8un93EeAY5+C8nkkaumnxzty+8rzE9QrpM
	f45CcLpLn7Lwhk7HD9CDqSft4f4uhjNlAJUF+0ztQcqhNkmJZ94tIsSDAPIHpBRw5U9Szao+0RM
	NQiebN96leSaxoWwENGs6kTzGEf/cmEpslBJDXwK9wg==
X-Gm-Gg: AZuq6aJanz5FZ654/+8lWlLWzTD1ZC1TZ83rFsGqlGUYtWrlB+kK2RigCoy9ZUJiMjs
	oGFrq43X1f2CGmeAJ3kDEJjgW2WY9gu06o+MGJLOKEYUXMc2t6VwoKhKX6GJkBjb5AeOJTj+xYb
	yJlHrA+g/Oz1lk+yAnS2XO2E8li5aBLs48H8eNBtq21dCj/lpIABgxcocF0KYN61iOBAH8qc/ha
	Kf0BqE+uuDqXeIdOSnt24rxKkd7rsdRjsDnNcLEtDdI8JJco7XwgSB2B3IHPm4y1yut1V2Cze81
	H8sW/1hk
X-Received: by 2002:a05:6512:3409:b0:59e:13de:fe32 with SMTP id
 2adb3069b0e04-5a0ed896f49mr2697234e87.18.1771856015442; Mon, 23 Feb 2026
 06:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1770818434-31096-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1770818434-31096-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 15:12:59 +0100
X-Gm-Features: AaiRm50lEXuaG6_yWJefslBtu4oc0grTs_Hyna6NoCD-eItzrKGBfWqYjkreluk
Message-ID: <CAPDyKFrjngB_CXEAXLeEqEgpcOMsq+J0qCHry9z6CJrZ_oADAA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Rename dw_mci_pltfm_pmops to dw_mci_pmops
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Feb 2026 at 15:00, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Since it's moved to dw_mmc core and resued by others variant host
> drivers, so drop the pltfm notation.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-bluefield.c | 2 +-
>  drivers/mmc/host/dw_mmc-k3.c        | 2 +-
>  drivers/mmc/host/dw_mmc-pci.c       | 2 +-
>  drivers/mmc/host/dw_mmc-pltfm.c     | 2 +-
>  drivers/mmc/host/dw_mmc-pltfm.h     | 2 +-
>  drivers/mmc/host/dw_mmc.c           | 4 ++--
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> index ed6dea4..81dc072 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -73,7 +73,7 @@ static struct platform_driver dw_mci_bluefield_pltfm_driver = {
>                 .name           = "dwmmc_bluefield",
>                 .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = dw_mci_bluefield_match,
> -               .pm             = pm_ptr(&dw_mci_pltfm_pmops),
> +               .pm             = pm_ptr(&dw_mci_pmops),
>         },
>  };
>
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 8b1b4cf..59b802c 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -455,7 +455,7 @@ static struct platform_driver dw_mci_k3_pltfm_driver = {
>                 .name           = "dwmmc_k3",
>                 .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = dw_mci_k3_match,
> -               .pm             = pm_ptr(&dw_mci_pltfm_pmops),
> +               .pm             = pm_ptr(&dw_mci_pmops),
>         },
>  };
>
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
> index e046674..a2e1b4d 100644
> --- a/drivers/mmc/host/dw_mmc-pci.c
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -84,7 +84,7 @@ static struct pci_driver dw_mci_pci_driver = {
>         .probe          = dw_mci_pci_probe,
>         .remove         = dw_mci_pci_remove,
>         .driver         =       {
> -               .pm =   pm_ptr(&dw_mci_pltfm_pmops),
> +               .pm =   pm_ptr(&dw_mci_pmops),
>         },
>  };
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 079d0cc..68770aa 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -125,7 +125,7 @@ static struct platform_driver dw_mci_pltfm_driver = {
>                 .name           = "dw_mmc",
>                 .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = dw_mci_pltfm_match,
> -               .pm             = &dw_mci_pltfm_pmops,
> +               .pm             = pm_ptr(&dw_mci_pmops),
>         },
>  };
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
> index 64cf752..ef1b05d 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.h
> +++ b/drivers/mmc/host/dw_mmc-pltfm.h
> @@ -11,6 +11,6 @@
>  extern int dw_mci_pltfm_register(struct platform_device *pdev,
>                                 const struct dw_mci_drv_data *drv_data);
>  extern void dw_mci_pltfm_remove(struct platform_device *pdev);
> -extern const struct dev_pm_ops dw_mci_pltfm_pmops;
> +extern const struct dev_pm_ops dw_mci_pmops;
>
>  #endif /* _DW_MMC_PLTFM_H_ */
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 97e8800..b2a6538 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3523,11 +3523,11 @@ int dw_mci_runtime_resume(struct device *dev)
>  }
>  EXPORT_SYMBOL(dw_mci_runtime_resume);
>
> -const struct dev_pm_ops dw_mci_pltfm_pmops = {
> +const struct dev_pm_ops dw_mci_pmops = {
>         SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>         RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
>  };
> -EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> +EXPORT_SYMBOL_GPL(dw_mci_pmops);
>
>  static int __init dw_mci_init(void)
>  {
> --
> 2.7.4
>
