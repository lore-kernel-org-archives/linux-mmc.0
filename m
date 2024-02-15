Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628912C53A
	for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994883; cv=none; b=NlxtPK9Pq0GmwGQdX5IIvl6eFPdHCQKZdrFWpOA6QOIejW6//f8DEfIuA845Hk0Tr9mBEQJiJniu6q2wKkd/q+PdANnExJa09D1oF8w+Ew3DOQdOnqgKMpVvTrv5eCigU/73o+jdQD0uiY+O4k3jo5Tj8V2bz70xiGYYzx5+ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994883; c=relaxed/simple;
	bh=cDEdSB2/9G7cVHoczeCQ+23h4ELW7WOM32Jsl5ykyPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAAedqvF6YsvIXgqH8cE+fB1CvXLMQ7rKzFO+z2Fjqd/U/NHf6tQOfnWv2lw0E2oNSfwaYXZmCNbp8eehu7fR3OZUxIkuEWP3DwHFV73kkMxBbDLznFoVo1m4beCceD+Bi7t6xs9eHObCR1GdMEzrv7A3oAFyBLEhjXIK/V3yC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btaXsw6O; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btaXsw6O"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607dca92fcaso2203777b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 03:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707994881; x=1708599681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDEdSB2/9G7cVHoczeCQ+23h4ELW7WOM32Jsl5ykyPc=;
        b=btaXsw6Oe09ggCHy/MUxBwc1WNHWtMoZZ2GODqsXLoXkAhF8pvhhxIrXJX3Byuoen8
         L0qplGKTq0Z2azuFrVxvHIPBObbCaDm6Oou98oSa6BlRbHBfBmMcIyjfi2URhLNp0Fd3
         nYObbvOog+jTXPMiBY3d2w34dWobiHTHm7zpbp4j9GDK0KfihHALJNL9eNFYcZRn+1xU
         HbWusz2ne5o+6F6Nh/Gdax+IUzHyI5LUOVyt4sHGaLwtAwOEABVyeTnHXCidZKz5aUAM
         Aa12LFfYQSEtQ0/cBbNcveznkSz4jnmoMX75p/upl0Wj/UarLzBa1EVMFb+O/avlPnxI
         SgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994881; x=1708599681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDEdSB2/9G7cVHoczeCQ+23h4ELW7WOM32Jsl5ykyPc=;
        b=SMzO75XWGzJc3p24/VpdiD9YOn5AGm9o8hWVlYqpcNH8J4FAHG4nVW3NX4QQmOjmP3
         BReTuQXApst3AwzqRt3dGYYDeCH2gNbtSbPc4moQiTaeURO5btv8C1KgeKqbk3bGlr9p
         7hhTVK4sIpPPq92KGnM7o1a4wFEvn10zkQU7I0A0tnYX9uIADPMQrvnq+MpxaSeoulNp
         LdEeXlZE5zTSqcM2m9p2ndhJ6yJKQqepwulo2giK3KP2eK1Q8w1ZFkkH95hPyIRj3vzE
         eOf2LUfq83mC86OsZrza5ZppD7uXyEzAhAeiHZ/r19I74lP3eGcUZAQ9/1zzy8hTIzZs
         n2Qg==
X-Gm-Message-State: AOJu0Yw+q4q7k6rmVloNHzlZyKyaPEg9WnBPCr4xGVwUOeXNkEYZAidw
	RXpeHeEn72cCOLm+QlsHrvZBZhR/7KFmImeITy+LzRzEpRXYbnjTM47JQCjGUW433gDbLVO+kIM
	9S+qIxNbkwg4EtxzCusAIBBak04HRCJ2KDBjhpA==
X-Google-Smtp-Source: AGHT+IG1SwCa8ysgussmiIZ4jSNfG9RkkDz0MVquvOYvRU/bylDuJVEABWxpn+GWMH5eHTfOoKxGi/RFaYMXEFb+hCg=
X-Received: by 2002:a0d:d947:0:b0:604:9cad:8c23 with SMTP id
 b68-20020a0dd947000000b006049cad8c23mr1308248ywe.11.1707994880752; Thu, 15
 Feb 2024 03:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
 <20240213051716.6596-1-sh043.lee@samsung.com> <CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
 <000001da5faa$d34e1600$79ea4200$@samsung.com>
In-Reply-To: <000001da5faa$d34e1600$79ea4200$@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 12:00:44 +0100
Message-ID: <CAPDyKFpOLU3nsQuXLRdK2KAaQqX=Vwe0+A3jZc7pP4XaMG7Wug@mail.gmail.com>
Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
To: =?UTF-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, avri.altman@wdc.com, grant.jung@samsung.com, 
	jt77.jang@samsung.com, dh0421.hwang@samsung.com, junwoo80.lee@samsung.com, 
	jangsub.yi@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, 
	wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Feb 2024 at 02:03, =EC=9D=B4=EC=8A=B9=ED=9D=AC <sh043.lee@samsun=
g.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Wednesday, February 14, 2024 8:27 PM
> > To: Seunghui Lee <sh043.lee@samsung.com>
> > Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > gregkh@linuxfoundation.org; avri.altman@wdc.com; grant.jung@samsung.com=
;
> > jt77.jang@samsung.com; dh0421.hwang@samsung.com; junwoo80.lee@samsung.c=
om;
> > jangsub.yi@samsung.com; cw9316.lee@samsung.com; sh8267.baek@samsung.com=
;
> > wkon.kim@samsung.com
> > Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
> >
> > On Tue, 13 Feb 2024 at 06:13, Seunghui Lee <sh043.lee@samsung.com> wrot=
e:
> > >
> > > In mobile devices, suspend/resume situations are frequent.
> > > In the case of a defective SD card in which initialization fails,
> > > unnecessary initialization time is consumed for each resume.
> > > A field is needed to check that SD card initialization has failed on
> > > the host. It could be used to remove unnecessary initialization.
> >
> > It's not clear to me, under what circumstance you want to optimize for.
> >
> > Is the SD card ever getting properly initialized during boot?
> >
> > Kind regards
> > Uffe
> >
> We receive a lot of reports about SD card issues in the market.
> There was no problem with the first time at the time of use, and there ar=
e many cases where people recognize that it is not recognized later on. In =
most cases, this is a problem with the SD card itself.

Right. Thanks for clarifying.

A follow up question from me is then, do you know more exactly *why*
the SD cards encounter problems?

In the past people have told me that powering on/off an SD card during
system suspend/resume, too frequently, could damage the card. For
non-removable cards, the card stays powered-off even after a system
resume, but instead gets powered-on (and re-initialized) when there is
a new request for it.

In other words, if the problem is related to too frequent powering
on/off the card, my advice would be to test with having the card set
non-removable (the DT property for this is "non-removable"), to see if
that can help. If that solves the problem, we can work towards another
common solution instead.

>
> SD card users cannot determine whether or not an SD card is a problem, so=
 they should be guided in this regard.
> It is necessary to distinguish whether the SD card is inserted but unreco=
gnized or the SD card itself is not inserted, and if there is a field that =
can check for initialization failure, it will facilitate guidance, so we co=
nsidered the patch.
>
> The variable's usage is expected to be used through the sysfs node in the=
 vendor module.

As Greg said, please provide the complete code.

Although, I want to stress already at this point, I don't see a
solution with sysfs being the correct thing to do here. The kernel
should be able to manage this problem itself.

[...]

Kind regards
Uffe
