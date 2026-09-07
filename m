Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC4471CF0;
	Mon,  7 Sep 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789357; cv=none; b=LlybeWIYnn80Ehk2vz2cfVdM7yap8dRNQLUuFoGBHxRbQWCGimD49Ynrsc74Uz5MWyaGVsz+gIa8rtEmp5HCM33WE40hs1WKk54ven7zUhdM1oT2h0McvZAq426+ELiy2xMkFcwmT7o5N5FXNDN8Imcgdbxl4pR6yrI1nbRWeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789357; c=relaxed/simple;
	bh=uJ9yLiPjkV7mqJYi/e/sLIQfI5MzeKtKqTaBRnPdZII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Ihie9yAdJ8P55m7YqxVaKK8HWMNepO5Cvjxzqdhh3M55zfTK4GsHeqcfci5GIHoeEfpRCSv0+9FHeNj32jgfqclVneguhndBakz4htQEEyY2rKANTYwVrK+hORH2Z+HHvjpcYylGEaCrwvTsjvqpydOPQihON+m07IsI2OhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivka8e92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivka8e92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADE11F00A3D;
	Mon,  7 Sep 2026 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789356;
	bh=QX2gRrWLh0XG2Wnzu/p5Y1nX85VR2Z84CbvCZIU2k4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ivka8e92obxVMpDR7ZEUoeDhvXqG3e0ojPCbeS/dG+aa3Y3rbtISKis/kmhPKuPH1
	 Yw3qhpozWs8XL9INijAninTqdqeB9qzyKA5f8rY6z/uRRbkEPjL6FPYp3mPsT7ofN2
	 7+4jfvEx5JZcliiczaVbBDZ9hgRMiwyCj6UApHCzgtur3QOAccZfVLesvAbJqjAO3x
	 aJSKaGW5icuy6uzIFw4ZUHr2S0XWa1pQCG/L8Ae3cl2yi+uANnJwkzb9++JSQQoXn7
	 M9rxz9PfmWNPjAgx4YTOvg10blOhuq7p15daryHYxdAP29pVZ+RR6ZwdrAwcNEmUt8
	 8uVUeB9kxbEhQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3ZpB-00000000erQ-2hV3;
	Mon, 07 Sep 2026 15:55:53 +0200
Date: Mon, 7 Sep 2026 15:55:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jakov Novak <jakovnovak30@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	Ulf Hansson <ulfh@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Shuah Khan <skhan@linuxfoundation.org>,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
Message-ID: <ap7CaVj82BJZgjf6@hovoldconsulting.com>
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
 <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>

Hi Geert,

On Mon, Sep 07, 2026 at 02:17:45PM +0200, Geert Uytterhoeven wrote:
> Hi Johan,
> 
> On Mon, 17 Aug 2026 at 10:13, Johan Hovold <johan@kernel.org> wrote:
> > On Sun, Aug 16, 2026 at 05:38:09PM +0200, Jakov Novak wrote:
> > >  Currently, the function vub300_inactivity_timer_expired, which gets
> > >  called in a softirq context, calls a sleeping function in the following
> > >  call chain:
> > >
> > >  vub300_inactivity_timer_expired -> kref_put -> vub300_delete ->
> > >  mmc_free_host -> cancel_delayed_work_sync -> __cancel_work_sync ->
> > >  might_sleep -> BUG
> > >
> > >  Fix this by replacing kref_put(&vub300->kref, vub300_delete) with
> > >  vub300_queue_dead_work(vub300), which does the same thing, but in a
> > >  workqueue context.
> > >
> > > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> >
> > This isn't the commit that introduced the issue. The blocking call in
> > mmc_free_host() was added by commit 1036f69e2513 ("mmc: core: Cancel
> > delayed work before releasing host") in 2023.
> >
> > I didn't look at this in any detail, but having that call in
> > mmc_free_host() (e.g. rather than in mmc_remove_host()) looks wrong so
> > perhaps the fix really lies in MMC core.
> 
> mmc_remove_host() can only be called after a sucessful probe, while
> commit 1036f69e2513 fixed an issue where the last probe step failed
> with -EPROBE_DEFER.

Sure, but should you be scheduling rescan work before all resources have
been set up and the host has been registered?

Johan
