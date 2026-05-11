Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789C310777
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512336; cv=pass; b=GSeEd8SunYIkTcSeYwGmk+SUGZozBZHUb7OE0NOjlqSOBHjlnC5lNluRrredUJlMifk7Tu6lbOPzD2ZxZPoUqVqaJRaFt6KJezeXrxXpXkdKhfE3GwLp8xrwQ/j/N9QAjmpSJkSrAf9VLtAPTyYldIWbrHX9uG1gP9KiRH6zzZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512336; c=relaxed/simple;
	bh=1H7Xf7d2is7GVflTECcZFEqt6F6L+thydK7Be71uvw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3ugGx0o2H6VBKctsKjIK3n3kali39jrSYlGSyz/LmqN1bMn4YD+DaSp/IyCDZ8HAR5O8IGWfhaKcgohPwJTFUfvax4+Cqd+U90ZJW/3VSeaMX06SJWmKuzpEnHagZhoT66kbNh6mZbgyy/Y1N9/OOd135W2WXeNM2KvBLxmfLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KyT1Fsay; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyT1Fsay"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so43061277b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778512333; cv=none;
        d=google.com; s=arc-20240605;
        b=jKgD7TIxKGwOaML1L1npTik86IqAut9FKHUlNal3WFWnMHk6VDwW17LdHi1rFcAbpo
         DvHytVu4KZXPjhyBomx1OKF9st71FQdDNNG1N7oEyG/4ZLk7VAeir2bfRsBT1J81VII7
         42+DJaMli632y9w/URVAW9EL/axicM+r2T6Tk7PPeiPpvq0H1qkDmmuV8/mccAox6+B0
         nfPoXcineqUxQyvfypJ3BqtsMefFSxdIrp9faaOU8zOiezUijLwLtjB3oWDBQixxa23X
         HVK5fT1uLjki+9xHWpV/1/TbUJC5YWmSKx6iPW06P5eWgOxyh1pM+gdH1fpGQd0E/OBk
         4kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/f5pcVVRZpgPLr1zYSd/Poxqpg4qBOt7BIeSZNx3Fjo=;
        fh=++uxYfgU/sTpA5KybbkgM4pgDN1uqqHsKRzn1gmlCXc=;
        b=U6I69YISKlj2nW+FsuCqBP06AJ53i9Q32LCht7Skir38t7hqN90KFrZ1m4gIzMYfWE
         574pEOCoC5UHPSiv90oAZNBAfvYHWbmKk9BzxUeEHuMrWcv9vfGMJydXDnVE9ZajX2Cr
         WV0F58X/1LpZcNxae9INF6KWl9rSKK/++hPBuOCDZqmEum/aSLIkXPubIVaJTsWdkbNu
         SbDkRP+e0/62+kWEeYD/lH2ZKNKmitXfc1PgG4TMdGejw0VPKnb3vlZ/lvE0uNSfycKn
         5IKL5IUCfO7Vj56pcvLnedxTiEcphr5gzYm3yXg5v7oppn1P8Lz266xJS5TLcuZnzcZz
         3Wdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778512333; x=1779117133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/f5pcVVRZpgPLr1zYSd/Poxqpg4qBOt7BIeSZNx3Fjo=;
        b=KyT1FsayyG9+KYNGd6I6yk/aExWR63Z9a+rKJ77dhOv5MNkYtZqvphqMKAQRL02LHv
         UT0462zqFogN3fR1RKX2QxUtHW2pedCLcdu4d7PbFCfncHRxrmQ+W5wWg/1vNJruh9z/
         oG2sRwgRoq8nqf0OO1IvWCrAbf3/VueW3ILioXlRDNQKL6xLArOhwsykQwkhuAECM3sb
         2PBE8bsnlICFNMkgcbjEXzz9htnR4Y5w3W93Mud1jQrGGUO9yFq9Hst5YiBTLzHE86uq
         Xxxn2X9gOvB2P6VU41csvBhFsv3Giv99TP3+LlOVqKOQirZn0WJhfkGn5egqyTx5om+S
         +UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778512333; x=1779117133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f5pcVVRZpgPLr1zYSd/Poxqpg4qBOt7BIeSZNx3Fjo=;
        b=ATSLMG1N29v2XEkZ8V4/5PUR9naZO0O5iKaEHVUWGY/auLG1l/15k7NdOwWj1yMndF
         jcqbrsD6tuDH8jclAtrwQCnhVWrlLFS2GPh8pB7qNI7tg6n7launcGieFP+Fw/6beoKZ
         bYYjq1MWtgBV18t3vM8RKe5h8Pm+nSf9mE8oiw8fXdBMGbxuFIdsFb7KMJm1svSJ4ZVL
         byZPwEFOON2rHjnVIHCjjo0C7tg9oAZ2tBrL0O/Z1UHrhokNBsEmr9OR18OLU6Gg7Q7b
         UcyN3PoNk+xMrITaUtT5WYP19nGKhPmnyHO3x+kg5RZFcNgQHh8sQvIlLZQgHo5eNROe
         bSiw==
X-Forwarded-Encrypted: i=1; AFNElJ9t0mgUWuL1zqbwO6nkhhKGwQUCpA6dqY9AQ4XQeBW7AhmYiaczemzN382eYyqhiWolQS7sM+dhVCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyIbCwhSz2My6DNKayNp/dsvha4ZoD2tgd9/jyDXPRwInYGMf
	p/EFWLXONYLvmYTb4houVQxric0Dl+tLuQ/Df/qqAeKOykjLT0hguai0bsea6GZhl/xHL0RDQf5
	K3+sGY44iPOJPVcnPS36dFVQKcIoGWe7zsGRzi9OU/HkB14bQbuG4kFg=
X-Gm-Gg: Acq92OG4EyMIbwqSDgyy4AC0BRKaC/qDN4hTWOx71Uw2Fo8UyUUN8PeBg1uFzrXZQEX
	qTdNWTwuJyjvfbbrpdmzjriYvaIfKaw0U2xr0iMj0iwpz8pD1juJrxRzhv+kqEGjBEGLdazk15v
	xEknmUEV5+P+U0ZVylKeC5stF61cSMKFPeECATdnRob6GMhmj8wgPKu01QApl+9gZDmkRWeAhKs
	uTmstw99dk8a8qTM+wGvAod1dO03wQpHDwBz1kFJ0kjJp2LfrprNBvkVRjobigNyB2nifa2C22C
	SOoZPfSZ
X-Received: by 2002:a05:690c:d96:b0:7b3:a5ae:4214 with SMTP id
 00721157ae682-7bdf5eb538amr251461777b3.24.1778512333347; Mon, 11 May 2026
 08:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-6-gerg@kernel.org>
In-Reply-To: <20260506142644.3234270-6-gerg@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:11:35 +0200
X-Gm-Features: AVHnY4JoT13V3074zVSJJIYRxUbzF897uIv-DHEkMY19qZbI5HkBtp9YPaUtMi4
Message-ID: <CAPDyKFpZ3h7Kx845K+f1EZs2ijgjBmKsLOX8GCuP=C5WV-d8KQ@mail.gmail.com>
Subject: Re: [RFC 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel() on ColdFire
To: Greg Ungerer <gerg@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	arnd@kernel.org, Greg Ungerer <gerg@linux-m68k.org>, adureghello@baylibre.com, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 16:34, Greg Ungerer <gerg@kernel.org> wrote:
>
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

Okay, so please resubmit the $subject patch when the mcf_readX|writeX
functions are available in a v7.x-rc so I can pick it up.

Another option is if someone can host an immutable branch for me to
pull in the changes for mcf_readX|writeX.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 375fce5639d7..6853521e8b2c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *host,
>         if (reg == SDHCI_HOST_CONTROL)
>                 val |= ESDHC_PROCTL_D3CD;
>
> -       writel((readl(base) & ~mask) | val, base);
> +       mcf_write32((mcf_read32(base) & ~mask) | val, base);
>  }
>
>  /*
> @@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>         if (reg == SDHCI_HOST_CONTROL) {
>                 u32 host_ctrl = ESDHC_DEFAULT_HOST_CONTROL;
>                 u8 dma_bits = (val & SDHCI_CTRL_DMA_MASK) >> 3;
> -               u8 tmp = readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
> +               u8 tmp = mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + 1);
>
>                 tmp &= ~0x03;
>                 tmp |= dma_bits;
> @@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>                  */
>                 host_ctrl |= val;
>                 host_ctrl |= (dma_bits << 8);
> -               writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +               mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>
>                 return;
>         }
>
> -       writel((readl(base) & mask) | (val << shift), base);
> +       mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
> @@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
>                  * As for the fsl driver,
>                  * we have to set the mode in a single write here.
>                  */
> -               writel(val << 16 | mcf_data->aside,
> +               mcf_write32(val << 16 | mcf_data->aside,
>                        host->ioaddr + SDHCI_TRANSFER_MODE);
>                 return;
>         }
>
> -       writel((readl(base) & mask) | (val << shift), base);
> +       mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int reg)
>  {
> -       writel(val, host->ioaddr + reg);
> +       mcf_write32(val, host->ioaddr + reg);
>  }
>
>  static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  {
>         if (reg == SDHCI_HOST_CONTROL) {
>                 u8 __iomem *base = host->ioaddr + (reg & ~3);
> -               u16 val = readw(base + 2);
> +               u16 val = mcf_read16(base + 2);
>                 u8 dma_bits = (val >> 5) & SDHCI_CTRL_DMA_MASK;
>                 u8 host_ctrl = val & 0xff;
>
> @@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>                 return host_ctrl;
>         }
>
> -       return readb(host->ioaddr + (reg ^ 0x3));
> +       return mcf_read8(host->ioaddr + (reg ^ 0x3));
>  }
>
>  static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> @@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
>         if (reg == SDHCI_HOST_VERSION)
>                 reg -= 2;
>
> -       return readw(host->ioaddr + (reg ^ 0x2));
> +       return mcf_read16(host->ioaddr + (reg ^ 0x2));
>  }
>
>  static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
>  {
>         u32 val;
>
> -       val = readl(host->ioaddr + reg);
> +       val = mcf_read32(host->ioaddr + reg);
>
>         /*
>          * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> @@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_host *host,
>          * fvco = fsys * outdvi1 + 1
>          * fshdc = fvco / outdiv3 + 1
>          */
> -       temp = readl(pll_dr);
> +       temp = mcf_read32(pll_dr);
>         fsys = pltfm_host->clock;
>         fvco = fsys * ((temp & 0x1f) + 1);
>         fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);
> --
> 2.54.0
>
>
