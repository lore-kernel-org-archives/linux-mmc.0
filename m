Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB54C83;
	Fri, 25 Oct 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828834; cv=none; b=uOfZPqNdYYtiuCrC5paBdO2p9n/u8C3qLu1Qv42SzCL4H7kUMXWfpgLpJz2nmDlfDTiN/6dL/z/lGXY4qTtwOFxWm1fC2EYE1xgG3zp4+B+qFyDLcpWDqrsiE8mt7e0jZiPECerDTVTgbNxMAbVdzxiqGtCuRRX8G4V2CJQ/LTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828834; c=relaxed/simple;
	bh=UnfumKbSXfD3Ri0PbWi/59CBARSG+OKlibkeKR7+clY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbJIIzMfTEtrUmmnBVvPyM3vQQOO+hFeqNfwuARcgNIF0DIf7EsOTN9WcFYF8WWfbGgJ5MtiL2eQNi2PNfj16lk4hclgs3F3sWw++wakLga0aif9Jk+r0yBWTXI2F4gyooTCMP13TJw1p4owyY6qyz04NFHUIYvNvqZZbP3eODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrjgMvEm; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrjgMvEm"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d3d2d0775so494580e0c.3;
        Thu, 24 Oct 2024 21:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729828831; x=1730433631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFr9jApJlHsRumVXS3aswqFDdSiZBz50eoTObyEuo78=;
        b=SrjgMvEmnGeD2kG3Bdis79FUIBx4n5JUkKdyhEpZym2re40ohE0U/GR+WfYd/cEMzZ
         QdsR0iaI9fOPzeM6uVQjOAlR/W6To3phrdLpXZn6u0pHw7OpHBURqpSTMNWLJxFYQINd
         ELsuKqhH9iUxYqbq3WFe9TgntO1vh2Tpamtnz1q1e4mNThxOw+4RuecDpL6SrnLypsfe
         BdV2lSpKxgsnahx0Xuy5WWxAqdGrnRu0i7qo1nPIwcF5Wdfsz71+cNltZ5ottMePC6Rc
         XGzrvdVvWuJZ/I/A0zEpyNLbLDIGvUZKYpSRUQahqfmjgMAPnOxRSackErD45EMfSOMD
         xbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729828831; x=1730433631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFr9jApJlHsRumVXS3aswqFDdSiZBz50eoTObyEuo78=;
        b=sFg5jD9r5kfJzp+S/wT5IIssibrdydO8BMnOXTTUBZI5WYm/tCcNRLapn18u0pAqja
         GgICJD4WuBYnfUcMd27NXemb3jSda1p5ikGPFjT2aVdgCujapv54QrcXw0+8O6c8Sjfy
         koTV3/3jNOEPRL3rLN6ZZpLmyfWizHLlJTYKbz2rJq0TBYQwBDGufBVG7MBwzvuPmS0D
         gIrlMJomyVNigQjaVscKd9lDQJVcqgYKobSHIPnuwt1eGQsXKau8YLu+f1q4AL1xNrVR
         b2XrdG6e9ZQ4pWzfvv8CdI6YZ/nN858SWzrvlVb7geid2wGmZVPxCZCE57XipuyNr2A6
         PZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfGwmXsJ5sj5hP55T7DsOeLusLP3jxPdCMAGC6toGZT+fTqgVCtLQXHwRsYGf0n0givp765m0YStn/kIk=@vger.kernel.org, AJvYcCWFKkSnvWfi1NCigAPGrhHuM457V48oshPIZU5lOtDdgiX6++K4wrxZoEoqAhjJ11IzUsE/7MBPbKy9@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsUNJ//JcXS27eZsfKdqCbQNPGRwjK3hJ2rt7qt1mG1kE8qSW
	Z79/xe5fQNoTZfx0vyFsxPgFibZB1wSsatN4UvPrG3ov4H1lwn2B/Ph23JSr+BKfbCvIjYKN2h9
	aB+jYoxf6jgxkZ/zteTDHkWJ+Fsk=
X-Google-Smtp-Source: AGHT+IGN7ZpaB7MTYq/uoBJE/mRK0YyYLcQ+X//Q8/O3AY8fPDzvH5HNwKhOvy8XFwKhir1RMTvBdK5793BTFkfx8Pg=
X-Received: by 2002:a05:6122:1d42:b0:50d:3ec1:154b with SMTP id
 71dfb90a1353d-50fd01bdbfemr10050003e0c.3.1729828831128; Thu, 24 Oct 2024
 21:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105333.4569-1-victorshihgli@gmail.com> <CAPDyKFrgwmPaAnv3CgH=rL9yV4JfbF9mX6nt+Wy=2OUphadZJQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrgwmPaAnv3CgH=rL9yV4JfbF9mX6nt+Wy=2OUphadZJQ@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 25 Oct 2024 12:00:20 +0800
Message-ID: <CAK00qKAs0yt=1eG5B==9y48TteyBnM7n3nR1ogGP8AWGOxzvXg@mail.gmail.com>
Subject: Re: [PATCH V23 00/16] Add support UHS-II for GL9755 and GL9767
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 8:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 18 Oct 2024 at 12:53, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
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
> > patch#1:     for core
> > patch#2-#14: for sdhci
> > patch#15:    for GL9755
> > patch#16:    for GL9767
> >
> > Tests
> > =3D=3D=3D=3D=3D
> > Ran 'dd' command to evaluate the performance 3 times:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 81.9MB/s 51.4MB/s
> > UHS-II enabled         :  206MB/s 80.5MB/s
> >                              Read    Write
> > UHS-II disabled (UHS-I): 82.3MB/s 49.7MB/s
> > UHS-II enabled         :  208MB/s 80.8MB/s
> >                              Read    Write
> > UHS-II disabled (UHS-I): 82.9MB/s 50.8MB/s
> > UHS-II enabled         :  205MB/s 90.0MB/s
> > (SanDisk UHS-II card on GL9767 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 83.5MB/s 50.5MB/s
> > UHS-II enabled         :  200MB/s 75.3MB/s
> >                              Read    Write
> > UHS-II disabled (UHS-I): 85.2MB/s 56.3MB/s
> > UHS-II enabled         :  203MB/s 75.8MB/s
> >                              Read    Write
> > UHS-II disabled (UHS-I): 82.9MB/s 51.1MB/s
> > UHS-II enabled         :  196MB/s 77.8MB/s
> >
> > Test command
> > =3D=3D=3D=3D=3D
> > Read: dd if=3D/dev/mmcxxx of=3D/dev/null bs=3D4096k count=3D2000 iflag=
=3Ddirect
> > Write:dd if=3D/dev/zero of=3D/dev/mmcxxx bs=3D4096k count=3D2000 oflag=
=3Ddirect
> >
> > Changes in v23 (October. 18, 2024)
> > * Rebase on latest mmc/next.
> > * Version 22 patch#1-patch#6 have already been applied to the mmc/next
> >   branch, so the patch order for version 23 has been shifted forward.
> > * Patch#1: Remove mmc_uhs2_card_prepare_cmd() function.
> >            Remove mmc_sd_can_poweroff_notify() function.
> >            Modify ios.timing setting in the sd_uhs2_power_off() functio=
n.
> >            Restore the position of assign the host->card to original
> >            position in the sd_uhs2_init_card() function.
> >            Remove unnecessary error handle in the sd_uhs2_init_card()
> >            function.
> >            Add oldcard judgment to skip some programs in the
> >            sd_uhs2_legacy_init() function.
> >            Remove unnecessary error handle in the sd_uhs2_legacy_init()
> >            function.
> >            Remove mmc_card_set_present() function in the
> >            sd_uhs2_reinit()function.
>
> I have queued this up for next, with a few amendments and added
> Adrian's acks to the SDHCI patches.
>
> When applying, I made a couple of cleanups and fixed
> sd_uhs2_power_off() to patch 1. I also took care of the checkpatch
> warnings for the SDHCI patches.
>
> That said, there are still some issues that remain to be fixed, but
> let's do that on top of the $subject series. See below:
>
> *) The error/re-init path of the card is broken, as also pointed out
> by Adrian. I will work on this shortly and send patches to fix this
> up, please help to review and test.
> *) We should read the card's ext registers, to for example enable the
> card's internal cache to be used.
> *) We should avoid unnecessary commands during re-init of the card, to
> decrease latency.
> *) During suspend, we should probably send the go-dormant command with
> the hibernate bit, rather than just doing a plain power-off.
>
> [...]
>
> Thanks and kind regards
> Uffe

Hi, Ulf and Adrian

I got it.
I will continue to discuss and implement the above issues with you and
offer any help I can.
Finally, thank you very much for your help and advice on this series of pat=
ches.

Thanks, Victor Shih
