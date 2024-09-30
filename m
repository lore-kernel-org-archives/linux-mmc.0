Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1118A6B9;
	Mon, 30 Sep 2024 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693230; cv=none; b=AryRCe2mfH0HMd+wSuOnms1QQVwi/dpU8QqwQ7qJc9auyoV3KjxXw1SAhszN7JjyYCoH1/h0s6zTHJCiMEFbQbq6W+YDqfz7Aua+wX5wEVpr4AJPprYYtOvywPtGKjMIcyJRwf/JUMO7Gwn9H7rEyYP12Y48nMUXCU7rj9YHk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693230; c=relaxed/simple;
	bh=ukDCgE9s2AovRNuGCZZupL6hqRs08UhDNcHSSHqB7Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkfqvNb7I2+vQ8nu5AECzXcWs08S+ZqqAFNsZ9Xz8Bn2WtLiiZJowLogk97BoQJdSdDbZlEcm+Rv/oAGa6PlZjdLjMVnTEdAJOsqdobCvzc/sRGMpG4C9behwIF5ajRvWNiVlqEXpyJEw9QG5gj1BZPKYybunxNqL/EsqVfF4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfA1IYSo; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfA1IYSo"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a3a4432737so1633758137.1;
        Mon, 30 Sep 2024 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727693227; x=1728298027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLyQGxOZrKZO5tcIaOz8q5jNB5R5IP/eTsdnigI4MkQ=;
        b=NfA1IYSoUOFm1OKcxYo+nooJoYBQRD2iSelhHlDQeco4fzcTi7/E7YR2Tstrr26TKG
         IjcMltFVFNy3JjnWd+LCYQtmo18FRygamzs3c9mOk9ZMnNvU9S9KDT3+krJAPwl/SW8P
         9mqlLWZq+ACf5sWPaMYfrcJbl8G69ro+VVUCU74zqiHzutNUv8kjk5gYcd5cn4csYG7X
         Ic8Wx0tuVOUWRiUZfsPgQGM8w6YUmEYNOn2lwGQiVroTEdcfUgRf6sYuR5F8nFwORCZV
         eR18dzBMcpiBOAQYfwjYtkN5d7faeUvvidfRx3Ivu4+WIQ45iGmvjtyj6OBwWkg4ZmQm
         PKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693227; x=1728298027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLyQGxOZrKZO5tcIaOz8q5jNB5R5IP/eTsdnigI4MkQ=;
        b=UlcWBwagEg8mu4BRtRzErWve35rCv8p0ZgVZOdltxpCUAJWlFBfl9vX67t5Pae1Iay
         Y64BOOJlwdNDXcQ5RDxt7nL/12z4RmDia7ASuM+6RdUeIU0Tl6lU5amQe7rm9FepIhI2
         /QECdh1ExQdyis+e1skDuu+LyCAYZ+T9pSROBtLauYrJcAWvNzyNdvvUc2RIKzklwmfh
         NNAO/LyKE3tXd2Pni4dcypqKDGUxl7i36MDpSc0MkgU4rnNOWeoG3ZxLGm1yFsKtXrZc
         TbgKXz63iM8AtCVZHhehgN/iD6mgDoJGnTTn4ghJ/NMmzDhQ1aUkd2fwPz9DU4dseJfI
         gOsg==
X-Forwarded-Encrypted: i=1; AJvYcCUNGRsTGoeoZcc+RcAqVeDOczEbu6rmPmT+cJxm2tCkWosTsZRY40mztS/jTCkAWeLWhG9tUTxrrCP2O2I=@vger.kernel.org, AJvYcCUfur9g5rcnVhcrS8wE/22btzg55XB9V4HnYm6n/V8LtqmoSMWyd17pfCURngnVg32acSeZcpPf5L8P@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVix28Ix7FnIVVnTVjdDgJ7JLZw1nvL1YXDJ9EcZgHjmUA7sS
	IBtkitEK49j17NWqNc45Zj2QP7Lz8yuhALBjZeQO1V9Re++cDTXLSxbM4MGDdtNVukhfenj5UYq
	QCg+T4zw6rU2IOx2/TeAVBjkmv6g=
X-Google-Smtp-Source: AGHT+IHF6iVBDwvd3Mixp43xIgyVVdaxVV94p2ExCeILDckhXdcytdgE6PFplsRLYlRblB0dBJz8gEkhuXfqahjxEu8=
X-Received: by 2002:a05:6102:f0d:b0:48f:b5c1:7269 with SMTP id
 ada2fe7eead31-4a28a162b7emr7204742137.0.1727693227497; Mon, 30 Sep 2024
 03:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com> <dfde5172-c1b7-4c22-94ab-87a1d5d5ee9d@intel.com>
In-Reply-To: <dfde5172-c1b7-4c22-94ab-87a1d5d5ee9d@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Mon, 30 Sep 2024 18:46:55 +0800
Message-ID: <CAK00qKAOd9_bSGs8sxaZjOjkpw3ge-jzXdmkZMcFmm=eg70KVQ@mail.gmail.com>
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ulf

Sorry for bothering you.
In this series of patches I have reached the final comments of the sdhci pa=
rts.
Please help review this series of patches.
I hope to get your feedback to confirm whether there are any needs to
be modified.
If you already have a closer look at a paragraph in the series, could
you let me know your opinions first.
I look forward to your reply.

Thanks, Victor Shih

On Wed, Sep 18, 2024 at 12:47=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 13/09/24 13:28, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 and GL9767
> > UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7:  for core
> > patch#8-#20: for sdhci
> > patch#21:    for GL9755
> > patch#22:    for GL9767
> >
> > Tests
> > =3D=3D=3D=3D=3D
> > Ran 'dd' command to evaluate the performance 3 times:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 85.5MB/s 56.3MB/s
> > UHS-II enabled         :  182MB/s 75.5MB/s
> >                              Read    Write
> > UHS-II disabled (UHS-I): 86.7MB/s 52.1MB/s
> > UHS-II enabled         :  179MB/s 77.6MB/s
> >                              Read    Write
> > UHS-II disabled (UHS-I): 85.8MB/s 49.1MB/s
> > UHS-II enabled         :  181MB/s 89.8MB/s
> > (SanDisk UHS-II card on GL9767 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 81.9MB/s 49.0MB/s
> > UHS-II enabled         :  186MB/s 87.9MB/s
> >                              Read    Write
> > UHS-II disabled (UHS-I): 80.8MB/s 53.5MB/s
> > UHS-II enabled         :  192MB/s 87.3MB/s
> >                              Read    Write
> > UHS-II disabled (UHS-I): 81.0MB/s 53.9MB/s
> > UHS-II enabled         :  199MB/s 73.6MB/s
> >
> > Test command
> > =3D=3D=3D=3D=3D
> > Read: dd if=3D/dev/mmcxxx of=3D/dev/null bs=3D4096k count=3D2000 iflag=
=3Ddirect
> > Write:dd if=3D/dev/zero of=3D/dev/mmcxxx bs=3D4096k count=3D2000 oflag=
=3Ddirect
> >
> > Changes in v22 (September. 13, 2024)
> > * Rebase on latest mmc/next.
> > * Adjust patch order to avoid defined but nt used warnings:
> >   v21 patch#18 to v22 patch#14.
> >   v21 patch#14 to v22 patch#15.
> >   v21 patch#15 to v22 patch#16.
> >   v21 patch#16 to v22 patch#18.
> > * Patch#14: Remove unnecessary code to avoid defined but not used warni=
ngs.
> > * Patch#15: Add necessary code to avoid defined but not used warnings.
> > * Patch#16: Remove unnecessary code to avoid defined but not used warni=
ngs.
> >             Modify commit message.
> > * Patch#17: Remove unnecessary code to avoid defined but not used warni=
ngs.
> > * Patch#18: Add necessary code to avoid defined but not used warnings.
>
> For SDHCI:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>
