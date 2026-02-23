Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDA281358
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856026; cv=pass; b=E8VfWZbof451OEZ3kgudxk/yf5w0dHL6KISWmdPWANDTvlK5Q6mY8yLTMME9yHfLbV1+dBHfy8uguEcq04f9BYYh3AxhFMMc++ZsVFCZIK0SNobFsTXh6Nah5iFd2KODMXEtrNTEYnf0nJtnekoM1kSAj7ZeWoBipTiqyUwBPu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856026; c=relaxed/simple;
	bh=4KkXfb0hX48GWnAgt+Gf2q0dnfvPe2syfroDOciYpG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNOhq+20NFw0KMR9PzwAR9E2MMJ015+m1IFEf2AfUELbz9cbuOX8gj9G8y8ekla0PvBOALy7mRXP2np10A1/rvnXxYTlnzCy/SSL1OVqSLzyJtqM1AHdnb+V7k1o43Awq72Rn6lDfywDsbsKQ938brm1IM/46INkNwTiyAxSmME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ay9uNtRW; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ay9uNtRW"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59de66fda55so4903308e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 06:13:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771856023; cv=none;
        d=google.com; s=arc-20240605;
        b=izWjDBVI8AIfFIfDyQ7rc/72w38i1ceWD6N9GhbO3wfrEoJppyHV/q4GYlazK4Pmn8
         VeGxAahpvz5mgB3ju0iNo85kb/GbHuDqua75ik6A3UUepma496aceI87mMNlOvlpr7ps
         qLtZL4APMczIXvKDwW6zCjSpujwKDMlwJl//XtZ2Ub+i1s2OrodXFYS2v39fYtcKUln1
         lEIyGe0muEJvPZ/5CDkRQHR8IU0wuWg/M1ZcOH65p75SZRIhSgRlwDUNGINzbe9W9I9T
         oGyFQN9KVyPn1nl/I90YqndZT700Kr8K059b419YL/40etZY0G4VC3ursRYp9qTY5Rcy
         Kyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZSkS4xSTQDd/nSKVQ38rSQfj2WvDl93Pr4Jl1qJpA/E=;
        fh=kWhYNB06xWP1qtllEh8Cf6U9SRkjVdh/gJ/uBNAjC7c=;
        b=UyRjMGWuUcn5oVYjwT3hj4KtIL4TgaLslqVEsGv1Kdo+zs4O0k5sCX3WcQvY/nAiP0
         hrWmv674E8sKXFHAJr4FngB6uDvt/gam3ArUzNVKfQzt3NCEL2TzPgAq8S2TqOrdmJHw
         VSpvXo+JTCgg9/0gOMTcqoCCQzBAVW1j2dOtfLKu+N+2Q7IesqD1XBy8KNxhudbjHQ/s
         ycY3YVmpPYvDs8GvRPA+6oHGyYXOYy8WgkQGIu6NNouspdiKH7uMOQ6PXwCGFpthETmj
         dnACuDeM+fI1TOrND+y4gsy5B2gJfGb+7fPfrH4DyTRe0PdJooFicMZrXONL+YaJEqav
         fQ6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771856023; x=1772460823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSkS4xSTQDd/nSKVQ38rSQfj2WvDl93Pr4Jl1qJpA/E=;
        b=ay9uNtRWfsroWDhWra3P/fVC3FaHx730i8NDjSneTGNlcz0AmiYYki7kSPVRA+iSMS
         q7VYS9GwzcTsMe22o2kjSsQgtD1DgVGyyINLNbDs7HHJWOEKWqwvukKa3lv8e+H0wk3T
         b53y5tsQzrHeW0yrTp01uztImjyOC7wKbJLWeAj6fAD27c784Nw0D0AtrNBhDjTy6+Fa
         EQgz8eTiHIRR1y23rpTpwc8Jl+OHyPHFv7a7V3Q+Mv9Gaw9kfon+3pLbFpYIHh7ljCE8
         cMEKg5eRt1B3dYX8KOttPYkGV9pVNvw1/zLaPNhwjT60IMq5M1Uy71vucP1d1/jB4eWb
         cfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856023; x=1772460823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSkS4xSTQDd/nSKVQ38rSQfj2WvDl93Pr4Jl1qJpA/E=;
        b=FTJo+wmWhDLxqm1m1Fug4my6tE3dcu/Gpjz4vtzMGGc9pLDLd+RFyn2tBgWfAITVUE
         gN9F7rRKB9Z4gDRwFnl5I7m1RlDmVGkJhYWcPgdIuPm8T5+n/E87vYc+mzRcdKIEmbg8
         +m3AoD5SFFHE1I4YjNlgjxEhRYSdfxcE+auK+xEh5LCxO7GvuruCa1f98ZMQiC5nfEYk
         b7cUo7bHXztzc4GfmoG7FboW1T+du7f1yMBRMdsRjqZWgxJTx5BfyfQoayBPkU4R21LW
         4aYHX+09ZOHFzpbxNmLUk9YPmFbMLmKS64uX6jlJ7MyTDsDNJITpv6JYzKOfmMJZoZmH
         AmcA==
X-Forwarded-Encrypted: i=1; AJvYcCVCFe/I6k739UOL/5HSY0M4YJvwhyjwCFc3WGsaIoIL+9FyUUKMU+poAJV8p8ixYlZbYdWwVo3aruw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQM04T8LFIkZS5YFBR7HgDvO9tdLu4iTmVd9KKbRisl++PoXcG
	peU4i2QwTUkGLrY9cai9nk+Z0k7v0vD397D+fCGjeaoyWF+xmHoMh2aeivpR4AMiJ3IFzf0+SU7
	bufKMRjfUUCSVf6yc0/CJ60/OjYaMDBXVcZe0Rcl7yB6IbfxbU20/
X-Gm-Gg: AZuq6aJ+D4e/XFEb+3iaL2VxJ11W9umgUAK0piKcRNk7oMGBjSjfVuQSkNNLzxO218c
	JQdcGWo49oubvMk69ODzO8sIJYZ/QcWM/0z/Gq6n10lWSu45vFsU12rpkqeHDBYZ3EFXICSmJ5K
	EwfPsh/RiLWe2Sp+6hQ82JVWDQA9tI398Q/CwB2wPe0aFuGcGQ/EF6Boe/5ApW73kVQ942xLCD+
	UQpf5FFp+RcfXqzdLyXdly64niAY6jthkvV8JkJTPXkbWbd0gcinaJqvYkF4QPnN8tUqMu7Z5X+
	gjTfNRRz
X-Received: by 2002:a05:6512:63ce:20b0:5a0:ee55:3dbd with SMTP id
 2adb3069b0e04-5a0ee553e23mr1810374e87.9.1771856022895; Mon, 23 Feb 2026
 06:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115214648.168365-1-pgeng@nvidia.com> <20260219202954.937508-1-pgeng@nvidia.com>
In-Reply-To: <20260219202954.937508-1-pgeng@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 15:13:05 +0100
X-Gm-Features: AaiRm52TCuoishBZCXeYAUbucX7Og7doxnsYuSPgLiLI9z3JRm4io_MyXU9Dlak
Message-ID: <CAPDyKFpw0Qe0doJ_H0E++4+OtGR0xBCqMDxZ_FHvTLPk1-AK-w@mail.gmail.com>
Subject: Re: [PATCH mmc v2] mmc: core: Avoid bitfield RMW for claim/retune flags
To: Penghe Geng <pgeng@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Feb 2026 at 21:31, Penghe Geng <pgeng@nvidia.com> wrote:
>
> Move claimed and retune control flags out of the bitfield word to
> avoid unrelated RMW side effects in asynchronous contexts.
>
> The host->claimed bit shared a word with retune flags. Writes to claimed
> in __mmc_claim_host() or retune_now in mmc_mq_queue_rq() can overwrite
> other bits when concurrent updates happen in other contexts, triggering
> spurious WARN_ON(!host->claimed). Convert claimed, can_retune,
> retune_now and retune_paused to bool to remove shared-word coupling.
>
> Fixes: 6c0cedd1ef952 ("mmc: core: Introduce host claiming by context")
> Fixes: 1e8e55b67030c ("mmc: block: Add CQE support")
> Cc: stable@vger.kernel.org
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Penghe Geng <pgeng@nvidia.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  include/linux/mmc/host.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..ba84f02c2a10 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -486,14 +486,12 @@ struct mmc_host {
>
>         struct mmc_ios          ios;            /* current io bus settings */
>
> +       bool                    claimed;        /* host exclusively claimed */
> +
>         /* group bitfields together to minimize padding */
>         unsigned int            use_spi_crc:1;
> -       unsigned int            claimed:1;      /* host exclusively claimed */
>         unsigned int            doing_init_tune:1; /* initial tuning in progress */
> -       unsigned int            can_retune:1;   /* re-tuning can be used */
>         unsigned int            doing_retune:1; /* re-tuning in progress */
> -       unsigned int            retune_now:1;   /* do re-tuning at next req */
> -       unsigned int            retune_paused:1; /* re-tuning is temporarily disabled */
>         unsigned int            retune_crc_disable:1; /* don't trigger retune upon crc */
>         unsigned int            can_dma_map_merge:1; /* merging can be used */
>         unsigned int            vqmmc_enabled:1; /* vqmmc regulator is enabled */
> @@ -508,6 +506,9 @@ struct mmc_host {
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
>
> +       bool                    can_retune;     /* re-tuning can be used */
> +       bool                    retune_now;     /* do re-tuning at next req */
> +       bool                    retune_paused;  /* re-tuning is temporarily disabled */
>         int                     need_retune;    /* re-tuning is needed */
>         int                     hold_retune;    /* hold off re-tuning */
>         unsigned int            retune_period;  /* re-tuning period in secs */
> --
> 2.43.0
>
>
