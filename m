Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D91F946
	for <linux-mmc@vger.kernel.org>; Wed,  7 Feb 2024 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290773; cv=none; b=Abd6OgRgBgfczXmxiVUBIxGZKGytCOdyZ7avyL9sSb34d7cauKlQHeGBsHGYHyV7o/NEG0gPsYKW50PNgN3AfpQ6za/pErdd1AleZX76kKyv+/UqvIx7FjByFRbgJz19UzNF5Mws57BW5uGVkwrdsYcZHq8XTDTAhGv/UNDm/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290773; c=relaxed/simple;
	bh=Xr4QbVlNSDRWdDF6YqeMGp6/b7O96sTDR3R3JeYqQSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/tKUD/BdWTGuXVcKTlxclFyXvDXxceXJjYYHgZ9Pr9ErUyndfM+vSRdRv7znlkUiqbOgo+fDxEzD1lGPCYpQCSihEIBEYANtpLQvi3PWMkZyctvseKRy/YUGZR3Nng+LkfPJqBjr9ZIPAArYn0wbQAxxvZ76dPRoVB1EfHoaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=monZpi5I; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="monZpi5I"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a146e8c85so162827eaf.0
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 23:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707290771; x=1707895571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr4QbVlNSDRWdDF6YqeMGp6/b7O96sTDR3R3JeYqQSk=;
        b=monZpi5IVWEDF4PK1e27HTNFasq0kFd57wDwkTTYg6ucb6Vr7aukujpwo9zuVgqYAm
         a6mjstuBwRLIH1aaQcSX0sIaNiDoEmRax1PDFq2hR3siAuSKp1b10/Sb9aAzLGx5JENE
         XpHp/RtmDWdGVX7UXeRDZAggedM0a28RSj+DgyiQQ2dsuIQtmYdcwl80QVUll9l68aQV
         E03Q2P3+0zKj8Vq2LciQ/DG9vwfXmF4IpgKqP+o+NJHlXF+jtexH5GYfcxrAHIK68LOm
         Mg0XOeT5ZOBM7w7a6RTWPGfCiJueikzKrx3XmCYlM+dCu89H0x2iHKXDh/31NiZUzIB+
         Ob2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707290771; x=1707895571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr4QbVlNSDRWdDF6YqeMGp6/b7O96sTDR3R3JeYqQSk=;
        b=YLrji3f0SdxhaInPpaAB3ffdiBykFMk/ydvyH7dy3fCfxeQK2J52UUqzHXRrnyOgj9
         SkZ0IZetV2VrgmapiFpENO1ZyImtXxBpX56Q/NxiEloVQwscJDrOq/a7UhNgHtjImR0B
         TkAb8GnhrAHho5Oxu9L1RVEIvfdOnp/jqS8OalZbnYYALlyKqZd1gHYGdQjp401zBdX8
         kU7gduvuEGk0HDBBizTsp7mTyLKS/Ba1rjgQ+9icSS7kACMAd9EYDApdQkz2+3/tnSpz
         xHPVAUAdJ3GK38PEGfNsBHvesL9nP3ccAFRb84WJmhy/xV/SqJq+H1V9V+0Pdvt0b+O/
         kAog==
X-Gm-Message-State: AOJu0YwF2rRuI8gsqyraUgPOOmtWsOLEUAP+pE5i2yn0cDuz6eDcLejm
	2KJX6YjWEa141v4Hy4hH9gMGjgHWeA6gQ/ktkXVfJ2lsroWL6EP2L6I5T4F9rz2bmUrRsSjOD+F
	KNM+7vDekcY4L9CA/mRPcB61dwaPn/DB5ZaZ4uw==
X-Google-Smtp-Source: AGHT+IGBYMcx2Qv+1PsdhEInOVkijjlWUTU7G4kTG64xit7GN+lOlRX6ltMsH3CESvRIOBR3uJV46YwlgDgLlZ6KFBY=
X-Received: by 2002:a4a:3057:0:b0:599:5575:bdaf with SMTP id
 z23-20020a4a3057000000b005995575bdafmr5202269ooz.9.1707290770888; Tue, 06 Feb
 2024 23:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
 <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com> <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 7 Feb 2024 08:25:58 +0100
Message-ID: <CAHUa44G+7HMNztQyYAWEhLFJvDBHDxPnqm+FRSVavb0NCyoYzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Sumit Garg <sumit.garg@linaro.org>
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

H,

On Wed, Feb 7, 2024 at 7:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> Hi Ilias, Ulf,
>
> On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Ulf,
> >
> > On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
> > >
> > > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > A number of storage technologies support a specialised hardware
> > > > partition designed to be resistant to replay attacks. The underlyin=
g
> > > > HW protocols differ but the operations are common. The RPMB partiti=
on
> > > > cannot be accessed via standard block layer, but by a set of specif=
ic
> > > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Suc=
h a
> > > > partition provides authenticated and replay protected access, hence
> > > > suitable as a secure storage.
> > > >
> > > > The initial aim of this patch is to provide a simple RPMB Driver wh=
ich
> > > > can be accessed by the optee driver to facilitate early RPMB access=
 to
> > > > OP-TEE OS (secure OS) during the boot time.
> > >
> > > How early do we expect OP-TEE to need RPMB access?
> >
> > It depends on the requested services. I am currently aware of 2
> > services that depend on the RPMB
> > - FirmwareTPM
> > - UEFI variables stored there via optee.
> >
> > For the FirmwareTPM it depends on when you want to use it. This
> > typically happens when the initramfs is loaded or systemd requests
> > access to the TPM. I guess this is late enough to not cause problems?
>
> Actually RPMB access is done as early as during fTPM probe, probably
> to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
> user being IMA which would require fTPM access too. So we really need
> to manage dependencies here.
>
> >
> > For the latter, we won't need the supplicant until a write is
> > requested. This will only happen once the userspace is up and running.
> > The UEFI driver that sits behind OP-TEE has an in-memory cache of the
> > variables, so all the reads (the kernel invokes get_next_variable
> > during boot) are working without it.
> >
> > Thanks
> > /Ilias
> > >
> > > The way things work for mmc today, is that the eMMC card gets
> > > discovered/probed via a workqueue. The work is punted by the mmc host
> > > driver (typically a module-platform-driver), when it has probed
> > > successfully.
>
> It would be nice if RPMB is available as early as possible but for the
> time being we can try to see if probe deferral suffices for all
> use-cases.
>
> > >
> > > The point is, it looks like we need some kind of probe deferral
> > > mechanism too. Whether we want the OP-TEE driver to manage this itsel=
f
> > > or whether we should let rpmb_dev_find_device() deal with it, I don't
> > > know.
>
> I wouldn't like to see the OP-TEE driver probe being deferred due to
> this since there are other kernel drivers like OP-TEE RNG (should be
> available as early as we can) etc. which don't have any dependency on
> RPMB.

I agree, the optee driver itself can probe without RPMB.

>
> How about for the time being we defer fTPM probe until RPMB is available?

Sounds a bit like what we do with the
optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP) call when
tee-supplicant has opened the supplicant device. It would perhaps work
with a PTA_CMD_GET_DEVICES_RPMB or such.

Thanks,
Jens
