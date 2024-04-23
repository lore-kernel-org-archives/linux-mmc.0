Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457054913
	for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861870; cv=none; b=lmdPqxCoPkeHsOxUpwLBCVW60a0Q7sel/D9oPkvSENoc7ZxSIqgtCj8qf3MWI0FvzVJenDbtr8EQSQo9Dae+2QFveJeK+gLK2/MWbBWNwCQYVESzHOBfAwRPDPG2h/Lj/0nioqKdhbG1PTqAez43G3f6np+/qWZbE/h5TlfzSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861870; c=relaxed/simple;
	bh=+My4GXa+K/9fAwH9uLEaNISiSAPjuktHxHqtmFm83Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFoPCSOEVJRh+ScR9woPorWDWwlkPrUe2gOsNO1B+/rABTNPuLinAt7GrJncEYn7jcO8VV6PFSUZ4TZfPrsLu6A/2bKjqFqfSt8SAFPUSqyjTyWvgwsihA4pcDiEZ4ulCrewfm+r2flw/WFtLuDbc2t2aCGdnXYaYHEXVXO/DKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hQJGEq7I; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQJGEq7I"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5af23552167so779739eaf.1
        for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713861868; x=1714466668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+My4GXa+K/9fAwH9uLEaNISiSAPjuktHxHqtmFm83Z8=;
        b=hQJGEq7IsWwCB7iF4VeKMS847bcIldwI3S7bVETDCnfKecxRXh2gR7mkDHKHQxHn/2
         BiSOQd8QivUYKLoPPNkYdeDODxb3gVSHoVqhsYEPWB3LznKYlCn4E/E+DVaB9oqLVyjd
         LI/3y0tTvNrXgmOt6bQE4/BVtvhKmT0gVFDujxb+WfkGxipYs0/Y9PwfR8GWkDrIAGGZ
         AVifceaPuCAvYsYRLuiZsTA7XouKEbZsh9HSh2S5IxYcYAK1vAgwLpXd+I4GS7LDV/qk
         ddoGKDJKhPjn9uAG1F3hycx8h1Khdutox3R0KLg31Rv+uSWPoixXFEYs1UlOCoDDUHTH
         4bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861868; x=1714466668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+My4GXa+K/9fAwH9uLEaNISiSAPjuktHxHqtmFm83Z8=;
        b=cibjnkYBaTmh4O0bRFXoTXk3tWPExc9hVcviD4mWNywAZnoMe3fC74xlk3d14seOQP
         NPxoRAMfZadyxKVUYnmbG6urZJSAJJh1B6cHzh2FOZi4DM45KL9hfP5yvLXHrieA9cXA
         28YzDd35Y74u8zWCthkZfH0PIDQmR0wIwyD6VEO1QoWmhqFNTFzjS4uaz2ZAfslEapsQ
         2APFEN0PHQEmepWtrs3nYGqSLVAlEfhFHtqLPED2bRDbuqW+tna5dUh1Hz7PzCGd/FD4
         MC3qu4Z07PWiuYUmJSCKwiZe2t0DQ/6MY/VVjXKTqq8m9o8Ouso05r3HXqPIyy/Yp/b7
         mI7g==
X-Forwarded-Encrypted: i=1; AJvYcCU5izlwE2tpo0nr1GgGdXXri8ecMAXQvgWlBMLbJhj/LA+Md24VPMTGn6G2426GZuMV0igqNE2l0vmhEWCJOuGfQWg26BchqQkh
X-Gm-Message-State: AOJu0YzsrbTaXnDIxG+ugGounaU/QCxA1h1yYws1acIeA8gPdt2z9OEC
	j3Nmr9NioBJ4d3zkv9aML2xXm8sLt6tzitpEqhaMqLSMb83BsMYx8tf4+D5bhFcBkPt84eWSfpj
	L8ekbmOVXStEoLL2sti2qmeQWD2BbNBX/IPPw2w==
X-Google-Smtp-Source: AGHT+IFEcRtF3ozJTE91QFopLg/DHbUsdVS1rllN6J8pIs46+14oweUTXy2DLOtlj4wnVzIkPzBbxpUkhsFgI+2EqbA=
X-Received: by 2002:a4a:1484:0:b0:5af:36ef:27d0 with SMTP id
 126-20020a4a1484000000b005af36ef27d0mr814140ood.1.1713861867830; Tue, 23 Apr
 2024 01:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <DM6PR04MB6575CE5A70F2C733DF40E54CFC112@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAHUa44EzMpRbhJ=-h4hJifgtrMsvDZj=Zt4C3JkDxjKE4gz=7A@mail.gmail.com> <DM6PR04MB6575E485C2CDB40CC79A3081FC112@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575E485C2CDB40CC79A3081FC112@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 23 Apr 2024 10:44:09 +0200
Message-ID: <CAHUa44F8J6byatNpg9W6Y2yinJw_RKEtLBKBSDxGkz0yx4Zi3A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:22=E2=80=AFAM Avri Altman <Avri.Altman@wdc.com> =
wrote:
>
> > On Tue, Apr 23, 2024 at 8:42=E2=80=AFAM Avri Altman <Avri.Altman@wdc.co=
m> wrote:
> > >
> > > > The OP-TEE driver finds the correct RPMB device to interact with by
> > > > iterating over available devices until one is found with a
> > > > programmed authentication matching the one OP-TEE is using. This
> > > > enables coexisting users of other RPMBs since the owner can be
> > > > determined by who knows the authentication key.
> > > Devices in plural?
> > > I am unaware of any board with multi eMMC devices soldered.
> > > Can you refer me to such a platform?
> >
> > I'm testing with a Hikey960 (HiSilicon Kirin 620)
> > https://www.96boards.org/product/hikey
> > It has one soldered eMMC and one removable eMMC.
> I used to have that board but with a UFS2.1 version, so I can't really te=
ll.
> https://github.com/96boards/documentation/blob/master/consumer/hikey/hike=
y620/hardware-docs/hardware-user-manual.md#storage
> indicating only a single eMMC device and a SD.

That's what I'm testing with, the kernel finds two RPMBs with
different CIDs. I'm running my tests with the removable one.

> Either way, AFAIK there are no production designs that make use of more t=
han a single embedded flash storage.
> This goes for both eMMC and UFS.

OK

Thanks,
Jens
