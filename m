Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CD1F91CD
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508240; cv=none; b=k9b8051x91UyzHwXN65fEgyiGqmDF3LnSyVg6/jH9qhc9eeN+YyAR6RrI4f/b13eqHQPf/zlTtsoMlxHC5pbsK7o+7FMk9vSF2SVsJvnm72vJMrgPdEbfzGpZ120ndmJAdvvXgngCAVV113harZt2e4ZuRwNjlb+0NjW3NuMhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508240; c=relaxed/simple;
	bh=Qxf7pul0wUbk0fSwy6plIWVWNrFDzhqa5xEHRCSsU98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rlSISAuo8K+OMfIyNubWIw6xSg/tGxewc64IZx/Ed14g3nxWIloTFWL8OcLN2CmdGW6hnadLR0hd6C2NZXQc/fKBr4kRWe/Cx4CzV/88XRA3vUtLWXBqRMU0hqaoFQZQ8Rm/dDWDJestyM8+SXDNbF6XKFHecWfs7OKZYHbLCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUDXbtE3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUDXbtE3"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff1e375a47so48882757b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Apr 2025 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743508237; x=1744113037; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOgeifCPueURI4iZ+PSvJq0F/yvoGRM/ptjc8joEL44=;
        b=fUDXbtE3ZewZhxxomie3dorFzWVM/B/P5sTzgNGamUmpEozl6KGQYVha1BEIBKTckI
         5b+FTTQUuBFgqbaNjLaeXRzkkSvSzK0j0aCzSR6nvrBtrt/YAAS+gXBon4CE4YLV8fA6
         k4QbaaxoIRyHaVmD+F2XXQnFAncH5vGao67t1Qy6vPJTZux8RiqnKPMNwwjXrn/aZmP+
         6mJetVf4ngHTQaCwOmsnbnMO+knQ3/N4SGvkzS1sIkIdjOlBeQPcUU8oBjZjrZuJMDv2
         BBBDsTyNflgudGgvjOgwneKMyxg1GyB1Di+v8AR5R79vVOLMbf62nbkrtQRPOgdV/Vd2
         BnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508237; x=1744113037;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOgeifCPueURI4iZ+PSvJq0F/yvoGRM/ptjc8joEL44=;
        b=CEVL3T6g3NGq3TSU7YYlVvJEFf9VcpvNKkax4W4rh9/LSrovw1vlk/Z1XyW/6Q5RGW
         gaHMj67VOmuiz2BJ5PC13hwDuz1x61DQPYQFME0ii7nMTKNSMBPKRLFomPhR39vzCULa
         GVa0ATEjvcreSZWgdOcBzzZnntYH2ijN6kiqNqsYMBNbMqnqu23RojLEubzJ34IYttHi
         eiYw1wt/l9E3ckKZ1D7a6cG4HrpWAo0rmciHnOd7DB2cqwNc8G0W7hO1tspvUQiX0yfj
         RHChi6xYy9unG4bS6BUxpqVcFZ09aeA0zOfuvF6dwoxqywsHUsjDTdggtbC0IsBkbdg5
         ecKg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Fw2jdyM8N1Y9Lj+VtrBMm/rrlAU1xIpwmK/B9FbDrbhJXkLGvbO37qFp1oiNQb7lqPts4Hj+1nY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7oGyEayspUemAuzfCHGLNq6msBMWo7ewi2HlgYfwiNnClDtIB
	Oe8vhDDs4Iq5Qr2zeQ3gTwzav55RuQ53kkZeZ6bXI9FGkGe+LBp0ZhS7W1QQK6QLKPCFv8yrNbB
	tW2lkrVMZKy8HMKdWI4hS9FxSX+WuwIgGIgUFM2kQaqYqIYSq
X-Gm-Gg: ASbGncu2a8t9DixsG8oiOpZcVpzDkm8hfLq2SQtZCRvthPYaQCirNJUcNrl0gDsWMoC
	aEFL/qUoatYu2NK9ASk2MZqBswl2lOqCCUTyFM2u/+UJpIW0gVPuRToBzc/fcDdfNNX2sZYFDQP
	GVC4WJIxoJw1DmBIi6W8vT9pYrvt/X9PE2lGLKew==
X-Google-Smtp-Source: AGHT+IEccr3CCj7xmEQlHsDfauhpuJ3bZ5uaub8hZq7c6Tbl/9LjElpjGlbWImSrgrcDwT40VZjgNc2LpyX75ImC3eM=
X-Received: by 2002:a05:690c:6f85:b0:702:4eb0:6af with SMTP id
 00721157ae682-7025734bd0emr179109817b3.31.1743508237063; Tue, 01 Apr 2025
 04:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
 <20250320140040.162416-3-ulf.hansson@linaro.org> <PH7PR16MB6196C3AC7A7B7CA99A70E7DDE5A02@PH7PR16MB6196.namprd16.prod.outlook.com>
 <Z-pQj6ynnfMa77fM@shikoro> <CAPDyKFr0MvQDxsi-Qd0F=1KuR4Gy6s5bhVdOXRt9K14Z9sO2Kw@mail.gmail.com>
 <Z-pyfv_7gJ72YWhz@shikoro> <CAPDyKFqW92wJ9P5cyO0vcV14dU5Q-JRGR=oKOS362crFy6y2Pw@mail.gmail.com>
 <Z-uM3aRHJ_8bwu0W@shikoro>
In-Reply-To: <Z-uM3aRHJ_8bwu0W@shikoro>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 1 Apr 2025 13:50:01 +0200
X-Gm-Features: AQ5f1Jo07Glme3B0Z5ezvlFDATG1bBux2mgX6GZTlztytvrlGC2oFJ5S_fWro3Q
Message-ID: <CAPDyKFqf3K3-gv2+7yORw3nqxJ5bnFbCH2yB+E8=XOGuYuVsyA@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: core: Further avoid re-storing power to the eMMC
 before a shutdown
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Avri Altman <Avri.Altman@sandisk.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 08:51, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Ulf,
>
> > mmc_card_can_poweroff_notify() would not be consistent with all the
> > other mmc_can_* helpers, so I rather stay with
> > mmc_can_poweroff_notify(), for now. If you think a rename makes sense,
> > I suggest we do that as a follow up and rename all the helpers.
>
> I vageuly recall that the commit I mentioned below (renaming hw_reset to
> card_hw_reset) should have been a start to do exactly this, renaming
> more of the helpers. I drifted away. Yet, I still think this would make
> MMC core code a lot easier to understand. I'll work on it today, timing
> seems good with rc1 on the horizon...

Alright!

>
> > mmc_host_can_poweroff_notify() seems fine to me!
>
> Great!
>
> > > I do understand that. I don't see why this needs a change in the
> > > existing logic as Alan pointed out above.
> >
> > Aha. I get your point now. As stated in the commit message:
> >
> > Due to an earlier suspend request the eMMC may already have been properly
> > powered-off, hence we are sometimes leaving the eMMC in its current state.
> > However, in one case when the host has MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND
> > set we may unnecessarily restore the power to the eMMC, let's avoid this.
>
> Oookay, now I see what you are aiming at. It seems I got the PWR_CYCLE
> flags wrong? I thought MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND is only a
> subset of MMC_CAP2_FULL_PWR_CYCLE. The former can do the power cycles
> only in suspend, while the latter can do them in suspend and shutdown.

Not exactly. In shutdown we don't need specific caps. The card will be
fully powered off no matter what. In other words, it's always better
to do poweroff-notification if the card supports it.

> So, in my thinking, full power cycle might also have the eMMC
> powered-off during shutdown. This is wrong?

See above.

>
> > Let me try to clarify the commit message a bit with this information.
>
> Whatever is the final outcome, it needs a comment in the code, I am
> quite sure.

I will add it!

>
> Happy hacking,
>
>    Wolfram
>

Kind regards
Uffe
