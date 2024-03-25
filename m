Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2714D28A
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332174; cv=none; b=HFnmonnV6QiO8H7be9l1f8oMtGImswbyfchmCY2Pr3tcmMBFQN0SoWUCVjHWyyHwJkma21ZMzyfkxkNFP/mcDc1RzT4F3D9u87jA7HMRHx7zKrCMqENDmLM6vTBm5GmR6dlRkznhwGCTsCcI4TH1vsD8w86HzvdrqTrB2RI4RJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332174; c=relaxed/simple;
	bh=r9B98m2a8dZ0bmDDC3obEW4AWL7V1A9bqVt8onHT71A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiWXF0GeVW+KlK1rsvqCn/D1Ji+os36vr3I/mIsvp8QcKcXd6vyLOom3Uh2Tv/KNdFVlV/6CTDNO8tk+UFbajZNR8B8ehnrnIHaAOe61hDET7NgPbUcQG79vOMwn/VVgHR8J3QyUejK3WRQtJloVdH/GZHi4QV/DmILER0HImtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BMoL2ktH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BMoL2ktH"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 402843F630
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 02:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711332163;
	bh=+mIvzsZciY5ySPQ+G6tsFtbRNob9H1jOM+O8s2gDVJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BMoL2ktH1qx7snnVhmYWji0Igw5QkyvgLAs6L+u10zr/JeWW9J9K4yS3ZsnHzTkj6
	 caNWBaSC/9c4hAhFT8GQD+iPLKqVElHfjLkxrisr7+AvTI1RVJr0LN1B8t/azrZH30
	 LHmnmsPtm4rbCuzPijUOTo6RBHob7FJDt4uJtqW7vquBJWlY/TwtaTsiJAgEwclexT
	 giwQ90DGHLaImtJq/uxNvDU1bWj0HlbYwoGjYABkV+SxZVnUTahe4Gxf6skfeCvLVF
	 Oj99E7aElot9ASgSt/oOwd4fmB+LDgcRXvi3FPTwW2RyzwB6MEGOSpy+KwY6NraJ8m
	 dt60nWaFfGkhw==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29f820081easo3463382a91.3
        for <linux-mmc@vger.kernel.org>; Sun, 24 Mar 2024 19:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711332160; x=1711936960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mIvzsZciY5ySPQ+G6tsFtbRNob9H1jOM+O8s2gDVJ4=;
        b=nge1MSPx5fJK4mgZFshKxtml3fisSclo07dYGhC+kdR+GwvgRvF9bDwYkC/ykg5Wmq
         hu3IQYbFxzFqFZV2CT5ROYpQHSJOl99+HXPKXrW1IAkjkumv2/nBOTzWWsfO0zOQNdlB
         gMFhR67pr/XpSTp132Vcw6yECtYYhj00CS/hoKaruwrKkudYMNNa6GDTJOYkk70w9wb9
         SKzNbg1UNdYHxC0/Cl3tp9Lb4o/RqxJQpoiYwRdzH74ExLcwvnicBzKlYU33yIK2GNiM
         W0EGWg6IfMy4Ci6yBPs7WDjPlVdu4lxEQqrOyniXls7GwQ76rHZaXQgt2lJ+jZRuUF8f
         GqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXCkL6dY0Xq7Rzgd1sdKxPrU2VuWZl6Ho/o/Sm9f4tirFUEFSWeo7RdtJL4EwAWtgmpAgTrf48Gd+CmJOoTEDMTA5WGZ37kxA3
X-Gm-Message-State: AOJu0Yy+jFXls7m4j3wpmauPjH6+gLo92Ra+XeAUHyU13DlzsJkGS+Ss
	Vxo750anwDousyJKB1qP8X2D8fsW5rbdjfKBAFYqKfzzQp00kyn+7J/9/au7a4DGy5+U6VvFXQb
	sOLFwj41y8GLur0Ly5pCgOVOv3gF6CfU33VnaeHdAisBRrU8QRC9PRkU5bAXx+Pv/va0zOY/m8+
	KY4x2pX/z8l5Y3zEQUb9/02fn+GMWhFJWNDtCfvQJ0/UEyph5I
X-Received: by 2002:a17:90a:f305:b0:29d:e004:f8ce with SMTP id ca5-20020a17090af30500b0029de004f8cemr4659463pjb.6.1711332159844;
        Sun, 24 Mar 2024 19:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdgo5FDJzC6NeqQqpgbGFtMGSoVZp9BqWYX8x2dG/6JMT5Lw6ZI0PR/TgTb83gGW2BD44epryd1XgAsZ7KfBs=
X-Received: by 2002:a17:90a:f305:b0:29d:e004:f8ce with SMTP id
 ca5-20020a17090af30500b0029de004f8cemr4659443pjb.6.1711332159386; Sun, 24 Mar
 2024 19:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAd53p52fi_wr3Js9Rqct+i1D3rjrnVZ6tBN=uHqThM7UvzXQA@mail.gmail.com>
 <20240322164311.GA1367151@bhelgaas>
In-Reply-To: <20240322164311.GA1367151@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 25 Mar 2024 10:02:27 +0800
Message-ID: <CAAd53p53NjYsYctrb6oknXVTMEq919nfVvrK17EBXwsGCxvtbA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, Ben Chuang <benchuanggli@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 12:43=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, Mar 21, 2024 at 06:05:33PM +0800, Kai-Heng Feng wrote:
> > On Sat, Jan 20, 2024 at 6:41=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Thu, Jan 18, 2024 at 02:40:50PM +0800, Kai-Heng Feng wrote:
> > > > On Sat, Jan 13, 2024 at 1:37=E2=80=AFAM Bjorn Helgaas <helgaas@kern=
el.org> wrote:
> > > > > On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote:
> > > > > > On Sat, Jan 6, 2024 at 5:19=E2=80=AFAM Bjorn Helgaas <helgaas@k=
ernel.org> wrote:
> > > > > > > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote=
:
> > > > > > > > Spamming `lspci -vv` can still observe the replay timer tim=
eout error
> > > > > > > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750=
: Mask the
> > > > > > > > replay timer timeout of AER"), albeit with a lower reproduc=
e rate.
> > > > > > >
> > > > > > > I'm not sure what this is telling me.  By "spamming `lspci -v=
v`, do
> > > > > > > you mean that if you run lspci continually, you still see Rep=
lay Timer
> > > > > > > Timeout logged, e.g.,
> > > > > > >
> > > > > > >   CESta:        ... Timeout+
> > > > > >
> > > > > > Yes it's logged and the AER IRQ is raised.
> > > > >
> > > > > IIUC the AER IRQ is the important thing.
> > > > >
> > > > > Neither 015c9cbcf0ad nor this patch affects logging in
> > > > > PCI_ERR_COR_STATUS, so the lspci output won't change and mentioni=
ng it
> > > > > here doesn't add useful information.
> > > >
> > > > You are right. That's just a way to access config space to reproduc=
e
> > > > the issue.
> > >
> > > Oh, I think I completely misunderstood you!  I thought you were sayin=
g
> > > that suspending the device caused the PCI_ERR_COR_REP_TIMER error, an=
d
> > > you happened to see that it was logged when you ran lspci.
> >
> > Both running lspci and suspending the device can observe the error,
> > because both are accessing the config space.
> >
> > > But I guess you mean that running lspci actually *causes* the error?
> > > I.e., lspci does a config access while we're suspending the device
> > > causes the error, and the config access itself causes the error, whic=
h
> > > causes the ERR_COR message and ultimately the AER interrupt, and that
> > > interrupt prevents the system suspend.
> >
> > My point was that any kind of PCI config access can cause the error.
> > Using lspci is just make the error more easier to reproduce.
> >
> > > If that's the case, I wonder if this is a generic problem that could
> > > happen with *any* device, not just GL975x.
> >
> > For now, it's just GL975x.
> >
> > > What power state do we put the GL975x in during system suspend?
> > > D3hot?  D3cold?  Is there anything that prevents config access while
> > > we suspend it?
> >
> > The target device state is D3hot.
> > However, the issue happens when the devices is in D0, when the PCI
> > core is saving the device's config space.
> >
> > So I think the issue isn't related to the device state.
> >
> > > We do have dev->block_cfg_access, and there's a comment that says
> > > "we're required to prevent config accesses during D-state
> > > transitions," but I don't see it being used during D-state
> > > transitions.
> >
> > Yes, there isn't any D-state change happens here.
>
> So the timeout happens sometimes on any config accesses to the device,
> no matter what the power state is?

Yes.

> If that's the case, why do the
> masking in the suspend/resume callbacks?

Because there's no functional impact when the error happens, other
than suspend/resume.

>
> If it's not related to a power state change, it sounds like something
> that should be a quirk or done at probe time.

Sure, I'll change that to be done at probe time.

Kai-Heng

>
> Bjorn
