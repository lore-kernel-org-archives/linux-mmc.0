Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A336B057
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340148; cv=pass; b=Eomq/CPZ53LFgI550Zab98j/93VH2wp36Mp9JFMkn3PoP++oh+ZJss0w0NrU3BwiHAcFP/MvpnMs7EiNmCnzHi0p5uI4iVr2xfIvUJBfkO5pBMOvxKYx7F3O++c6/DhWSju9CFXkOBGHtGK0FYvwDFQHq207DZrhD0QorDNn9q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340148; c=relaxed/simple;
	bh=3Cha9lFMx5/WB4xxbWCMId3YmzpUMS3QC3hqlVHwtJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6tLdsoCu0eQJMZ1VEv5uKQqdG/8OlurxB+S796O4L6hjYS8j60f/MqDIpd2oFV1ibvqfevIejOi4k4I7z6d1VIBj+9U5rg7rMWqB3+i9k+krt+pRWP2BLW3Ul9Xf1J0LWC4sc4PWGxqu0lkIrvws7MWkwiDUmPdmM1h7hyIN8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6mOwhsk; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6mOwhsk"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649e97f1e99so3829280d50.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 06:55:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771340146; cv=none;
        d=google.com; s=arc-20240605;
        b=Ijsx7ADPFdi6mV1LMUH95mKx/XgWmkHoQHxtBcmJq5e88B8rSLmCxMFacdTYlDy/Eo
         b7YClVUBJIp52PX3ppMiS9I39Pa0YQoJfXfno7p4x4mSiF3fgZtZx4qrotEWRGP44S9/
         PNTcoO9Ra0MHCBk51dYQ173g8efN6gMCwBGs2nlUi1cW2ylNrI+1x81xUuZMUR/Ch/XF
         m6W7HcuxqJ2l5M9xIdRct+dPk+PJ/zu5Y4OWVuME11xt8yrXRrbmT7HE52dwjH924y8V
         54Q0UHxP30y8vJoDc7o7uTnmAHaYqsIdubQyR9eOx/lyqMbjLTleUSvIsMgf4bQ22jk4
         BlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EUOXZnoPwW4afRUrdlgUn+EodM+CPxsvenUvczXmW78=;
        fh=bCmoRPidXbEoyj9SDeJdc3mAIQtVIusBr51+81mrXlc=;
        b=hXyM4KRARyCvyrmj2CqdK7aqYpSwhmHDrgQx/ymrdzhbe7wLFYA6lVBZ3i+5oVR2pQ
         jctsQ0m8j74bCx2Jhec4LZdzig1BzhbH/rEU2sWijR3vL3TRD9baSn3ftKMJdGBN8QxS
         92TyGOlt+eR+Zhkz8mWKsIIJpcWH+YnUy1PJScdSa+cl5qHr7HKxC247o7pCyaK6QLeP
         y8YRqTCVL0i/ePh0kQBY8H65O1IlY99yKzRLy117zKtWcJUDGHQJR0DfTBgpmjVWyjSn
         3Cet+i9Kaz6Tahlu/ePP5xGjv398NtY81/+w3ALKyqeuxbLzUSWKRx10QBJFKrpSNmtS
         JiJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771340146; x=1771944946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EUOXZnoPwW4afRUrdlgUn+EodM+CPxsvenUvczXmW78=;
        b=f6mOwhskxX7xQGV377oPW1xFYCOi5u7lTeBxdY7lVK/uQuWS4m78G3jpTpiOuDZAeQ
         VJayVKemgGjppm5SPY0RRqq9quu7Zbz7y5UD/XQz0RYHaYJeo41cE7MkEhMZ3zca+ZNt
         NHv8EtIzbVCRb/PliFJfuVQqVkF1Idca1gypNYIaX5fdyM4XPzEYfna+RGuaX6sqMzO9
         RAcHncUQ/cnKyKxFxSNLFIC1wLwn2X/313D/+zEkHOT2qTbmeYwzUp7iUTKc3P91RTdc
         KTCqZpcm0YR6Uq50cYXIiVzwnv86UA2uCaNf9XblTEs/z6U3Qc/QsF9dBrH5uOlNLntO
         FVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771340146; x=1771944946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUOXZnoPwW4afRUrdlgUn+EodM+CPxsvenUvczXmW78=;
        b=cT2Ll8IoUXHSqmOYPl8EHByPyG1hn/20ax37Zi1e+WEP7wazJFDEo2Pms2QbS4ByPV
         Zffxp6F5x736WxaR1S+45F1XeiDuM4yNtyL+4N+MZceUnYoSEeOW+ugx/nP8KUDkWj80
         HYT40Y+hZi8144aBfi5Z8+FtAdemdsFaNFQjbHKJMQJScDHPyRVX3rIexyibvw7vXoQK
         dtGf5QI1apfgn0OPe/7+ORHagLPBvH7irL97wyLpnCpNzxZrYJK87XwukPKNNhlNan83
         VTmqMIEt6iq+3sbF9KYtiecSSr2QkEZLcO9qaN47vxNbB5wqOO2LBKVxqVx8xIw8PC5Q
         InCg==
X-Forwarded-Encrypted: i=1; AJvYcCWMP8VnWcky1SEVUwd69yRQPWjodxxDWaGKaVU9WoBTq44ZFUdWKGJCc0x3Y5iVygXq3B0Xtoi6sWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWe8RRfO+AFJJMfamr+VyoTK48bGfBCqCsAPBBPdMJIqaC1f8S
	Lk1Aihd7SEf/1pVZ2crtU5smmT+x6PTgBviO5JcCRKbBwhc+FN152RCC2GazdfitgP/RaEAHWL/
	xtxv+Eg/fSJe4sK4zJZpOUok3oNsTeu/p2vdULuND7w==
X-Gm-Gg: AZuq6aLhbqv4Rqm4HJ4YvDH7cjAfxbY6VLndD3z+9tK+Agu0GGhdZJAHwmcVXTG9H5G
	AI35gYW/EQgbXLs/bS/avkEEPvD38nCS0fJOh5q9Yy7+5MwUbhM3xXkuiGr4CEX0GCHcrpMFlf1
	v55IRnQMTRXaodBSH0Y985YiWhsVVki9pJAsyi9RYMqKhWZDK9Y0teDWwhT3OzvzcP/Si5sKC2P
	RF3zNSpfCaQpH8X0c7vIc8GPg+hf2KwDH3KDsARNwGIjDfL4bJOuZx4ucp2wJ2UXDZBBdUgdjfF
	DFN4tBAa
X-Received: by 2002:a05:690e:169b:b0:64c:2581:eecb with SMTP id
 956f58d0204a3-64c2581fad3mr7183736d50.61.1771340146334; Tue, 17 Feb 2026
 06:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216191543.2514647-1-kamal.dasu@broadcom.com>
In-Reply-To: <20260216191543.2514647-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 17 Feb 2026 15:55:07 +0100
X-Gm-Features: AaiRm51PTpCZCJlLwWn7BPkKSIk9PRnuEG_OBJnTn7CydyKYx_zNUvJrCSEJu-0
Message-ID: <CAPDyKFp+1O6qAy3tRibPJ3oBOFkMLF_fFAtV5qWE3U2g7VMa5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: use correct register offset for V1
 pin_sel restore
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: adrian.hunter@intel.com, florian.fainelli@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Feb 2026 at 20:15, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> The restore path for SDIO_CFG_CORE_V1 was incorrectly using
> SDIO_CFG_SD_PIN_SEL (offset 0x44) instead of SDIO_CFG_V1_SD_PIN_SEL
> (offset 0x54), causing the wrong register to be written on resume.
> The save path already uses the correct V1-specific offset. This
> affects BCM7445 and BCM72116 platforms which use the V1 config core.
>
> Fixes: b7e614802e3f ("mmc: sdhci-brcmstb: save and restore registers during PM")
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index c9442499876c..57e45951644e 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -116,7 +116,7 @@ static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc, enum cfg_core_ver v
>                 writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAIN_CTL);
>
>         if (ver == SDIO_CFG_CORE_V1) {
> -               writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> +               writel(sr->sd_pin_sel, cr + SDIO_CFG_V1_SD_PIN_SEL);
>                 return;
>         }
>
> --
> 2.34.1
>
