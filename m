Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383C4F6474
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792498; cv=none; b=PGGvhfveJOcu4n8pG3b9EE6vOBhCEgo+PxMukI02MslkWg1af0SN3vISYCNpwjGBfJhTsp1vr+Fdr1lrzrVady9HXImqMJbt8He4Ic5y1LDwf9ngkCHoM8WfruhfXbVmSzjArBwNn8kSW/kFYpX54lH9wZMkPNqSwacvJu0pLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792498; c=relaxed/simple;
	bh=E0L90Z8k7uiNby0Rmgil4xEwTSX+gJc1C3iKm4pcpes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCVqqI3ksMlkQm2WvIi6QKbKO+Etyvob4T012uK6EE0noFG8A+5c/B0S9YurjsdZvKXcxSHKGaWtudpo2XaFkj0mmwnma8Vy5UFzIwzD0zs0Pl1gOOIDuYC8uMHA9m4YWpp7DOsmUFIJgURcSeo5Hd4plaVB6q+cCNMVmglaDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-779d18ef706so2612652137.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 07:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792496; x=1789397296;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=417Vq4voeTSrz4Uh3qUJbU6StigGvlQmE4Y64hf9ijE=;
        b=ladr5+ZzYInYCh2HG6vwV88QueZpem54BBcH7XMDu0AK7Yj7RHGzR8NqhxdkSWZlQS
         xU+qk2O+2puSz41I88TMMsCeokJG6w7v9MXnxpik4qFicVDfG8hsN4PyhtVhR1/7e2Ly
         1YeC5pauUpMhCzka+3zvgxtqwei89rtjQL6o9MrJIr/qiubQ3Gl35y0QqrjzOdzefkEy
         q2q0LMEdYxF1bw46FP2QmUl2LVPEXCj968Jc8hahnLrPL6njuCjdJnWrRUe643RgvvuB
         C7k61qE16JbeIc9tEtJO6CDF57fWNxAGynFyWlDDnIruvOfUcfVVHPm4uzTLAIcxUrUu
         PBcA==
X-Forwarded-Encrypted: i=1; AKwUvBykwwDUZNfwihMuOFe9LjeeWKy7MGBQqcc5GFYnH8bLhCxlTEgQM1YQ0X+TvlUoH8edSCIqiYDq0vQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m5Ab8085nTfmU+5j5Fc5LPPhKPbM9ZfN/l7QHlCGvI0TIFuL04
	RUUuvh7bj+oGUwNEcm0Q5OT8pbEIZjEB6kmw03DVVh1KSOKsv3SrIaC7hzH4xG+2
X-Gm-Gg: AYBFou24psf7f0ErKCnYWHnJ6eiAYBP9jxVc/tkNuSzkEOtlbFFWkDrJ52Fj97yws9v
	oupiuNE7bCmoc3yrgAeKqCuG+XuW4dMX4eVGrSPBO1WJbR5RF9/TWiOHZanQ2gBePz42R6xgxty
	E0aEbfNAic1RFcxSSJQCaZ/5drNWkzm5PYpc8gwZsFC/mvv107oS5Npo/Vf29XiEHqelTLqyZTg
	YByUTplIfZyHASOEEYpDkY9Wgecop9R5wX8+CdLqzogOMICIM0/P7L3QAWaUTWeJ33W5i6mIoCb
	6T3oKQoHqoK4phnp3DBdfJ21STYqDdgMmUr1KGsvpuJjIMQhIZMoBUwUGYDFQk7Kab6p1JNenzG
	04SXQYnJT74JPLFHygfI4F3OayXuWl5dg4qrTldXQXEzXVCkSuAcQJtMpC1veqqWFaH1JrxwhNB
	tILUa0vzNyFJ6T+lVuGFg+gRuU5IqkqR1qJ9cBdE8QRM5n2RMtK/1UjAbAE30ayfjhvZjGE4oGE
	oSBmssOKHxxOAN4oSE8Yp9i7g==
X-Received: by 2002:a05:6102:291e:b0:77a:7620:81b4 with SMTP id ada2fe7eead31-78a4a839bd7mr9224344137.4.1788792495587;
        Mon, 07 Sep 2026 07:48:15 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee1c0cdsm7457095241.8.2026.09.07.07.48.11
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 07:48:13 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-782af6c753cso3354055137.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 07:48:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxDcpnXKCtifqNdc7x3Ufo5CMl1NSt5IugE9A86L6a5ptWwmNRuTTNv9/TB+vsGJfs+DNGOd1IeVJo=@vger.kernel.org
X-Received: by 2002:a05:6102:b02:b0:786:c86c:4f5e with SMTP id
 ada2fe7eead31-78a4a6e7023mr10514501137.3.1788792491716; Mon, 07 Sep 2026
 07:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816153809.7067-1-jakovnovak30@gmail.com> <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com> <ap7CaVj82BJZgjf6@hovoldconsulting.com>
In-Reply-To: <ap7CaVj82BJZgjf6@hovoldconsulting.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 16:48:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
X-Gm-Features: AcwNN1XKT5JMOm2wspHuB0_T9Xeh0iYlXl0ZBuZdAHt4KZH-NPNXF5M72vmaKSg
Message-ID: <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
To: Johan Hovold <johan@kernel.org>
Cc: Jakov Novak <jakovnovak30@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	Ulf Hansson <ulfh@kernel.org>, Guangshuo Li <lgs201920130244@gmail.com>, 
	Runyu Xiao <runyu.xiao@seu.edu.cn>, Shuah Khan <skhan@linuxfoundation.org>, 
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Mon, 7 Sept 2026 at 15:55, Johan Hovold <johan@kernel.org> wrote:
> On Mon, Sep 07, 2026 at 02:17:45PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 17 Aug 2026 at 10:13, Johan Hovold <johan@kernel.org> wrote:
> > > On Sun, Aug 16, 2026 at 05:38:09PM +0200, Jakov Novak wrote:
> > > >  Currently, the function vub300_inactivity_timer_expired, which gets
> > > >  called in a softirq context, calls a sleeping function in the following
> > > >  call chain:
> > > >
> > > >  vub300_inactivity_timer_expired -> kref_put -> vub300_delete ->
> > > >  mmc_free_host -> cancel_delayed_work_sync -> __cancel_work_sync ->
> > > >  might_sleep -> BUG
> > > >
> > > >  Fix this by replacing kref_put(&vub300->kref, vub300_delete) with
> > > >  vub300_queue_dead_work(vub300), which does the same thing, but in a
> > > >  workqueue context.
> > > >
> > > > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> > >
> > > This isn't the commit that introduced the issue. The blocking call in
> > > mmc_free_host() was added by commit 1036f69e2513 ("mmc: core: Cancel
> > > delayed work before releasing host") in 2023.
> > >
> > > I didn't look at this in any detail, but having that call in
> > > mmc_free_host() (e.g. rather than in mmc_remove_host()) looks wrong so
> > > perhaps the fix really lies in MMC core.
> >
> > mmc_remove_host() can only be called after a sucessful probe, while
> > commit 1036f69e2513 fixed an issue where the last probe step failed
> > with -EPROBE_DEFER.
>
> Sure, but should you be scheduling rescan work before all resources have
> been set up and the host has been registered?

I would like to defer that question to the TMIO experts.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
