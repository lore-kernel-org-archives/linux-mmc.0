Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6F2E06D2
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948093; cv=none; b=Ti5aGVK8BFH+mO+chPtUyIKRUQmCJqyPMuQgWy8Pc0Q+NYK6YiC5MzKZbm8EBWbVUZ1IuXJ68RwscWGakztcerKcXSH0BlKxYzCxXe58D7mQz2CteJviL35ywGhI+7phmty/MF1dw8lB1Noqb6AF+2Mn5vMgOx3gP3Du/tzSm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948093; c=relaxed/simple;
	bh=CsMGb72n65sB84BarfkbfHWx/m2UMDZrZnqMTlXRG54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3Y2dvA79MbdLN6jw058YgirQFXw5BldhmejhfO5bJSlvd8xhfDqKSEzqTWI9BYYbSCAOAg9+N3jAIAN+2Ind45DCpUVJAXUC3Iig4HCBIxwF/q6ANeyZqbPLXIffsjRM9BA2NL+OddyIXRMJSIhSchyQtxhiBUtWLO0G0SnM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6gEz/Qh; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6gEz/Qh"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f9beb2730so662094d50.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 03:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762948090; x=1763552890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgzISDlirsE7rAWSMafTJShRBnGq5ayeujnsXMAtrvk=;
        b=p6gEz/QhKAoAn8gGGoZGX15jWJOJFKqia3aIOW+PAsj43v8gQsGagVuKwdriWbOqVK
         LQt13St9sO53imHqePs9RW1YNgRqd0IquKTEzAyUqoJQC9xpb2pnJFCUzcLF+fe81b1A
         cgnKXW20RRSy2ayWCmRBjYyq1U/T5iRZdGlpSTFyVpOnwuosFc6eoZ7pmfRN7Vvtp8OY
         vVQxuCJTzM65+NuTnY40wjNJyKIU0wB58TqJLzjxqPrat0dJCi27St1tqIL+F/NeBwoj
         XkZi9AgKfOd73846AN8MsKXQPqxqHxGJ+UuL4L9QGERrR8DdQgX/6FQ1k8idKtciTuy3
         Xn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948090; x=1763552890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgzISDlirsE7rAWSMafTJShRBnGq5ayeujnsXMAtrvk=;
        b=uady5rtxke34sF4LtnZ7vWK6qSb2fGuJ7ep+RFLwSvY2Hm/qsPhZVTKg2SRkBtDKDv
         9jcr07qBheN6r8+w6WzxR6YS0aeZXZTg50oigZkss7EMdZSw0QhnEJi4LD+hjAP368wQ
         AbW1d6tWBQTNU9Cg8gd7Ia4NrWA5y6baqUKL/NBuZE8f4kWqfbUctTkg2RLZFK647/yH
         g8QR+8YbIBjFKELwXFXHg6Wytzqa8KhZRDT4Di6OdCLf0PUvK+nfJ/Tpz4miolEmSzQg
         fcf+/TewxG9TYVkKs7AO0rEjycDzzz1XRNEOIFRaWA+4Uxl7SmA9PiE5wvg88mGTEPJw
         UhAA==
X-Forwarded-Encrypted: i=1; AJvYcCW/JBqxnH/8byTwE0zRV2NaR5bx4HSFJwlAZAp74okUrt5O1ayJh8nWolVh7+cbpzVV2fnzJwjnfTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbckzrB/3AXxE4Zroy2T7uLsK7lRrzNMa8WZzHgudSZ6/MKjy
	WxqunSav8uQGzC8RgKvKUqetW5/wKjt+3gnC2uoBdGhPFYHSNcnQnqp6v1Q2uNwRamlMk+0g3UT
	8wS4QsJ7j/b/o2XrPnR2/s9DTUwnf4WO8kGNs5uOhIA==
X-Gm-Gg: ASbGncuR1RTr7EIiW96MMcugEGlUP7s0VyH7KWX0peqi+ZKGe6mJS8+379sTVp6XQ2j
	UrzYkVHGoQ3rqaXxnzw08sreodcEpWnBFOPUWce9+6EhRqqrGn+ngdOgtPbZfpEaZOX14816kzv
	9Tf4L+dNnCcmzXuPeiT9F5E29J9WuA4lbT3OId5PZ8tO0yY6naZabZmLCEAICuj3htImbj0A3NR
	N8Lb5uTd0V8bDqFwhcMv3gweYO/FVd5l4BJ588BPnV6MKXcipotL3EPm21rpbwFmQHs3QH6
X-Google-Smtp-Source: AGHT+IGxVD1ah00znx8Z0n4+25eGvivHAA4K6zNXyg92I1xK4Swd+fm3I5voy/zxPnGWNkitMSTktR/jSmObcXDdDAc=
X-Received: by 2002:a53:d056:0:20b0:63f:9a42:f21 with SMTP id
 956f58d0204a3-64101a47863mr1905650d50.19.1762948090275; Wed, 12 Nov 2025
 03:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141654.226947-1-marco.crivellari@suse.com>
In-Reply-To: <20251107141654.226947-1-marco.crivellari@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Nov 2025 12:47:34 +0100
X-Gm-Features: AWmQ_bmdzPpsi3lbHRhrOb4oHz6RYePwKDFXzCKbUNtzfxdQrCK7xqkVjQWSxdA
Message-ID: <CAPDyKFp9ugYVm4dm6JkHV8z5Tudi6RWbLk2NrkPA26nCbawP5g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Applied for next, thanks!

Kind regards
Uffe


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
>         if (!card->complete_wq) {
>                 pr_err("Failed to create mmc completion workqueue");
>                 return -ENOMEM;
> --
> 2.51.1
>
