Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986414D711
	for <linux-mmc@vger.kernel.org>; Tue,  7 May 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073732; cv=none; b=VSTwuLoD+wrUSmEO9fuOVt4IOlK89Zmv52dy8BUTUorSJfSdFJqLo5nETNjPeGm6dT/Uyelnwss/rB9LipQ76usBtTGw1hkhqIK44cx+tWz60FZj/VpJU2CNvwaCr/U5/dypHAHqDVXigk4vu0itvEs74+p8uTVXkvdtzXq9i5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073732; c=relaxed/simple;
	bh=MYbuBqfdt+dluLElLanY3jhxaBB9u5sP0QgbMlw6Cds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpvZop5FU3mRNRiXZkq1kZhfZ5+j5qRVTYWgrlziHdX9kx30G4g5uvy6ZWpAupGys6jvor+am9/GGUkj3YiuH95iny6JJUgADGTSHWNZ5+j9saLQNql9w4dmMh91UAW676Ubrlv/8QyrCjRBYlyfSoJFtkXP3uuo3FzzAdhU1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMG7SAJH; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMG7SAJH"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b22f818a24so487777eaf.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 May 2024 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715073730; x=1715678530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYbuBqfdt+dluLElLanY3jhxaBB9u5sP0QgbMlw6Cds=;
        b=SMG7SAJHNXGovld8lQ1jlyj0OeSUAhQsbGGNvlSRUMu0zai4KfRsfA7VpfDnWLwLfd
         ImOWkx5ToyVOiHnNKNTnYHIju7QogtZB66JRm1R9uh7qc7uaahU2bl6FcqrHn6SKKRE/
         YptLXKJ19AmayZRVEkz+xKZKHTcLszWIQHDiw+MsoJDS94uZTT8zSjf36GqIEANWUXs9
         2B0A1Sduc9X6bwRP5mxXYozkgOf8B7lKLj+JflLwwikbcdmuR5hA3JDWzzrqX++ZPrQw
         gGloHL9mUGW3Ss5opr+qATTgbrSD1tOBqvMaRlKdRzS1gehl39kpLL4Lxs9jYDaETxeh
         xy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715073730; x=1715678530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYbuBqfdt+dluLElLanY3jhxaBB9u5sP0QgbMlw6Cds=;
        b=djj7gE0e1EkyRywAqdqeeRxH818MR//euTNPr6t9wrisx7ZRtbSO+/UY7NlDk+BDb1
         HLdLP1AR1DpgvsvpR5/vKRgOSp/klwjcHOPcpo1771eNh2iaxbxaBF5rDmQ/pkCgPHIb
         Asz31zzjAGLTUEHOL9psWppb8iz9gqwa/0D3fbJKsvE7GcRFCTVgT5RJILmsDaFyMPCW
         CCPB8fII/9rwsxLmLNSjxxWS6sMbAyIvTeVj97bypY67avSEsi5IYi/Gm9XGDiu4C72Q
         Ov39e6Q9m02SrMAIUvHx/IDXLt3kWHN0hCzJovpzuJPTyy7GUxAd5GU7bWuNQAf8CQVI
         03DA==
X-Forwarded-Encrypted: i=1; AJvYcCWEiRNfz8X/dHhw88PFcaA3YccM1gCNO4BzUckuA5KBTGV2gIMAduyU5VeAHo24TGEMwq3ry2RelvdEE85D9r6Ed/vMQNb08GIs
X-Gm-Message-State: AOJu0YxrDaaQKDigthXp47quf7tQZwRsUsQm1ZdZHXGmKWxd7iTidzl+
	5AzyBoDEwlcWiKdw0mpJITan7M7suoD9SiAnIHAkylL0/qvD9TqckSF37MJ0BRASBeSbociItzi
	ElVtbWkwiOPybVrj82spUnYV+UMM09XfPsj+tVA==
X-Google-Smtp-Source: AGHT+IHJK0WiaCWVqELVAzoNebQZ8ZxPZXO8o9tEhvNxNCLWnV1DUAg/rrh+Q4aj4rpoZ3w6JUobtDl1KXMWZfo/3gE=
X-Received: by 2002:a4a:5441:0:b0:5aa:538a:ed60 with SMTP id
 t62-20020a4a5441000000b005aa538aed60mr12850169ooa.3.1715073730349; Tue, 07
 May 2024 02:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-3-jens.wiklander@linaro.org> <ZioXkvnIw5V5MXBU@mecka.net>
 <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>
 <Zi9rKzz8u8z7cIy0@mecka.net> <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>
 <DM6PR04MB6575AC5DEB3A46D1AE11705FFC1B2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575AC5DEB3A46D1AE11705FFC1B2@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 7 May 2024 11:21:58 +0200
Message-ID: <CAHUa44GLGT7F0=LL6fjw1inf0N-OPpVL+D44F84yndUmk-xLhA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Manuel Traut <manut@mecka.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 9:36=E2=80=AFPM Avri Altman <Avri.Altman@wdc.com> w=
rote:
>
> > > > >
> > > > > Is it possible that idata->buf is not DMA capable? Any other idea=
s?
> > > >
> > > > Thanks for testing. I don't know, the idata->buf is allocated using
> > > > alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO); i=
n
> > > > optee_pool_op_alloc_helper().
> > >
> > > Is this really true for idata->buf or isnt the complete RPMB frame
> > > memory allocated like this and therefore idata->buf not page aligned?
> >
> > You're right.
> Maybe add an assert of PAGE_ALIGNED(idata->buf)?

That might be a bit much. It turned out that there was a 2-byte
alignment causing the trouble. I don't know exactly what's needed, but
the amount used by kmalloc() by default is good.

Cheers,
Jens

>
> Thanks,
> Avri
>
> >
> > >
> > > For RPMB via tee-supplicant the idata->buf is allocated within
> > > memdup_user and therefore page aligned.
> >
> > Yes, that's a difference. Have you tested with page-aligned buffers to =
see if it
> > helps?
