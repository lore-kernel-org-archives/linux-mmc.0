Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54433086
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881211; cv=none; b=Kh2J5m2TijdBxzuWXmQWjpnLuYLlr+rRTYfDR+eE/pE1EvwPBjRc+O0Sy4KFupcGsb6D+1+AKBh5CySwLktaJHijyTen56n8h5RAr3m18sRvx7bYEmt7ewaCMqdxhgcT+ER8UmuCDol9EvAVe0YogbMWxI2KR49eV7+4O4TUUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881211; c=relaxed/simple;
	bh=XWfTO4/IXYtSv4EgyQT3r4JllI6XqufjvF1l29xB2vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+fob7Qs4l5bKiUgxrtgIOPoBeR81dbYM+MLmuYEFBxABUCkZwQodq2dVSy7mKjuMiZzmp1euMSJtdYdH1uGlr6gDETVXJVFAw2XMnSLDkYATMow37KxqJ4VRuXijfwlcA2L/vHPVhBUHxyht0Sya6Jf5DGc8gq7oimKXfKdzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=apSJy0Yx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apSJy0Yx"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60157747so38451407b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762881208; x=1763486008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QmKCicVCPHIj3mdKL3div0nARhe2VGZEzDrkecA8Xk=;
        b=apSJy0YxvtCZXQJ8pRiAClvyJv2T8b3lMDkN6i8A369nLPQGR8i55fDJuD2Ul7XmPp
         yKPME9CrcrrhG9jrrz0HNIsIPueleT89lFRzElf1StkWcRiz3N3W6O67QRyXoxmHivK1
         3rFqtQnN2aqEw1JMtNP9CQRIy5hz0ax7pdlkmQ6+TCZJARcPFgw7UFXMZFnV4+AZFUD3
         g0jizlkGMQNbcgCAXbwloT5wqbS8eAkhAxS7csb7UdImTg3JrzVg5tgtWnTw6FNHzBnR
         nHd4eVQE0DFv9W9RYycUd/0B3zMYX5OQGKYSV/uPHzc4RwDwiXh4ERUnFoE07rsg7/Hg
         uRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881208; x=1763486008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QmKCicVCPHIj3mdKL3div0nARhe2VGZEzDrkecA8Xk=;
        b=hLrssFpIBUsK5QzgeKcR+6a1BQaJnahgKpCvIZFqsSipmj9QKzzIoFn9gAIHAj63rh
         AhFMXERiE0NwczvUsItXXZpXtOfgXPgw98u2oi4+7Nt9I1cPsunF+BmY3QouOmZ2QAZx
         osE7P7bOqSjgcvgmD/zF4i+YYMhlw8flB9MaAXSUWjahIpd51//U6AW4R78gotWvStJU
         y2BeoRdT81si7uhG9h0YUp9rDXOP9ew0AfOGFBOUYVrczB5PBleEkw35R3IBfOZZ4BCQ
         HYJP9qH+MqLfwGtMECsQL9SxupbrUghHmwWPYXjj8HRftw2TWYPBgppXsAhAqyoUK940
         rZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdSv3kM7EUj2kv8JsQE7CxprtFN7kgcQoD3ZoMTGLQvbcjGzxP1oARlAkX22l7rjHfPteSWlgsgLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0yMmsCX6FPMnKpfbuziPmsncyPIDtWIydCokAtGrl+JfTlmN
	0/TYXnyXpBVyxoAUZ/BXzu3QGD9OylyMgMADzicEfCi8EvgcXyzuSNfsJ5rUMI4CKxQmcGTs1UF
	BzABN7flQW2EDX3BlCwZzN9vo9JUB/5ORME9ouOCCZA==
X-Gm-Gg: ASbGncuVx5sl7eTVzEUdalrNQnA3g8EjUj3/oZ7IHVdQqGWYuPKdPQ7jTvjxEtFEPHp
	FICWxRGATRfKkAbxI4DZtGA9M0JbBTjECmb7L2MNpEH3msL92sibd6FN6Z5YxgADn5MERTqsPmv
	BytXcQIUjhd96zD9QGh9keTfQzMIhWdCXHMvldYO5iM4rSdl3psuS928V1L42xBNV1n2lzg603P
	60XjYisEdsurIYc9ooTFTPdIe9Kbgk1UoZE4/rVPVv/Z/WeDujMLfjAX5jKA3bn7XyEmqkC
X-Google-Smtp-Source: AGHT+IHsBdT3PZHzLqRZFfNwozig+Xj22E+YyhYW2OHI0PA6fmjqwweePG9pSYLroeVpxbau2y0IZ/+9yhkJkYzwk7w=
X-Received: by 2002:a05:690c:4c13:b0:786:5ebb:483f with SMTP id
 00721157ae682-787d5473c6cmr123803657b3.65.1762881208594; Tue, 11 Nov 2025
 09:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141654.226947-1-marco.crivellari@suse.com>
In-Reply-To: <20251107141654.226947-1-marco.crivellari@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:12:51 +0100
X-Gm-Features: AWmQ_bm9jflRRYlPnBrOqM5u5sgpAgSohcTdgzu--tAO09VnwRFmrIOBZngqZcg
Message-ID: <CAPDyKFq46qON9W5akWh7CV5fiGSLHV=K9F_Uj6u_g1g08DPV=g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Adrian

On Fri, 7 Nov 2025 at 15:17, Marco Crivellari <marco.crivellari@suse.com> w=
rote:
>
> Currently if a user enqueues a work item using schedule_delayed_work() th=
e
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
>
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
>
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they=E2=80=99re need=
ed and
> reducing noise when CPUs are isolated.
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU.
>
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/mmc/core/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index c0ffe0817fd4..6a651ddccf28 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -3275,7 +3275,8 @@ static int mmc_blk_probe(struct mmc_card *card)
>         mmc_fixup_device(card, mmc_blk_fixups);
>
>         card->complete_wq =3D alloc_workqueue("mmc_complete",
> -                                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +                                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_=
PERCPU,
> +                                       0);

I guess we prefer to keep the existing behaviour to avoid breaking
anything, before continuing with the refactoring. Although I think it
should be fine to use WQ_UNBOUND here.

Looping in Adrian to get his opinion around this.


>         if (!card->complete_wq) {
>                 pr_err("Failed to create mmc completion workqueue");
>                 return -ENOMEM;
> --
> 2.51.1
>

Kind regards
Uffe
