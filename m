Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41684192E0;
	Wed, 10 Jun 2026 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103662; cv=none; b=VKq48+md79GZpGN+ZyA2nUzPioZVggBW5Aoh+PbEdTaS9uyMNbKVWiJ0cf44PxneKTAk9b2BUetTNM8VUcOCRn8Gha08FHNelPFJCzoPmHo4wUZwWeZ8XsWYt+i3+qLO6cnHKsjoLdFKrC6NLvgHgv+Bf6CB0sDesd1fokbjeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103662; c=relaxed/simple;
	bh=w5lKl1wXa7c6N+MArdV+wVb1XwQIh50fQ/ufprdQRE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpuX7EdmhwCbvTmWd4WWDE7o3zdsqCMzOrcjunPm15PcCvGUTBvqKd2NrjdiicZXDDKfVgfnuGqdQQfMoMbyNXSqE6Hu/LfUb5ZjIAYE+3rdALqzI8QFBIgHE/Xl/JJLhy9y+QOOiwPwHe4HC3mZE1LKjrbPp35JuDCjhe6WXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV/Yu7Im; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV/Yu7Im"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730851F00893;
	Wed, 10 Jun 2026 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103661;
	bh=fLAunGlrFoqKXW1G7loD/e2T2CoCAwtBASWawWOtiM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eV/Yu7ImqlmUKb1vrlC/ZY59Tp1NeOhqhmR6GnntjVM9lvoPrqC7yOKq0anROCN9Z
	 nr7Ghdn95czxjNj24q6bZmRBIdtUMWtU5pchW6hoEK7Bpj2xA7EiRgcLJhq/EiZ7gQ
	 VRJjh9KLzAiflsTPXhSLQXrN7lfdStIMWCor6iTKLKUeC8M3NmOvEyMLO8bLcfXjlu
	 eoe+/pQ/ekxjziro9GtTyeYNUF926aUk4/S0csixDx6f000NX3VpldN3Eqhl3g62y8
	 6O5CRdPFOuOB3Ij/076LObiaUrE5CqgNBAkNV+maNLow13xEXeIepUJf27ZhGTAapz
	 drdpih/ITK0EA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXKQN-00000001WKs-1VHE;
	Wed, 10 Jun 2026 17:00:59 +0200
Date: Wed, 10 Jun 2026 17:00:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mmc: vub300: fix use-after-free on probe failure
Message-ID: <ail8K3v_Ho06rNCv@hovoldconsulting.com>
References: <20260610145630.1788731-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610145630.1788731-1-lgs201920130244@gmail.com>

On Wed, Jun 10, 2026 at 10:56:30PM +0800, Guangshuo Li wrote:
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

Still wrong.

> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v4:
>   - Fix the Fixes tag to point to the commit which added the
>     mmc_add_host() failure unwind.
>   - Add Johan's Reviewed-by tag.

And my tag is not there.

How are you generating and reviewing these patches before posting?

Johan
