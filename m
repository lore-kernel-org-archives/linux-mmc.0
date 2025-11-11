Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778163A5E61
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882632; cv=none; b=eaGriHgS/8Mg9yVpXKGOycKrybeDF3sA0UbdWSpp8DDcAJTulC6EJRiPwaPEZToPWZGYyaBBytOmQNQlw5RsS+TtFvY9Gv3FJE+dASMf3f+4Y7NptHGsTPKnX9b0M8Yy9LLdu14YIMJqupwE7FIZKY7eAVOIJUUwTMx61gCoXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882632; c=relaxed/simple;
	bh=EvsqPPFe0oeSUmlgAw3dm0536WHrkhiXIamVRC7y0qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbRrh5B40sUHI1AkakvwFn4YXU6xhgEDQGz5sMtdu+6KnBO0PBSlMvJJVFlRuRBWrP30rEuq+KQV82F5wMCuKr1UusE64VdGS9igjSnX7BYeeO3YT502iHAhU8ISMm8aObhEQXXbMyQv4NrYL/e7YTbGUI3eIzBPyAzJjt+w2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A3oz7lA5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3oz7lA5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-787d5555274so34252447b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882629; x=1763487429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LKCHaTU9AqqSilVdSEk0nqYpEpb/jCCe95SCGOIIGQ=;
        b=A3oz7lA5twyw0E1kVLDFiJS7dbLpY7Th1fblmNr84kkr0/+5TGO1zFPAbcU5Qd2cyM
         x74vpEPEu7DoQmAFlFfpQim4orULRoR5IAoD/Tj901CBe7FR13ix+n8RKqTA9S7lCOBR
         99qS6J9GUXum4JHlUKkf5hjxxOu2xhk36GuTmdVrkWjcyJQLsQGeqGzZ9muPRcAAJ8jH
         ZEf4yfTix3SqNI/E+fuiYdRjPcBpSEIoBiHVmEzpwOefmy0B4euMkIdMD1YZp/l7J20u
         D48ntADN+IHsGTG0ii3PHbzhv3Cn2oC3aNOVWB+6bGYno5yXOAk4u7edWHQ+wGDnnnwR
         fM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882629; x=1763487429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LKCHaTU9AqqSilVdSEk0nqYpEpb/jCCe95SCGOIIGQ=;
        b=kEYecXcO3fpR3SHwh5LSR/Gm1qthZtyb2TwFrIib2QGHfDdPO4eyDe36Frkex/H7wJ
         TJrIo4/Q4exBh9VJ9AE8UnK4Iwu/B/OEIVfmct5Qtzh4usH8UvMQqFeNeIcYNz3RAMyA
         ClDfEERW778FyI44zFTUStHxpfxUaKZSEaLE008AHfxi0FBpIRJEtghkpD3LKA27xG/T
         HO8NwXb46l1POyTuXpnC0r/YJBHphL7uJS0B98FiZJ0HiGdJovne5gp3dIXhqH6rSzOB
         TtQAh5cj2nZ5nFpOJkQPu1AZfQ0HLhxk9ZbpUo1z2d0wtF4I65Is+HHrSBgJue+ZDn8V
         DTZw==
X-Forwarded-Encrypted: i=1; AJvYcCUEezanrrdXxdBajZBc2TR3dZUDeVi9rK+tr4TghWMxlWAXr/+DuO8bHee8YyulMRD7K5u8QRMXfyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9GcEWnKOArf98dc6mD8uF+K0da5MlHVEAiv3iz0XmxhI0P4a
	AmPCwW+9HAe/4prdHfIHCnlSzG2Z2VYcQ+QJBxYgbl+F4dx4BuOiKMxo/zObmOyRmUbqnTbMf2O
	7nAsgq2wk/byyJOVtBpMXWvxcb2jyV4ScRBbxr3fcUw==
X-Gm-Gg: ASbGnct/xEgRoqOrG8EmKkXBW2LkzGHUZkTSUlVcIu4OqKLXUn5c3CZvH9DpIYRW9kq
	d8i6VWbBrwTStGusHrcItcxZkYzuWkTvu1QdY2KDnKVxXvpuu7PBMNO3+Nvwnep5Ssvy6FdwvN4
	hqwfXTQ8UYIGBZE4rcZjHFGD6UUr97vugAzHFrOUea158IeSHVd9rOUPd4oWO4BnxVrcuGmWnXt
	9oQ2+71JGwxzJbJw99NEWEHEfqDHYzwC2pyyns0kA1IohJjVkOF8B3hVRr5wJ7P9dZ5n0Iz
X-Google-Smtp-Source: AGHT+IH2f3XqezxeAhdNiKVObMgHBbdajDoMt0Uzx41msTtJ4/Cc2g0V2tOxLNTPJCJid1luqYuD5eKp8Mt/296kpes=
X-Received: by 2002:a05:690c:c349:b0:784:80c9:a4f8 with SMTP id
 00721157ae682-787d534ffe1mr94850237b3.6.1762882629298; Tue, 11 Nov 2025
 09:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141907.229119-1-marco.crivellari@suse.com>
In-Reply-To: <20251107141907.229119-1-marco.crivellari@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:33 +0100
X-Gm-Features: AWmQ_blId-hdIdA29G_YqWQ_lxGPlkPRdUq8v9Z8X8IVcdr2EYee2EAYY4IIHQM
Message-ID: <CAPDyKFqpiWuJs3fZkATnfPejmqL=Ei4x1U9QbuaykuZxca9f4Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-omap@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Nov 2025 at 15:19, Marco Crivellari <marco.crivellari@suse.com> w=
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

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 52ac3f128a1c..4a13111e1698 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1477,7 +1477,7 @@ static int mmc_omap_probe(struct platform_device *p=
dev)
>         host->nr_slots =3D pdata->nr_slots;
>         host->reg_shift =3D (mmc_omap7xx() ? 1 : 2);
>
> -       host->mmc_omap_wq =3D alloc_workqueue("mmc_omap", 0, 0);
> +       host->mmc_omap_wq =3D alloc_workqueue("mmc_omap", WQ_PERCPU, 0);
>         if (!host->mmc_omap_wq) {
>                 ret =3D -ENOMEM;
>                 goto err_plat_cleanup;
> --
> 2.51.1
>
