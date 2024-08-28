Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C945C1C
	for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856098; cv=none; b=Dz0AbwB8CUvQileB+zmf7AC2bkYgUrmypwCZsDqCx/Rxz5Z74atwu/5Yuq6H0jtL7fGKDYU+DEs28xXTzFs24rpMb6HcoOwnJhhJ/fwTuCoCYtXsshI8M8QM6pgvSc3U4k6nQir0pRMDtzKCvQLI51BMQDLeAnQ1k8b8KOWknCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856098; c=relaxed/simple;
	bh=XFsYtEDpPJmSlFsXumGTxb6QS1JjyXFz3cje+YthtP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLzHlIiTWpkMpP/z26J2fP4ngqUxMEKb8/Y4DUQuDy9R3QCNlhRnAl8ff8EDmbQdedNyMocTRMp7eEX70+K44kuV98nol/vWvQrz7jsvQihrfb1FCBrW0W+6oBjHt+wAq4ltpK0b7AH4c9Iom0f/wubJd+TIX3ppKhk7nuM+cfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYI1TSTG; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYI1TSTG"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e17c1881a52so555283276.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724856096; x=1725460896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3gsgMHkBX2MPNI8iiLUQvqurjnGHwhPAjD0V8QMC3s=;
        b=nYI1TSTG+sHfbPbXPmQBMlg5uD1B/aaewqswuB3upM07TI8fgRXX+MLsZFDpXH7TMW
         haqfp4z4dOb1HxNJHDqBL+y6VySr2vE1D/XX10MAZrbYL9n3Q57d2f7DkBvEeQzDd3PJ
         5mWllLjfy7W9sIMSQLHHXZ0gqDDTMJe0Yl/jmMnfYv2js3GZDB3TltdUNIruYkpRs8Qq
         GcqkZUO0uHItIruMD+D9Aq/PfcRpJLNDrt5slcn5holcdeA+bYFMNE4dZ/buYL8a1Om2
         hIBcWWP+thjTkO7UZXvtjCDJsHGbdC4bTv9KkNuwg6DNBnzFbTtKwJUoEsRDEGYsYBmP
         0uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856096; x=1725460896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3gsgMHkBX2MPNI8iiLUQvqurjnGHwhPAjD0V8QMC3s=;
        b=uC5W2wfOu76CBDqXUV/sj8p+LeUYNY6QxKjCOB6X25OQGoioiZYpblBPY9TPiBkZw+
         vHmhwiC8XSLcjrkrrr3Wx6fvQ/z7hZxabTDd3PoUw/Fm62axs70QP2niPQxf+LmU3vtK
         Dj1rXB78lEW7IqrCf4H3aBOEstDt7AzO6TeLP5+K6eDbVAHLJdwV3vT9uWM973v1u1tu
         tKQbLteooMVjm9bIow1Qqs5pht7PnBSK6A7u9wVUBoQnKacfGh7y2x6VChe5+LLDoyTF
         sdVSIvsFUGZXFnO2hBmtSaO6fjFr9ygt40c5ngOWJVOTOAtNdS1Cy2nZhviBMZGcqgC/
         Whjg==
X-Forwarded-Encrypted: i=1; AJvYcCWXSrGP/yZZkkortfj6tZKdoA6VFiTmQX60aFSmECMiDu0zRZuA9Z9bKKAF2OK7k5pOAAGKNPiHhKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aVm6u1y8HsoU1yjN1W7ZXCb51mySihhxW+2KU3WH/eqmkKDP
	HUOowOXNfC4a92DjgGLwyCBOS2dzib/wPJ1bbse0U2Krnd5DhyzTE+ASvA1MqdQWWKjpCx2q1ss
	ay4vSgfBc5esEM4Aod0z/3K1E9NIi/ZqViFhS/xWKtM0JthGi
X-Google-Smtp-Source: AGHT+IH6+W5pIYk+4K8q4fdeCp1DcAnQaa7XI6whwl1cqc9VNtjtvQn7zVJXRryPte99tFHVm82HJAM8K4r2+eOOWzQ=
X-Received: by 2002:a05:6902:2789:b0:e0e:83e1:d1 with SMTP id
 3f1490d57ef6-e1a4492c57bmr1833609276.20.1724856096161; Wed, 28 Aug 2024
 07:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825074141.3171549-1-avri.altman@wdc.com> <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
 <DM6PR04MB65756CEE03C15524EF646C3BFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB65751048E9B35CFED478F180FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
 <cb9c225c-b5c2-43ba-a6d5-843dc2790fd4@intel.com> <DM6PR04MB657568FC857DA6877F2BA7FFFC942@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB65752FFC3CB355F2FC704C16FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65752FFC3CB355F2FC704C16FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 16:41:00 +0200
Message-ID: <CAPDyKFpSA_Esoh=2_j28JMotxqhOrRxnzj3xfZg9BoWUd=B72A@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Add SDUC Support
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 at 12:58, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > > On 27/08/24 10:45, Avri Altman wrote:
> > > >>> On 25/08/24 10:41, Avri Altman wrote:
> > > >>>> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.
> > > >>>> Those cards support capacity larger than 2TB and up to including=
 128TB.
> > > >>>> Thus, the address range of the card expands beyond the 32-bit
> > > >>>> command argument. To that end, a new command - CMD22 is defined,
> > > >>>> to carry the extra 6-bit upper part of the 38-bit block address
> > > >>>> that enable access to 128TB memory space.
> > > >>>>
> > > >>>> SDUC capacity is agnostic to the interface mode: UHS-I and UHS-I=
I
> > > >>>> =E2=80=93 Same as SDXC.
> > > >>>>
> > > >>>> The spec defines several extensions/modifications to the current
> > > >>>> SDXC cards, which we address in patches 1 - 10.  Otherwise
> > > >>>> requirements are out-of-scope of this change.  Specifically, CMD=
Q
> > > >>>> (CMD44+CMD45), and Extension for Video Speed Class (CMD20).
> > > >>>>
> > > >>>> First publication of SDUC was in [1].  This series was developed
> > > >>>> and tested separately from [1] and does not borrow from it.
> > > >>>>
> > > >>>> [1] https://lwn.net/Articles/982566/
> > > >>>
> > > >>> Perhaps add support for mmc_test
> > > > Actually, I am not sure what should be added to mmc_test as far as
> > > > SDUC
> > > indication:
> > > > from dmesg we have:
> > > > [ 4253.922220] mmc0: new ultra high speed SDR104 SDUC card at
> > > > address
> > > > d555 [ 4253.922409] mmcblk0: mmc0:d555 SR04T 3.72 TiB
> > > >
> > > > Additionally, we have the card size sysfs entry:
> > > > # cat /sys/block/mmcblk0/size
> > > > 7999258624
> > > >
> > > > As well as the csd which implies its capacity:
> > > > # cd /sys/class/mmc_host/mmc0/mmc0:* && cat csd
> > > > 800e0032db79007732bf7f800a404001
> > > >
> > > > What test did you had in mind?
> > >
> > > Doesn't all the I/O need CMD22 first?
> So I tried to add it, and it looks like I'll be needing 2 - 3 patches to =
enable mmc_test for sduc.
> How about disable it for now, planning to ameliorate it in the very near =
future?

Don't get me wrong, I am fine by this too, as Adrian.

However, the purpose of adding support for SDUC to mmc_test would also
be to help us test while developing the new code too.

[...]

Kind regards
Uffe
