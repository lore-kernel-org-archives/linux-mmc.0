Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDEA471D16;
	Fri,  9 Oct 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529918; cv=none; b=AAziLLxFdYOxvv7Gs7stjJpK1whkta/PH6LgirjHBmIs+qxiDpHe7NoVpPVBo3XZchr9KBIDxO8lmsXRqWsZInQYSZoq0w0CkyM+BWZ5E5AJs1p3JnfMvPRuQSXbhrcOBljDTNdauEgxNdtIeQ7Lz3iF/82lo0NcJM2Fu75t0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529918; c=relaxed/simple;
	bh=kn4vth4vq4LX7Nr/w7aiUn7PLILS+b8gFxVLKowNkOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGBfxVyJNYp+HGczpAQL1GD0GHLEyKf8FzAi5ODy8Uxdz9aejrBUNPpaNMwEcq3iCtvRgUdKnyBa/0NkZEnkC2yqfDQJn3rR/M3G78YyNMWd9c01YFATBQYxcZH1ErOrWJ3VH9SopMvxMYBaLbBmwGKv+Z57VbdPfGCINY8WRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X3sIV03m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+soDEjPx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X3sIV03m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+soDEjPx"
Date: Fri, 9 Oct 2026 09:11:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791529915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qI0teZcXrHycO5RdYnELojTgh/o+UFCV/n+9LzyZqFg=;
	b=X3sIV03mGRKoi7W8A8eLx21lFQPk9jNvzBAIVcDFgpTgkCEXR3BOBvxukpbzsI6qt4reRZ
	u0U9jOaAH9hG4rsvdpa5JfYLRg6VRuPfnFUq7Yn7lOM4/Z6sGhlDTN0vKoiRGnt81Z+F+t
	hdjl51it/uC+VSPkeIkGsx+iMqOV3+MNtthUdtUovz4Sl8emgaCgXLtCTygyaF16VvJbeL
	oJlMBJtml6YpUkxWTRq88TIww9eXnU5zJsL2WMBK8asW+vZ3qAYVVSRVNUoOrmCIxiYBfT
	khqmkEyZMoPwM6v2b9ZOnpwYdUPQdCp/VJfgwTy1ags17xJmfPS+WkjPsdU5/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791529915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qI0teZcXrHycO5RdYnELojTgh/o+UFCV/n+9LzyZqFg=;
	b=+soDEjPxyf7SrT/DzxVpdDu44pE7aWoLjRK7cUgf3pcfnbJ8WFq2o6tDuDmZbsjly7XNh0
	ErnOHbhE1ujbCWBw==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-brcmstb: don't log an error for missing BOOT
 registers
Message-ID: <cfhxi3zbkkhnslbocne3moqdm34zre7x2qjdizlrlpmurcl5hj@vdvp5aevi7gk>
References: <20261009003201.68288-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009003201.68288-1-kmehltretter@gmail.com>

Hi, 

On Fri, Oct 09, 2026 at 02:32:01AM +0200, Karl Mehltretter wrote:
> The BOOT register range is optional: the probe function ignores a
> failure to map it and the suspend/resume code checks for NULL. It is
> mapped with devm_platform_get_and_ioremap_resource(), though, which
> calls dev_err_probe() when the resource does not exist. Every
> non-removable host without a third reg entry therefore logs an error
> at probe time and then works normally.
> 
> The binding only describes the "host" and "cfg" ranges, so this is the
> case for the in-tree users. On the Raspberry Pi 5 family (BCM2712),
> where the SDIO host of the Wi-Fi module is non-removable, each boot
> prints:
> 
>   sdhci-brcmstb 1001100000.mmc: error -EINVAL: invalid resource (null)
> 
> Look the resource up with platform_get_resource() first and map it only
> when it is present. Hosts that do have the range are mapped by the same
> two calls as before.
> 
> Fixes: b7e614802e3f ("mmc: sdhci-brcmstb: save and restore registers during PM")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Gregor Herburger <gregor.herburger@linutronix.de>
> ---
> Tested on a Raspberry Pi 500+ with v7.3-rc4: the message is gone, the
> SDIO card is detected as before and Wi-Fi works. Suspend/resume, the
> only user of these registers, was not tested.
I have seen this error a few times but newer looked into it. Thanks for the fix.
> 
>  drivers/mmc/host/sdhci-brcmstb.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 1de2f05..7c17a3c 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -491,6 +491,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	struct sdhci_brcmstb_priv *priv;
>  	u32 actual_clock_mhz;
>  	struct sdhci_host *host;
> +	struct resource *boot_res;
>  	struct clk *clk;
>  	struct clk *base_clk = NULL;
>  	int res;
> @@ -534,9 +535,13 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  	/* map non-standard BOOT registers if present */
>  	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
> -		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
> -		if (IS_ERR(priv->boot_regs))
> -			priv->boot_regs = NULL;
> +		boot_res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +		if (boot_res) {
> +			priv->boot_regs = devm_ioremap_resource(&pdev->dev,
> +								boot_res);
> +			if (IS_ERR(priv->boot_regs))
> +				priv->boot_regs = NULL;
> +		}
>  	}
>  
>  	/*
> 
> base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898

-- 
Gregor Herburger
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 35; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy 
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen | 
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700 
806 | Geschäftsführer (Managing Directors): Dr. Wilfried Wessner, 
Katharina Kopp, Alexander Gieringer
