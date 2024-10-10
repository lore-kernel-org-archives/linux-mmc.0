Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F0E1BC9FE
	for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554260; cv=none; b=bvyRfBw3j05GbZKo5b78DJIHv+tdbT52JnOGOxzYt6LCjuor9jh5AjnTnrI1KoYZLIRqoz85qNBxnHZl1BpqeDiiF5PljpqwCLBTia+HVYVmmh5CV1G6aTOmMcZciC5j2KbMBgGfQOWqa9SPcRzzUXRcIAtS7NAtBqQxDJcCFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554260; c=relaxed/simple;
	bh=dJ57paU3yob7a98B5OTRsIY7OeCtfujMFlrYsNqU8PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbCyE4ajafqYnY40E+WuHIzlg0z+wpReRbg50pW8j3HM/LoGvRIvCfYKaQUWbACGyRO5rXxDTx5I0S3e37EvfkHBL/FGbLaDGlAVMG3o/Mx+HHeRbX9Z2niQ6hMe5JhrD2d738aoWxYMfKCoV4WMzh2l4NmiC8UARwmIUkPCIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YT5jwcCk; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YT5jwcCk"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e03caab48a2so562193276.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2024 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728554258; x=1729159058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2ArA4ZcoREZanu8i6/c0JbOGoOWnzH6250enjQ0frk=;
        b=YT5jwcCkqs8gCzvkaW6EQFS8XxibjtMZnbStmPqAExpyFwzXGZKxcUdX6AB40AWlNx
         HKDS/V+kFwgc2YUStqkKc8+IBLfkNPRW2azad1Sl56Du6MnTTz6k0UkSzzjv1bgYxKuT
         Acu4RW/k9r2tNlt//BEX1moyp8/w2mwtHsG0gw+ozLIlLhLmIjqDVBpOitMhpV0N7N8J
         3yvUif/yPhH+8JR3Ai9OkXv7co7rVrDfMX6LJ85O17stjxBMXQ3BTo0VOhUuo+JVxIcI
         82ovVsrk+2yeGMWHvtsnrtHFcQUfTuY3FcwJ0bXx856/LUKZCaiBG4dFYiAPh9RGj1+b
         lG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728554258; x=1729159058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2ArA4ZcoREZanu8i6/c0JbOGoOWnzH6250enjQ0frk=;
        b=ZQ25CQZe7WTeS7QUXlDRBAouta9uKGQpyMv5L/7X+QDGlDWenX0Jb+VtPxnrlBsNXf
         CafM2opGHz7jNPrKruRdrBEvJPRWjj5X+VIbPaOAp8MKXcFoFh5yz4Wjj6VWSwmTVfAD
         ZgBgMwTISR33PoupMQp7DzEcHp4Uxl9ZodtdYdW1Hs4i/ywFSkvYOrHRoe/6NzVl4zqr
         qnf4cjHOQ0flGv8lihXTYdJq/oAnCEOzP/oOF/14hC5HLY2L8Asc9xPd5DqBG66p6/yj
         PvtH2QToAYCCMhrNlTAQgi7kmJc/X0JV+bFhjuq/FJtpE7vgeuIcM/06aAXA/g4RkL4X
         N9sg==
X-Forwarded-Encrypted: i=1; AJvYcCVKGjaJdG5vP7FsGcKCMwGW0ZW/9vrSLU9pG+QjJKGXj86AQdKBp82N+ZkoIBumj1vvsOPeC6isxyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBA31ubE0wbDxucaVVCSnma48SBhjBSygxC9WavevCn/6GszO0
	yd+g8sXgSh8d+J7Qq/EOf+0X4T837MGOHoHcFi18uMUdriyvgPx8cHGX+kUVfea8ImSG+2OMtm5
	hhqVfK/hEeuqC0uBunESsHUIIqc+iMUzVPhjuhw==
X-Google-Smtp-Source: AGHT+IFutXdu1n6F87Ao7/fpG55G3IQ3I7av3UbOLSvXJvC0UI/LJPXg6XG5U7GQSsXzAx+mdlHswYAlQWxtVCzTHio=
X-Received: by 2002:a05:6902:140e:b0:e16:4ca7:7acf with SMTP id
 3f1490d57ef6-e290b7cefa9mr1978248276.10.1728554258022; Thu, 10 Oct 2024
 02:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <CAPDyKFoHrRGYkNCu0ev8iF6e8tQV7cbTAxm9jS0CCqvizmoWmw@mail.gmail.com> <CAK00qKAUg5VFkxbrYUeFjRq+3UN2dcOZ0RJFDK2e3tCxKOJNLQ@mail.gmail.com>
In-Reply-To: <CAK00qKAUg5VFkxbrYUeFjRq+3UN2dcOZ0RJFDK2e3tCxKOJNLQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Oct 2024 11:57:00 +0200
Message-ID: <CAPDyKFqhbt-u8qRCfvssSBDT5RUchj6gJj=4a75dEdpp++emdg@mail.gmail.com>
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2024 at 08:20, Victor Shih <victorshihgli@gmail.com> wrote:
>
> On Mon, Oct 7, 2024 at 11:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Fri, 13 Sept 2024 at 12:28, Victor Shih <victorshihgli@gmail.com> wr=
ote:
> > >
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
> >
> > Patch 1 -> 6 applied for next, with some minor updates to patch2.
> >
> > Patch 7 needs some more work, I will comment on that separately.
> >
> > I am okay with patch 8 -> 22, but since there will be a re-spin for a
> > new version, perhaps you can run a new round of checkpatch.pl to see
> > if some of the warning that it reports can be fixed too.
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> Hi, Ulf
>
> I really appreciate your reply and I will resend the new series of
> patches before the end of next week.
> Do I need to include patch 1 to patch 6 when re-sending the new series
> of patches?
> Or should patch 7 to patch 22 be sufficient?

Hi Victor,

Patch 7 to 22 is sufficient. Just rebase the series on top of the
mmc-tree's next branch, then you should be good to go.

Kind regards
Uffe
