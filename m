Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A759405F7
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779044440; cv=pass; b=ANfPopbxIPEZsntsfkKcLqCQaw/J7AUibrdF+CHB5aLAb8sndvF1bmRsEjtKDtwonKfU1ybD9mhCURjq6NQFJ7hAT2QPIx0gpPIOVnA4efN4MnR//50SSgzokyQB2NNXcaegPlS5DT0y0MyVwjWKxFzCBaZUlge0wH2LoNc5laI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779044440; c=relaxed/simple;
	bh=6Pu8ZFw5nRrpXUt8iauCXEouB2tgpYnUpfnYcSMw3nM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToVf8EbJBpi6RD81omtDA8wtguR5PmplIFUh5tPECiw9F6yx4FutmQ9vimD1AlvlSL411Su/wSvnZCOYgdQi4fmw1AMnRpOjCrtgSTUh5Mg8QF1klKZYorigOvPe0PBIOS3IUpAokHhC5cpvAtUZVnXJX662TAtfeSKbAwgtewU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=pPPgz4Z+; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="pPPgz4Z+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso2033619a12.2
        for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 12:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779044437; cv=none;
        d=google.com; s=arc-20240605;
        b=aIDYxDSidgDBuyA5xVCZLNI1AFEMZzn4+h8Q7Qp5aS+bKFZPS2NMyb/O6/cwXcQ1uk
         Lssmd0s49RT8E04shEy0N3p3o+0kfug7YkZN243hjsyEOCWY1NbjeOo3Xb5wV0Su+iaR
         wnTVf+rHp+QhymhKd5qJMsHdjdTLaHD7u9R/xVUqjbZKy2y6e+9xYdqzVZ6NM2Qj24fq
         56tNmbrWBqEGgrdMoIHc7sOdUM7gDHbxGFVkeAqFFBBTd50IWD6bigwWg4TVkrGEgDdF
         NyBdd4iGFmj4zoVUAB5xo1AhO/7AoSi9iu+wEU6Dc/pCw+Jkrr2Ef36bsL7u9mLHSkNk
         x6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=1JphhE5f2R3RqqlFjJRdSApyosT8RlyHaJ2EQJNTHbI=;
        fh=j7ocOvIlrcwSuADXjBbbMjjt+RePUzY2fOsaUf1iagQ=;
        b=JTrxMzW7aRV9+sqA8HFtPL4sGCF+cx1m4W/7NueM3fLomxIWni7ejWBA22ryl9Rn/s
         16z3StMKY6QQlTSIT751Vr4056TPCNyC7mooZj83W9f/uTWYWgfeHN9i1jpWh0Y15z3M
         x35CP9r5s3l9YfyM07J00nCOZ3Bu/UC29hWVXxBAWa5soQ8fN3ZtKqZ2CAARgWjXXUf+
         mlpAdV/I1ZSyT5J3JYY94g6UPSv4Qq8MwIj3jZXiZRnzrJLehtlm59sxuMTCfkwtApbg
         BGRNfExipe7L1z41EzWwqnAFQr1aURud75TZwGUvq+QLiw+r28+OYBAoqy4T+ovgewqk
         kKnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779044437; x=1779649237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JphhE5f2R3RqqlFjJRdSApyosT8RlyHaJ2EQJNTHbI=;
        b=pPPgz4Z+xn+jWVyeCOYNOJ1yhFTSklxinnR/S3/9XR4aKOzuvx/6+n3IVnOm+eq0Cz
         Of/q8FDC8n9tqVAAICKONzaxFa/iqWFSSPv9EVDsFqPRJoXrCfb3KawDt5+IgKgALT17
         2UXNVpPzpRN3QOgZZWHqIzafQP+jPfUwW4nblO92TnpAhk0vZ3SjVcdH1pR38PhpoBpp
         0v0yHgps/7yqR2SPOneN9qVf4RiAGryIeBegm3ehDcjWHOYAOhlo7mQnwzQzTH4qgPcj
         U4ksTVJhl4s1GsYzEm+w2PwWcAzbmO/tfmEr7r1t6MKtKCmbjIy6preAUXJBVKNBRm6A
         HmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779044437; x=1779649237;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JphhE5f2R3RqqlFjJRdSApyosT8RlyHaJ2EQJNTHbI=;
        b=nyYlsgKBXkdfjwbXG8v7dY5+GJDYY23H+8osqRJ+GJ8UPS8li8DsKrdd1L3mY0ViPW
         qgHdtD5O2SLmso2Z2qKyNdOroBA5oomLbkhq0nZ3szF+xcWCvgGwWDmPGUW3p+ccHANU
         GeUZtuWaNm/wumcz3efX8A1MzMjTZlRXVedu1AGXQ8rzGsvFEpe+M9lacva48wmW/Sf1
         XrTLpyBuQEdoQHQfN4yszmcGAE4PvK6gMReE6eG6aZgu3UJ1KgFR7nhILWW8bJIZYCvP
         EAKTOM9Li10CQbe3n9vQrR4UWHbpA6+Xdozr7JbpXqnuxSTAC0WD/HkLoMbXkEQ8JLhu
         HgPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fdQVdE1zwKhCx7+t6gCR5exc8j7pEQKCMpqGaL2yU44Mjd9NGlcUAf0E9kcPt8s19Mn2WPmeUiec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zuvYVf6YO9M6emj3mEW8/JTZ4eU06QJp/oIDE2YXeRpy5f35
	K59sw24lrjb9WZ4FVbzALdKpFTV4Nhg7GVrCLf8SsYgX+Z4P3AJwd5wxaTb1Em5+sGh0drpBZ2w
	Rpw9wOzJ/iWp+UqKlxz7pUj6zO+n24j6YC3lag7TCmg==
X-Gm-Gg: Acq92OGA+bnJ6jri70Xx/EfRLbBUzSw1TusCbMiswxnFqk07/nJwtJEm6htWDYNpK5T
	tb1tEX3JK1VwUBFAVsbp3s/FIAI0YkGbGsASEuzV8laGPx2SyMc0i4y3RWea1pBINdvnZkNBcPC
	T3ZFMq8UJHzt3oBpO0XKOFCl/5n3F8orSUrtEoMtaWAtj9YBw4EIILZeuGh0HiDXHFtrUfoKujQ
	kAlYx+TLxLumSVRCLo9SUg+gUVTErVYPjkrVlYf7n3kVa4S6ut9OZ/QN2Qkk+WXDX08yZxf1rUe
	E2eP38Qca1A0lUDNRqk6JOKOGVhjgfdrZpYp
X-Received: by 2002:a17:907:2da1:b0:bd5:b26:52d6 with SMTP id
 a640c23a62f3a-bd5177d78c9mr654774966b.5.1779044436258; Sun, 17 May 2026
 12:00:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 12:00:35 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 12:00:35 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-6-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260506142644.3234270-6-gerg@kernel.org>
Date: Sun, 17 May 2026 12:00:35 -0700
X-Gm-Features: AVHnY4JWE7dTwHmdk1WFCo-5y5V_ABFrYGVfcGaUQK_jNNfZ8FP0HbytljKloS0
Message-ID: <CALSJ-wDuXfMzV=Ydic-2S=2v+jbe034gqmy+wr-R1d14LBxuFQ@mail.gmail.com>
Subject: Re: [RFC 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel() on ColdFire
To: Greg Ungerer <gerg@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	arnd@kernel.org, Greg Ungerer <gerg@linux-m68k.org>, adureghello@baylibre.com, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

On Thu, May 07, 2026 at 12:26:46AM +1000, Greg Ungerer wrote:
> From: Greg Ungerer <gerg@linux-m68k.org>
>
> The implementation of the readX() and writeX() family of IO access
> functions is non-standard on ColdFire platforms. They check the supplied
> IO address and will return either big or little endian results based on
> that check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are wrong. This is now in the process of being
> cleaned up and fixed.
>
> Change the use of the readX() and writeX() access functions in this driver
> to use the recently defined specific ColdFire internal SoC hardware IO
> access functions mcf_read8()/mcf_read16()/mcf_read32() and
> mcf_write8()/mcf_write16()/mcf_write32().
>
> There is no functional change to the driver. Though it does have the
> effect of making the IO access slightly more efficient, since there is
> no longer a need to do the address check at every register access.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> Note that the patches to introduce mcf_readX() and mcf_writeX functions
> are not in mainline yet. They are currently in the m68knommu git tree
> for-next branch, and so should also be in linux-next.
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 375fce5639d7..6853521e8b2c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *host,
>  	if (reg == SDHCI_HOST_CONTROL)
>  		val |= ESDHC_PROCTL_D3CD;
>
> -	writel((readl(base) & ~mask) | val, base);
> +	mcf_write32((mcf_read32(base) & ~mask) | val, base);
>  }
>
>  /*
> @@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>  	if (reg == SDHCI_HOST_CONTROL) {
>  		u32 host_ctrl = ESDHC_DEFAULT_HOST_CONTROL;
>  		u8 dma_bits = (val & SDHCI_CTRL_DMA_MASK) >> 3;
> -		u8 tmp = readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
> +		u8 tmp = mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + 1);
>
>  		tmp &= ~0x03;
>  		tmp |= dma_bits;
> @@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>  		 */
>  		host_ctrl |= val;
>  		host_ctrl |= (dma_bits << 8);
> -		writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +		mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>
>  		return;
>  	}
>
> -	writel((readl(base) & mask) | (val << shift), base);
> +	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
> @@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
>  		 * As for the fsl driver,
>  		 * we have to set the mode in a single write here.
>  		 */
> -		writel(val << 16 | mcf_data->aside,
> +		mcf_write32(val << 16 | mcf_data->aside,
>  		       host->ioaddr + SDHCI_TRANSFER_MODE);
>  		return;
>  	}
>
> -	writel((readl(base) & mask) | (val << shift), base);
> +	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int reg)
>  {
> -	writel(val, host->ioaddr + reg);
> +	mcf_write32(val, host->ioaddr + reg);
>  }
>
>  static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  {
>  	if (reg == SDHCI_HOST_CONTROL) {
>  		u8 __iomem *base = host->ioaddr + (reg & ~3);
> -		u16 val = readw(base + 2);
> +		u16 val = mcf_read16(base + 2);
>  		u8 dma_bits = (val >> 5) & SDHCI_CTRL_DMA_MASK;
>  		u8 host_ctrl = val & 0xff;
>
> @@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  		return host_ctrl;
>  	}
>
> -	return readb(host->ioaddr + (reg ^ 0x3));
> +	return mcf_read8(host->ioaddr + (reg ^ 0x3));
>  }
>
>  static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> @@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
>  	if (reg == SDHCI_HOST_VERSION)
>  		reg -= 2;
>
> -	return readw(host->ioaddr + (reg ^ 0x2));
> +	return mcf_read16(host->ioaddr + (reg ^ 0x2));
>  }
>
>  static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
>  {
>  	u32 val;
>
> -	val = readl(host->ioaddr + reg);
> +	val = mcf_read32(host->ioaddr + reg);
>
>  	/*
>  	 * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> @@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_host *host,
>  	 * fvco = fsys * outdvi1 + 1
>  	 * fshdc = fvco / outdiv3 + 1
>  	 */
> -	temp = readl(pll_dr);
> +	temp = mcf_read32(pll_dr);
>  	fsys = pltfm_host->clock;
>  	fvco = fsys * ((temp & 0x1f) + 1);
>  	fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);
> --
> 2.54.0
>

Tested this now on stmark2, sdcard mount/umount/read/write/erase works
as usual. Thanks.

Acked-by: Angelo Dureghello <adureghello@baylibre.com>
Tested-by: Angelo Dureghello <adureghello@baylibre.com>


reagrds,
angelo
