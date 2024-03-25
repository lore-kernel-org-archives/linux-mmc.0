Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B5A50
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374267; cv=none; b=G1WayIFT0iEGCcqhLQQy361tcW/eypoY2WeUHC5fQwUTltXC6vUKvE5V3Fe7V/mb6FdvAjtXb8VfHVuMzA7BMPG7WHWsYWpJHMaUDSIYu3VBCnFxIZKTQlGwd6J6JECf9NmJe/p1iNbeYUZbJmLKbdRXAc3oL7ly9Tum6UNDJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374267; c=relaxed/simple;
	bh=4XWLFE0pxc3fVz/SAFj06I2kyx7X0OPfbpFgD8Pe8z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQnR2A1VASBswwG2V35ge7kWhwRYupdnYrfaJoYrKBV1KWt5bSIOqGAMSq/Jbg7qgOUmuU3jlr8az2RSO3yZ1XejpWyLK0Ir+uRYkUXf4E6z0ESko3fkEl7bV+lips31SaXr7moTNSlkksUNxqg4ylR/9Q2/rzpihrD7OEPWpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wktJ2/37; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wktJ2/37"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c3ceeb2d04so420588b6e.1
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711374265; x=1711979065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ml8keGZQD08AWVFz/kHQ46jKgano2DEJCQh7xhRitU=;
        b=wktJ2/376Oprz9DjgdqysWrzs7S4W4kAUs4C7Jvf+kmlju2JHa3UoYTi0+v7C+Wpeq
         mpC/2fWDDajh3UA1D2+Oq+6o6sAZIiSUdYVq6hBQnsZpIjrDndg44WV2lesTTRQeff8Y
         uwGikvK4AYOdDdDvY0hzayRdlMlkR+6I8PFsc7xU9mItQ914SkqUI9FPH7R3aTbxcU1q
         ML6XyqokNZZYI6ufe4y4MTub2238gSsJ6laZbOFolCnvpW0M2M9E+DPPE/jZz7k/FQ7b
         yTXCxuajGTj7jVSfttWDQDwiL8IUvzAAYVsr9kptFm2u2PL1c6VexjlLg3fgWVGvt7Ib
         X0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374265; x=1711979065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ml8keGZQD08AWVFz/kHQ46jKgano2DEJCQh7xhRitU=;
        b=sBhx1+yNJ1oKjyTc+TUktJRMbljJBhCqKF5BXdWU3cHwu+gofsLQuav/snABEUCXab
         jxM+K2t73a2fMI6rWXRUZDCSAsTtlZG5i1xpzWuSyZ249v8dhRqkpHwv4iXvqVo8oODE
         a51Pn06hvLdkxkN0KSETdmpStfmGD5tJFPLUtiJ8o37cl0f+RTjPLn0UJDP/22CZXmeG
         sNwxR/SkMgrsRPeUaNs3ieza4UQCbDhP3RAiilDK8R9KRKwi3+AcC1NtZ6rwUCw4d2vH
         Blq0266kXgtV0QNddzjnlW5MnUO9a95RFx5/SdmVhWo7j+D8STOWx82u0Dh9D2xBHRDY
         JQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUypNLUlKwuSqkLGd2WoiNn1xsqaz8buLdo8wwSApaPcOMR6350gBmukWDTAUnKB9w3rO+rFv0imMdzFiH0U1GKy8stmu8W/ivD
X-Gm-Message-State: AOJu0YxNt1urbX+sEaes6/zqNXMDRtBvYweuNtxNZ16o4q3JtY6T5og1
	mTws+9wXCTZUXA9jws27qt6+PQRfq9wyNyc7KNiO4hLYZNn+gZ9J/7bgC1gSd5dTuOpeH/c6NZn
	fvamnhFL/6MohU3XZH23OrTKYci2QsnTy7/5O/w==
X-Google-Smtp-Source: AGHT+IEb8eQ1zM1bXQF+rTtAAfkxf2uFhJYbBnSvifcSAk+BTpDpm5+fl67NJC3KNeM5ddeq0O35Pp5nhjta+LRlQmU=
X-Received: by 2002:a05:6808:1291:b0:3c3:b10c:efad with SMTP id
 a17-20020a056808129100b003c3b10cefadmr10345176oiw.27.1711374264814; Mon, 25
 Mar 2024 06:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org> <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>
 <DM6PR04MB65755A95AA492565F7576D10FC362@DM6PR04MB6575.namprd04.prod.outlook.com>
 <PH7PR11MB76054BC0C863E5947C7B2DAFE5362@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB76054BC0C863E5947C7B2DAFE5362@PH7PR11MB7605.namprd11.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 25 Mar 2024 14:44:13 +0100
Message-ID: <CAHUa44E7z=nppPnBEAqUddtrbTeiZxK8gQ95AGV9oA0-UdLMCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:23=E2=80=AFAM Winkler, Tomas <tomas.winkler@intel=
.com> wrote:
>
>
> > > > +struct rpmb_frame {
> > > > +       u8     stuff[196];
> > > > +       u8     key_mac[32];
> > > > +       u8     data[256];
> > > > +       u8     nonce[16];
> > > > +       __be32 write_counter;
> > > > +       __be16 addr;
> > > > +       __be16 block_count;
> > > > +       __be16 result;
> > > > +       __be16 req_resp;
> > > > +} __packed;
> > >
> > > I haven't looked at the NVME or the UFS spec in detail. Although, I
> > > assume the above frame makes sense for those types of
> > interfaces/protocols too?
> > The rpmb implementation in ufs, has drifted apart from eMMC. E.g. in
> > UFS4.0:
> >  -  the frame is different - see struct ufs_arpmb_meta in
> > include/uapi/scsi/scsi_bsg_ufs.h,
> >  - Additional extended header was added,
> >  - the frame size is no longer 512Bytes (256Bytes meta info + 256Bytes =
data)
> > but 4k,
> >  - there are 9 rpmb operations instead of 7,
> >  - The atomicity requirement of the command sequence was waved, And
> > probably more differences that I forgot.
> > This is why it is better to designated this as an eMMC-only implementat=
ion?

Thanks for the update.

To move forward here we can either
1. as you suggest make this an eMMC-only implementation,
or
2. we could remove struct rpmb_frame from include/linux/rpmb.h to make
the shuffled data more opaque.

Is it possible to find and route RPMB data to NVME and UFS devices
without a common meeting point like the RPMB subsystem proposed here?
If the answer is yes option 1 makes more sense since we'll add a
missing capability to eMMC. If the answer is no option 2 makes sense
for NVME and UFS even if we save the implementation for later.

>
> As  I wrote previously the original implementation has already resolved p=
rotocol differences
>  (NVMe have also different byte ordering) for closed usecase of storing d=
ata (not the configuration)
> I believe the whole point here is to let TEE driver to store the data, re=
gardless of the technology.

Agreed.

>  In addition I might be wrong but I don't see much value in eMMC as the U=
FS and NVMe are currently leading technologies.

This patchset addresses a problem on present platforms so it's not irreleva=
nt.

Thanks,
Jens
