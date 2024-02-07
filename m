Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D61CD28
	for <linux-mmc@vger.kernel.org>; Wed,  7 Feb 2024 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286315; cv=none; b=lsVxMJMMRIaP81/F9Aa0BW5p0JQlOgPdPT7PXYI05dXdivlp3pTFVzeAx/IcCoZvTuHfogjXJMbe9+rmmbGtVRPAnCaRQub4ytKwhWXGiGBPvXTICfzwGgrsSMWXtehEVaQvHRmhVI4MlKSA7Wrgm2J0q6406/5vDa/8EvGosBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286315; c=relaxed/simple;
	bh=MXcOIfQoNRO5ZjYXIjrOev1qoj5neivD/X754LViIHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV0wE5py7LUMPphUCrbAmXUcbI0HPicIl9rFSi3JryaLfT6TIxzxSdvuKkruuU+2FWbT7Ea2rVSlf3CBD/EyHy7kfX8RUAaRoHBGrDkPgY1OFKh2BbEkWSs3JOgJ/nP+DCdL4XEulFh26EcH6IyME4G6cBjFQEY7GRJxHI41OAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qzUPNkOW; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzUPNkOW"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so120773241.1
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 22:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707286312; x=1707891112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MXcOIfQoNRO5ZjYXIjrOev1qoj5neivD/X754LViIHw=;
        b=qzUPNkOWmgGL1OZbA8XJQr8kBaHDPd1ezjOLQD2WHCPwCDPLuj+UdAKAS937JTNmZR
         l5ottFFaprHTxxoXoOa2HPzhpV4tx7Zf1cbz5MypYnugDLpnjPLTOtzvf8Ol9vCqxjgM
         YrgCCJEiK3ijp3q6UL00jlqvOWEsFx3DiW1QtyMSmRiO8s0ImX6gxGL/jTqxvusl6N5M
         BSd2SQUZ4xUbZf/vN8iwIAXbam/KWzaYM3iIcISgCwgnQKcl8xvOMAoeRhkBoHONMUoq
         Qmgbwos+iJTcGqAVcv1695NAQYpCFVa/85zvrYxyEFXG6HIdYbZS//LtGw5iP3Yvd/1w
         pfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707286312; x=1707891112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXcOIfQoNRO5ZjYXIjrOev1qoj5neivD/X754LViIHw=;
        b=BDJbG7z69bgNB4pmAlMBx/wMdcCP1ajxr/DGorHoSI+Z9g9Dm/f3kG8sV115x+AeHd
         9AV+7ArGWZV5cT4BzQ4HEdVOXmO1NSeeTDm2C067O/6tISoNVmzcCq5aNvllKyNbBYkS
         HOG5E1GrMJzinkvi+sfrW0eaEd+rFURJfc/79xpZB2q0WP4LMXRJ9ySaD+he1/uGfj8A
         iJiRr6e994c+N2zNSewdzvXx6COiUoDcwpVlKikGlaClz33LMuQCnhKJ26SnHQN7F+yB
         dnuDRnV6KIahYIlneBOFibB+tYicV135PUqsLhTq4SRA1UwD52pkf2GK3QhwYmd03lnm
         ZzfQ==
X-Gm-Message-State: AOJu0YxvOVUYnYRHVGsjLst0zvcIVAVxS2+AOLhVyFrK1duAmZpnhMd2
	ZCkiCnT8iOuR0LODLckf3hPLrGzMbw/JK3b9i1RZtnjP3t0ibRHi7H33YuQGYsVmCBOqBqF3ypS
	DAi31B7UeFqL310C8OKrQ9TYkap8oafTMWvU8IA==
X-Google-Smtp-Source: AGHT+IEOnPi0xHT1TQovo4uWsauFx9V82/RzzdzP1M9V7J3e1++Dvktqp/6DKtdbBO8XPPLtj6qRcdQEMQWfIzDQL3g=
X-Received: by 2002:a05:6102:236f:b0:468:6b0:ef95 with SMTP id
 o15-20020a056102236f00b0046806b0ef95mr1635936vsa.24.1707286312499; Tue, 06
 Feb 2024 22:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
 <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
In-Reply-To: <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 7 Feb 2024 11:41:41 +0530
Message-ID: <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ilias, Ulf,

On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Ulf,
>
> On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > A number of storage technologies support a specialised hardware
> > > partition designed to be resistant to replay attacks. The underlying
> > > HW protocols differ but the operations are common. The RPMB partition
> > > cannot be accessed via standard block layer, but by a set of specific
> > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > > partition provides authenticated and replay protected access, hence
> > > suitable as a secure storage.
> > >
> > > The initial aim of this patch is to provide a simple RPMB Driver which
> > > can be accessed by the optee driver to facilitate early RPMB access to
> > > OP-TEE OS (secure OS) during the boot time.
> >
> > How early do we expect OP-TEE to need RPMB access?
>
> It depends on the requested services. I am currently aware of 2
> services that depend on the RPMB
> - FirmwareTPM
> - UEFI variables stored there via optee.
>
> For the FirmwareTPM it depends on when you want to use it. This
> typically happens when the initramfs is loaded or systemd requests
> access to the TPM. I guess this is late enough to not cause problems?

Actually RPMB access is done as early as during fTPM probe, probably
to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
user being IMA which would require fTPM access too. So we really need
to manage dependencies here.

>
> For the latter, we won't need the supplicant until a write is
> requested. This will only happen once the userspace is up and running.
> The UEFI driver that sits behind OP-TEE has an in-memory cache of the
> variables, so all the reads (the kernel invokes get_next_variable
> during boot) are working without it.
>
> Thanks
> /Ilias
> >
> > The way things work for mmc today, is that the eMMC card gets
> > discovered/probed via a workqueue. The work is punted by the mmc host
> > driver (typically a module-platform-driver), when it has probed
> > successfully.

It would be nice if RPMB is available as early as possible but for the
time being we can try to see if probe deferral suffices for all
use-cases.

> >
> > The point is, it looks like we need some kind of probe deferral
> > mechanism too. Whether we want the OP-TEE driver to manage this itself
> > or whether we should let rpmb_dev_find_device() deal with it, I don't
> > know.

I wouldn't like to see the OP-TEE driver probe being deferred due to
this since there are other kernel drivers like OP-TEE RNG (should be
available as early as we can) etc. which don't have any dependency on
RPMB.

How about for the time being we defer fTPM probe until RPMB is available?

-Sumit
