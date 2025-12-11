Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673A222597
	for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765415458; cv=none; b=okwLI3MBrXVOv4und4EiwFSI0n8dgO00lTryIXVQ69qHrwEuT0d/Eh2aqrW51WQEwL1566gNrJNG8p5aQpMzYOLPSx3xMfIzrAhMXCDAqYFSKW2rAqS5DCCSbGPMylYPu2913WFGsB4bC7DRQks3b7suVNcUpaeMOggFWnvD1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765415458; c=relaxed/simple;
	bh=QSKFU015GrDwvBb0YJ/GAe1Mq7c6iU6OtXAQ+wmbvCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umkdhav3vViU7qUKSt+Vv0WCFOOWeUeyRbT9UnWCas99AtEENUPri7VF4Ak+uZS8Nl3P79Zj247L6WJzq0Tw64fXJ+ujBCFMiG3UIjXAWSCueyeKYCOIqBbGaOIWa9M18l2GAzuZifp30/pMAN+nNMNrTuvsKkJMsvXx30PbNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 262A7340AB6;
	Thu, 11 Dec 2025 01:10:54 +0000 (UTC)
Date: Thu, 11 Dec 2025 09:10:44 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Mohamed via Bugspray Bot <bugbot@kernel.org>, linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org
Subject: Re: Unaligned access in drivers/mmc/host/sdhci-of-k1.c (arch:ariscv
 soc:spacemit k1)
Message-ID: <20251211011044-GYA1890420@gentoo.org>
References: <20251205-b220841c0-b1d85d237308@bugzilla.kernel.org>
 <f6031c0f-ef68-474e-8e21-6ce39a2cb25e@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6031c0f-ef68-474e-8e21-6ce39a2cb25e@intel.com>

Hi Mohamed, Adrian:

On 09:35 Tue 09 Dec     , Adrian Hunter wrote:
> On 05/12/2025 23:00, Mohamed via Bugspray Bot wrote:
> > Mohamed writes via Kernel.org Bugzilla:
> > 
> > There is an unaligned access in spacemit_sdhci_set_uhs_signaling that calls spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
> > 
> > As SDHCI_HOST_CONTROL2	0x3E the helper function spacemit_sdhci_setbits uses readl and writel functions, 
> > ie.
> > /* All helper functions will update clr/set while preserve rest bits */
> > static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val, int reg)
> > {
> > 	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
> > }
> > 
> > So you get an unaligned access exception/panic/oops with cause 5 on the read.
> > 
> > To reproduce this you need to enable the emmc in the dtb as none of the boards have this enabled. It seems a bit strange that the commit message says that the emmc is working, as it is disabled in the emmc, yet there is working version based on 6.6 which does work. Obviously, it must be my mistake as the commit message cannot possibly lie and say that a driver is complete and working.
> > 
> > View: https://bugzilla.kernel.org/show_bug.cgi?id=220841#c0
> > You can reply to this message to join the discussion.
> 
> Adding Yixun Lan <dlan@gentoo.org>
> 
> Needs something like:
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 0cc97e23a2f9..634a362fd66a 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -112,8 +112,12 @@ static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned i
>  
>  	sdhci_set_uhs_signaling(host, timing);
>  
> -	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO))
the code path is targeting for sdio, which we haven't fully implemented for now
in the mainline code, and it's even skipped with "no-sdio" property in emmc DT node

> -		spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO)) {
> +		u16 ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +		ctrl_2 |= SDHCI_CTRL_VDD_180;
> +		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
It's might not enough to get sd/sdio work with above change.. 
or did you test the patch with sdhci1 controller using sdio(wifi, for exampe)?
if it works, then worth the effort to push the fix..

btw, we have plan to work on follow-up patches to support sd/sdio, stay tuned

-- 
Yixun Lan (dlan)
