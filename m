Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB5256C64
	for <linux-mmc@vger.kernel.org>; Mon,  5 May 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450695; cv=none; b=dE1LhMiWk/L+w127LZln+iGUhQuw1HvWLY4loFC2ukHychv8IYbEDOPn6UfAGfJgg4Jdm+8/jxaJzAPIn8tBSRHdb5NQ6fvNBaY3ACb3SmltFTXXG3CvAS5imFbDH7aGHWIQm8MtXFVJAFEKNqRDJywn0khAu8M1XdZvQFk9kaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450695; c=relaxed/simple;
	bh=JAhyEvfgy1i1Ua4qr7SYpCjo1cisNLOYZt8v/j1Km3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcOThbOci+KcQwFDfsdVD5QhlK9LG4fjS2lRJiNWPB4rGMDv1CrddKI5C1XyIUQtlyLUAZIirjbRJTj2ydexv3huq3IsWtVH7HP9OtDIVbUdRlA9OQiK+iZ3U+F6NL20C/XX2vqeyyfnWsH0x7ca7CBn8Sbea0wsDYLY6gIvdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3+TJmUK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3+TJmUK"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e75607f95eeso3265918276.2
        for <linux-mmc@vger.kernel.org>; Mon, 05 May 2025 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746450692; x=1747055492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JAhyEvfgy1i1Ua4qr7SYpCjo1cisNLOYZt8v/j1Km3s=;
        b=o3+TJmUK2jdet8ttnQU40NHRGUZcDvpoyfjUp253YsixuedCmxIIycFKuXU0rXj1pv
         7lI1tXMUE0gTmrFtHVZSfTrXWYMAxo8r/MLoAxT4kk5TpzMEQd094U//2SvlFG7xv4dh
         3gVA7+avpFHbNiW/okyQRFy5V4YB5OZTnxQjWdBwKkjSfcza3ggU2/e5hs97HYRLdiv7
         L2MOfmyYHvccBCspjVSJGoxAsefHujHxIC8k9mhzVhhkXYs8mQivE6YDdUFeyE1/CEtP
         ykV7kdNht4hu19kOF2PxtfS3VJxu09qe+s2KeCuAp/yMS6uYD91f0C/bBnODuNVN3Tf8
         gd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746450692; x=1747055492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAhyEvfgy1i1Ua4qr7SYpCjo1cisNLOYZt8v/j1Km3s=;
        b=UqyvGth5U/BQAgcQDdQ3MayVBrjOcHBdmxcd5rnKxMvyGbnwYjNdmHXVw5g4T2Oxm1
         lOq37/KmzcemEXt5FA3WN5v1TVXHUUITRin7Ecgcfvp1eEqCY0dQZKYFmB00eACYDEAt
         cTifhwINPky9oWL9Tagym4oZbmvcxOFOqTh9dzkDf6N/QfbR6DuXvN3+iZMq+WQb3wxz
         xscFOqgA5ukA02V+TOW23KcmDUhUqjZmU3yASEQEVhOJlzM5taK1LKYp8l6ZbGCVtlgo
         MKl4tCmOI8zlpOwH0sg12QnMo9X/bviOXEEbqwHxaqHRXSIojjXy7XMUPV4daIsp8I89
         IE0g==
X-Forwarded-Encrypted: i=1; AJvYcCV4Fga4vSyQBnYadop/gCQcpTM47U3phbzO5vjo+5LvUMA3zbtAZHZXF8BtS2+jngETIMxhN/WTyNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjXedNncGhXZnP7MOX5KsVMjwCwF6bODIy/r2UQChCaUP0qUx
	qmfkTQGNzrwEi6KG+B059H3JBjYdJ/tBOYc0UjLlKkIORDsx+ICuepTyY+/efbluqorDR+YHFhx
	uY/BwTFZH6lgjQWl83Oc37BBx/jh4ZXOmW6Fc0fvz9U9KSvyj
X-Gm-Gg: ASbGncvnl4lIGLXYIWzNghZ9GBZwgvzpBGyuacPv9CCcbI0FGKBUI56CdtAAGTNH1zV
	z8GcHpkvF/nDkME73Deq2P1vl6DkaxqDHfPIzDPdx2uHr9/36hDxGgUQzIYVjt2qFEymZffDK4H
	FYKsU5GY4TE00mNQ0Ckrz+B0o=
X-Google-Smtp-Source: AGHT+IHYbF2WPZAiZQJkMemTDe0eA/WNRrjqs4w7sc6I3JE6Dj46TaOld9R59l3cTHEPKEvrfbHdG2JW0rfdFv4Rzlg=
X-Received: by 2002:a05:6902:70a:b0:e72:d449:72ed with SMTP id
 3f1490d57ef6-e757d2eb6fbmr8387246276.24.1746450692302; Mon, 05 May 2025
 06:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310102229.381887-1-o.rempel@pengutronix.de>
 <CAPDyKFrC56BBJk=YAPWCCNYNqFAoY74_yH0ZXfNQEiDhaA2xJg@mail.gmail.com> <aBiztawScUfcLELt@pengutronix.de>
In-Reply-To: <aBiztawScUfcLELt@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 May 2025 15:10:56 +0200
X-Gm-Features: ATxdqUGopRIyAG9fE6pCiDkLofZQUawSDV9qKybdHFgAD5Qsbz0IQB0_BYNYZ5E
Message-ID: <CAPDyKFoVacuOQV0dH733BnhSXGQ7-c3M_u5=+AonGAXAYLsU3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mmc: handle undervoltage events and prevent eMMC corruption
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 14:48, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Hi Ulf,
>
> Sorry for very late replay,
>
> On Thu, Mar 20, 2025 at 03:36:32PM +0100, Ulf Hansson wrote:
> > Hi Oleksij,
> >
> > On Mon, 10 Mar 2025 at 11:22, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >
> > > changes v4:
> > > - drop HPI and SDHCI related patches
> > >
> > > This patch set introduces a framework for handling undervoltage events
> > > in the MMC subsystem. The goal is to improve system reliability by
> > > ensuring graceful handling of power fluctuations that could otherwise
> > > lead to metadata corruption, potentially rendering the eMMC chip
> > > unusable or causing significant data loss.
> >
> > Thanks for posting this! I will spend some time reviewing this next
> > week and let you know my comments then.
> >
> > However, I just wanted to let you know that I just posted a series [1]
> > (forgot to cc you, sorry), which also reworks the way _mmc_suspend()
> > understands what scenario it should be running. I am guessing that
> > re-work is simplifying for your $subject series too. Maybe you would
> > like to have a look?
>
> Ah, very nice. The integration of undervoltage support is easier now.
>
> I rebased by match on top of mmc/next branch and do some testing
> tomorrow. If you have no other comments I'll send updated patches after
> testing.

That's great! I have started to review the series in more detail, but
feel free to post a new version, I can look at that instead.

>
> By the way, are you on embedded recipes this year?

Unfortunately not. Linaro Connect in Lisbon clashes with these dates.

Kind regards
Uffe
