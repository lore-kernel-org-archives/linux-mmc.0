Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D88C242D72
	for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690680; cv=none; b=oucthC9clebneCiyARF2ZDjxQhRcqJBn8Ypj4QpioYdsvc86geeaSW8md1Oj8H7+Rb2qDdVuw2Ctqp6bsGA/lsBWri7g/QeDb1bG/QhI05OcWbqLbMzO3129kCSc6AKxIaYo1yi7SzE0RoRnIGObHFB11wncjUZ7+cXA3OnBQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690680; c=relaxed/simple;
	bh=GkRRgy9PjHfoh+Q0+YrLwiAPxuPpcGqjLCT5hHVfmIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OajLHkszOAyR4dW0iCEr+Iql8ABnq48ZxKYJLB1Ks09VcYtHjQudUgGS2ZYpX7C/UB7g0hxWdCf6lG0/VQdacoxJkdUYLXbxEya8dcUzoM4K6X5ehjwfuzyzKWKJNTUdhl/O4IdmrYHOvoYkRaOPoVbmNI/QIAeLiUkVOgFRSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sZgPlLyC; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZgPlLyC"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e93498d41a1so3272381276.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755690677; x=1756295477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lOsgMtR2/WTXb6MvEREQsGNGK5lblKBRRgtakM80Wd8=;
        b=sZgPlLyCdtLC9EKLQorMMr155TAtQpbq7zMgKLgITRaOCT6mRAdUYBBimU5Mt5CFU4
         KuDRvn/d6feIJN1Mmlh4WNCEpVYbXDUU2AF4Cz2QBzmYMj99gBhF7EgiyMoeSKAO/IFA
         Yuk0uwe6x/WCVTlLAIAccr/WNyOOVfzbW+cnu8E8KSbVQ4+iNpl+HpPgVoBghFnNgsQc
         KnhfjTdrdP284tqm87j/QNiubTLLWfDgCTvR0wePGChItNNpEKtD0pw0QVMrMnoo43FJ
         C2BEN4hPEBAGPFai7ZKVVRM+uEs+s1iSisBzt91cCK3ttgsBJJW1/a3VsvuJz84NAKAg
         Euyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690677; x=1756295477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOsgMtR2/WTXb6MvEREQsGNGK5lblKBRRgtakM80Wd8=;
        b=AxbLUPcFo6pB7MBmElpjg/rPMHiQz+VrG/Fs1LC9drMyW87WHLnJ86kADW0OzbLQ/D
         GBqrKAk1H0y5XHaNreUJV0QhIhsz50V02UrfRKQbTW8bMLkMPmYQk7ySqeQDQDv0FBOW
         FXdiL5Xd/B0QzdDJrov5guUG2tybRtlsCGLyeJeaT4ct5WPWUG82ECoK63eF3WxjNzGX
         fFtJMSNnJQ7zd4IKSeteBj+rXbbKWpBVvKnJXDL0D9yKdt1vi2Ssnxn/XT1ldgudu9wB
         AMUIo3xmsdNN3T4pGhwnknN2Uy0D3nwO6xzplaktMFHT2tKL5UHdu/mVSKQL03bDO/g2
         uwIw==
X-Forwarded-Encrypted: i=1; AJvYcCWqDB7MDZXnlXT4AWManVmud+jGA+5/U/FArAGluoL+KRMbDzHOVa64Jg/BiQTVwiDzJYZQN7Z1sYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNAkO7GWB7PcXmzuMTo66iis4Dy5FG8JK7EYFwPY7SCEQ+QTs
	URS8g5O9f6SI6mwT0N9nDKyRozf05QLngtVsPZUkGZ+H6A1rWQrM/kYlgHfopBpuSZOfV6NniQm
	rnKu6IHjwCwxkCPSsWlfHJZ5dBGLQGPKBqtnkrcLsvA==
X-Gm-Gg: ASbGncvw+9BDgg9SC34UOcDPJXhcty425XAZylZBg/I7Wr4BPpP7QtGmZAXAOblQ8Wt
	6gOc58burnvz+IruUflkHycOx1+FvOkQvjgfpfqTrZjmjammaMQ+pgtQmQJQG+2dn0x5m7WqJkT
	Yo0p1iILRc5dx2/CssZGhlLN1nFywIVb51KxLHDGzSEfKsxb82TNGldwJUflpyJSdRUvvVibyuz
	wAlj9dj
X-Google-Smtp-Source: AGHT+IFGfpVZuf3qC5EwO7N/indwc+AUht5SzBeVXUI0oDlfLcte6yMTGB1r05G/DM/oXcm+DnSY1lfzmVJ5h4x9n4k=
X-Received: by 2002:a05:690c:34ca:b0:71e:80d8:19a6 with SMTP id
 00721157ae682-71fb322e461mr30240107b3.39.1755690677411; Wed, 20 Aug 2025
 04:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814130705.326073-1-o.rempel@pengutronix.de> <20250814130705.326073-2-o.rempel@pengutronix.de>
In-Reply-To: <20250814130705.326073-2-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 13:50:40 +0200
X-Gm-Features: Ac12FXxQ9EMTp1sCAGjq-qr2qTOkgH5lah9fdjpdw1ORTdJZWly8BaMXPgEYQP4
Message-ID: <CAPDyKFrGcux7US6SQmHSbREqqSyHbzYuxRMgvm=256214Gf=NQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mmc: core: Add infrastructure for undervoltage handling
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f14671ea5716..5f0ec23aeff5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -564,6 +564,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         INIT_WORK(&host->sdio_irq_work, sdio_irq_work);
>         timer_setup(&host->retune_timer, mmc_retune_timer, 0);
>
> +       INIT_WORK(&host->supply.uv_work, mmc_undervoltage_workfn);
> +
>         /*
>          * By default, hosts do not support SGIO or large requests.
>          * They have to set these according to their abilities.
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5be9b42d5057..7dc0a9339c5e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2370,6 +2370,7 @@ int mmc_attach_mmc(struct mmc_host *host)
>                 goto remove_card;
>
>         mmc_claim_host(host);
> +

White space. Please drop it.

>         return 0;
>
>  remove_card:

[...]

> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a90..0d2685365c6b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -11,6 +11,7 @@
>  #include <linux/device.h>
>  #include <linux/fault-inject.h>
>  #include <linux/debugfs.h>
> +#include <linux/workqueue.h>

We should not include header-files from header-files, unless it's
actually needed. In this case, we can do a forward declaration
instead.

struct notifier_block;
struct work_struct;

>
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/card.h>
> @@ -342,6 +343,9 @@ struct mmc_supply {
>         struct regulator *vmmc;         /* Card power supply */
>         struct regulator *vqmmc;        /* Optional Vccq supply */
>         struct regulator *vqmmc2;       /* Optional supply for phy */
> +
> +       struct notifier_block vmmc_nb;  /* Notifier for vmmc */
> +       struct work_struct uv_work;     /* Undervoltage work */
>  };
>
>  struct mmc_ctx {
> @@ -494,6 +498,13 @@ struct mmc_host {
>         unsigned int            can_dma_map_merge:1; /* merging can be used */
>         unsigned int            vqmmc_enabled:1; /* vqmmc regulator is enabled */
>
> +       /*
> +        * Indicates if an undervoltage event has already been handled.
> +        * This prevents repeated regulator notifiers from triggering
> +        * multiple REGULATOR_EVENT_UNDER_VOLTAGE events.
> +        */
> +       unsigned int            undervoltage:1;  /* Undervoltage state */
> +
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
>
> @@ -659,6 +670,9 @@ static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
>  int mmc_regulator_get_supply(struct mmc_host *mmc);
>  int mmc_regulator_enable_vqmmc(struct mmc_host *mmc);
>  void mmc_regulator_disable_vqmmc(struct mmc_host *mmc);
> +void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host);
> +void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host);
> +void mmc_undervoltage_workfn(struct work_struct *work);

We don't need these to be available outside the mmc core, hence please
move these three to drivers/mmc/core/core.h instead.

>
>  static inline int mmc_card_is_removable(struct mmc_host *host)
>  {
> --
> 2.39.5
>

Kind regards
Uffe
