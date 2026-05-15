Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4975305693
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883013; cv=pass; b=PA+K9VmiVyY11GzJjZ2uNVqVsRILdSnAw5NKl2PbYAmOGROd1y4XKeL7Yt9UztJ5WhhVWhDzQB7Kt2TXJdroR+1EUM3RwuTUO1sHKx7lZ/N7p5e3xupuIh/vKYSwy70woTm3pCKFYqNLhfsaOKxRu7qp+kMCo/xsPOnUsKBXV7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883013; c=relaxed/simple;
	bh=/2SsPHQjThXjMTGdvvRkqJDE7fzSQCoKx1NCSA0r31E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyQmiXd5cr24Ieqnk41qScq4Lh0Lh4/1HPA+qMj1x8Jw6IscHZXxw/5MztqgdHKyckd6cxoaNx7rnlN8pruhKeLc2SZUxDwMwRbVJJUSYTca5PMEGp1CKqfM7VXYdWHXLC5Cc4eWrBtiF/Z3bEyPz7ahBMSsToG1tVAt8cSEmVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La6sXmjN; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La6sXmjN"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso129825a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 15:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778883011; cv=none;
        d=google.com; s=arc-20240605;
        b=liupG5U6Dc3eIEhnkDR3eZQoKJUsnWBiH6bwdaaTor79vLuwGvLQMP7tzQwkrw5tPh
         xU+STxMeeJrLXlZN5gid1BvMQU1Gaif6JT8kmhYZpL6nLLjDx2Lq3TJNUO+EW0Gf9WN8
         /Z+ttqGthii2HRvI4sXNNPWjedvqdKVmjWmvljCmLGhXtNNR82TbOIfvRse/8TJ0iHry
         RgZqi5bWz0hqhJmlPanCt+2H7RuTKGbFCMTBNEanrqBZjrzo6tX0h2yl3OEVX0NrWUNG
         SuTIeE0/uCetOdCX3dOx/pw5pSl9BfYB3PsQfpEkNB3HWwv800sqRVB2BP/lrXsJhRVL
         8Ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9EXY/w/9VSswFgbA75YAw1RPVxPq4B/z+cWDTOohrfI=;
        fh=Xn5gGOD0wfvxR3QQnaA7YlzIeHMppEapma8laY3ceNU=;
        b=ZD7evF9zoGWVJJj4Dt1JRF/p1xVf1cU/05n3RX++YXTPdGiEufBptXlb/jdfkrlM6d
         w0fYDcJDdeRM579iPv2hqFE699AvCQchxLDyvE56S94ORXhx2IPYARKEi21r6bhgBnKu
         7XSgMW3qOBjAJeuuqiugd+5g0s7KPFEFygISvuZ2tSrVtelU0MQpMNLnmXl51ik2HPVK
         lrd/BVpB9L0ocEtP7Jw/nKLxSxNOXxmgl+wg7Gv1Pa6g7TcSD+xEUb8uTgHM+3alraro
         MiNZB3XQ4HMD3CXXHR6wU5yrAYiern/iLZ+X7iXR/alK0qpeWcEQ5gMhomTElSmjJT6a
         m2og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778883011; x=1779487811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9EXY/w/9VSswFgbA75YAw1RPVxPq4B/z+cWDTOohrfI=;
        b=La6sXmjN18/4C6qmSrleDcDl1W4O3DiaDAyLpal89hOHjKaIFL1KXQOFylQAKL2FUL
         MOSZxTdecz1tD/DumZ5H2MkAY4VLF65ZidouzUIT1XkJIbi/3vZ6DFdHwixG1SlqQX0o
         d4tn7gSr1crAbg7ixvanJps8kCcqvOV5jghBiFP6elUSptwTyTtxcrcvgw6AFF4mkjMy
         mvx2SYQwO3CwapCQPbZ7a7gZ2ad+Nvjyi62H+FotR0XcF/tLORGhnmunE9suG4XyALCC
         DyDp8CpXBT2Z0QQjZo6axO/Y7e++JiH1Eva0qd0KHcRFthqo/3DXaP0Zn+yiWk/pf9F2
         FsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883011; x=1779487811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EXY/w/9VSswFgbA75YAw1RPVxPq4B/z+cWDTOohrfI=;
        b=XjjiEK0Ky5zNX7IQyuy054m1REtUK5+aVNCBXGVOhSaxDUV4Ps0SjplazccHe2bE5c
         fWxGonrH7t7R+4EHleruGD8Hw1/CFz04mwjejYCTGtRG3VwazP1qVTG7eNu7zjx50cm6
         /gwdbbONphHsM+3WFQnz7v9QC+XOeyePiZlg80eZ9FwghE0/V1rE51NfKbm99JNmJj2f
         uVqfualJHqQrTHHIph+lFKgdzLEhQkSdNuCp/d7v4cC25WyrDK0UNRy7vDpZTXsTMCiT
         6wwqbs0ayKqj3wR9wYm7/WuD4R7shRlbzx7Om/I5ABF0Nv+H5F+4zZ/VE9f6V9/2+4KR
         2AHQ==
X-Gm-Message-State: AOJu0YwpipUSnB+5GzeMgAIt+qj0YSscWZNypToA7qh8Sp2NTJBtFBjK
	AVEMiyfZSsnxeVIXcGYb0qc7cmTK5gjLlpLkvpKtG2ZmgVqn4XrvIAbCcCCAZ/Ci9XhXpl1Bz+H
	6nApkkuWrixeL3St99k0HL7NnSoKiYS0=
X-Gm-Gg: Acq92OGrX+r6pcNXCL8TSSZUjTDUlWWfppN4tAglymzDhr7FlqbPGdM6Fv0ogVXM082
	MJFLl6LfAyIVPHdnkqs07gUGpaw46cCS0OtrwNLDwIF+iBn73MIR5fIkMQHSlRBjC/3CX1ZF48V
	zgMohIdYMkigkJybtE0IXwKaZsrh9zslJQX4InZKWYJPFANEJt231RoBfwyFg4QYntIN/O7rrQe
	UC3aeKhjCYmsxR7oelUTiCO/NtIDM9JqTsS+CFxQt1jJJCBt0/ugorVoJdRdNqGEa6I+zeWIN2X
	zM3UWBg8S1ctd7iLeX0Y5yDFxmeCedQ/pWky3dZleW9eqwW/mA==
X-Received: by 2002:a05:6a20:9154:b0:3a2:fbf9:d823 with SMTP id
 adf61e73a8af0-3b22e7c64b9mr6359384637.8.1778883010804; Fri, 15 May 2026
 15:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
 <DS1PR16MB675343BEA9DE94B268CDE927E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
 <CAL5DHTFvJfV1DVNjBLsdCQ8FP7TmNq0SK=EpA-2wWzdo4+FsRQ@mail.gmail.com>
 <DS1PR16MB6753295FF074D304308ADF78E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
 <CAL5DHTGjVWOV=KuvR7foMPf6vqDWwRyKU6_eVtxOPhbJ9hAvpQ@mail.gmail.com>
In-Reply-To: <CAL5DHTGjVWOV=KuvR7foMPf6vqDWwRyKU6_eVtxOPhbJ9hAvpQ@mail.gmail.com>
From: Torstein Eide <torsteine@gmail.com>
Date: Sat, 16 May 2026 00:09:58 +0200
X-Gm-Features: AVHnY4Kum_XCrhGZhaU9fECPTNN_pzl_h8gP9zjPyTpd-vOVjpZPaIMIKm4D154
Message-ID: <CAL5DHTGba6fK447DFNgGsfFF2Rut0ho6Z=H8U+-JAVEfTbtsqw@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc-utils: improve lsmmc usability
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Torstein Eide <torsteine+linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The current master is on https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/
is 5 months old. can it be a possibility that your local master is a head?

fre. 15. mai 2026 kl. 22:28 skrev Torstein Eide <torsteine@gmail.com>:
>
> fre. 15. mai 2026 kl. 18:46 skrev Avri Altman <Avri.Altman@sandisk.com>:
> >
> > > > > Resend the lsmmc usability updates as an ordered series after the
> > > > > previous submission could not be applied cleanly from patchwork or b4.
> > > > >
> > > > Thanks.  Still having some troubles applying it cleanly.
> > > > Please make sure you are rebasing it on recent master.
> > > > Will review your series anyway.
> > > >
> > > > Thanks,
> > > > Avri
> > > >
> > >
> > > The first patch serie i modified after  `git format-patch master` and did also fail
> > > locally,
> > >
> > > in the new export  i only changed the subject and description in cover letter, I let
> > > notice it was not happy when i try to apply the cover letter, but locally to a new
> > > branch the all apply without issue.
> > > I am unsure what i did wrong.
> > Your local master seems to be behind upstream. The patches conflict with
> > the CID date-fix series that landed recently (commits 6f6b6e1..2364dc6).
> >
> > Please do:
> > git fetch origin
> > git rebase origin/master
> >
> > Then re-export with git format-patch.
> >
> > Thanks,
> > Avri
>
> That makes sense that you have conflict, but not a other errors.
> > >
> > > > > This adds external manufacturer ID files, accepts /dev and
> > > > > /sys/block paths for register reads, adds an mmc list command, and
> > > > > installs bash completion for mmc- utils.
> > > > >
> > > > > Torstein Eide (4):
> > > > >   mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
> > > > >   mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
> > > > >   mmc-utils: lsmmc: Add mmc list command
> > > > >   mmc-utils: Add bash completion
> > > > >
> > > > >  Makefile           |  11 +-
> > > > >  completion/mmc     |  62 +++++++
> > > > >  docs/HOWTO.rst     |  77 +++++++-
> > > > >  lsmmc.c            | 434 ++++++++++++++++++++++++++++-----------------
> > > > >  mmc.c              |   6 +-
> > > > >  mmc_cmds.h         |   1 +
> > > > >  multimediacard.ids |  16 ++
> > > > >  sdcard.ids         |  23 +++
> > > > >  8 files changed, 452 insertions(+), 178 deletions(-)  create mode
> > > > > 100644 completion/mmc  create mode 100644 multimediacard.ids  create
> > > > > mode 100644 sdcard.ids
> > > > >
> > > > > --
> > > > > 2.53.0
> > > >
