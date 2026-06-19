Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AA29ACF6
	for <linux-mmc@vger.kernel.org>; Fri, 19 Jun 2026 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864699; cv=pass; b=PzCVvQgZwBjqCLJLFM0VSOT9N6tbhelseobxIoD333Xs8qgjJBill9jonCav0t2bAyL6BQq0GZgwwpMYHfo2AwecZdKojvLXjaGfKp7Nq/nsE4G5Xabp6L1q6pU5qVdgrg7OvIcTtWK3Qb1IgZMyJGpZESWcmbKG9CIueidkFxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864699; c=relaxed/simple;
	bh=ni/12ceZsW/f1/rf10e0NeNiqZaIvmVbzOgM9UdT9bo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUktlKPPrf9WNPZiuo/0ztQGRmmImeHlxL56rFFMI13Jq6kUC4bTFTLro36NcjcX10cykhBvkAF0FIePy0IbAN4HKDR+IORVz58d16MNEzzyN8Hwi0lOjDVQBbaVyp1Ybdd7aImeCJuD3nSjz/OaAiBZxu6u0i5HHpWOcTeO9x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DVuV13ZJ; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DVuV13ZJ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c0bce8840b6so31783066b.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 Jun 2026 03:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781864687; cv=none;
        d=google.com; s=arc-20240605;
        b=dVSjoye0GujPlD4Kf3ggZleALT78ZF/hgJ38r868hgYntlSmjsBVa+rbCbvv0NSNJE
         BkesvkABJ80X4spDKTVuMY3HkvV3L25bFuTja4/vnXIzzmc4JbFHPyzOADJ9vIFUyHzG
         N1yFkbjpkZx4t47CfJpjiKi3SRWvxm1U8XSDvI8mXY2fUVC/cpyBdlnT8xt+D4enKEHR
         tAKWfkD1C5DKWm52mF6NxH7UQMObro+V+5uHAaPAkEz4n80hUTF+39DKto5JT3+MZAKZ
         5M1dD+XnkBw0p0vKzx/xo9ohFUJS/WvJjOqCu876l6ZF/g/ZxpaFoRrMhSCK85oTYkpN
         OoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        fh=9FIoDJqSeF9TpVggTaOyoYQLc0bsJiqUvn6urWLljwU=;
        b=WX4WW0LaQTUu2cXgkgmImCtqwmXpYsELVjVue3YLD+IZXVSQq8FbR6rgHr5yxeSscS
         PE+RJLzfatY+LgbvuKxWUkXxLOfQrVtQzDbvxORKsYQUPaCU35epb2xLcoHLcM19nf0+
         X29blTnJwzDZq3WvMZ3a8u9ScsZ44Y2i8PlDGUc1AkGWePuq0TfPD+x73GxaSAXzEqfk
         ISQTitY1BWUwMP0iCiimXvg6j7gWlePCKsH7rOOk/w2vRtIWIR2ZETcXCqwis0Jnj1ft
         5pTW7Zgee/4VkJMcjY2E40ZNTJCskYXmhDBImfLsenwyFbrRgUFdG2FaJR0tC8jggRN9
         +xog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781864687; x=1782469487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        b=DVuV13ZJQA4cwjxq5qn5w+4fYtykWO7KQnr5FcmRgeOerrN4yQWr68pqhbw8W92+4m
         Irc1EwZS1CTi412HTYPErXss2meyHGeXjEZwu9JsfE/tpu8zqpqTipylsssCP1K9k85r
         HMY9Cg7VUp+jVhhoUJtRsl/zBf7vQWSxVNjJe/ROl34txpn1e964Yz1N/DEvFa/MSzN8
         uR8/gNdi/kQNZNC8o+/0PjmC9IEr+9wQQHDGPfggJlo3dVLjC1z3d2DUIhq9bM9Gv9di
         edYIOqTRtvSuNlu8LQRBfSwqeRnU7gwabLMW1l6jvP+YNmsB4gXCK6E51eqKZCwgdpaW
         kOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781864687; x=1782469487;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        b=A+GghmssiZHDSFjuFt9DmgnIjx22InTbwo/ZtlGsbcMlw44EazcV0Bior4EebFWTqy
         /jc/zy+G7lxwlZ63mfIFN3pXrtWdQMiqLEq3AeM6uwXB+HEBgPEnlErP/TLBWgTmsdc7
         yxY4v7O4dFlb5AMRntLYGjm6RgN1eOE1AgPwf+sB6Dglp9MBc674oahlnVkQPWBCD60q
         27i/qCIaXzto+tdkZz7rLfvuPd/Tz0Q0XSgZdJd0CnqvYKx+ua2FrtWOXG0gNVop5rUU
         fhYZLugdTa86jdf9Bly+3mzyKC566BOzwvNscvFsKELDPgeNLqgsrvh/zeJp6VZteiUe
         NUOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/I1zXHRVJEhymfkGj2xaTQ7a0/2ldPGioGbizS36X6HBntPGnh6okcu2bggII59CxBJ7M7mAMCRn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+lQbW2/jjcvADmvH2JsBo2GLTgu9UpPdkdInZoEY81RJTL2+v
	iErBcZ2oOu87IbTmDe3ARy+HAbON4dcPjfIcmkkX9wlid87lt7jScAFhmKsv9Qt/AardL7Fg5U7
	VEsc4HE0n3vQzH5xdm5+4CcKWLL2/gCCWf5aTuid4AA==
X-Gm-Gg: AfdE7cn+AdbfdkwdVsXNc3gG30/5qCmYNWIeGwvHOAl/NYYuwYlip9MLFTTJJcULdRU
	lM7loiIYbLW83xeGz1J/y6LRS/Cf7GXA+ukI+KINCOEhEBqaD/2ZHtFyaTjIkutCm4Bpq+B05xy
	C1ezOYAmeno4TQhK4MudsgyZB+Sh/jK+xdAToGCI83pvOJMi4TLQdqOR/QKENyFFg2oYgwyWGxB
	7b9q4vJnEzQE63RP2y4DXlnkbdxyNmPZMMMloRDQ3khG/h0t90zt+ZD+Geh2AXJzYe+IBBcj69k
	r6p9KWfmOKpuAmhjXHGsg7TYtg==
X-Received: by 2002:a17:907:a786:b0:bfe:ed74:526 with SMTP id
 a640c23a62f3a-c09901bd9ddmr153293866b.53.1781864687277; Fri, 19 Jun 2026
 03:24:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 03:24:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 03:24:46 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260609142139.1563360-1-gerg@linux-m68k.org> <20260609142139.1563360-5-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260609142139.1563360-5-gerg@linux-m68k.org>
Date: Fri, 19 Jun 2026 03:24:46 -0700
X-Gm-Features: AVVi8Cf5uu_-jErGjE81PbtvCv_YT7XlmD0BhPjrXgKYB7qRKbzp8TAf4rZ-9HE
Message-ID: <CALSJ-wBLOaQ69+Hy5sgYoBr=fx654sfcfw7du1O1p89B=1gF0A@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel()
 on ColdFire
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com, 
	imx@lists.linux.dev, netdev@vger.kernel.org, nico@fluxnic.net, 
	adureghello@baylibre.com, ulfh@kernel.org, linux-mmc@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

the driver behaves as before, and it is not using "edma",
but his internal dma interface, no new issues are introduced.

Over testing btw i noticed a possible issue, totally unrelated
with your changes. Will fix it eventually.

Tested-by: Angelo Dureghello <adureghello@baylibre.com>
Acked-by: Angelo Dureghello <adureghello@baylibre.com>

On Wed, Jun 10, 2026 at 12:13:00AM +1000, Greg Ungerer wrote:
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
> Acked-by: Angelo Dureghello <adureghello@baylibre.com>
> Tested-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
> v2: moved from RFC to PATCH
>
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
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
