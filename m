Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B018F2E3
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155040; cv=none; b=vCou+rhXyb7RtQxajLqLWDfrQlTo5QuYh82uuIxD8cRuI/Ol/5oibxH5dKCHz6vUzyY6erDlta50btpBGyIqaHdohZfJJZvF0u1KVVVKlh342gn9bHT/jVjr5NKHiSU1sNAzFPw4wqvCILMP+MxtVn4CBjYKkSVS/NwZgCJolqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155040; c=relaxed/simple;
	bh=vldmY9TwpGQTnAayMgS2+WrfIRlpGIRE50G9nkaFwR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTI1mPjxYn84GGRgwuukFE3qJF2dqiIoUdjfvV3vaPT2zyOQxD+N0qelCTrccJ3c5QxHS/9GBmxmlqDaCbg2by3CgyAvAmtWPMJHLYX1pd74ur5XJ29FvmzoOGKB1czh68DUu9biaE237ZHD+Bpqm9DwviAfWoM0HAc+CQew1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IP37sffO; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IP37sffO"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so5800270276.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724155037; x=1724759837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHgKXmFQM/pgtpmlbe84jYboMFFbc+30nVBykAeuVY8=;
        b=IP37sffOsgXp1eO6OZNHN+hntS4J15AARaGBteVUEDII1eWoD0gKaMgOY7IFic3WOi
         oYxJRQNh6DEaJTYD0EYc0IcoVDxN2cxBRwRXdByyjrOz+xT6GYwcRTJSFA7GCpL37DP7
         k8HNCgA1KJnS1kohJlgNp6Va4vpNw2muNirstMFQkeEZTTTTkejTJiC6HbN6daf4ZlaS
         8+2Nyu/jaGj6hWP2jvDB/AqDVpRr28JqlC3s/gxaQVwICrt/if1FCf58ywt9XvM3V238
         jomvL3eBHqWXcmA3kcNm2ds2ObDt60HgWd3K0J4ce3RZw6D+ZJedfF3nV4XnczP99dB3
         6vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724155037; x=1724759837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHgKXmFQM/pgtpmlbe84jYboMFFbc+30nVBykAeuVY8=;
        b=WOLUOFiBKbC+GAP/yG11PhTon1NVxoAsWxKxxVLeLuoO3JFIHXLozBMhzayoZN8YWG
         C8BzwCeDovBDk0jlfHJ8DRZOIEUhmrD60BbeSveyeYEbjjkEF8CNsb+YoWclPytOviaS
         uU7dJt3tISXqBKTqrjZzPy3FL0fQZKba15EBqQ98ZKOTt8x8cGu9e+buHc/YPrD2PDXc
         +X0oBbkzDh03B9Ot7JbHhV74l5U8Rz2RuYYI3meugYp6vbVgbHihQWIkKxthmIxsADkw
         4skcHJRj8MF8xpRkcVEsT9giehHtk5eQvfqxgdwf0itNTNVtWnUYEse4/xh8zomIdPlB
         nItg==
X-Gm-Message-State: AOJu0YxbYAb1BKrIget2QKckKByh7IkBFR/kEPcFCRonLw68QlLZzpgx
	a31gnkRx7/3GDKK8LQ3FZm24WrZclfcxJ0hAHraObqxysjUi+YLbnco+ACWSGqDTKHfyM5lrze0
	sTKIUGl6oWOi3HeBGto3BJHWFmzCKnF2D2JtUzA==
X-Google-Smtp-Source: AGHT+IH084TQLlYBGOvXhEHe3flxk+W/oYMrkV6d7sKsNBNmWB+KA/P9GYd/x53vgmaaf2hNI1/uwJdUGOeFN+MdmqY=
X-Received: by 2002:a05:6902:144b:b0:e08:5f0c:97c8 with SMTP id
 3f1490d57ef6-e1180fc610amr14694366276.57.1724155037595; Tue, 20 Aug 2024
 04:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com> <DM6PR04MB65758FAE9750D94B73B17587FC8C2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65758FAE9750D94B73B17587FC8C2@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:56:40 +0200
Message-ID: <CAPDyKFqV-CkbOMxE5uymbr4icsoanFvQ7K6aH0kJNxifjW4FTQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Add SDUC Support
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Aug 2024 at 07:46, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> Ulf, could you please take a look at this?
> Not sure it will make it to 6.12 merge window, but I was hoping to start =
making progress.

Yes, sorry for the delay.

I will look at this and the RPMB series from Jens the next couple of days.

Kind regards
Uffe

>
> Thanks,
> Avri
>
> > -----Original Message-----
> > From: Avri Altman <avri.altman@wdc.com>
> > Sent: Wednesday, August 14, 2024 10:29 AM
> > To: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> > Cc: Ricky WU <ricky_wu@realtek.com>; Avri Altman <Avri.Altman@wdc.com>
> > Subject: [PATCH v3 00/10] Add SDUC Support
> >
> > Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those =
cards
> > support capacity larger than 2TB and up to including 128TB. Thus, the a=
ddress
> > range of the card expands beyond the 32-bit command argument. To that e=
nd, a
> > new command - CMD22 is defined, to carry the extra 6-bit upper part of =
the 38-
> > bit block address that enable access to 128TB memory space.
> >
> > SDUC capacity is agnostic to the interface mode: UHS-I and UHS-II =E2=
=80=93 Same as
> > SDXC.
> >
> > The spec defines several extensions/modifications to the current SDXC c=
ards,
> > which we address in patches 1 - 10.  Otherwise requirements are out-of-=
scope of
> > this change.  Specifically, CMDQ (CMD44+CMD45), and Extension for Video=
 Speed
> > Class (CMD20).
> >
> > First publication of SDUC was in [1].  This series was developed and te=
sted
> > separately from [1] and does not borrow from it.
> >
> > [1] https://lwn.net/Articles/982566/
> >
> > ---
> > Changes in v3:
> >  - Some more kernel test robot fixes
> >  - Fix a typo in a commit log (Ricky WU)
> >  - Fix ACMD22 returned value
> >  - Add 'Tested-by' tag for the whole series (Ricky WU)
> >
> > Changes in v2:
> >  - Attend kernel test robot warnings
> >
> > ---
> >
> > Avri Altman (10):
> >   mmc: sd: SDUC Support Recognition
> >   mmc: sd: Add SD CSD version 3.0
> >   mmc: sd: Add Extension memory addressing
> >   mmc: core: Add open-ended Ext memory addressing
> >   mmc: host: Always use manual-cmd23 in SDUC
> >   mmc: core: Add close-ended Ext memory addressing
> >   mmc: host: Add close-ended Ext memory addressing
> >   mmc: core: Allow mmc erase to carry large addresses
> >   mmc: core: Add Ext memory addressing for erase
> >   mmc: core: Adjust ACMD22 to SDUC
> >
> >  drivers/mmc/core/block.c  | 62 ++++++++++++++++++++++++++++++++------
> >  drivers/mmc/core/bus.c    |  4 ++-
> >  drivers/mmc/core/card.h   |  3 ++
> >  drivers/mmc/core/core.c   | 63 ++++++++++++++++++++++++++++-----------
> >  drivers/mmc/core/core.h   | 14 +++++++--
> >  drivers/mmc/core/queue.h  |  1 +
> >  drivers/mmc/core/sd.c     | 16 ++++++----
> >  drivers/mmc/core/sd_ops.c | 34 ++++++++++++++++++---
> > drivers/mmc/core/sd_ops.h |  1 +  drivers/mmc/host/sdhci.c  | 38
> > +++++++++++++++++++----  include/linux/mmc/card.h  |  2 +-
> > include/linux/mmc/core.h  |  1 +  include/linux/mmc/host.h  |  6 ++++
> >  include/linux/mmc/sd.h    |  4 +++
> >  14 files changed, 204 insertions(+), 45 deletions(-)
> >
> > --
> > 2.25.1
>
