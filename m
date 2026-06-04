Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB220D4FC;
	Thu,  4 Jun 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561511; cv=none; b=BETLQIsNegNZrd06ZFZ0cWuRfdZdAfJyIeuQZkgLKoM2CdITk5hwLd7mlp7aiDTXMqeJh8LpH4ZBVYxol+39FKOJzlL6HB+5UKgBwMYYDDsBx8KDby5sYd3qxvtHhL3Q0VYR1SZ0xgTbiGNH6kK+75MpZuu5yGfShrztsPb8+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561511; c=relaxed/simple;
	bh=R+NSz8gkXXbdn42YjypHRCJF+zl9VikBLJkSs8CLkvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnlbwYUKzbrBgtFkYtVy8UgIs57VQk30OEVNGUEDywWbSoh/dQpApxxmOnz0KCm8WFxJJQ0CCAYiU/hukDHQC4QP987Hcv7+FF0IQ9fo/u5kLFq5Vk2N3XtZs/kAhxQHi1P98dWlTBMnU5Q+nlA+9nWd6WDg4O9ovbJ8Z52tnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiYao+Ei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiYao+Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A20D1F00893;
	Thu,  4 Jun 2026 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561510;
	bh=gzNa9GJvNJi2A7GhZdv3uw+x53geajtTfU8l8xFo0pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eiYao+EinvylZHqu5p0Wc9olE0CSHoa/MwN3cVV/d6ltAUMd8YuW0rToxOll5ZMQP
	 K3EpLxetLqJ8esXuGFoDCmWXauwbW8t1dPdufwNIGaeGsSKDKFBiCsDV3hvW8+huWD
	 ekK30CwfI6zvlB/8PNXuo4DiYfgISaNtSQeInu0p1gkeLAPpIIST9Kb4PHkrI8zkGZ
	 s4r9+DwTM90Z26q5wHaRXwYw43F3zDmtIZpSQcS5O0OWWBVzQAW2M3ETRQPlkf0Guc
	 0iEmxSWawzFU4+wyqrhgjbk6rqw3pJjm1Yw8e9bXxZl/PbHAR1e+ccwU9K2GS50gLN
	 Z+d6p2EDqGq/g==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV3O0-0000000AyHm-02hk;
	Thu, 04 Jun 2026 10:25:08 +0200
Date: Thu, 4 Jun 2026 10:25:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: vub300: fix use-after-free on probe failure
Message-ID: <aiE2ZKQ1z1s0XVo4@hovoldconsulting.com>
References: <20260604054628.1411107-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604054628.1411107-1-lgs201920130244@gmail.com>

On Thu, Jun 04, 2026 at 01:46:28PM +0800, Guangshuo Li wrote:
> The vub300 driver lifetime-manages its controller state using
> vub300->kref, with vub300_delete() freeing the mmc host when the last
> reference is dropped. The probe error path after the inactivity timer has
> been armed still bypasses that lifetime rule, however, and falls through
> to mmc_free_host() directly if mmc_add_host() fails.
>
> The race window is between arming the inactivity timer and reaching the
> probe error unwind after mmc_add_host() fails:
> 
>         probe thread                     timer/workqueue
>         ------------                     ---------------
>         kref_init(&vub300->kref)         ref = 1
>         kref_get(&vub300->kref)          ref = 2, timer ref
>         add_timer(inactivity_timer)
>         |
>         |   race window
>         |<---------------------------------------------------->
>         |
>         mmc_add_host(mmc)
>                                          inactivity timer fires
>                                          vub300_queue_dead_work()
>                                            kref_get()          ref = 3
>                                            queue_work(deadwork)
>         mmc_add_host() fails
>         timer_delete_sync()
>         mmc_free_host(mmc)
>           frees vub300
>                                          deadwork runs
>                                            use-after-free
> 
> timer_delete_sync() only waits for the timer callback itself. It does
> not flush deadwork that the callback may already have queued. As a
> result, queued deadwork can still hold a kref while the probe error path
> directly frees the backing mmc host and the vub300 storage.

How was this issue found? Are you using some kind of static checker or
LLM?

> Fix this by making the post-timer probe error path obey the kref lifetime
> rules. After deleting the inactivity timer, drop both the timer reference
> and the initial probe reference, and return without falling through to
> err_free_host. If deadwork was queued, its reference keeps the object
> alive until the work item drops it; otherwise the final kref_put() runs
> vub300_delete() and releases the mmc host and USB resources.
>
> Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")

This is not the commit that introduced this issue.

The incomplete error handling for mmc_add_host() was added by commit
0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()"),
and before that you'd probably get a crash on disconnect instead.

> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/mmc/host/vub300.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 3c9df27f9fa7..3546473d3486 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2341,6 +2341,14 @@ static int vub300_probe(struct usb_interface *interface,
>  	return 0;
>  error6:

Which tree did you create the patch against? These error labels have
been renamed in mainline.

>  	timer_delete_sync(&vub300->inactivity_timer);
> +	/*
> +	 * vub300 may have async references via queued deadwork. Drop the
> +	 * timer's kref and let the last kref release free vub300 via the
> +	 * proper destructor.
> +	 */
> +	kref_put(&vub300->kref, vub300_delete);  /* timer's kref */
> +	kref_put(&vub300->kref, vub300_delete);  /* init's kref */
> +	return retval;

Add a newline before and after the return statement to make it more
clear that you have an early return here.

>  err_free_host:
>  	mmc_free_host(mmc);
>  	/*

Johan
