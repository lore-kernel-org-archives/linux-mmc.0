Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE2374FA
	for <linux-mmc@vger.kernel.org>; Fri,  9 Feb 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522133; cv=none; b=H/QIpogxGVRj58zvorqWEwzMDvXl8sy2J8phZvE96Z2/MKYolzo+BjF78jPVTQUXcVuUxx4+HZftiC2Sy9mQVuSgK3hOQ624aLScb5GDVzyZVLipnuY0rD6tIE/9sgvO0LXSFxjzpfOiogwW6CJB8cxahB8rRTeTU+9pIYv2VYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522133; c=relaxed/simple;
	bh=36Bp5V3HrWBZbS46TYrpP52qQdL28XvTzmsXoRqxpGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3v2SFRcJhxQKydbGp5KJwjSR4IT95pG15EAb04RT4gQIUEsaxM1pjXCwytaXTSD4t0gsXCaFT6Fp+fvBL3e/tw4I23K2Oi8jOSh50cE3tor/lteh2R0o+BPXmjvvlZ7B/8hv5WeoCkaWSAwruCWlUYO/X8u7tOYsn5/Sm3ir/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PcA3RQ2P; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcA3RQ2P"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6049b115630so18267277b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Feb 2024 15:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707522130; x=1708126930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Bp5V3HrWBZbS46TYrpP52qQdL28XvTzmsXoRqxpGI=;
        b=PcA3RQ2PJQ/gQKp5Cbpb6Iyf1ol8kyLN0c/63Z6kA6JiW4NDdE0EtJaJkT2NyxXXMy
         Kyg5hdLAEPPNzB04lqr5hn0ILOjhm6/z7b3nh72UL9jePV13NKv6XRsNQ32UYHQX/sKc
         Mmap00ZUMCx8I848Z2GGHIuBpal/DUZjBCBz7OSHOZYEiRPXkng1ZmBtr+C9h83QY3v7
         2+limIbSa2U1/MlnGpPTyEYskY5d8oRshKsEVbSxvABbSzJ0y9Ld05H+5JDEiw+W/9Dz
         rLw3MXxoCUbIEtd6uqs73wvDSKnO5Sxs61WxY6Pm1sh8lqIOlcEeMfGTxx+w1e9YqGvi
         mC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707522130; x=1708126930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Bp5V3HrWBZbS46TYrpP52qQdL28XvTzmsXoRqxpGI=;
        b=RneTLrCkk4yEGUDVun1eX/Y6zyv8ZAjecOMJt2BAM69DBYY6iRYE5BGeZVD/V8DB53
         inCgc7GuYJRSoS/mdm6wRpy5xxd1/v1PG4hpwmR92rz0VsKwroivYCulAydEDV+ReYcJ
         wZ//Rjl7N4d0FaCJ+BklIU93fXKrcnMICkAQeg7u6cW4AI9QVykZPFrzz8IRQlYiOaPV
         fo9DhszJjB9ks+vYXDDv3Iqb4frrGxnXDzs0ZdCBjltqukNjsXBXF5Dnxju5R3cuWzC8
         ngWkSShmO85AuRGgge4tEwf/4kIWhU+DC5O6IHG7LA+wYnoc+2RsnaQcgBgGwboaQ6y8
         pKuA==
X-Gm-Message-State: AOJu0Yys9aWyP/WJ0L0QsfBP5gVE8egKsqqI6FlgEuEr92JEpDd6mIAW
	CebpwvMDYRwneewwFyyDwSqj59xJ5L/HPrWnsm1PdcKLJ4YyGUU0vxmc9bm8pWwZwdsyxRF3zA+
	LaPpwQHmU2qB4ps3gwUCWA4W/ir/0kzS7nclJaA==
X-Google-Smtp-Source: AGHT+IH7eTrIingP+ahCyJb1b55HFte2tzebTYQbAUv8STciXDuToLLW+b9233LY5KATmB4DKaN2RVXULUm1vcU1YrI=
X-Received: by 2002:a25:7187:0:b0:dc2:2d55:4179 with SMTP id
 m129-20020a257187000000b00dc22d554179mr2436830ybc.17.1707522129933; Fri, 09
 Feb 2024 15:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
 <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com> <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
In-Reply-To: <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 10 Feb 2024 00:41:58 +0100
Message-ID: <CACRpkdb=aDd+CuJhckE9xZjA4MXRS_BD=qd3sc3Qjnm7CNbATA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:35=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-lin=
ux@rere.qmqm.pl> wrote:

> > I think it's worth mentioning the cb710 example here, which
> > uses a platform device as a child of a PCI device and
> > does not assign a DMA mask nor use DMA.
> >
> > This one will see a change in behavior, meaning that the
> > blockdev buffers are no longer bounced. As far as I can
> > tell, this is fine because the driver appears to correctly
> > use the sg_iter infrastructure for mapping data pages,
> > but it would be good to have this confirmed by
> > Micha=C5=82 Miros=C5=82aw because this code path has probably never
> > been tested without BLK_BOUNCE_HIGH.
>
> Hi, this driver doesn't do DMA at all, so having DMA mask set or not
> it should be good as long as the CPU can read/write the buffers.

The only difference is where the CPU have to read/write the
buffers really, before the change those were all guaranteed to
be in lowmem (bounced there by the block core), now they can
also be in highmem, but sg_miter will deal with it for sure.

Yours,
Linus Wallej
