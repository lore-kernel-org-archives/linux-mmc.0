Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0D3A9002;
	Tue, 18 Aug 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065727; cv=none; b=HGKFJ4uNRd8BOzJyPNWXxiWqd0FpAlWbrkAR47I4agwpqXTyWaA+UKHTa/piA4z67VYtB6TRiln6ewRtEcBGNBnCoY/CL1wDHe7xakKKrlv9VZWudPucUjPG1GsJ3aeYM32zDSlZtYN+Skeap5nnG1W/IvVwdcBGce42FeOQRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065727; c=relaxed/simple;
	bh=sCpC4dcWlGQy/NmTH4fZB3oNMOjGtZq8/H+eR9TSOR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJZk6MTrxDfsCKEUk0I70I7iCp/s+CDtzHok/qOqha4RFbEnXwQu36Qj8TYREr2kvY5tG0v6ubckTfg3DTmi36fS+uqEMvMA0WP3DcspJk9v7EDpKGBxTchIck+gEkJPtoY6fKruRmDgLQbY5ye/TSSVCrEpOj7waQ8EypPGVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhX+GHpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhX+GHpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3E51F00A3A;
	Tue, 18 Aug 2026 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065725;
	bh=Puj5T14JRbxbfZCXiCnh/G8usK7dMC5igNOOiUb/f+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QhX+GHpPtd/YC3K/9Kzik1Ukv8gGeA4YksFu+1v+909Ds0C9IyR7RJ1CGah9/9LxQ
	 ToGufnBpCs/8wQk9sO16Hz3yCSrzFSAUotGDkyGYgK3PLRhanxBCbowl46rTI2d1wi
	 PcA5R7vu3eJGHmliLGUjIipBfeeuZ2mVWHTiP7S/Ty5wvQfHWuH1+TSMqPI7L0xbDY
	 2wax5MZH9p7tMFzMpdFXCQtFEs57fWHEK+grw1/BUR/cOMeL0mYtaWHrqSSKRgkGrg
	 I0JcNzUYAo+0paFGJefzwVco1iWIhwVErUZ78OzZw5BLa3ANCcqoIpNkqwCBGntFxn
	 Jf4qtbp4Mjyfg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwLQh-00000000tuL-35y1;
	Tue, 18 Aug 2026 17:08:43 +0200
Date: Tue, 18 Aug 2026 17:08:43 +0200
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, cjb@laptop.org,
	tony.olech@elandigitalsystems.com, linux-kernel@vger.kernel.org,
	syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mmc: vub300: fix sleeping function called from
 invalid context
Message-ID: <aoR1e68--w71XihE@hovoldconsulting.com>
References: <aoLDMrhGPGOjNVpb@hovoldconsulting.com>
 <20260818143658.61667-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818143658.61667-1-omermetekaya0@gmail.com>

On Tue, Aug 18, 2026 at 05:36:56PM +0300, Ömer Mete Kaya wrote:
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

This is not the commit that introduced the issue. See my reply to [2].

> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
> ---
> v2: I used an LLM to help structure and polish the English commit
> message. I did not know
> this required an Assisted-by tag until Johan pointed it out - added
> now.

So you didn't use an LLM to write the proposed fix itself? The commit
message and comments in the code makes it look that way.

Also note that the syzbot LLM created a similar fix the day before you
posted yours:

  [1] https://lore.kernel.org/all/49982079-95f4-4e8c-bbbc-bcb127e2f378@mail.kernel.org/	
and there are at least two further proposals:

  [2] https://lore.kernel.org/all/20260816153809.7067-1-jakovnovak30@gmail.com/
  [3] https://lore.kernel.org/all/20260818064800.3886851-1-tao1.yu@intel.com/
	
>  drivers/mmc/host/vub300.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 2dae474dcd06..def8c7a29e91 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -744,7 +744,7 @@ static void vub300_inactivity_timer_expired(struct timer_list *t)
>  	struct vub300_mmc_host *vub300 = timer_container_of(vub300, t,
>  							    inactivity_timer);
>  	if (!vub300->interface) {
> -		kref_put(&vub300->kref, vub300_delete);
> +		/* Intentional no-op; see commit message. */

Comments should be self-contained and not refer to the commit message.

Johan
