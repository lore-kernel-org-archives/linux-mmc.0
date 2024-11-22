Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6313AA4E
	for <linux-mmc@vger.kernel.org>; Fri, 22 Nov 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291134; cv=none; b=LwZ+y6zLK29eoGrmL8lf4NgSQhMBduvy4/LAPDpcpXRzr7757But+ZTEzLSGFXYmwoOxIrYhfCLy56/M2YEqToIn6YLVFm5uPk4bJP6gjoFW5eOe2JQv6tQREdj5I4RhvdA093N7JWD6plw0fOp3XdK3vKWmZYRTYgagJPofr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291134; c=relaxed/simple;
	bh=iGGAHueaU7gHOOc094ZgRe6jaE4hvaTK9x6PNgkZBu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oonJgxE4rcu6XwrUgBAHDvJmu4UFRXGpRvXDD+Wo27AKRLiCd3uPIkhDTE7qukvkJzPvUJ2xZG4t+vsNTSyS3PsqywEivZhhgXavs+fAsbK0kv5PlX2S1ENSKy9rmEA9n4v5oAZqIgCUUZbOoq84rYhw8VJkpwVEVWl+M4bI0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=giw0aLoc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giw0aLoc"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so6454373a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Nov 2024 07:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732291130; x=1732895930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=87gqIQer6cH6xwrwYxg5RmnkRz2vDc/aiVC6VYzA348=;
        b=giw0aLocqPjgT6WXO2tQQYG/tAHg+Fe7IukJOcMQkep/4zI1k8RVjxgwLPLeMWdC7Q
         P0u8rrBlGYD+wkx4OjA11N6GwKzLq/znKM3xb+TAQTE3UG8AN6OeikYs8J3nQyMvfmbD
         y1hHTSO5mm7X/amUs9KhvH+aqzPQa/4sbjlkB5OvepzMBb3drCsVANNE7Ghr/UW5UJox
         J618GT7hEQf8fNLc7cB34YToxeV+d7mbZ+Jr02kxob/W4GpcxGgt6GStda2Koo9pqC2N
         EOFBh6ebiyLm18dfCBP5HlTqhmpqZjPH80PW71230gDx0vNm/fF139+5G4Dz0dcURcrt
         mIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732291130; x=1732895930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87gqIQer6cH6xwrwYxg5RmnkRz2vDc/aiVC6VYzA348=;
        b=sXPvS5AA8QfKsv/uIXt02OWu/ClQ2fD+fL4uosQYhYzQLGMz4HaQv7ttcs9lGrIq+R
         Ab67Vc+sL7X3gK9LN81EwW9Vxi9/+pgcjowYbQdnUf43mw4VaYwVbqjOQvhxtxwSN6Qk
         JoYH8Q4zSMoRP3f5Rcm4bJ2iX8tXTe/hOcadhT8fFw+7hBuRmOpItLLCGtRngA6BedEA
         8DvVBOGRpym6I+FywXXXkb5297hlw+HmyT+gP30KXbBJiFItAaBvqndVvXi1/A1Vb1ln
         J/YA4XuQTOMBxRnKpjZamMg/qC6zSEWXwBZSGS22AbR2oT3ntz0mHpAVlzu5jCaTYjbx
         fYag==
X-Gm-Message-State: AOJu0YxggMwwrJ4cGa0/YzLLl4ZzUdGjUqV+HVWQ9TCmepl3OeC/r+6l
	kvFHpiCQ/P1x5t4BSWgjOSSA/Lx9FRfuLkeD3OiU1V4SZqHcDsoKt5vaohFhIy3Ofpb4lc8PpzP
	krVbuOLPhx/Vaqao3ZRVftTj1TEQcC7uIVFsOJg==
X-Gm-Gg: ASbGncsr4/BZUbb3blTUJkuGDlmyOgRMiARvtkpVVe+W4OIeCIlfDpy4nauwLF52VDi
	ASl7aHM7lNyMqNaU46eX/k73gWzHkATdk
X-Google-Smtp-Source: AGHT+IEjm2UdM3yY92ooZDkWJSsW/ZTWYRr5dWP5Jn03lXQEtE2pedZruPqMaNfr01BeL4CqDZnxREexBJ42PkoEVqo=
X-Received: by 2002:a17:907:3fa7:b0:a9a:cea7:1294 with SMTP id
 a640c23a62f3a-aa4efe2a359mr773250166b.21.1732291130619; Fri, 22 Nov 2024
 07:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN0PR08MB695133000AF116F04C3A9FFE83212@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFrmMog-jemQb2-FGogq93+RACkoBXxOFRHUfYSkEsg4cw@mail.gmail.com> <BN0PR08MB695151B49A2CBFF1D293775883222@BN0PR08MB6951.namprd08.prod.outlook.com>
In-Reply-To: <BN0PR08MB695151B49A2CBFF1D293775883222@BN0PR08MB6951.namprd08.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Nov 2024 16:58:13 +0100
Message-ID: <CAPDyKFo6BnHRg6G9vj6xiUncowUi59ExE3sCVLk8K+=6wqd1xQ@mail.gmail.com>
Subject: Re: MMC card detection may trip watchdog if card powered off
To: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 14:23, Anthony Pighin (Nokia)
<anthony.pighin@nokia.com> wrote:
>
> > >
> > > If card detection is done via polling, due to broken-cd (Freescale LX2160,
> > etc.), or for other reasons, then the card will be polled asynchronously and
> > periodically.
> > >
> > > If that polling happens after the card has been put in powered off state (i.e.
> > during system shutdown/reboot), then the polling times out. That timeout is
> > of a long duration (10s). And it is repeated multiple times (x3). And that is all
> > done after the watchdogd has been disabled, meaning that system watchdogs
> > are not being kicked.
> > >
> > > If the MMC polling exceeds the watchdog trip time, then the system will be
> > ungraciously reset. Or in the case of a pretimeout capable watchdog, the
> > pretimeout will trip unnecessarily.
> > >
> > >     [   46.872767] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> > 03220301 flags 0000049d
> > >     [   46.880258] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000001
> > >     [   46.886082] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000002
> > >     [   46.891906] mmc_request_done:187: mmc1: req done (CMD6): 0:
> > 00000800 00000000 00000000 00000000
> > >     [   46.900606] mmc_set_ios:892: mmc1: clock 0Hz busmode 2
> > powermode 0 cs 0 Vdd 0 width 1 timing 0
> > >     [   46.914934] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> > 00010000 flags 00000195
> > >     [   57.433351] mmc1: Timeout waiting for hardware cmd interrupt.
> >
> > Hmm. How is the polling being done? By using MMC_CAP_NEEDS_POLL?
> >
>
> Correct. (At least in my understanding.) 'broken-cd' in the device tree will trigger
> MMC_CAP_NEEDS_POLL to be set.
>
> > The above certainly looks weird. The mmc_rescan work should not be
> > allowed to run at this point, as the work is getting punted to the
> > system_freezable_wq via mmc_schedule_delayed_work().
> >
>
> This is the backtrace I get when the timeout occurs:
>
> [   46.154348] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 flags 00000195
> [   46.161917] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> [   46.167743] mmc_request_done:187: mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [   46.176526] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg 03220301 flags 0000049d
> [   46.184016] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> [   46.189840] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000002
> [   46.195665] mmc_request_done:187: mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> [   46.204362] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
> [   46.219307] CPU: 6 PID: 153 Comm: kworker/6:1 Tainted: G           O       6.6.59 #1
> [   46.231988] Hardware name: [Redacted]
> [   46.238678] Workqueue: events_freezable mmc_rescan
> [   46.243466] Call trace:
> [   46.245901]  dump_backtrace+0x9c/0x128
> [   46.249643]  show_stack+0x20/0x38
> [   46.252948]  dump_stack_lvl+0x48/0x60
> [   46.256603]  dump_stack+0x18/0x28
> [   46.259909]  mmc_alive+0x74/0x88
> [   46.263128]  _mmc_detect_card_removed+0x3c/0x158
> [   46.267735]  mmc_detect+0x30/0x98
> [   46.271040]  mmc_rescan+0x94/0x238
> [   46.274432]  process_one_work+0x178/0x3d8
> [   46.278432]  worker_thread+0x2bc/0x3e0
> [   46.282171]  kthread+0xf8/0x110
> [   46.285303]  ret_from_fork+0x10/0x20
> [   46.288878] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 flags 00000195
> [   56.793379] mmc1: Timeout waiting for hardware cmd interrupt.
> [   56.799116] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   56.805545] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
> ...
>

Okay. If this is system suspend, it looks like the workqueue didn't
become frozen as exepcted. I don't know why, but this needs to be
investigated.

If this is a shutdown, mmc_host_classdev_shutdown() should be called
to "disable" the mmc_rescan work from running the code causing the
above.

What am I missing?

Kind regards
Uffe

> > >     ...
> > >     [   71.031911] [Redacted] 2030000.i2c:[Redacted]@41:watchdog:
> > Watchdog interrupt received!
> > >     [   71.039737] Kernel panic - not syncing: watchdog pretimeout event
> > >     [   71.045820] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O
> > 6.6.59 #1
> > >     [   71.053207] Hardware name: [Redacted]
> > >     [   71.059897] Call trace:
> > >     [   71.062332]  dump_backtrace+0x9c/0x128
> > >     ...
> > >
> > > CMD6 is SWITCH_FUNC and arg 03220301 is POWER_OFF_NOTIFICATION
> > (bits 16:23 = 0x22 = 34).
> > > CMD13 is SEND_STATUS, and when it occurs after the
> > POWER_OFF_NOTIFICATION (as above) bad things happen.
> > >
> > > I have made the following change to attempt to work around the issue, and
> > it seems to hold up, but is also quite brute force:
> > >
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -2046,6 +2046,11 @@ static void mmc_remove(struct mmc_host *host)
> > >   */
> > >  static int mmc_alive(struct mmc_host *host)  {
> > > +       if (host->card && mmc_card_suspended(host->card)) {
> > > +               pr_err("%s: Skip card detection: Card suspended\n",
> > > +                      mmc_hostname(host));
> > > +               return -ENOMEDIUM;
> > > +       }
> > >         return mmc_send_status(host->card, NULL);  }
> >
> > Yeah, the above isn't really the correct solution in my opinion.
> >
> > We need to prevent the mmc_rescan work from running, which I thought we
> > already did...
> >
> > >
> > > Anthony
> > >
> > >
> >
> > Kind regards
> > Uffe
