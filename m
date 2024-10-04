Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56D1581E0
	for <linux-mmc@vger.kernel.org>; Fri,  4 Oct 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042922; cv=none; b=rLwsCqX4ouI2pIfH/R70dnCSBgN5M+gIKYwefZCHmtxuEOeTnr5+eW90lud04bGo+OU1I2LS/W8MezuyfuxDgJyIW09HFEIN2m7T9ZOlm6BbwRDnuE26BdiHfWTcQW8KyXCXG/r6NprXTspsa4oh3549/ITwJF3fE0ujVXa9e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042922; c=relaxed/simple;
	bh=lW4WYgkssxVBDl6uNjKBsszdRCDAxXm8ViV/nvdlr1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyixtlE32/BhgYaEiOmW5TiRexLCuSGZkvAIwp4l+Ba36FbX+DS6wXWvRQMMh4YW6bX8Mvxn403RYQaTuMnA3x7qxK1qo3kDr512Oc7gSM3e1iIezdRsnXRckXKA49usVvUEWrD0rb2hW58u3k92cbzbH7FUHmKyg69BKutCbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFx1/JX9; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFx1/JX9"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e28a083d531so161113276.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Oct 2024 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728042918; x=1728647718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTaeamx6DcDUAZ9BpfuVVEl85CSz9b541yZH8Gp9Gkk=;
        b=fFx1/JX9eoe+64XPdM6zVjGuUXYuOUV0QwDSk9hGDXcYo15L2V3G1Gj0yH1f/pwVXW
         ranYZL9P5RMNObO3Jcm54/q+DJc8dc9kE6RsCb6ScBabFOEnLJzmkxv3q5DrWCsVaukE
         Jom/E1KjCqZJnq25xvi0Y0egkvCh9kSnKJsmOqNP3ETBi1YEy6UYq4/BrB47Xx0i6BnO
         K3XugRyEEjFYfSkvxiowsmEB+XiGuvK/vCxn6zXiFrx8yv5fq6vhcR16HVaPgg6MfnY9
         DvRCQ3Ut/nFZ7Rn6eV40UcZgtu23pMsqMYZCeYgaqavEKup2oYntn/OXCTX4e2bHllz+
         WwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728042918; x=1728647718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTaeamx6DcDUAZ9BpfuVVEl85CSz9b541yZH8Gp9Gkk=;
        b=AsHQHjPb6DyhPKnxePI4IVBkAa0ovf/1NdjPv5SHprNT51YVyTZuyR823vf68gtnFC
         rpu2otCkIG2MNUeaYL6VK8pMmUrcIGUVqIFyFheftAU54aYfzWy0HSXH4hwXurqLSimd
         iHgHxzcfjAnjnPaVToYseif2v8gTydM32TwxRRon/m2oGW76gT2aI0Rj3Um1rAMkT95I
         rLu0dNp/dc7m9w4Fk4f9D+XPJ1h/phR7NC+E9NkGK1JU2JAJABrwFV1K7iHXa5tY0khR
         6WvbQVSlMdJr4QXB85euKZ99F2YOjfmnZSkBU63M0dTvE/TlmcT1VF7++eU90F1w8W8G
         wPww==
X-Forwarded-Encrypted: i=1; AJvYcCXb0kEc9uxZKJnyUcX8+5SLs6XOf8absSj3r0F0qJha6yQYmIKJjs9PsAHVOtv95OcaI4TBQCweAAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTx6wgSu4/lAwWmQYv9Kb/nOmGAa32dF0DHteOUpTIdLwWyFHi
	ImQSPSjuSJhF7V2R5WTyOqwIxqkySBVZABLDcbPjDvFnBWHzLQsvoKAoNy8Tvle/R3h032RH9du
	Y6xPie/Z6sSPA608k8iSidjNkr+jIf7dWiNnWdMgQZOUCOARF
X-Google-Smtp-Source: AGHT+IFOHbZCszBR3ogOu1f/JhER/gzMihu7gc5SjpNsnu2X6RNavWmU6/W2zmAtwXas+DdPqNCvqMeG+iyhpAHKMzo=
X-Received: by 2002:a05:6902:11ce:b0:e26:bea:9580 with SMTP id
 3f1490d57ef6-e28939513f8mr1470314276.53.1728042918520; Fri, 04 Oct 2024
 04:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <dfde5172-c1b7-4c22-94ab-87a1d5d5ee9d@intel.com> <CAK00qKAOd9_bSGs8sxaZjOjkpw3ge-jzXdmkZMcFmm=eg70KVQ@mail.gmail.com>
In-Reply-To: <CAK00qKAOd9_bSGs8sxaZjOjkpw3ge-jzXdmkZMcFmm=eg70KVQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Oct 2024 13:54:42 +0200
Message-ID: <CAPDyKFqrSS=AhcQxVET9V_SN008Cu=n5PuBF70_yBt2CDjMK-w@mail.gmail.com>
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sept 2024 at 12:47, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf
>
> Sorry for bothering you.
> In this series of patches I have reached the final comments of the sdhci =
parts.
> Please help review this series of patches.
> I hope to get your feedback to confirm whether there are any needs to
> be modified.
> If you already have a closer look at a paragraph in the series, could
> you let me know your opinions first.
> I look forward to your reply.

Hi Victor,

Just wanted to let you know that I have re-started the review. I am
looking at patch7 right now. Hopefully I should be able to complete
the review later today or on Monday.

Kind regards
Uffe


>
> Thanks, Victor Shih
>
> On Wed, Sep 18, 2024 at 12:47=E2=80=AFPM Adrian Hunter <adrian.hunter@int=
el.com> wrote:
> >
> > On 13/09/24 13:28, Victor Shih wrote:
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > > These patches[1] support UHS-II and fix GL9755 and GL9767
> > > UHS-II compatibility.
> > >
> > > About UHS-II, roughly deal with the following three parts:
> > > 1) A UHS-II detection and initialization:
> > > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> > >   Sequence[2]).
> > > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequen=
ce
> > >   [2]).
> > > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is inclu=
de
> > >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> > >   Setting Register Setup Sequence.
> > >
> > > 2) Send Legacy SD command through SD-TRAN
> > > - Encapsulated SD packets are defined in SD-TRAN in order to ensure L=
egacy
> > >   SD compatibility and preserve Legacy SD infrastructures (Section 7.=
1.1
> > >   Packet Types and Format Overview[3]).
> > > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UH=
S-II
> > >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2=
]).
> > >
> > > 3) UHS-II Interrupt
> > > - Except for UHS-II error interrupts, most interrupts share the origi=
nal
> > >   interrupt registers.
> > >
> > > Patch structure
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > patch#1-#7:  for core
> > > patch#8-#20: for sdhci
> > > patch#21:    for GL9755
> > > patch#22:    for GL9767
> > >
> > > Tests
> > > =3D=3D=3D=3D=3D
> > > Ran 'dd' command to evaluate the performance 3 times:
> > > (SanDisk UHS-II card on GL9755 controller)
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 85.5MB/s 56.3MB/s
> > > UHS-II enabled         :  182MB/s 75.5MB/s
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 86.7MB/s 52.1MB/s
> > > UHS-II enabled         :  179MB/s 77.6MB/s
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 85.8MB/s 49.1MB/s
> > > UHS-II enabled         :  181MB/s 89.8MB/s
> > > (SanDisk UHS-II card on GL9767 controller)
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 81.9MB/s 49.0MB/s
> > > UHS-II enabled         :  186MB/s 87.9MB/s
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 80.8MB/s 53.5MB/s
> > > UHS-II enabled         :  192MB/s 87.3MB/s
> > >                              Read    Write
> > > UHS-II disabled (UHS-I): 81.0MB/s 53.9MB/s
> > > UHS-II enabled         :  199MB/s 73.6MB/s
> > >
> > > Test command
> > > =3D=3D=3D=3D=3D
> > > Read: dd if=3D/dev/mmcxxx of=3D/dev/null bs=3D4096k count=3D2000 ifla=
g=3Ddirect
> > > Write:dd if=3D/dev/zero of=3D/dev/mmcxxx bs=3D4096k count=3D2000 ofla=
g=3Ddirect
> > >
> > > Changes in v22 (September. 13, 2024)
> > > * Rebase on latest mmc/next.
> > > * Adjust patch order to avoid defined but nt used warnings:
> > >   v21 patch#18 to v22 patch#14.
> > >   v21 patch#14 to v22 patch#15.
> > >   v21 patch#15 to v22 patch#16.
> > >   v21 patch#16 to v22 patch#18.
> > > * Patch#14: Remove unnecessary code to avoid defined but not used war=
nings.
> > > * Patch#15: Add necessary code to avoid defined but not used warnings=
.
> > > * Patch#16: Remove unnecessary code to avoid defined but not used war=
nings.
> > >             Modify commit message.
> > > * Patch#17: Remove unnecessary code to avoid defined but not used war=
nings.
> > > * Patch#18: Add necessary code to avoid defined but not used warnings=
.
> >
> > For SDHCI:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> >
