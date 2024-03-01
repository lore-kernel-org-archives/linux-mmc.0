Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57C208D4
	for <linux-mmc@vger.kernel.org>; Fri,  1 Mar 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289244; cv=none; b=lje3iBp388sQ6YqJaNQi5SNDkjAvnBt0kk0wuIfLzwPM5olkeJNehfYX9UO9ZSz9otgD0L3d/noQnNEtW3/Z7thXBKbY76ttrNYFQ5CcuXuWPZzqtF6j+cCIMdoiJGQ/Q2TxI++v2qVNFsPYyF2w6unWE5hIrlDsJ6ubdtDmjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289244; c=relaxed/simple;
	bh=Ry8/2w0QVEHlwgRVzjogopViWIZq1zbn4ZZBHItPozo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L451s85pCoqqTS+oLa7ZM5yeiRhImWRIz37BecRoZkyL/eRRrDRrYz93UQWCgcRQqzIwN/nTaRLm3iJ4IX0G+RbilOwcp16bN9YhYpTGQM4/tyPhjAm7/X+wPM6PAOL9dqTDx2B96u/mdCswWacKR6pmfuIzS8gd3H0FKr1C3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uQ1Q7qdp; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQ1Q7qdp"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so1932158276.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Mar 2024 02:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709289241; x=1709894041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry8/2w0QVEHlwgRVzjogopViWIZq1zbn4ZZBHItPozo=;
        b=uQ1Q7qdpg7Y+zkac/17XmSrG7/sop4upvYPJUVjyv5/PuhYFwszcKEECpTVKYyL1/V
         UzfhdpqfnhAt8UWzihNgsr7Ya9tc3EfYUBuSrQRL1zQOeZVI0jMqJEorPxhjYtVvrAS/
         1JS7xp8nCqY6w6L80UdnynM/LI58MDv6AXH9bHyXpqZsV/2OQmhXLzcxaHk26yDdcx8d
         kmZk5WAKqdHJtQx8xqOa/3V0nbFDB8FQJwZA3HyB2pJ7iTn7sq1WcXYTaqFIHsYLKxVC
         3nj9Kb7HcmNJ1DYcA6OUoolWG22ebzX1ZhlQV1Qlv/0d5ECEGp2rX7vx6bGx1+TKlPzg
         iTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709289241; x=1709894041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry8/2w0QVEHlwgRVzjogopViWIZq1zbn4ZZBHItPozo=;
        b=K2jmRb4NMBV0wIc2KEt2DbX08TksgqOZcrkbzkD88VMg+WKdeSzIsCetcdYKo6mNeT
         vt145383Xua5rf1nbHRiPchOZbiJDPzbjZ9Wy6/KnHZud/unI4dL/Gk3WOGRkyIu5A2G
         mLe3HHC/m94s75wRu4DUghS+K+VXxzYg1ROYbPg+DD5pNIMZaXCyUZT7YmPDf2hqRjkf
         SVKk33gyFLCzxH4JRA7ue2O/Rm8C/MYW/s7IY+yQRPNWWDdRWAtGS7Wv6tXR302GOGtT
         VCP3wgfj5mPqNvNdDCxKCMdbIXSuCcxHu0E8NA3T+Mb9G0BSkmqj25roCyD/GVz+5sZr
         lJzA==
X-Gm-Message-State: AOJu0Yx3zs4ZlCVhqAxxn7Qf8uS7xOT8J7hKIuAeHvNceEK6abe2CQ08
	O7vZft3C8WdyNQ9muSzZ0VIDidWey/O657GYdSCpnd7EQCoVK7c7xbdYSeppeJKwqD4+GuT6RJy
	bO5wYNlAW/ziUZl/sfuRCs7TMt5wgjQ9ECPCpcA==
X-Google-Smtp-Source: AGHT+IGERyzwl5JHRolGFpVOmFvjkUTfdY15E+u1KDaBF4OJqM+rOB0z84Izn+7q9uLfFLp6OZE9sWxK0P9ekG0WUOI=
X-Received: by 2002:a25:b988:0:b0:dcd:26a8:7f84 with SMTP id
 r8-20020a25b988000000b00dcd26a87f84mr883337ybg.47.1709289241487; Fri, 01 Mar
 2024 02:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
 <20240213051716.6596-1-sh043.lee@samsung.com> <CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
 <000001da5faa$d34e1600$79ea4200$@samsung.com> <CAPDyKFpOLU3nsQuXLRdK2KAaQqX=Vwe0+A3jZc7pP4XaMG7Wug@mail.gmail.com>
 <000001da6075$754d6ee0$5fe84ca0$@samsung.com>
In-Reply-To: <000001da6075$754d6ee0$5fe84ca0$@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Mar 2024 11:33:25 +0100
Message-ID: <CAPDyKFoaNFox5iuyh_veP203JYipa8Nt36Z1Y1J6CUJSCLhx_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
To: =?UTF-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, avri.altman@wdc.com, grant.jung@samsung.com, 
	jt77.jang@samsung.com, dh0421.hwang@samsung.com, junwoo80.lee@samsung.com, 
	jangsub.yi@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, 
	wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 at 02:14, =EC=9D=B4=EC=8A=B9=ED=9D=AC <sh043.lee@samsun=
g.com> wrote:
>
> > -----Original Message-----
> > > > On Tue, 13 Feb 2024 at 06:13, Seunghui Lee <sh043.lee@samsung.com>
> > wrote:
> > > > >
> > > > > In mobile devices, suspend/resume situations are frequent.
> > > > > In the case of a defective SD card in which initialization fails,
> > > > > unnecessary initialization time is consumed for each resume.
> > > > > A field is needed to check that SD card initialization has failed
> > > > > on the host. It could be used to remove unnecessary initializatio=
n.
> > > >
> > > > It's not clear to me, under what circumstance you want to optimize =
for.
> > > >
> > > > Is the SD card ever getting properly initialized during boot?
> > > >
> > > > Kind regards
> > > > Uffe
> > > >
> > > We receive a lot of reports about SD card issues in the market.
> > > There was no problem with the first time at the time of use, and ther=
e
> > are many cases where people recognize that it is not recognized later o=
n.
> > In most cases, this is a problem with the SD card itself.
> >
> > Right. Thanks for clarifying.
> >
> > A follow up question from me is then, do you know more exactly *why* th=
e
> > SD cards encounter problems?
> >
> > In the past people have told me that powering on/off an SD card during
> > system suspend/resume, too frequently, could damage the card. For non-
> > removable cards, the card stays powered-off even after a system resume,
> > but instead gets powered-on (and re-initialized) when there is a new
> > request for it.
> >
> > In other words, if the problem is related to too frequent powering on/o=
ff
> > the card, my advice would be to test with having the card set non-
> > removable (the DT property for this is "non-removable"), to see if that
> > can help. If that solves the problem, we can work towards another commo=
n
> > solution instead.
> >
>
> I understand your focus on finding the root cause of the problem.
> However, unlike internal storage, there is a limit to analyzing cards tha=
t have problems in the market.
> This is because there are many different SD card manufacturers and many m=
anufacturers leave it to OEMs.

I understand that this isn't an easy task, but for sure it should be
doable. There are plenty of less robust SD cards out there, let's just
try to find one and see if we can break it. :-)

>
> For deferred resume, a responsiveness problem occurs on the user side on =
mobile devices.
> The response time of the initializing SD card initialization in the appli=
cation seems to be slow.
> Currently, it seems to be a good structure for the first initialization a=
t runtime resume.

You are correct - an initial latency for the *first* I/O request will
be added. On the other hand, if the SD card remains unused after a
system resume, there should be some energy to save, as the card would
then remain powered-off.

Moreover, if we also can avoid breaking the SD card, I'm sure it would
be worth it.

>
> Regarding non-removable,
> We will test if we are given an opportunity to further analyze the cards =
occurring in the market.
> However, SD card detection is also used as a wakeup source and must be in=
serted/removed so I'll consider it for testing purposes.

Yes, I understand that part. A proper solution needs to take care of
removable cards, of course. The suggestion to set the slot as
non-removable, was just to try to understand if that would solve the
problem of breaking SD cards.

If the card-detect irq, can be configured as a wakeup source, I think
we should be able to distinguish - if we need to do a power-on
(re-init) of the SD card during system resume or if we can avoid it.

I try to get some time to put together a patch for this, no promises
for when, but I will keep you posted.

[...]

Kind regards
Uffe
