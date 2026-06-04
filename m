Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEDA360751
	for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566176; cv=pass; b=lhAtQlOvFsnJR8FSnkp9GEJb1h264/7njQ1dc7Bh/TUJEnkmzV0jycV3+D1MG16MAfPwuuf7+X52CMXKbakJxeK3gs8qL6CwuTaKO2VHTBG7stOHA1ZlsTx6o04fLlYcBCDwHbgtM7+ybRZyvJrUY9WXfeoK2A/bsbYy9HfbmXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566176; c=relaxed/simple;
	bh=6BE5bmVZydE7/skGa7dtArX03R3ef655ddaEGMb7CSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv36gcAezNiiBsnZsr6fv70uEo8qHNObhPTSjz6nBUopfwPC+9tdEvFVYUcUfj0U2yPuYbgPTvU8RgpKraSPhTdX/KxD8ak9XZeWCSHgxbxdgwfYYeszPi77GrivXTROxJZaICIYrys9WVEc/tY/9zOYvP6VmQ3/CT/XVqa4ZR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRgfDxSd; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRgfDxSd"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66067da0638so282335d50.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 02:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780566174; cv=none;
        d=google.com; s=arc-20240605;
        b=R/VIkLXxBJqp9820H3ZwiQKDDyK8ng2+sgyjqGjaptlpmScKwefUdzKMbiZpm5Dn9i
         jU57QnhOfK0WbPRxyemUdoK363vrdV814UKLU25a4RNv0xcN4FqiU514jG3tsdn1RDli
         7aiGXjhUCqv/MkGif56gDkrOHD2j9iQV6vLkjlhA4q2owUpEYqOez/cdJ5k95Bwq3K+/
         jMnL9xSnmJFxdZU1Zpz7uwXsyEdX1cps5kPcXoXveZ8IuWDB9tjKWZGL9aQOajl+ykaL
         74Cd9AMnp02M1ieB0K1KwnFEmdK4MGFvbtclLqzM7IBpWLdKAyHmM/tc9X0PtFDI6IH5
         lF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=towcvvxR/3+tEcOs+CVcldscZxHGHXuL2B5M5HUIX9w=;
        fh=iZbU6IsKh3TyHNPuSgI8BAsnzRYAeDfMQ/0KjQQLrpc=;
        b=DhhEPhCaXTEkznanoLrFEklk0I5J+OUPewnEV2nBMVQcSFHBl50oA6VqucZTEkrdQS
         dO1vMYal/vmswCwUKnDd9WX5l02/2P39IYi3TDXIXKi5P6rC+uLqc0m3XtdRd4b/gtmt
         bOLOKTmQbB9EZPFXuq76a3iLhxk0eEE7TeUGKgnA3kzNwf+m17sVsZphirUZ7+qv3xva
         1BOrGgX4cUukKuX2q9n6agi3LN3KcVoR4Gv8rGkL9+QFrs1FpcQo6fGCdxbsoWH9xZ5t
         bhrVEy/P2CgQoPW4efFpDblXAXyw7ltRq/U0+ABOBKA1IYQLbsZWeEA0byX7c7Udl4yw
         x7+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780566174; x=1781170974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=towcvvxR/3+tEcOs+CVcldscZxHGHXuL2B5M5HUIX9w=;
        b=pRgfDxSd46LwJtOmks9aNWMMRTk6PmSIG5hBGtjoLcqExlVUr2z5ihGrP1V14ni+G0
         bxNc9bJPTYHkCYmuZAPNp6pHke6Kb3NrMeHXHJ9VDP2xfUr8hMwdHOwy5CIFW4T+9SfN
         5/vUyWJ+mG3o+58Ngle+hvVVn3icDVidcsiHMNpcUtWj08BT+2XmW3Z9bcskzyMeHv5p
         Gt8VlPI0cyxj2fxR9GtS+gxZfkzUfHhoTBMtYA9dPldJDgGY3XdtNMBneQV2SpwnRgog
         aAKpG4nPutjx4UEKO1RgsVMFCjqdCuhb39uuiR4zeE3UhJRtl8MuWFC0She1HmZoWxN1
         gD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780566174; x=1781170974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=towcvvxR/3+tEcOs+CVcldscZxHGHXuL2B5M5HUIX9w=;
        b=pi5Ni9Rl9su7//utCvJNbElO4BTcKN9KhF0q1qZCLLj9dT8SQeGC9fP0c5UVS1V88r
         wkCJa+OwSv28yYskU69Yplv+1p40ZMPxB0Wkr+OjHSXacxEG+MrOH4sTaFWf37DrcDO8
         aU907rHgig+Z+cG3LaDwLZu0BoyozRWoEo/5umV+r76zhbqkBxk0K8w+KLmvyolL70kN
         C2wI9+IS+eW8sM9yQmG1nPJawCwjQddxlB5P5XwopGQKzIhi6jGGaGPs93QrMeXt/bfp
         eFd2NPtfm5K0vs6Wzx7LhNxJ51GQojKcnY14ezx0eR7ZY89Yj7lizMVJMu21JCKYUFgx
         Y8lw==
X-Forwarded-Encrypted: i=1; AFNElJ9nkte7RK5Y9neyJ8nGG+PtWliPfWWAQ3xLxmHVpxY3W4vxyL0xtHzrFI51/Ae2aBcIjBtetUfoSbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqIjMeg7s5LyF8/RhSo4zGQpQBVS3Yu6VsyjPUZP9nSQe7Aju
	ZrvQxvLlD0B24x2BCrRrKZnBAZ8/F/t6Zx41TnDYB1w7C+pOyjmO6/AHHEbai7OF9kKisf+1kkV
	uIZZuePnqICCHv5r9cl7nZVAVmj4wb5Q=
X-Gm-Gg: Acq92OFNkOsDJbp77uvvazNt+5mDHdHI2JBIxDzSwi98SJ/PlA9Vlh2UR9Z2YT8Y0uA
	E24iNmZHdt/uleGGI78shbEYP2LR9uxKXaOH0VWpYDF5AN/ZXEUxVklewBXepe/Zo8B0FqCxFSf
	t/nWNyhChCN7r9U2yLfIozHJKnGTryYDUk3atsqAXZFoa+W78m6EjQrsom1R8ib/9LEv4sQl0iI
	OAz7PvOr0wr4ah+h+qdboNzxvFAIiW5R0mrlDsCKb7h+GrdsQ1f6kEI5xdUBqFA04fyfO2aVlWx
	v+b6A9n0zZCfRIgU2ueT
X-Received: by 2002:a05:690e:1c0e:b0:660:877f:a5bb with SMTP id
 956f58d0204a3-660dc4ce5e5mr5974220d50.51.1780566174393; Thu, 04 Jun 2026
 02:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604054628.1411107-1-lgs201920130244@gmail.com> <aiE2ZKQ1z1s0XVo4@hovoldconsulting.com>
In-Reply-To: <aiE2ZKQ1z1s0XVo4@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 4 Jun 2026 17:42:42 +0800
X-Gm-Features: AVHnY4LayZp1lHfcj8sEI-iu8kS65t0-0T2KUbfNM5Dcrtl-Q-QEB0xa0KMafAY
Message-ID: <CANUHTR9Fqu59yESZFw1SWfg5MpbCVwJ6w79yvpxA0muSaxP9qw@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix use-after-free on probe failure
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

Thanks a lot for reviewing the patch.

On Thu, 4 Jun 2026 at 16:25, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jun 04, 2026 at 01:46:28PM +0800, Guangshuo Li wrote:
> > The vub300 driver lifetime-manages its controller state using
> > vub300->kref, with vub300_delete() freeing the mmc host when the last
> > reference is dropped. The probe error path after the inactivity timer has
> > been armed still bypasses that lifetime rule, however, and falls through
> > to mmc_free_host() directly if mmc_add_host() fails.
> >
> > The race window is between arming the inactivity timer and reaching the
> > probe error unwind after mmc_add_host() fails:
> >
> >         probe thread                     timer/workqueue
> >         ------------                     ---------------
> >         kref_init(&vub300->kref)         ref = 1
> >         kref_get(&vub300->kref)          ref = 2, timer ref
> >         add_timer(inactivity_timer)
> >         |
> >         |   race window
> >         |<---------------------------------------------------->
> >         |
> >         mmc_add_host(mmc)
> >                                          inactivity timer fires
> >                                          vub300_queue_dead_work()
> >                                            kref_get()          ref = 3
> >                                            queue_work(deadwork)
> >         mmc_add_host() fails
> >         timer_delete_sync()
> >         mmc_free_host(mmc)
> >           frees vub300
> >                                          deadwork runs
> >                                            use-after-free
> >
> > timer_delete_sync() only waits for the timer callback itself. It does
> > not flush deadwork that the callback may already have queued. As a
> > result, queued deadwork can still hold a kref while the probe error path
> > directly frees the backing mmc host and the vub300 storage.
>
> How was this issue found? Are you using some kind of static checker or
> LLM?
>
> > Fix this by making the post-timer probe error path obey the kref lifetime
> > rules. After deleting the inactivity timer, drop both the timer reference
> > and the initial probe reference, and return without falling through to
> > err_free_host. If deadwork was queued, its reference keeps the object
> > alive until the work item drops it; otherwise the final kref_put() runs
> > vub300_delete() and releases the mmc host and USB resources.
> >
> > Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
>
> This is not the commit that introduced this issue.
>
> The incomplete error handling for mmc_add_host() was added by commit
> 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()"),
> and before that you'd probably get a crash on disconnect instead.
>
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/mmc/host/vub300.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > index 3c9df27f9fa7..3546473d3486 100644
> > --- a/drivers/mmc/host/vub300.c
> > +++ b/drivers/mmc/host/vub300.c
> > @@ -2341,6 +2341,14 @@ static int vub300_probe(struct usb_interface *interface,
> >       return 0;
> >  error6:
>
> Which tree did you create the patch against? These error labels have
> been renamed in mainline.
>
> >       timer_delete_sync(&vub300->inactivity_timer);
> > +     /*
> > +      * vub300 may have async references via queued deadwork. Drop the
> > +      * timer's kref and let the last kref release free vub300 via the
> > +      * proper destructor.
> > +      */
> > +     kref_put(&vub300->kref, vub300_delete);  /* timer's kref */
> > +     kref_put(&vub300->kref, vub300_delete);  /* init's kref */
> > +     return retval;
>
> Add a newline before and after the return statement to make it more
> clear that you have an early return here.
>
> >  err_free_host:
> >       mmc_free_host(mmc);
> >       /*
>
> Johan

This issue was found through manual audit of the vub300 kref, timer and
workqueue lifetime rules.

You are right, I was working on a local tree that had diverged from
current mainline. I will rebase the patch onto the latest tree and send a
v2 using the renamed error labels.

I will also update the Fixes tag to:

Fixes: 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()")

and add the blank lines around the early return as suggested.

Thanks,
Guangshuo
