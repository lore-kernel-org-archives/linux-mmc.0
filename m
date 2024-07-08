Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF7139CE9
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jul 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445593; cv=none; b=Y7MGRYTYLosZbmAT3zVxz8nGeDH5amkQryMcTocFrdvg421k4z03LAWrESmWYPa0NZDqIiMyHLNrzNTeXBD/NPj+cuIjMAL0OmU3cTxaYPp/gt1ETfeSYiwty5OptumsjKR6Rc45KPGEpLESckFd6hd0HcGLmtHPtic9RMJTEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445593; c=relaxed/simple;
	bh=Cd24Jdc2pRItx5BleblDmwmq810RBw3sqfwuXtOiB9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLkAYF820aHNNwuSKJxfUW8fM/cEzZ8m8yTVgCZRXo9LEdw2uqsP4zDZmncVUCWst+wOMXzXtcJR8C3sy6tgI15ufCa3QhntLfHT8rd3aUgAovKRv66xw+v/1m0zVQ0F3iDIqsIL7RgBbUtz04QzLxrfW+TPl77oWTirD5znPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OkX73O7j; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkX73O7j"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e036eabc97dso3843696276.3
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2024 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720445591; x=1721050391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd24Jdc2pRItx5BleblDmwmq810RBw3sqfwuXtOiB9Y=;
        b=OkX73O7jZuxgPedP4M4r6ef1nM6ZtJychhcgZvQde8dsivXOc2W/dJEVfcWM5AAHHz
         9f9znU+HUDw5C8Is+NHb2Us0G6RdHfkLdx0VOmX6ldmrCnWqY2CxncDEITWFFsRdVcdh
         Ul18hBC5mp7UDueRVAv0IJe8wY4jUcWXh1tSIApdzImYrsQ8wYdhHphDWs1wXkqz7F1i
         6cMXsjYYz8ab8Morp/yKCjxzvajZg/0BB7I1t0Pd/z35aha8014Dtcf1fB+ImPrmQN7u
         as7agRUGHXAlkmXid4EDO8xTNNCcOquQ9flNUunXU9/r3RX+PnomB7+VVxAfmZ6fQxbf
         yHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445591; x=1721050391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cd24Jdc2pRItx5BleblDmwmq810RBw3sqfwuXtOiB9Y=;
        b=bBD3PDUPrvzOR0wRK7fKHB5lypKSNtHVx/8evnDori8ndsKepw8vpVuvHlsknuiEH2
         JaSp4bs2gBwR4JvGBeTafQgGaR1ed83Pphe/MtrlQ4qug/GDbbWs+T2mCptJBavrYgxj
         qFXjhjvSrfeaFg3h95s+IRqOC/2A8YLFTHf+kLwumakEDJz1SOeWGI/Yk/baHQaiG23i
         XP4LRIchSe7e0i5m2vcFtTOMsjXrfeBEpF5a3zLx1ONpSBlw168w7xbX6VJh9t+WgXED
         +JHDesG0WBhRQQSbm+lF5Z6ydLehKZIqlHkmcUZ/0ymRUGW43Wxuz0HXEIKRwKGAF+jW
         U78Q==
X-Gm-Message-State: AOJu0YzvGngYUre7obfFBT0IYeXsvLXcLzFgepS/0Kmrd2eqIRgAwVCT
	37CTwwxZOezWV8W4SqBtQ/PIWlNhO25MRzmSztdv39I2eJi+KAeSnIb/g/1yOui0MAXQ6XwJgit
	6brpYr0VXCN2aCgFVHxjYPes6tDxVc0S//LDtZOup+w+sHPmN
X-Google-Smtp-Source: AGHT+IHgoluybVQWGajlSIZ0ftF1N94XD39FHLN8/yJP11UL44AS/gFnPC0yPfzRMkoyQvX+fdd2lxwwzjXuz8Ev7Yg=
X-Received: by 2002:a25:8610:0:b0:e03:9a95:bc78 with SMTP id
 3f1490d57ef6-e03c1959e4cmr12944687276.36.1720445590973; Mon, 08 Jul 2024
 06:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131222.1131880-1-linux-mmc@danman.eu> <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
 <c89d8a0c170fa3bc8593bfde25b07e4d@danman.eu> <CAPDyKFpLkmU-vjAaM=QDkc+3F3tMNjViOdnYSFNqyDduyfBm1g@mail.gmail.com>
 <6845f5386ccb71908eedba833e8ace29@danman.eu>
In-Reply-To: <6845f5386ccb71908eedba833e8ace29@danman.eu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 15:32:34 +0200
Message-ID: <CAPDyKFqP4R2nPq1y9zdZWEcGp4_x_JjRbO6XM+770w0fRK5YbA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
To: Daniel Kucera <linux-mmc@danman.eu>
Cc: linux-mmc@vger.kernel.org, alcooperx@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 20:15, Daniel Kucera <linux-mmc@danman.eu> wrote:
>
> On 2024-06-20 16:32, Ulf Hansson wrote:
> > On Thu, 20 Jun 2024 at 14:59, Daniel Kucera <linux-mmc@danman.eu>
> > wrote:
> >>
> >> On 2024-06-20 14:38, Ulf Hansson wrote:
> >> > On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
> >> >>
> >> >> From: Daniel Kucera <linux-mmc@danman.eu>
> >> >>
> >> >> Locked SD card will not reply to SEND_SCR or SD_STATUS commands
> >> >> so it was failing to initialize previously. When skipped,
> >> >> the card will get initialized and CMD42 can be sent using
> >> >> ioctl to unlock the card or remove password protection.
> >> >> For eMMC, this is not necessary because all initialization
> >> >> commands are allowed in locked state.
> >> >> Until unlocked, all read/write calls will timeout.
> >> >
> >> > Skipping the commands above, only means the card gets partially
> >> > initialized.
> >>
> >> Correct, but it's an improvement in comparison to current state.
> >
> > Not sure I agree with that, sorry.
>
> Are you saying that that being able to work with locked card is not an
> improvement in comparison to not being able to? Or did I misunderstand
> that?
>
> >
> >>
> >> > Leaving a card in that state seems fragile.
> >>
> >> Fragile in what sense? Nothing can happen to the card as it is locked.
> >
> > We may end up having a card half-way initialized that we can't really
> > communicate with in a stable manner. From a system point of view, I
> > would be worried.
>
> It's not half-way initialized, it's initialized correctly, it's just not
> using the full potential of the card (higher speeds, etc.).
>
> The situation would be the same as it is currently with emmc. Locked
> emmc gets initialized correctly but reads/writes time-out. What is wrong
> in having the same result for both sd and emmc?

Very good point!

>
> >
> > I would rather just power off the card if initialization fails and
> > remove its corresponding device from the system.
> >
> >>
> >> > What will
> >> > happen to upper block layers and filesystems when trying to access it?
> >>
> >> Everything will simply time-out.
> >
> > Yes, but it's uncertain what that could lead to?
> >
> > What will happen with power consumption and power management support,
> > for example.
>
> Okay, this is a valid concern. Would it be acceptable if we just enabled
> this "feature" with a module parameter, something like
> "sd_initialize_locked=1" with default 0?

That would be an option, but I don't quite like that either. I guess
using locked cards isn't that terribly common. So, perhaps we should
simply leave this to be managed entirely by userspace, for now. As
pointed out by Avri too.

We should still be able to power on/off the card during
suspend/resume, which I think is the most important part here.

[...]

Let me get back to reviewing the actual code for $subject patch, to
see how we can move this forward then.

Kind regards
Uffe
