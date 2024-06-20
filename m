Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEE200AF
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885347; cv=none; b=W66s+bdH2GeIBtxj2D7dxLiJ2tZgb/pNIUDFGO3rgSHzjjxyiO/5i/Wo73HZojFCAc/Ths5S8AxofTseiuDHMwd0SN0uizL2uz+LBGyPpAugjslb2OFejrRCcgx4VLfy33G1fXjYRE69A6D+DAKg5f599W6rLpkK/uY4rnmy4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885347; c=relaxed/simple;
	bh=48jNK/nN+we5mSQwgtEYIGL/qR5P/QIHlq2usz3YKbk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5i/hVh1xGhWJihg6kNfL+hI2snW+vHdAZ8PaznFuz1kdoOJH2EvmbC0JMY3zcXVLaPlyZKbUDwpPGqr/jUpfeQ0oELzorATmg6to2UhgACamkvb+kEFcqVJXjCc1X+tfl8lRRmH04wKYoOvo9FZlR1gyq4rdt2JUCDHzsqkBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gt54jydw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gt54jydw"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so6776651fa.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718885343; x=1719490143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1dDuHd3Lw3JeOXFjNDUh6A33G2y4ATNomX4TCEfNQs=;
        b=Gt54jydwsM8Y0Z21NgUiG5KhWLz8P5BPao3QPzpRnfZYQXBltQwcCS/p+D2aZnO2g+
         o7uGLpu0ehXYpjO9aF9bx1sclbT954vParEggJLktCZ8GkvbLsDQRFjb2hhiPuFtwrii
         7tIIKy1Ckc+h3nqqv6iluCxGUe1cTKLw+5qEBaFfC9uzgYCL04voDTj1EdO/fYd3ri/p
         JlgoY93dy3Bop1QGCPnJeuqyIT0TCHqPaYKdx13KXWbnffhxqts1J4UbYqidz7OsVVuQ
         n3SPwArgPKRINThQTk5oJPr6oekCQY4ruPbAsiR3AF9uUVoOECCjNWn4mR1HzKvIJve6
         2ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718885343; x=1719490143;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1dDuHd3Lw3JeOXFjNDUh6A33G2y4ATNomX4TCEfNQs=;
        b=TKoJg/ZUayB8ShQTnKoifUt1vOx20ljp6909drlYq16lHdR69ft5WNBwmMHR0tsbA5
         jMp49odg4XyQ75xuw6uYFistTB50/3I//Wi8sWoPPGxyUmcqJCv3QlPrcAfgUz0tjsCQ
         r4tdOWihIiMvpLWKvXy2GseYj4loYXTZZZkyo6kJJaUDBx5K/XAHWcM0FxeNuYO+ZP3D
         4epbBm7q3kxBx4tgLJt8Xp1PB6LKeW7qnJyxDNSF+7CmOFaUkcUSc5v7+WVLcCGFvMF+
         yce9HeiiD4vYi8vP1gMXta6LXuvBYCtDO/5HgTSc5L2kGYO/OrvANot+yScg+mcyO5wz
         ErTw==
X-Gm-Message-State: AOJu0YzAQRM7dF2jvcniiBkgN3naS5f+XvyKE6dJ3440t/Xq5eCvd+VV
	If8n73eFzHpMOnpW7MiHdCmzz5FAu0gb/bHYpZk69bvqJX2rIFOD/Ig2Aa0vPPvxeZ+8SDAOIHj
	U
X-Google-Smtp-Source: AGHT+IGcbXdmuXReNGMGxQdHXhhJBNuz2j+UubmG15weSgiIfxf1WVIH9s8Qd2jMQYajA45UOFn41w==
X-Received: by 2002:a2e:7a02:0:b0:2ec:476:7c60 with SMTP id 38308e7fff4ca-2ec3cec59c3mr32940161fa.27.1718885319475;
        Thu, 20 Jun 2024 05:08:39 -0700 (PDT)
Received: from localhost (host-62-211-197-135.pool62211.interbusiness.it. [62.211.197.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdfc4sm9504255a12.19.2024.06.20.05.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:08:39 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 20 Jun 2024 14:08:55 +0200
To: Peter Robinson <pbrobinson@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrea della Porta <andrea.porta@suse.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add ARCH_BCM2835 option
Message-ID: <ZnQb1_K1Ctvhtngy@apocalypse>
Mail-Followup-To: Peter Robinson <pbrobinson@gmail.com>,
	linux-mmc@vger.kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
References: <20240620074248.152353-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620074248.152353-1-pbrobinson@gmail.com>

Hi Peter,

On 08:42 Thu 20 Jun     , Peter Robinson wrote:
> The Raspberry Pi devices have to date all used ARCH_BCM2835
> as their SoC arch dependency so configurations that use this
> and not BRCMSTB won't end up with this module in their config.

AFAIK the BCM2712 (RPi5) is the only SoC of the Raspberry family
that has an MMC host controller that is more or less like the one
present on the STB line silicon. Adding ARCH_BCM2835 to the dependency
will then allow RPi<=4 to use this driver for which they do not
have the relevant hw.
If I'm correct about the aforementioned point, I'd be inclined to
avoid this change, then.

Many thanks,
Andrea

> 
> Cc: Andrea della Porta <andrea.porta@suse.com>
> Cc: Stefan Wahren <wahrenst@gmx.net>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: 40f22df5269e6 ("mmc: sdhci-brcmstb: Add BCM2712 support")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index bb0d4fb0892ae..eb3ecfe055910 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1016,7 +1016,7 @@ config MMC_SDHCI_MICROCHIP_PIC32
>  
>  config MMC_SDHCI_BRCMSTB
>  	tristate "Broadcom SDIO/SD/MMC support"
> -	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> +	depends on ARCH_BRCMSTB || ARCH_BCM2835 || BMIPS_GENERIC || COMPILE_TEST
>  	depends on MMC_SDHCI_PLTFM
>  	select MMC_CQHCI
>  	default ARCH_BRCMSTB || BMIPS_GENERIC
> -- 
> 2.45.2
> 
