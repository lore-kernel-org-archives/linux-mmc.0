Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341AF397924;
	Wed, 19 Aug 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150450; cv=none; b=MT4gxWceJxgD2walQHHhjy1dEhzH+4S+DUdLclqtcKDmcNhvI7qkvu9B3LoZGLEAUO6CmSMEcH4mZr2Gv+87oI+0N0eL37voSB73tWHzdAabJbg1V0DDOspe5HazSlaInQFZvmy9oYTKrFmVwV4FrF+lLp8I89MHbAxyRvxJDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150450; c=relaxed/simple;
	bh=OCelcKD1iht1E8yTPr9g33eyH/fEAmkTxTH11wHYQkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDFCttxi0qbbHiz97Ux3u8FYoWmjRt/pk/KmUVrgdbhzCN63tnqw3B0/QWasYEKdCki8co8nap43XQ6j59UOGLrLMpaee/MhLnYCxhL5iU6hR3zJkLRkV+OxELb6vrgLnnwY9BHHWay4ZzWp8fFWh05r+tdOPk7IWJ3/B1GzxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ9wkdD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ9wkdD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B691F000E9;
	Wed, 19 Aug 2026 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787150448;
	bh=eXAX9WVkkjwpfwoBP0aSF5+4b6zmDw0yiHK3x3icvdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cQ9wkdD1SGpWiXYfOYk995KoukUoiLoO+fv56BXNgjsNUU8ksIiPdtcvVIWNnaNZ2
	 GhjmwdQRd3Lio6alHUlk+x6hkUxLZe019NYvkySPN4lfqMitu4ckoeTubbJfsZw+vL
	 B4RSwd6Y8ciTzJTCT4DgPqdcH/292o/f4MkBnZ38r6UKXERoMJXC6bxIHwhW87oIO0
	 LRRdOdkl5exVB0XgisA8KoQSchtcQRrfeEOcU7VsDXfyZV2QRMT4FJKydeh+2YVJdJ
	 pnxijDOh/uQke1+bKN7SYEI59DysB1fO1TuskLnMpGtvhmWHvpyMyyMHMP0UANsJL9
	 uF6tdcDln2hOQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwhTC-00000001Dwo-1ipg;
	Wed, 19 Aug 2026 16:40:46 +0200
Date: Wed, 19 Aug 2026 16:40:46 +0200
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, cjb@laptop.org,
	tony.olech@elandigitalsystems.com, linux-kernel@vger.kernel.org,
	syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] mmc: vub300: fix sleeping function called from
 invalid context
Message-ID: <aoXAbneEwlouktIx@hovoldconsulting.com>
References: <aoR_1vXMIqIdBDaI@hovoldconsulting.com>
 <20260818180514.71765-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818180514.71765-1-omermetekaya0@gmail.com>

On Tue, Aug 18, 2026 at 09:04:36PM +0300, Ömer Mete Kaya wrote:
> syzbot reports:
> 
>   BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
>   ...
>    <IRQ>
>    __might_resched
>    __cancel_work_sync
>    mmc_free_host+0x19/0x30 [drivers/mmc/core/host.c:700]
>    call_timer_fn+0x192/0x5e0 [kernel/time/timer.c:1748]
>    run_timer_softirq
>    ...

> While auditing the driver for the same class of bug, also switch
> sg_transfer_timer's two timer_delete() call sites (in
> __command_read_data() and __command_write_data()) to
> timer_delete_sync(), since usb_sg_wait() returning does not
> guarantee a concurrently running vub300_sg_timed_out() has finished.
> __command_write_data() additionally only deleted the timer on the
> success path, leaking an armed timer on the cmd->error path; the
> (now synchronous) delete is moved before that check so it always
> runs.

This sounds like a (potential) separate fix that should go in its own
patch.
 
> Reported-by: syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0e06aa1bdc6495bac24b
> Fixes: 1036f69e2513 ("mmc: core: Cancel delayed work before releasing host")
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
> ---
> v3: To clarify,
> 
> LLM usage clarity:
> The fix logic itself (decoupling inactivity_timer from the kref, the
> ordering of timer_delete_sync() before kref_put() in both teardown
> paths, and the sg_transfer_timer leak fix) is produced by me, not
> the LLM. LLM was used solely to clarify the English wording of the
> commit message at first (English is not my native language). The
> "see commit message" comment style was also a recommendation from
> the LLM (argument that "in-code comments are unnecessary when
> there's a detailed commit message") - I now see that this is bad
> practice for the patch, so I reverted comments to the classic,
> self-explanatory in-code format, first time I tried this and I
> won't repeat this pattern going forward.

The verbose comments in v3 makes it look even more LLM generated, as
LLMs tend to be chatty like that.

Unless you're doing something really clever, which should be avoided,
the code should be self-explanatory and not require such comments.

> Proof that mmc_free_host() is not a core issue:
> In response to Jakov, you said that the fix might lie in the MMC
> core.
> a) The doc-comment of mmc_free_host() does not specify any context
> (process/softirq) requirements, as in:
> 
> /**
>  *	mmc_free_host - free the host structure
>  *	@host: mmc host
>  *
>  *	Free the host once all references to it have been dropped.
>  */
> void mmc_free_host(struct mmc_host *host)

It also doesn't say it must only be called in process context.

> b) grep -rn "mmc_free_host(" drivers/mmc/ result showed that all
> callers to mmc_free_host() (including SDHI, dw_mmc, sdhci-style
> drivers) call it in the process context, on the remove/probe-error
> path - usually after mmc_remove_host() or on the probe's error
> branches, both part of the system's normal non-atomic teardown
> flow. vub300 is the only exception: it calls it from the softirq
> context via inactivity_timer.
> 
> If it were the core's fault, we would expect:
> - The API documentation to have made a promise that "I am safe in
>   every context" (it doesn't)

No, that argument goes both ways.

> - Multiple drivers to be using this pattern (calling from softirq)
>   (it doesn't, only vub300)

Not necessarily, as this is not something that would generally be
useful.

> - The line added by 1036f69e2513 to have broken a pre-existing
>   guarantee (it doesn't - there was no guarantee before, it was
>   just safe by chance)

It did break one driver. And that blocking call in a release function is
unexpected and looks out-of-place.

That said, the vub300 driver is a mess and I've suggested elsewhere that
it should probably just be deleted. I'm certainly not interested in
spending time arguing with LLMs over all the issues that are still
lurking in that code.

> Proof for the Fixes: tag is 1036f69e2513:
> I noticed that the commit preceding 1036f69e2513 didn't have
> cancel_delayed_work_sync(), only mmc_pwrseq_free() and
> put_device(), and contained no sleeping calls. The git show
> 1036f69e2513 diff proves that the
> cancel_delayed_work_sync(&host->detect) line was added in that
> exact commit. Conclusion: VUB300's pattern, which has been safe for
> 13 years, has become insecure with 1036f69e2513 adding a sleeping
> call to mmc_free_host() - this commit is the true origin of the
> bug. My previous Fixes: tag, 88095e7b473a, was wrong.

Right. But don't just copy the output of your LLM into your replies,
it's enough to confirm that you agree that the Fixes tag was wrong.

Johan
