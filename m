Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2C382F13;
	Wed,  9 Sep 2026 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936809; cv=none; b=hhyhQWmMHVPIAGfY6WekcJGN9KIHqxenM4dWXccMcRkuJFA8raqP4zDp37OG1yn7KmSxEN88A87RCVGX0M8rIAmD+10rqv2wQDhREJEFJA0PmkEaRNl+v8n69ceHJvGrxYjVBlhJWYXIVL1JrQqmlcowJZAT4QxyqMzv91aoICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936809; c=relaxed/simple;
	bh=YOVDnEGVN2m35o+yeMdH4SJbA8GpCPWOBsXNd9D//Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZJf6jE6MHRHurOobO/WcpRj1/3+Oma9KlKsri4WWz3weQjrW8SiXyJFvrTXstsPIGEZ9ZlIUvA9chXonR2Uz3cm/5C3jnKUNn56xp+zWg9Tg2IqLcksNpRYxdfbXymOy+8cET2fVXFupIi04fjPee/FQBhVIbGJdtuciiFNLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWqJfPP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWqJfPP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AA41F00A3A;
	Wed,  9 Sep 2026 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936807;
	bh=gVoTzg8k2Q2SdIEsXVnrd6PG+iB9TcVYJpotfyeESyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QWqJfPP9wSJKqWZSre+6MLR3q8Ud/lIIrdGTm+eohTFO9aLsD0OXAog8P5ttprR2t
	 fNcZobcs0zx76JKxWABElw4SabTl8Z+3xTZ/7eVlLcoJV0YvUZTirDJU/IvU8QNSaX
	 RvJ5ufsQ8bkmQdqu6RVfYDUxq9n6FdeRiqeoa0tCf38uzMoaZHA+95wbUaxZ0c2JoT
	 /2tThLazsXGbwLLbVhxghctYeQ7An2M7Y1HrIuomj01uCqszXDZvf8SVvxVeKhDs/T
	 bJWQPakd2zfsmunhTo2+Za9YFUfYYSGk2vToTvUlYBkamt0nhO8GNQgczC+fll6ABo
	 /+CSn6vaCV0GA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4CBQ-00000001onS-3Xcw;
	Wed, 09 Sep 2026 08:53:24 +0200
Date: Wed, 9 Sep 2026 08:53:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Tony Olech <tony.olech@elandigitalsystems.com>,
	Chris Ball <cjb@laptop.org>,
	syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Subject: Re: [PATCH] mmc: vub300: never tear the host down from the
 inactivity timer
Message-ID: <aqECZPhDe_elcG5P@hovoldconsulting.com>
References: <20260908165050.1930-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908165050.1930-1-yogeshgaur.83@gmail.com>

On Tue, Sep 08, 2026 at 10:20:50PM +0530, Yogesh Gaur wrote:
> vub300_probe() takes a second kref reference on behalf of the inactivity
> timer and arms it:
> 
> 	kref_init(&vub300->kref);
> 	...
> 	kref_get(&vub300->kref);
> 	timer_setup(&vub300->inactivity_timer,
> 		    vub300_inactivity_timer_expired, 0);
> 	vub300->inactivity_timer.expires = jiffies + HZ;
> 	add_timer(&vub300->inactivity_timer);
> 
> and expects the timer to release that reference from its own expiry
> function, once it observes that vub300->interface has been cleared:
> 
> 	if (!vub300->interface) {
> 		kref_put(&vub300->kref, vub300_delete);
> 	} else if (vub300->cmd) {
> 
> That is wrong in both directions, because the expiry function runs in
> softirq context.
> 
> If the timer happens to hold the last reference, the kref_put() runs
> vub300_delete() -> mmc_free_host() -> cancel_delayed_work_sync(), which
> sleeps. The ->probe() error path arranges exactly that: it clears
> ->interface and drops only its own reference, leaving the timer armed
> and owning the last one.
> 
> 	BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
> 	in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 191, name: kworker/0:2
> 	Call Trace:
> 	 <IRQ>
> 	 __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9197
> 	 __cancel_work_sync kernel/workqueue.c:4487 [inline]
> 	 cancel_delayed_work_sync+0xb8/0xf0 kernel/workqueue.c:4568
> 	 mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700
> 	 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
> 	 kref_put include/linux/kref.h:65 [inline]
> 	 vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747
> 	 call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745
> 	 </IRQ>

> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Reported-by: syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f4a0159ce6802a0a4774
> Reported-by: syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1ee4f3b9228e35f14677
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>

You forgot to add an Assisted-by tag.

Several people have already proposed (LLM generated) fixes for this.
Please search the lists.

Johan
