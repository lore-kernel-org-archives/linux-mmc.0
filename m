Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1340856
	for <linux-mmc@vger.kernel.org>; Tue, 17 Jun 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168370; cv=none; b=KNXHwpYF8xFUkMA1E48+gBPXrJEh/k2u53GmwjyDj6kEM/nfV19iwuGUCydLy3gFlxB0rw2+zgti0lhOhFE56dVJa/tPq0CMM/cJ5em7ocv4gUxSe6ajFa9elPLzFjsHmEJ3rSYY/MWjFCuRfXuLYZ1UPuQCQ/mL4RskUAWIfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168370; c=relaxed/simple;
	bh=cPKFsBZNovy+Axcf4YqlKa2GQnFL9ioNnP/K+f2IUAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwpjOf7EHXRjk+dfgXPs/b0CASRageE8nz/XVF+7o9Bxxkx7ZA/Q9pTMlHoLGbAW8MZGgrkOV1Fe0zYL1PNmCdoLv/uduHxWhhzFP3bSmxfLLb+uo5pQ2Suu1coDdclWiMEDrcaecQbmXQt5VHS39trfUX8C/UvN5NCSSaw6tRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqErE3qu; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqErE3qu"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8259b783f6so1637180276.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jun 2025 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750168367; x=1750773167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPKFsBZNovy+Axcf4YqlKa2GQnFL9ioNnP/K+f2IUAQ=;
        b=lqErE3qu9ir1fYF60/rRCAmKueq/MdQPtOnKIYu6XNVguZFDEikZZwofvv+TxagzGI
         n74yctFukz/N3quKRA8w8fPJrat3sF6L7VlqiB7hrqf9iVM7yBkw+X/1PDQ9+Kf756LJ
         UYt6dlE0mLd1gVdvcP3EbeA5kYf0/RNl38YEWIlFhbGMLCXzzsm+EsfEP6yyccrwmPcN
         w5gH+1Dz4/peNwH90RrzMbA4gqPZV6zxniw2WjZ2du/rSSN37toqmnJugPVfI58A/mF+
         sFWBFoGWyfjzMoqtdRYSx+eFfTRjxAdHN4xaKQE0JCybJ3hdS2bbmUp6Tg1dNhz7mfjL
         77Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750168367; x=1750773167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPKFsBZNovy+Axcf4YqlKa2GQnFL9ioNnP/K+f2IUAQ=;
        b=AycK14rlJdTiGbvWkpfYNN1HH66SMFp2sN6VZ1TkGSzU8Q9OLBnjmNizP2mF++5fwq
         dm1IJOOI0+0bWJnkzzQnRmvTwfl2sAr7XRRn5a+/z/4fKN7xxnIQQoIRaCovsEDNoXYr
         fntCuv3sllR5oNV4eM5GC/txyG5DIMS2PWGQIVDTYxjN3gfhgOdfDoyRrUERq3M+K3Or
         GA5Dd62trtqTk3/f1c2L2lx3OBv79EH3GAA20zdw+VQOVImZyxtTU2aRlt3lOTvjY5oJ
         08zdGO1A/C886tIMFet0n5QGPfQvZZHV/26Pg0LugPHbtfCETIgFiZD1NnomG4BPIWMH
         y/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSK51fU+lSYbx7LU3edWxNP8vzgWqoJh3kUZjTbAvOYkvvoo/zOQTM5TqMyRRvaunaX8MhbPOOrDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBf+khKboaJB8TWGyS8X4b9xFSlALeTqItmxRPABelAunN20A
	J2NRojLXU2M4Dmvh3mHvQce3Y9xAlKruHU7ObhTrgRhwAn3j7x9vZ880OFz7SXwMuQ8RecwiN8b
	AeFTg6eGHRdd4JeaIL8y/8An3AU2tZWa/nQDEtFSn7+FtErfrNb6W
X-Gm-Gg: ASbGncuPbsi7eYQ2kWTodTY3HpZ52g62R1FrtrYH4qSiMPBJmR3be8QY9RZcw/zktey
	J5IxKXfY5f6SIHF6ivGxf/1LEpWYyAcLmvd2BOTj4v6erFpE9c8wOfLoLvkUiRpzzO0QsMO1iDa
	Ld+UqRkhY11yMdBvKE0HJnHJ29zAQut68mdok+gsJcxoXl
X-Google-Smtp-Source: AGHT+IH20Tw99umGLY3dKLQM2GcGs4M/xr/xv85IRDscix0HWFTBZk3XGY3dAPIyjfyrvASV3F3XP3NlpYbFn+iceO0=
X-Received: by 2002:a05:6902:1021:b0:e7d:6a8e:dc5a with SMTP id
 3f1490d57ef6-e822ad8bad8mr17922867276.36.1750168367326; Tue, 17 Jun 2025
 06:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eaaab4af4cb6161c508a07734beabba27117ce4f.camel@zougloub.eu>
 <8dc24db5-f7a2-4cf8-9eb7-2c9430fe47d6@arm.com> <1ef49897bf775bc6058053fdbb555f4e784a5222.camel@zougloub.eu>
In-Reply-To: <1ef49897bf775bc6058053fdbb555f4e784a5222.camel@zougloub.eu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 17 Jun 2025 15:52:11 +0200
X-Gm-Features: AX0GCFvVLqn-27xDwnDYn4ADXs8PuHR9Hi09XqAzqsiEQULd05pSUhYp-k6uwm0
Message-ID: <CAPDyKFod7aSrgCs9HS_yYHR4ML7W0o=fg5ukkrzY_k0Zkt-1KA@mail.gmail.com>
Subject: Re: Clarification on safe power-off behavior of SD card without
 power-off notification extension
To: =?UTF-8?B?SsOpcsO0bWUgQ2FycmV0ZXJv?= <cJ-ko@zougloub.eu>
Cc: Christian Loehle <christian.loehle@arm.com>, 
	Vivien Didelot <vivien.didelot+linux@gmail.com>, linux-mmc@vger.kernel.org, 
	Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jun 2025 at 16:59, J=C3=A9r=C3=B4me Carretero <cJ-ko@zougloub.eu=
> wrote:
>
> Hi Christian,
>
>
> On Thu, 2025-06-12 at 23:38 +0100, Christian Loehle wrote:
> > >
> > > While I certainly can issue CMD0 by userspace according to their
> > > recommendation and call it a day, I wanted to know what you think
> > > of
> > > it: does it look odd (looking at what public information I can find
> > > about SD cards, this "do CMD0 before unplugging" seems reasonable),
> > > or is Linux missing some functionality?
> >
> > So my two cents again (something according to this is discussed
> > surprisingly often recently?):
> > CMD0 is sort-of unsuitable for this, it doesn't have a response or
> > a way to signal busy, so the host isn't aware of a CMD0 'completion'.
> > CMD0 is just a FSM transition, any FTL behavior this may or may not
> > trigger (and some card manufacturers may or may not have implemented)
> > are unpredictable and hard to guarantee.
> >
>
> Thank you for your comment (and I'm sorry, I hadn't found previous info
> on this).
>
> I guess I will challenge what I've been told (but who knows, maybe for
> this particular device it is what it is?).

Indeed we have card quirks that we could use for this. But in this
particular case, it kind of sounds like a fragile idea to me.

In principle we would be sending a CMD0 to the card, then just wait
for some predefined/hardcoded delay, before cutting the power to the
card - and just hope that it works.

Kind regards
Uffe
