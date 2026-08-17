Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340113BBFBC;
	Mon, 17 Aug 2026 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954419; cv=none; b=kz6B6dW6pTWaWOPEOXsdRXnl6seCnbqDFOiPDMLD4ZRd2jVJAeuDhr/yNhxgFUIYhwCpkDlcvwn+AAZGftQIbqGffYUyt+N+bsoHvBRrVT5fj9yvqlWvyOtu5OFuQpiOTKldef/jw+3Yw0Y4lmWAEFFx0MCnwA5KOuUJ6GnYmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954419; c=relaxed/simple;
	bh=4S2TSWz7Baz3O0LkhlH2uKt6ixayYoArL+nrjiKcjJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+iFb5IyWMpeAXYCEJoPAtFl4C+l9R9zTqbXmgk/B1ggsvaHGnbT++IRcz914+NuQCojZfdpEekEcSoqF9yjSt4ujwTBWvlvtil3bbFhH2w4y99VI5TrdK1Sv2P7sCyZfjJq/WLs9AABundcm28EsaoJeLRx1syw6qoGA0NtOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRFsk+mi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRFsk+mi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01CC1F000E9;
	Mon, 17 Aug 2026 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786954417;
	bh=4RpDwH0d4knjfA2Q+V2d9v2VHkcLh3bXBPUfqvWstyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LRFsk+miOW8KxVEQR7zbIFDF8frCoNvQ30lPkgVspyLA45MbdQLjA3UJGoXxkL3jT
	 6FwJ9axdG0sFs5A2sQ/ggBlePl/hLp+4Yk6UN/EWJrZIngq2LiLIlqO86gq0JSJNZe
	 qVE/ti/EZVa1BoZc5iZg7KpXF0HcXgW9nQH9jpMI2pWirqgbB5q+7ieglcLL3kbmGI
	 iZI6EoKxye5SBUHYYB8RuNTq7VVs7LEIIyn0gIeRPYA04fR84+xJA6PjDK84TqMHLJ
	 i4Ed0sF89SiWHGHh8dTWXyU9amGO9etzRSms47fYPEZgjwA0IDKT3ZwbXaG95FvQzo
	 xv/iUfaoydDHw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wvsTP-00000000bQc-0Oe5;
	Mon, 17 Aug 2026 10:13:35 +0200
Date: Mon, 17 Aug 2026 10:13:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Jakov Novak <jakovnovak30@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, Ulf Hansson <ulfh@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Shuah Khan <skhan@linuxfoundation.org>,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
Message-ID: <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816153809.7067-1-jakovnovak30@gmail.com>

[ +CC: Geert ]

On Sun, Aug 16, 2026 at 05:38:09PM +0200, Jakov Novak wrote:
>  Currently, the function vub300_inactivity_timer_expired, which gets
>  called in a softirq context, calls a sleeping function in the following
>  call chain:
> 
>  vub300_inactivity_timer_expired -> kref_put -> vub300_delete ->
>  mmc_free_host -> cancel_delayed_work_sync -> __cancel_work_sync ->
>  might_sleep -> BUG
> 
>  Fix this by replacing kref_put(&vub300->kref, vub300_delete) with
>  vub300_queue_dead_work(vub300), which does the same thing, but in a
>  workqueue context.
> 
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")

This isn't the commit that introduced the issue. The blocking call in
mmc_free_host() was added by commit 1036f69e2513 ("mmc: core: Cancel
delayed work before releasing host") in 2023. 

I didn't look at this in any detail, but having that call in
mmc_free_host() (e.g. rather than in mmc_remove_host()) looks wrong so
perhaps the fix really lies in MMC core.

> Reported-and-tested-by: syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com

Not sure if syzbot has started suggesting this tag, but this should
be two separate tags.

> Closes: https://syzkaller.appspot.com/bug?extid=1ee4f3b9228e35f14677
> Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
> ---
>  drivers/mmc/host/vub300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 2dae474dcd06..df0096bc53db 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -744,7 +744,7 @@ static void vub300_inactivity_timer_expired(struct timer_list *t)
>  	struct vub300_mmc_host *vub300 = timer_container_of(vub300, t,
>  							    inactivity_timer);
>  	if (!vub300->interface) {
> -		kref_put(&vub300->kref, vub300_delete);
> +		vub300_queue_dead_work(vub300);
>  	} else if (vub300->cmd) {
>  		mod_timer(&vub300->inactivity_timer, jiffies + HZ);
>  	} else {

Johan
