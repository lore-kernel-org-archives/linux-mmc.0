Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29553EB0E5
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283056; cv=none; b=FwR1FnGvk+aGEYQNiphHLx4xFebVpWe2l4iCRH6U3g9mODLs6z6j9L0P9lefHr9vAx/Vbn316bly11rUAz2ZDv/iEfzO7pGzzZNCIQj+FMduSc0k+zpHhHoi0D9b7FDktnIPTWLqntBP60twENb+sDJtQ3TP9w0sdmItU3jXVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283056; c=relaxed/simple;
	bh=ldQ/iUGMrGHxKXxkUXAQa6J8x3uVZmvW1Kddq04F3bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VscKVuIJPmltslJ+vinRgk67SS8Tf8zCVV0EoavNAIGMUPmDiwpC7NxiC0BO7LN8uLkYUjvuD49GhV+uibertiCiNO8VlnTMFNA0mi2kWrMj089RcTs+4VmqSHh8hoxU/Au1FvPXMJJH5PNM+Ax4WA8CLz32C0xIo4RTVvau/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA0nuJKD; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA0nuJKD"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4518ad44e83so2557206fac.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784283053; x=1784887853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vijqM8KLfxoJ7zWFWIhaauEg3BKDHA3EobwX8Ha/oEk=;
        b=bA0nuJKDaZifJ6cWLZ6eBETdyJP/xZAssluBGKTUWCzTMpBkwAUJFXAN/Ih4ayBhTX
         OSP/gTNGnwvtyUPxwBPswZP3+v9lFNEQoOeGB9Cu670kJSknvHPm2sTmtWfcIBmlK2aZ
         5IwhBxSaspoWJlZEXW4/TWlB1hTE1dJn/ZIcT9sdyVuL0UWh9k4A0aDnCSCYQEzfRIuS
         w6wVXbK2qxg8XlD90PVPiA1HU0I/PtXjhPfqeIe+MMI9IeK/xXBLZ6Dik9jReOVzRnAx
         7GFAFw3WrRVsMmY8m8mPNPKLP2IbF+UuAbzcCEPh6znwrRXQhdJ/3h8i5DlxXk91mnq7
         9F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784283053; x=1784887853;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vijqM8KLfxoJ7zWFWIhaauEg3BKDHA3EobwX8Ha/oEk=;
        b=m8BgNRPvVYjg5b9An6kIcQ5zLkuSGkK6StrgUTA1yjykDx61bL23P1GYm0xuLRiCpV
         nsuBATyvDmTVVHBIUIDE/z+xFhfQG7y8WJPecSQGNtAR9O2kvnMakkdDmRbKbIMXv+8m
         qc/XzNTUmqxzI8LC5rWQFQET5pYB0CZNYaVMwQU1YoTVcdPQQgYaFk9H0HaFygP9Vxeo
         TS+/bQKky3msdxa/2EiZ2vG228QQbWmlHfb7K5SkAgHhtx98s59ENLlBkKgLorR79RNL
         Esye5HxiIvNmNJKC104HSBqQr1cQZ6hT5LSIIDzI+N4dvkEVQR/gT3MHx7Dc3cXKICVh
         Hnig==
X-Forwarded-Encrypted: i=1; AHgh+RqFHyM8y0pqbliHxPcwiVNRc2nbrhPjxadrCb0bPZx5LO1jgMPB3ebDhnAmwGdBdDV1ohBeVMKDm2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmtz7KhcEpwVS+dCLAvFaMj5DD4QTfeJ34lPsHXUApjrlNkQjB
	YtZTyvs24cbInMJ6vgOCiU4AnfX2XEVBGk714QCVEIO+0HCaPLU2FMNf
X-Gm-Gg: AfdE7cl4ZLaOAClUP54KdZciAM7xIjxqeCII04t4z7YsbhlEkRd/CZDU0Ojr4lhcd4f
	OJNGT7FS5d0U8mJ5lwqQG0Q9vjufRBU9aMN7gLvtOyJLxYdLOj1ZCVht+h2tkAnA6KTjt63y4CC
	ux1qyQ27jkkpbspHsNe3pIs7FCeGA7GYzlRcWVywW1k3MYSdksgowSS0+EP++F7TJZpObiDfTEc
	ysxQRenzoOQy1FtCQNhF+yutPU8JhtwW5ht253biBmMuozGQtF47mvu8zX16V0yXJkb3pecZ8Hc
	DBSPID12vEN6nnKMIzMA0UDGHBI4/BGyTDpo0RDWNh/IKC1NTq3bbVERSYNMHQTrVml3aee/OU7
	8+eqWToT1UEpzMtUEe8KtozyGsRAhuDnb18dCxPFL745RLsKQX/Yc/KsiKKoi2MHPdzwZQQ==
X-Received: by 2002:a05:6870:b3ed:b0:455:c1d1:9cc0 with SMTP id 586e51a60fabf-456901aa97bmr914974fac.19.1784283053390;
        Fri, 17 Jul 2026 03:10:53 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4568e61cee3sm970024fac.9.2026.07.17.03.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:10:51 -0700 (PDT)
Date: Fri, 17 Jul 2026 13:10:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
	s32@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, harshit.m.mogalapalli@oracle.com
Subject: Re: [PATCH v7 8/8] mmc: sdhci-esdhc-imx: fix resume error handling
Message-ID: <aln_pFNqL8495Y_a@stanley.mountain>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
 <20260715071818.272318-9-ziniu.wang_1@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715071818.272318-9-ziniu.wang_1@oss.nxp.com>

On Wed, Jul 15, 2026 at 03:18:18PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> Check pm_runtime_force_resume() return value in resume. If it fails
> (clock enable failure), return immediately since accessing hardware
> registers on an unclocked device would cause a kernel panic.
> 

The commit message says "would" which implies maybe...  Is this something
that happens in real life?


> The early return intentionally skips enable_irq() and
> sdhci_disable_irq_wakeups() because the IRQ handler reads
> SDHCI_INT_STATUS, which would also fault without clocks. The PM runtime
> usage counter leak only affects this already-broken device instance and
> is an acceptable tradeoff to preserve system stability.
> 
> Remove the return value check for mmc_gpio_set_cd_wake(host->mmc, false)
> since disable_irq_wake() called internally always returns 0.

I kind of agree with Sashiko here that keeping the check is better future
proofing.

> 
> Also return 0 explicitly on the success path instead of propagating
> stale return values.

Unrelated cleans...  :/

> 
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 290a3172931b..18f4905c15b9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2123,12 +2123,12 @@ static int sdhci_esdhc_resume(struct device *dev)
>  			dev_warn(dev, "Failed to restore pinctrl state\n");
>  	}
>  
> -	pm_runtime_force_resume(dev);
> -
> -	ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +	ret = pm_runtime_force_resume(dev);
>  	if (ret)
>  		return ret;
>  
> +	mmc_gpio_set_cd_wake(host->mmc, false);
> +

copy-paste-checker says that similar code exists in:

drivers/mmc/host/sdhci-tegra.c
  1879  static int sdhci_tegra_resume(struct device *dev)
  1880  {
  1881          struct sdhci_host *host = dev_get_drvdata(dev);
  1882          int ret;
  1883  
  1884          ret = mmc_gpio_set_cd_wake(host->mmc, false);
  1885          if (ret)
  1886                  return ret;
  1887  
  1888          ret = pm_runtime_force_resume(dev);
  1889          if (ret)
  1890                  return ret;

In this case we are calling mmc_gpio_set_cd_wake() before calling
resume so it's surprising that that doesn't cause a panic..

  1891  
  1892          sdhci_tegra_program_stream_id(host);
  1893  
  1894          ret = sdhci_resume_host(host);
  1895          if (ret)
  1896                  goto disable_clk;
  1897  
  1898          if (host->mmc->caps2 & MMC_CAP2_CQE) {
  1899                  ret = cqhci_resume(host->mmc);
  1900                  if (ret)
  1901                          goto suspend_host;
  1902          }
  1903  
  1904          return 0;
  1905  
  1906  suspend_host:
  1907          sdhci_suspend_host(host);
  1908  disable_clk:
  1909          pm_runtime_force_suspend(dev);
  1910          return ret;
  1911  }

regards,
dan carpenter
 
