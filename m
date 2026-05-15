Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862453E1694
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876901; cv=pass; b=BAIyhZ495ZxyHv/Mxk58zcoQ579kmOjMi7Zeg5imeAeV8/4+r2eA+eQBJRK7yJIqrkI3ncNOyYwM8wIUU1aFNbnVLqMx+8+RuyIgUrrHAgx8EPojghRCSs2AjIO01HlBsKgWbAYjJpHThUuyaTjPIk2grwq0D7SNEVaGM8iHPMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876901; c=relaxed/simple;
	bh=zf+cfDTruj3lJZwMPhwNbfZGwoMmYdUvg50BEM3Yggk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUiMGOHVi1AgDqVAZolAT7O/SF4U3H4XjBmlI11uaqTbbo3Caq42PHn7zMqS2l0FaL/3xNQgmp495xg6vtXudSCNlVcVLjhmVJfdZpMqbUXWEuWpW7aPCje0pd4mg+XdtziqnBBeYVTqUbtk9d4yz51/sy0wfSSJgD0yDNaHIww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oduOYy8Z; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oduOYy8Z"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c80167f56cdso91952a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 13:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778876898; cv=none;
        d=google.com; s=arc-20240605;
        b=RF01SQbPlpi8JeupWD9WOYE6BCm+o6/jbvWB1m38Iu68sx304uhDjQKobilbjHZV+n
         Xt+dbUdEKkHO5iSQLrqfcHG1nD41m4JI15BTkqlpvo+1KG3/WriogVFZXWZI4jFwUvxr
         8dhg3Nsmb3IeHlV/jDHBEY0CXAON095fHuTAvhwzKkeXqOWIc5K1T36lb6dChn6WGw6K
         xDzvwwTyo+ke35Zlo1bAnk94Q4j3+guu9KF6V9D/rL8hQTlzWKbWHSe8hojxo8296MWH
         NM4JfeNdjeZvFoUIv+qeQceRR9aeaPoXYC11IKcEMTyP6liRP/V4FOm2BCMCk0emLwMO
         OaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S2uDCT92xR1s2yLFCu6vNIqsIjjLvILLfDk2ybhhXi8=;
        fh=Xn5gGOD0wfvxR3QQnaA7YlzIeHMppEapma8laY3ceNU=;
        b=iF5ypc0OkAuFGVJGeZ0n9I9Wb6r7TtP0yOmtsBW//7cmaEeH5q/tL1Eu7puzRiLxz4
         nYd6EAzx8wNmX0/zo4vRZBtcLV8PCpa534Ji5aJocpocdHRLQb0qEzjUZRix6bVFzQGe
         c4PqG2ysbS4jiEkXFApIm2IpMT+JJBy/7736TfhPPoCpsR9AALOf7y/BlxdcCjLanKuK
         BSWvVU2qM8c8fFt2q5w47g63Zx6BEkF5uL9Ufcg0ph/vP8wm2fC/+p7emxjbxDb05jKF
         fhmtpyyRzvBkc3F0MBGTQtTr0APIWjZhWVTP3dpqLg6OktW77/blfHjxy+py5GvLTs6V
         yQ4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778876898; x=1779481698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S2uDCT92xR1s2yLFCu6vNIqsIjjLvILLfDk2ybhhXi8=;
        b=oduOYy8ZIlF7C0ihUn96xT+W8/ruldAXhwwWci2QgIoMfluye/QotF0hGXjzkJPKKj
         WCctkXptX3bCWvIEgu+/UACi/BZkpxfsSASfE8Og6gwhbdOcWiWDUcBeFLyHNn7BmoZj
         LTHsZkqHcR1m1htXHu+4apPOwgRi9dn9gQwH0DjWcm2Jqx/KZjkgXespfpO8Olgimuht
         sABRKnzpOLs7M51HIKWXnxxti5VcCYpHvXSzFKbh99KDJWcCRvLXX6OmKMA6LNk6wC2R
         YPf7B5Yu44gBh6y51B7MjJRRh3I9lM3JPMvG3HZ/k6CHJBFnACYnj9AdTXpmfvs6Jkxx
         SKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876898; x=1779481698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2uDCT92xR1s2yLFCu6vNIqsIjjLvILLfDk2ybhhXi8=;
        b=dXpJNgfucv9QZ9/dELyQ3F0tDSIh4TlwRD01cFPpWXMpoOOImER/dB4lgtvsbi7cgO
         ygTmt1WC65XOs4MZjD6wBx2+R3TyfXBfWtenJA9oRHFo8Eu5So6H88OxL/NLl4/fyEpI
         PRQxmv2DwHpgwJ0TWS+Ob0pHyBLM+S4tEDhBJlkbQbeoIswOh82/F7KB6TLPa0NmR8rJ
         iKK9F5FM9HjcbzLSsMPabT00fHAVYX62TKhV5HT2H+ME2R6RLfayCkJepULCWNoJSVrj
         KUYkseW8sL8XHVdFGVqozT+aCHd1jyf1iVDPgtoQOfUN0Noejs37RdH9GWHOHNEoQtYm
         JXeQ==
X-Gm-Message-State: AOJu0YzWo/v3tJ6LVD35wnyx4SjW5dGJe925Kj+tQyteYWC4r93b/575
	/DKHcLT1RM9guzSTphQRCuOZR4hmiVnuZIb4IcBb51VXG5HVjtnbCDGIOQiMfGKpSBVHZufP+qG
	lZa64DwoWk+xkDGAR2S01j8MgZZqXgMATObY1
X-Gm-Gg: Acq92OG/MeUVhmAGYqCEob4tAaYfoE2DEE1hRfgC4ZMo93rrf8KcVR1kXP62GlUI16Q
	vsMVWRa4S+pGmrmW2GzmvnuT/Clboxapml3ahIb/FbgetUJ5QYdWxyZne3KiGAe+ozqhG9WVlwl
	reVL0dOb1ltKJlngYwTUD9ZdZfCZvQfzSKfQjq9C6LsOnbfZAHWsA9AHd895XS9KfKSCc+L139I
	ciquHJqLXb+MPoEwTYoLTMFtcS7uBKBXYEi/qdtq2+wPBWxl2xPPZxuKXVqMN9Ql4x3FhOtoo2L
	aHpEPP8Au5qHjKTrQJNEIhXZAhAonaHAwqfcfQ==
X-Received: by 2002:a05:6a20:939d:b0:3aa:c99b:5c64 with SMTP id
 adf61e73a8af0-3b22ec58a69mr6539486637.42.1778876897819; Fri, 15 May 2026
 13:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
 <DS1PR16MB675343BEA9DE94B268CDE927E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
 <CAL5DHTFvJfV1DVNjBLsdCQ8FP7TmNq0SK=EpA-2wWzdo4+FsRQ@mail.gmail.com> <DS1PR16MB6753295FF074D304308ADF78E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB6753295FF074D304308ADF78E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Torstein Eide <torsteine@gmail.com>
Date: Fri, 15 May 2026 22:28:05 +0200
X-Gm-Features: AVHnY4JpCtcM4nBwfd8akYRRpR9H-HQ-yPfs5FTSrsHaYLAEQ4szkegkXmimwts
Message-ID: <CAL5DHTGjVWOV=KuvR7foMPf6vqDWwRyKU6_eVtxOPhbJ9hAvpQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc-utils: improve lsmmc usability
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Torstein Eide <torsteine+linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

fre. 15. mai 2026 kl. 18:46 skrev Avri Altman <Avri.Altman@sandisk.com>:
>
> > > > Resend the lsmmc usability updates as an ordered series after the
> > > > previous submission could not be applied cleanly from patchwork or b4.
> > > >
> > > Thanks.  Still having some troubles applying it cleanly.
> > > Please make sure you are rebasing it on recent master.
> > > Will review your series anyway.
> > >
> > > Thanks,
> > > Avri
> > >
> >
> > The first patch serie i modified after  `git format-patch master` and did also fail
> > locally,
> >
> > in the new export  i only changed the subject and description in cover letter, I let
> > notice it was not happy when i try to apply the cover letter, but locally to a new
> > branch the all apply without issue.
> > I am unsure what i did wrong.
> Your local master seems to be behind upstream. The patches conflict with
> the CID date-fix series that landed recently (commits 6f6b6e1..2364dc6).
>
> Please do:
> git fetch origin
> git rebase origin/master
>
> Then re-export with git format-patch.
>
> Thanks,
> Avri

That makes sense that you have conflict, but not a other errors.
> >
> > > > This adds external manufacturer ID files, accepts /dev and
> > > > /sys/block paths for register reads, adds an mmc list command, and
> > > > installs bash completion for mmc- utils.
> > > >
> > > > Torstein Eide (4):
> > > >   mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
> > > >   mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
> > > >   mmc-utils: lsmmc: Add mmc list command
> > > >   mmc-utils: Add bash completion
> > > >
> > > >  Makefile           |  11 +-
> > > >  completion/mmc     |  62 +++++++
> > > >  docs/HOWTO.rst     |  77 +++++++-
> > > >  lsmmc.c            | 434 ++++++++++++++++++++++++++++-----------------
> > > >  mmc.c              |   6 +-
> > > >  mmc_cmds.h         |   1 +
> > > >  multimediacard.ids |  16 ++
> > > >  sdcard.ids         |  23 +++
> > > >  8 files changed, 452 insertions(+), 178 deletions(-)  create mode
> > > > 100644 completion/mmc  create mode 100644 multimediacard.ids  create
> > > > mode 100644 sdcard.ids
> > > >
> > > > --
> > > > 2.53.0
> > >
