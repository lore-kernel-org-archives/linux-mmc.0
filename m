Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CC1AE086
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896516; cv=none; b=NTYHNN0jOJu2GHifqvw/zUBOhiCfNpVD2sdVle46UcsHb8MGirynQ88JYFWmUavMC75Dsy7IIJZ4/AIQhO62cnT6bzdP7rbuAwohn4nyyQseXwxCLpZ47RvW1OzZlkhRbqKw6DjHKWLLOfifjM3FqwX4z/fzH1FgRXNRQHZb9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896516; c=relaxed/simple;
	bh=V6VoyIUBT+326lf+t2vvFKTmyT4585YlNf/SrOWCqIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXghJnNMbPJNLRSC9+U7GiHEHXjdak/5Jcu0qRH1i8XZUDzS5PIOefuQbP+7PMGQCzyEn64n38RJgGSFT2a8spCb3HGj7jX6gZf5a7gPfFkych20Prv9InSQDx4tBHA/iyE7jOLVQ39+gAKHjO8mQcogR1unoMREEqeVFEtnnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKvlv/VM; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKvlv/VM"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df481bf6680so958621276.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896514; x=1719501314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj6dgbesfcKrGQvCi6D94hFyNH51gAPFw3ySdp3QXHM=;
        b=UKvlv/VMIWo6+VSx6NpreaCtlL8AfBYGwmqSRHhLdZVQ9nUMBw51UeQkXJ+qBlQUcv
         KBffbb8tY1ykAK25P7XTg/ilrlUwuBftJnOx229GV79J1dJ4IejxtdLInUuhWbSERulZ
         H09tLrOMeTu6TYoa2AHm8ZsiHx7jk41KsYmX20aYyYsi6hmwhd07HXJUlfiHltKvUe4K
         4oF0r2I3We0nTyKdROisM0HMBaj8RssLRAb9k1JxjsoumtKcxPzeQQHRfpnVyIVS4jwo
         jvJgNR5ib2gcZ5oc5yu/JgqY+t3lVWL/joyVHwGweQJg5HdtA47iaXkCTlbcCPEzYbK9
         ZLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896514; x=1719501314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tj6dgbesfcKrGQvCi6D94hFyNH51gAPFw3ySdp3QXHM=;
        b=w2c9mxm0RoJpAyDCkKEsXHEmEeNfg46rqXesfECl7SuHvTnFOADR1TVCmlqAgXD837
         5SZQ6R/EJKKU/HYaLHBuxRx+u8AW60opD/QF3PedhJGXwdE6fk4ZUbL1qy7wDH1nzynM
         Y2C+D4excrAl2cQzFnqUzLhNltwp/cgPU5dHonf6U8RtujYQt9UU77ePmuqoffk32/Mb
         rcm3M81cKq7EBxVIpV54AIKuCYuxA90h5NQWKfp3OzCFsKK4lLNzCdY9oZTOS9nHzdDc
         GYegNhTp7hGLQ8Y+semB7cCHXSIHpiM4g8hH0Z7DetA6jda/9fiO884KEYBtFCNuqtpz
         jw4Q==
X-Gm-Message-State: AOJu0Yw/nLODxzkZIBRCdM16TzNQRfToozHshYKM1OvUC29jrZAfXI5o
	Pgqr1mob2lx3ofTvvYWhhrEaP1cyNxCj2E4Onfz381G8PTD1CMgPmuTLFwXKr3COQXJlFYSQ5oG
	sWfP2Hp8Ff5K/1IVPfxGkbCVmeEEXw6h3c2g0ag==
X-Google-Smtp-Source: AGHT+IG+BAP5C9JiE+TJ4qZwEiIU87aypPX7/+AZrSkgVQ1iUSoCmA86IwjTkhfyy18H+gJG5SbTCWvNXh3yMgtYaXk=
X-Received: by 2002:a25:874c:0:b0:de4:738b:c2e4 with SMTP id
 3f1490d57ef6-e02be18f1bcmr5887304276.28.1718896514179; Thu, 20 Jun 2024
 08:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620074248.152353-1-pbrobinson@gmail.com>
In-Reply-To: <20240620074248.152353-1-pbrobinson@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 17:14:38 +0200
Message-ID: <CAPDyKFpc+tQ3obyyYN7V7hpLJcG4LqGb2YdSDbdWSLdh_ZQ79Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add ARCH_BCM2835 option
To: Peter Robinson <pbrobinson@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrea della Porta <andrea.porta@suse.com>, 
	Stefan Wahren <wahrenst@gmx.net>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 09:42, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The Raspberry Pi devices have to date all used ARCH_BCM2835
> as their SoC arch dependency so configurations that use this
> and not BRCMSTB won't end up with this module in their config.
>
> Cc: Andrea della Porta <andrea.porta@suse.com>
> Cc: Stefan Wahren <wahrenst@gmx.net>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: 40f22df5269e6 ("mmc: sdhci-brcmstb: Add BCM2712 support")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


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
>         tristate "Broadcom SDIO/SD/MMC support"
> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> +       depends on ARCH_BRCMSTB || ARCH_BCM2835 || BMIPS_GENERIC || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_CQHCI
>         default ARCH_BRCMSTB || BMIPS_GENERIC
> --
> 2.45.2
>
