Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1538E8D5;
	Wed, 10 Jun 2026 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078230; cv=none; b=N0EHTdRx88ktl2bLUEHQP8Xh6Wxh698R6RnTlQbbNcrkQ0osDI4D0IHD2QPXCgp7bEkAvWDEnvGtmSEcIKForUi/hMuWilSnqLpQUC+h5B+6sxZZQE3g4yLFZMRGbnI2llG045JB8u95U6eq1vU2JTG5dFLiLXGt4v2CouJQMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078230; c=relaxed/simple;
	bh=7XaHBnf7Alj4M/i4GuM/skfdr2Kj4vkJ2wB974S52AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaklbIzDKFOKSO414RWvWg+SHBL7gqw7zDuJgyaT5DFJ5YcooxMiBXZPKSK7IHDuLPEikfY2skjGcjZWCXjRBpg+lG4xHbkGXJsPbl4aoOD3tMjDHNt+0X7oxj322a3XGTQSsw64vOyRebgkew5WA0/jer2KcBItGr+ZMx1MBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+ETSH4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+ETSH4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2662D1F00893;
	Wed, 10 Jun 2026 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781078229;
	bh=0GUjnWsLZjYOu/RMSVn+JZ9RMSDzRp+3XSMCNRi65Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X+ETSH4K1MIpKJHhg0fQqMn3cRB/lFRkfGzDMOzM7mSeWW+VfFgkylcl+NtwEtz2k
	 O61yHxwKw3zCyKV9xS7L34ixjERjQsUhax9LTWLZRu+fOGV4Ww1JFRuDNKRrrtOJe5
	 aP+NrsBZhKjeMOc7pPKy4l1yrP0MlpI2W7WWO7uK3kIvq4OeThKrN8LNKjm+Hli9JR
	 uyM8xZcpgJhspSAQXcOPQujpg/bsdrxZtVB2Lbkd15r4J82kw+Q2NhGLX+INz4XjEH
	 M49eOlkW/KYwDzlZCuxx3jGJKL+JmylskanIJg8652kSteTLrTNk+yrCBAFD1iUZ8C
	 wc1eHVW5mbk5w==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXDoA-000000017Mt-3s6l;
	Wed, 10 Jun 2026 09:57:06 +0200
Date: Wed, 10 Jun 2026 09:57:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mmc: vub300: fix use-after-free on probe failure
Message-ID: <aikY0nFweVi4fn6v@hovoldconsulting.com>
References: <20260610034904.1596521-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610034904.1596521-1-lgs201920130244@gmail.com>

On Wed, Jun 10, 2026 at 11:49:03AM +0800, Guangshuo Li wrote:
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
>         add_timer(inactivity_timer)      fires after one second
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
> The inactivity timeout is one second, so this would require
> mmc_add_host() to both fail and take more than one second to do so. This
> is unlikely to happen in practice, but the error path is still wrong.
> 
> timer_delete_sync() only waits for the timer callback itself. It does
> not flush deadwork that the callback may already have queued. As a
> result, queued deadwork can still hold a kref while the probe error path
> directly frees the backing mmc host, including the vub300 storage.
> 
> Fix this by using the same lifetime mechanism as disconnect. Clear
> vub300->interface so that the timer callback and any queued deadwork
> return early and drop their references, then drop the initial probe
> reference and return without falling through to err_free_host.
> 
> Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")

You are using the wrong Fixes tag here again. This should be

Fixes: 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()")

unless you consider this bug to have been there since the driver was
added.

> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - Use the disconnect-style teardown by clearing vub300->interface.
>   - Drop only the initial probe reference and let timer/deadwork drop their
>     own references.
>   - Mention the one-second inactivity timeout in the commit message.
> 
> v2:
>   - Rebase on current mainline.
>   - Correct the Fixes tag.
>   - Add blank lines around the early return.
>   - Reword the code comment.

This looks good to me now otherwise, so with the above fixed:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
