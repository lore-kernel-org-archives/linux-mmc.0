Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64E2147E5;
	Mon, 17 Aug 2026 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954550; cv=none; b=KyskQt6haaQiM1OzKmLW5k3PWZNYGZRgfqVCX+7F+z028lzQkPC4wqB8MDJ4hb6+FMXzKNCmwND5JHuTmPFtgkiSPdP2k0SuKTMobwbrWJgy7V+L43HixHX+3DFq5vgFVXWx+sAkyYwYWb/hFqP5BaqfkdecekyrVoXYj3M1bQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954550; c=relaxed/simple;
	bh=u6FLMiIrnqqILYvGteoG+weuF89aQsGDDnC3xATvIuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5WEcXwauETvnOMr7/lopAJLYopvdEQbyVdof3+DT2HsP6FDVfMLge75xsov8uK8O8AlQyVey624+cGahmvg54elSkaMYhb6vnVRYcMxjEBQeWlZTNaEbNAz0mlbjT2uE6+PW4ly/dR4gBf7ogFd7cVWyfpBqvP7ii0RJ1CD2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4pHUx7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4pHUx7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086911F00A3A;
	Mon, 17 Aug 2026 08:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786954549;
	bh=3blEDhhm/oKO43rgWZ04ZpnWEzWWex97RbKnAdCy5q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d4pHUx7fL9DJ6+Mm2wcseloFIE2sAEDAqCvtYs0KAzdTMTYT2eo8HYWSqu/CyEOVl
	 S6dewIo2rZYL1PUadDayEPSVaiooHD2zJkt7Up0l5cSTU8iogL/3oifYVW/DrMScWs
	 rccHUiW9Jd5+20C4nCsypgRrqS4bthUX+NX3ZGLn4IeSBUny2KeUlvoxJbnBZ9Kjcn
	 ytY15LBnKwPHTKP7M0d/cGaSpX6PT76Odft8QwPTgtovqZ7FuhC5+zwrIB20QsBnFt
	 wLqIpX2fHmGnYXvdjG+Iq5BpOJr/qspK4PGyH6dCiRXjFbsiUX/fOsPndowaCqYKFg
	 G4AY9WBHaG3Nw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wvsVW-00000000bSS-44ht;
	Mon, 17 Aug 2026 10:15:46 +0200
Date: Mon, 17 Aug 2026 10:15:46 +0200
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Chris Ball <cjb@laptop.org>,
	Tony Olech <tony.olech@elandigitalsystems.com>,
	linux-kernel@vger.kernel.org,
	syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mmc: vub300: fix sleeping function called from invalid
 context
Message-ID: <aoLDMrhGPGOjNVpb@hovoldconsulting.com>
References: <20260808231019.28528-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260808231019.28528-1-omermetekaya0@gmail.com>

On Sun, Aug 09, 2026 at 02:09:50AM +0300, Ömer Mete Kaya wrote:
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
> 
> vub300_inactivity_timer_expired() runs in softirq (timer) context.
> When the USB interface had already gone away (->interface == NULL,
> cleared by vub300_disconnect() or the probe() error path), the timer
> handler dropped the object's last kref via
> kref_put(&vub300->kref, vub300_delete). If that was the last
> reference, vub300_delete() ran from softirq context and called
> mmc_free_host(), which calls cancel_delayed_work_sync() - a sleeping
> function, illegal from softirq/timer context.
> 
> Root cause: inactivity_timer is armed in probe() and continuously
> re-armed via mod_timer(), but - unlike sg_transfer_timer, which is
> explicitly deleted after each use - it is never stopped when the
> device is torn down, so it can still fire after ->interface has
> been cleared.
> 
> Fix this by decoupling inactivity_timer from the object's kref
> entirely: drop the kref_get() taken on its behalf in probe(); make
> vub300_inactivity_timer_expired() a no-op when ->interface is NULL
> instead of dropping a reference; and in both vub300_disconnect() and
> the probe() err_stop_io path, call
> timer_delete_sync(&vub300->inactivity_timer) right after clearing
> ->interface and before the final kref_put(). Since ->interface is
> already NULL at that point, any concurrently running timer instance
> takes the no-op branch, so timer_delete_sync() is guaranteed to
> return with the timer stopped for good - removing any race with the
> final kref_put()/vub300_delete()/mmc_free_host(). Before this
> patch, a successful probe() left two references on the kref (one
> from kref_init(), one from the timer's kref_get()); after it, only
> the initial kref_init() reference remains, matching the single
> kref_put() in vub300_disconnect() and err_stop_io.
> 
> While auditing the driver for the same class of bug, also switch
> sg_transfer_timer's two timer_delete() call sites (in
> __command_read_data() and __command_write_data()) to
> timer_delete_sync(), since usb_sg_wait() returning does not
> guarantee a concurrently running vub300_sg_timed_out() has finished.
> __command_write_data() additionally only deleted the timer on the
> success path, leaking an armed timer on the cmd->error path; the
> (now synchronous) delete is moved before that check so it always
> runs.
> 
> Reported-by: syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0e06aa1bdc6495bac24b
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

This is clearly LLM generated, so why didn't you add an Assisted-by tag
as required?

Johan
