Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DF1F944
	for <linux-mmc@vger.kernel.org>; Wed,  7 Feb 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292157; cv=none; b=PRaEU1t2xpN77syZ9IvCkpEr5Y3RvYPUT03+AkqDXv4SWkwNC9smqHY0OtQeh5awFbNKPDz2W7fam34yqO9d9czfzYuDki/KDNCJHP7ZbKiStjYA+d4J+131AihbFzqfReCLfYhM7NhtUCvnOXdMDkl9mdbUbX2HRk8KXAnv01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292157; c=relaxed/simple;
	bh=yGJSWXa0tmgeOdHPNvVXOcFWn0J26BdQTqkblLmPk0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4Bh1RlGJmR+pzlYenA+TJB9ui4riiT6kH9lFeFRgHC2oIVhLPfuhc58XHs0zWyyutamiFNhtD65hh3552wi5PwdMSSGJKw9aMLXH6Zo9RyR5nIKzhf+UJbFCc7prOr6boWkz6FUhpXNU5JWxBdA228mFTrEDvEglZKAFHQ3zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v/UdfHVE; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/UdfHVE"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so141395241.3
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 23:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707292155; x=1707896955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGJSWXa0tmgeOdHPNvVXOcFWn0J26BdQTqkblLmPk0o=;
        b=v/UdfHVEPTpQgv3m1g1bpYhhdF3gR4jRlsQQiA+bm8Cy2UCjNtC0f89otyEShbkQvA
         GtuOgLAaegih0p1taZD6ZZe/S30Es4pnR5cGoTTckAZn7LexcE16qWqbtPO9jhRAJFtl
         mqTv3M+UvXnAavTHrtIh5bdD8JxRVioPXtBSa8bDbPCZ0uC6k3RRQ+fuaUotikr4Fes+
         oYjTSB1K+MyNNJltwV7PVwc4dtDRlZgkth4SFGUyDDLa5HBKq65LB37JXlkzfeckndPw
         jUWOEvWyx/ICE+nyux2D0ztYnaUI1y+4w3SevPQ67Hoa+Z4xdwpBhRrDmDHh+rCrnoe8
         nbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292155; x=1707896955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGJSWXa0tmgeOdHPNvVXOcFWn0J26BdQTqkblLmPk0o=;
        b=RiyvljlU7RGTSWQLlW0kPJX3wHPOdBb1HkMt2pEYKKFMq1b5uqVwYEntBiB4T50ybQ
         OEHgTl2DLG2gjUtM6t518xOym7xTaW9OSb/QT92UjJa1rz8VZJlAlCkq3tbPrWJdlRkD
         4YsjYrjA/NYN97Vyw24E9xfD59FO8am3/ri8RfAxDWrL9WasGEzixjXhiFtRh3wl2eeu
         1bGwhUvyBB1DyKS1ylp+Lxpz3OV/vJPsr7riBKbYRLZp6Z35z4RtEuWuBhEW30ObeZSA
         ppDPKcWYZSAGu1an52V8GJF94X3qHCaQWnYQzO4vVEFv10ll8/iZjUWVduvIzynydlo3
         HlLQ==
X-Gm-Message-State: AOJu0YwlQFrbWDKbn8rEW+uaOsYfeFStqG7lz/YnFuG3J1NSpEwesYNP
	mDvWqCTV2tj5S2NpASDOQsgpuTnxQf630A4gLmehn/wH87eyagVXf5JnVSOf9DbY/KST8fFVqCF
	4tu9yTUHdKTs1AVVJxJ0pRbILtJd84Gs6IFnkUA==
X-Google-Smtp-Source: AGHT+IFujJQgoNgF5h3ELvefgatb5AhxnPvBN98IDbK2o1GCBOxSd1pJjVdiP2H13sB+JXTgT+gEPSp7F41Gwcfhwqg=
X-Received: by 2002:a05:6102:290d:b0:46d:37d6:3908 with SMTP id
 cz13-20020a056102290d00b0046d37d63908mr2372082vsb.5.1707292155276; Tue, 06
 Feb 2024 23:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
 <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
 <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com> <CAHUa44G+7HMNztQyYAWEhLFJvDBHDxPnqm+FRSVavb0NCyoYzg@mail.gmail.com>
In-Reply-To: <CAHUa44G+7HMNztQyYAWEhLFJvDBHDxPnqm+FRSVavb0NCyoYzg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 7 Feb 2024 13:19:03 +0530
Message-ID: <CAFA6WYMNyw5GPji8XMMcPNHSkX5zXubsuVhauWHyGvBBQ3Mefw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Feb 2024 at 12:56, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> H,
>
> On Wed, Feb 7, 2024 at 7:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
> >
> > Hi Ilias, Ulf,
> >
> > On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Ulf,
> > >
> > > On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
> > > >
> > > > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro=
.org> wrote:
> > > > >
> > > > > A number of storage technologies support a specialised hardware
> > > > > partition designed to be resistant to replay attacks. The underly=
ing
> > > > > HW protocols differ but the operations are common. The RPMB parti=
tion
> > > > > cannot be accessed via standard block layer, but by a set of spec=
ific
> > > > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. S=
uch a
> > > > > partition provides authenticated and replay protected access, hen=
ce
> > > > > suitable as a secure storage.
> > > > >
> > > > > The initial aim of this patch is to provide a simple RPMB Driver =
which
> > > > > can be accessed by the optee driver to facilitate early RPMB acce=
ss to
> > > > > OP-TEE OS (secure OS) during the boot time.
> > > >
> > > > How early do we expect OP-TEE to need RPMB access?
> > >
> > > It depends on the requested services. I am currently aware of 2
> > > services that depend on the RPMB
> > > - FirmwareTPM
> > > - UEFI variables stored there via optee.
> > >
> > > For the FirmwareTPM it depends on when you want to use it. This
> > > typically happens when the initramfs is loaded or systemd requests
> > > access to the TPM. I guess this is late enough to not cause problems?
> >
> > Actually RPMB access is done as early as during fTPM probe, probably
> > to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
> > user being IMA which would require fTPM access too. So we really need
> > to manage dependencies here.
> >
> > >
> > > For the latter, we won't need the supplicant until a write is
> > > requested. This will only happen once the userspace is up and running=
.
> > > The UEFI driver that sits behind OP-TEE has an in-memory cache of the
> > > variables, so all the reads (the kernel invokes get_next_variable
> > > during boot) are working without it.
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > The way things work for mmc today, is that the eMMC card gets
> > > > discovered/probed via a workqueue. The work is punted by the mmc ho=
st
> > > > driver (typically a module-platform-driver), when it has probed
> > > > successfully.
> >
> > It would be nice if RPMB is available as early as possible but for the
> > time being we can try to see if probe deferral suffices for all
> > use-cases.
> >
> > > >
> > > > The point is, it looks like we need some kind of probe deferral
> > > > mechanism too. Whether we want the OP-TEE driver to manage this its=
elf
> > > > or whether we should let rpmb_dev_find_device() deal with it, I don=
't
> > > > know.
> >
> > I wouldn't like to see the OP-TEE driver probe being deferred due to
> > this since there are other kernel drivers like OP-TEE RNG (should be
> > available as early as we can) etc. which don't have any dependency on
> > RPMB.
>
> I agree, the optee driver itself can probe without RPMB.
>
> >
> > How about for the time being we defer fTPM probe until RPMB is availabl=
e?
>
> Sounds a bit like what we do with the
> optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP) call when
> tee-supplicant has opened the supplicant device. It would perhaps work
> with a PTA_CMD_GET_DEVICES_RPMB or such.

That sounds much better, it will be like an OP-TEE driver callback
(optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)) registered with
the RPMB subsystem. But we should check if all the RPMB partitions are
registered before we invoke the callbacks such that OP-TEE will have a
chance to select the right one.

-Sumit

>
> Thanks,
> Jens
