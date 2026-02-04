Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2172836A0
	for <linux-mmc@vger.kernel.org>; Wed,  4 Feb 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213859; cv=pass; b=X2QkIU0YywGPqy1dem3qRdvbAbwJWo5nzi4CawU3lq1pUMpKAu6bKAIkg51No617Vt4L2qfwwsXI/IvSaVcViW0xqg30gQ3C7mCaNs1eLY7roeencvg5fERXAsEYET2lnI0E0Ej8p+p+lAbG6FlX+6TLwouSRmqyxKYWTkZ58oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213859; c=relaxed/simple;
	bh=ChwWtJcDN/2f7VACJ/I6YLG2a+MIHtJIsYwqrr4QlSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ptla3QLXGAefY84rLJgTsvBqiYkYT5pbwRqqzQphF3Z4uuQecWPjOFjseL+UQBHKtDkuu2PlBGpcLaSnBB4k2j5muW9CVyUIrETnOurzw9vCBmnfTxMsBkh5PgVttHeqlD9FyAGLYMbKDrCBdtU+AOk770mVyKmaO2NmcoC+4sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqDc1FXw; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqDc1FXw"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59de38466c2so8634341e87.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Feb 2026 06:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770213858; cv=none;
        d=google.com; s=arc-20240605;
        b=IaKowoOm5iN8RaMciy4Jrjop0LMYN/M6MoThRuqcezWaGSAsIUXw/fvfiaq6Jp7384
         8PtAkzuSsT2RNYrgXvptrbp7+wZa9Fphw0CjScnuM42yoWyoZx9QKq1+A5GcQ2aRFjmK
         RAXq7A2iUZ1zfLwHHAlbK5hRwK6WF9OcNSuSZvkBDczyyaS2bVQzbVBytYCwfIqAJspO
         3S0I57MDHrmqfxT0IJn4M8QgN+y9bfwjs9rLsx6ibQUbl72/0NJPD2FH6E6Bncm9pccJ
         pUM+XEXWApHdn9o94zYP0J0NhEaKtycDLXjX1PJlEI66HNtIXiHe8nosa83FqL2CHKRw
         22nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8WwleI6v1wqUCQvLpwiMmZCS6MRoRYJaXgrW9ntrM5k=;
        fh=1xGwu1VucO9Pfktou75TAnRGVj3ZpYhvyIDvtNhGKXk=;
        b=WS7KQsyOMb8NZ12XKs/JRelvE1KcHHoNzLLp9xElGjAt9iQ29jTgkB7TIikUK75CHu
         /yBVCI57DVr4EU0QOzWXN421OV2FMGnR9b+GbfOOiVGgnmHZW9nDXUMr0R+1zm7MGtAI
         vQ0xoTHPIjp2PwCCxD3Yjv16hNZq7xJoc+fjSuF4gPjEDFRCUHik0A++JUl9kZ4SMtJT
         y9dreTQGuipLz1UY+7SBhk5MRfHwZk8YFI1lxXkx6EVY1nbDckAmhlxgCZsbWn4y9pE3
         VG0ugnrCvmuTbuK8h90EzzTOhAdNFsfK2bxUHPeiX703ZHEdQ/iB5wibGAk5r1INwSdG
         YT8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770213858; x=1770818658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8WwleI6v1wqUCQvLpwiMmZCS6MRoRYJaXgrW9ntrM5k=;
        b=oqDc1FXw+UTJdRhIZ4eI0vVP7/+HURAu0JK0VkYMzhNTwUmJlnKvdkRunjrg+t55Bk
         Qo6wsF/o8prW+KlhUWpza58nye1sWsmpEnH07hjiz4xkkvwZSJqE6o+Ov4uxJ7i+0jr0
         ddsn1jD3W6e6Jl2oUeMwumf4Yj+Oj01Icx49Cp6mEEyoi8Enrv7TMg9ifoJD3/mryLZE
         cVEP5hnuRI7O5N2csYO/s6YxGSoKTsE2l3yeGqohZjNAfktki0zvUxCh3EJvqOZqw0Kk
         /7KtMprFgt+mLk+3vNctgGZJE8EPMuNSi8ExDfXTm3rYs1BolDRNGsbjQtoNkY1cc+5+
         xfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770213858; x=1770818658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WwleI6v1wqUCQvLpwiMmZCS6MRoRYJaXgrW9ntrM5k=;
        b=lTBPDnMVnOEnDYHOAptFpiBBGt+82mawRpKRdqeaPo4NnPttz7WNpBKZ+0vFOQKZSk
         UgHBEsMyIv24kTt0ahRS7qA/744gkm50nMUayIzebh/EWA2qBIGwfFlmgKAaRImYbC2/
         6rDuX2ESoQodViiUPp9CBweIU5X+K+GbK6Pp8g/4oPQnlPkHcvEDC+Vf8c/dFLUEjxdm
         701OiYoreCJnaDfYl1t6BX33YyHNImKDK83YjTo3tlv35HwLuzMcoYvQzpWvyHk1PvRv
         xH4Jkw1rM4nf5sM/oN9lRlj375d/3LsOdRgxlcW91waPRpcdDHQhqhLbQuffnwWqu68z
         vcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu6NUgYv0Ly838HzbaL+hq/QOAVrADHqEbUh+46NWuvHzqCsh2CbL65oMSuCoIYaHoY4BN8YnSW/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjICzZBDNUG1wMKFISrRlKpQfM8lubzZIIVsJpaU/xgrSVSYxB
	vGicRmuEXwwlOexYHctseyCXznW73ne+S0cY0xg9EtlwfH02d2kEpbrNffp7Ovr0CO5Q3gNqpcZ
	O8e2Mc+yTHvQFNzYplUjPS8YazA6UbrxgDqat3l5WUg==
X-Gm-Gg: AZuq6aLBKcXPdyjYsMCgZXCFfQJjqGNyjX0tDpV0ebYu0pgEwRP4zU32OJ+hZ199gZZ
	UTNN6Z8gmvDRDAngxU6pP0566IPLunYa9B+QopAMZg0r10WzCQZdgYjgcUeDcA/JacRJWO7Ozjf
	dcMZf+pVWkOgNDKU1Sye9gdVLiOtZBAOuvVDCsMNe2RJvhSyLbfSfu4Sl/1Zv4bvjXLebKzuYN2
	4GI5wzdXAEuLu7648TuvKROXybeC/uH4A9ZLzf+cGBqzZzbO+Ka+DtHWMC5nruu/BR9AuJE
X-Received: by 2002:a05:6512:1507:20b0:59e:38cb:2e2d with SMTP id
 2adb3069b0e04-59e38cb2f4cmr840864e87.30.1770213857547; Wed, 04 Feb 2026
 06:04:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204130035.4088103-1-arnd@kernel.org>
In-Reply-To: <20260204130035.4088103-1-arnd@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 15:03:41 +0100
X-Gm-Features: AZwV_QhWaG6VM8YwNuG37HBXvJWN0_-3e-8SEzl-0fkBqBed2vq0XvzS1D9oQO0
Message-ID: <CAPDyKFrJxP03V-ow1yGbuUDUqK_tv16NUt7TCtYLfViz2RZ-cw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: move pmops into core driver
To: Arnd Bergmann <arnd@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 14:00, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Since the platform power management structure is now shared with the PCI
> front-end, there is a link failure if only the PCI variant is enabled:
>
> arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: drivers/mmc/host/dw_mmc-pci.o:(.data+0x74): undefined reference to `dw_mci_pltfm_pmops'
>
> This could be fixed by selecting the platform driver from the PCI one
> in Kconfig, or by reverting the change to the PCI driver, but since this
> is now used by all dw_mmc variants, just move the structure into the core
> code as well.
>
> Fixes: d9346fb36d84 ("mmc: dw_mmc-pltfm: use modern PM macros")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix, applied for next!

> ---
> I ended up not renaming the structure in the process, but that
> would be another option.

Yeah, we should probably rename it to "dw_mci_pmops", but I think that
can be done as a clean-up on top. Maybe Shawn can manage it?

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 9 ---------
>  drivers/mmc/host/dw_mmc.c       | 6 ++++++
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index fde465a4bf5d..079d0cc97766 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -56,15 +56,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
>
> -const struct dev_pm_ops dw_mci_pltfm_pmops = {
> -       SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> -       RUNTIME_PM_OPS(dw_mci_runtime_suspend,
> -                          dw_mci_runtime_resume,
> -                          NULL)
> -};
> -EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> -
>  static int dw_mci_socfpga_priv_init(struct dw_mci *host)
>  {
>         struct device_node *np = host->dev->of_node;
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b2ac61f3a8f7..97e880022007 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3523,6 +3523,12 @@ int dw_mci_runtime_resume(struct device *dev)
>  }
>  EXPORT_SYMBOL(dw_mci_runtime_resume);
>
> +const struct dev_pm_ops dw_mci_pltfm_pmops = {
> +       SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +       RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> +
>  static int __init dw_mci_init(void)
>  {
>         pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
> --
> 2.39.5
>
