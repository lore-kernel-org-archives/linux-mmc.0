Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670563F4839;
	Fri,  5 Jun 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665051; cv=none; b=n+FrOp2dVYEBLSpm9GbnlK9ofg6rBdFT+UQOQPsxzntm3EXoGkyYxdLLjuT9g48KEbK0Flaa/aacaLTvVOj2rsc2Jxao53epoAWTxLeePoXjQTpX2EnsEtftUr/29CEtSnXCPKbDmTv82Hsvno0LutsofGhdz/J6UXVlDsh5has=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665051; c=relaxed/simple;
	bh=+8VoWYOVVk4Ax/GXwqQQ/cI8xY5XtFijHh8x+1AF/S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsY1b7KSOKnY5ecWCP98lvEKxSrMCdLqgH99uZOetB0CfhtMg6pbmdI3lR5ve0Uu95bnxWY5VoOYWg3efCQKlqk2AVXXxmtIIwbRG4RJQlIhrp4hoqG8I6w5TSI4x34nIBE7vc9iPNxHBpeMKBcmGOisoVuRpKfrossKxhcXd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL+VTKb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL+VTKb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC91D1F00893;
	Fri,  5 Jun 2026 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780665049;
	bh=E5fv+gocFRzI67nbJoG36UWHjesSesONvIbk0lbKuI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dL+VTKb/q6KMKBkT8DQbb/Vh+hOxFlgICPpaHxLLv4bxVrb4py4J8Us71/NoW7yo6
	 1HKqbdSW/anzDhuJN7psq3OMhYuI2TxUeUqNQWmdO2uuU+L8j72GsUFF7rSYqYnSU2
	 5K5qZLql0IhXMX+VYj970UmkV7HRnLUTCuOMwJ9pZt/DJETfczd61UHd3bqu0GXovB
	 7UYNQyN67wPUrNm2SJtOUMNR7QxfN7blJ0I/33ib1MzQhQjbfT6oXfGiHRxL2qjlk1
	 mt7Xx7ThfAVPHhIkwGDR2JfrcHyCxQmohbtRoAE/rI61uOYgDTGw77p80k7l1202x0
	 3F0G+kLn1JcuA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wVUJz-00000000EJf-2iOb;
	Fri, 05 Jun 2026 15:10:47 +0200
Date: Fri, 5 Jun 2026 15:10:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: vub300: fix use-after-free on probe failure
Message-ID: <aiLK12tgrzvqCMp_@hovoldconsulting.com>
References: <20260604094801.1418367-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604094801.1418367-1-lgs201920130244@gmail.com>

On Thu, Jun 04, 2026 at 05:48:01PM +0800, Guangshuo Li wrote:
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
> directly frees the backing mmc host, including the vub300 storage.

You should mention that the inactivity timeout is one second, so not
only would mmc_add_host() need to fail, it would also need to take more
than a second to do so, so this is unlikely to ever be an issue in
practice.

We should this fix it of course.

> Fix this by making the post-timer probe error path obey the kref lifetime
> rules. After deleting the inactivity timer, drop both the timer reference
> and the initial probe reference, and return without falling through to
> err_free_host. If deadwork was queued, its reference keeps the object
> alive until the work item drops it; otherwise the final kref_put() runs
> vub300_delete() and releases the mmc host and USB resources.
> 
> Fixes: 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Rebase on current mainline.
>   - Correct the Fixes tag.
>   - Add blank lines around the early return.
>   - Reword the code comment.
> 
>  drivers/mmc/host/vub300.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 6c3cb2f1c9d3..1b46bb87f39a 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2342,6 +2342,16 @@ static int vub300_probe(struct usb_interface *interface,
>  
>  err_delete_timer:
>  	timer_delete_sync(&vub300->inactivity_timer);
> +	/*
> +	 * vub300 may have async references via queued deadwork. Drop the
> +	 * timer and initial references and let the last kref put release the
> +	 * host through the proper destructor.
> +	 */
> +	kref_put(&vub300->kref, vub300_delete);	/* timer's kref */
> +	kref_put(&vub300->kref, vub300_delete);	/* init's kref */

This driver is a bit of a mess (and is IMO a candidate for removal
unless someone steps up and rewrites it), but shouldn't you use the same
mechanism which is used on disconnect here?

That is, to clear vub300->interface so that both the timer callback and
queued deadwork returns early and drops their references? Otherwise,
nothing prevents the timer from being rearmed after you drop the final
reference here, leading to another use-after-free.

So something like:

@@ -2336,12 +2336,16 @@ static int vub300_probe(struct usb_interface *interface,
                         interface_to_InterfaceNumber(interface));
        retval = mmc_add_host(mmc);
        if (retval)
-               goto err_delete_timer;
+               goto err_stop_io;
 
        return 0;
 
-err_delete_timer:
-       timer_delete_sync(&vub300->inactivity_timer);
+err_stop_io:
+       vub300->interface = NULL;
+       kref_put(&vub300->kref, vub300_delete);
+
+       return retval;
+
 err_free_host:
        mmc_free_host(mmc);
        /*

USB drivers must not do any further I/O after disconnect returns so not waiting
for any scheduled timers and work to complete is a bug in itself which should
also be fixed though.

Johan
