Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE873463
	for <linux-mmc@vger.kernel.org>; Wed, 29 May 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970729; cv=none; b=PIKQiaXvbcoYdG2fVgfRM3n2Y6ZgoNDWKnO6xq2eKtwM50/XwDgp+/w/3Oi9KoQNUhxCJeUt92obLBBTFm1M4CvA7ENsIUOFLjAzHy8+tRnfoPBZaEfA7CLauter0qNwaHNv45i4FDCr2xVOVBlppJP/v3NNSNL8tMpHnVZN2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970729; c=relaxed/simple;
	bh=VpkZ9d+Zc2avkwHeplX5gXZyUDYAVIyVVvyeY08HzO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNFEclT37f7xSorHENSA0VzcWS4RR1eh/bZ7L6jlQlH72S61/zi0NZi1DrWB22OZXBLUitMXRze9iYIsTyLbzDN9MhN+WaNOZ3xa2VgPAnlUgQI7XbaA7b0JYoU5qP2/n5Q1FikSB8LBSm1Yh7ql/cPDHrlok3iQaw+O1LyrF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0Dl6z1d; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0Dl6z1d"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48a398971c4so594387137.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 May 2024 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716970725; x=1717575525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f3U10PPUgvbykvjyd6DPSMXhzlJ3Ya3OIzEIHPAWBQ=;
        b=T0Dl6z1d75J1TA1g7DYAdeXNObMYC22kJ/mn+D/IpVyc0mJjiPfVMOlybI1AGu8SRM
         cy0tpURD9ShJBicgdOwOvCtngTznL5DPnzG2I0YwIk7/j02XZpVPdCa8GwQXYh53X5aG
         Kxol6hECOwlJABxavZQjJRYdW9n8ql2iOGBEkBhHtDfXcMGsjlX2OoPFyKtU8hiNz8MV
         yM/trXC7FvJ8csLOMlKiiNl0BIPUHqT0E7yZtkD34mX4NtLsxhuF/vsH2R9dUJ+TArOI
         5gONaCgaHdZgv41FmvkuQ7hO5BuT9dVp5qgL6Q+7dmrJ5S0oxXIfNViiML8IDuc2qtRP
         w/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970725; x=1717575525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f3U10PPUgvbykvjyd6DPSMXhzlJ3Ya3OIzEIHPAWBQ=;
        b=geQ2kfhO/ZUM2H24OKKyHHkfcPib/eZhgxz6+r4TKyqZD7viscU3YJormMkxBNov0d
         FXGN44RX0zi/NHpDqbyHInG+zV7f5GX/IIJwaz07SMJY0ob9ZTzGYNl34B+MdsUiybXg
         mZH3F6jQkFI7fEwQb2SkzkzH4tD92C+FajNe5Dxk2JFKlESkQNXcRGskX93CDRcM2z4X
         exzEXIn56JYUK1F5hJaRiBDVH9CPg3sRHQu75xU7J/3BQqua+K3XtEtgp90RIXqFob4q
         ywC/6rPkNL+f34G4OAlJNHi/uP2QTv/nN/aLgA5ekSduZv1n/wvc9U4fwBfiuewmxMYy
         XQbw==
X-Forwarded-Encrypted: i=1; AJvYcCXINOsRKmwsN3NhOAVg9xlU01vqv15Yq9/K+7jOpcn1Yy0tqmhVqq2QVKcaLuSte0rRe15YlMIB/Tdvy1qFQ9gC5mbcdET3HAuR
X-Gm-Message-State: AOJu0YzEbm245LTai5k+T6AeDm/xifjG4w2sJbnc9L8zVzF2KBGLsVt6
	PWNkFuUbCFkcu1S+PitUkEArB9YkEMsQPbTZs6tr3Iy/tqEDyOuzfx9zm7Dm3qf+T8WDIj+F+Ta
	ZdCuNh/KxZlnN92YzEpxDZgcBbdp2WvGZg1vTQg==
X-Google-Smtp-Source: AGHT+IG/dn7+tdOnu8ZtYM7orfHlswFmSsTQ41Y2J17VPeLtsITInXNgLq5j7XHxt5sOONwtBPKPtG5xGFng4YzByhY=
X-Received: by 2002:a05:6102:301b:b0:48b:a7ef:97da with SMTP id
 ada2fe7eead31-48ba7ef988bmr228185137.13.1716970725268; Wed, 29 May 2024
 01:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
 <ZlWkSCCjJ2fbE2ML@nuoska> <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
 <ZlbUwI0G3HGvioNm@nuoska> <CAFA6WYOny9RVPLbGCsTwUqOo+doi6k+F-RgCorNdyC+w7u63mw@mail.gmail.com>
In-Reply-To: <CAFA6WYOny9RVPLbGCsTwUqOo+doi6k+F-RgCorNdyC+w7u63mw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 13:48:34 +0530
Message-ID: <CAFA6WYP-cA4ChV8M-7z0JX1uHLzbAQk-s0mMFDKOgqFxZSK9Ow@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Traut <manut@mecka.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 at 13:36, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 29 May 2024 at 12:39, Mikko Rapeli <mikko.rapeli@linaro.org> wrot=
e:
> >
> > Hi,
> >
> > On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > > Hi Mikko,
> > >
> > > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> =
wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > > > > <jerome.forissier@linaro.org> wrote:
> > > > > >
> > > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) t=
o probe and
> > > > > > > use an RPMB device via the RPMB subsystem instead of passing =
the RPMB
> > > > > > > frames via tee-supplicant in user space. A fallback mechanism=
 is kept to
> > > > > > > route RPMB frames via tee-supplicant if the RPMB subsystem is=
n't
> > > > > > > available.
> > > > > > >
> > > > > > > The OP-TEE RPC ABI is extended to support iterating over all =
RPMB
> > > > > > > devices until one is found with the expected RPMB key already
> > > > > > > programmed.
> > > > > > >
> > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > Tested-by: Manuel Traut <manut@mecka.net>
> > > > > > > ---
> > > > > > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > > > > > >  MAINTAINERS                               |   1 +
> > > > > > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > > > > > >  drivers/tee/optee/device.c                |   7 +
> > > > > > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > > > > > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > > > > > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > > > > > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > > > > > >  drivers/tee/optee/optee_smc.h             |   2 +
> > > > > > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++=
++++++++++
> > > > > > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > > > > > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > > > > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > > > > > >
> > > > > > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Docu=
mentation/ABI/testing/sysfs-class-tee
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..c9144d16003e
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > > > > > @@ -0,0 +1,15 @@
> > > > > > > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing=
_model
> > > > > >
> > > > > > Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?
> > > > >
> > > > > Doesn't the routing model concern tee-supplicant more than a TEE
> > > > > client? Then it might make more sense to have
> > > > > /sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for b=
oth
> > > > > devices representing the same internal struct optee makes it easi=
er to
> > > > > find. Anyway, I don't mind removing one. Mikko, what do you prefe=
r?
> > > >
> > > > As simple as possible. A single sysfs file is enough. Even the exis=
tence of the sysfs file
> > > > could be the needed indicator for userspace to queue tee-supplicant=
 startup.
> > > >
> > > > Outside of these patches, I think the optee RPC setup with fTPM TA =
is one area which
> > > > currently requires tee-supplicant to be started. Detecting the exis=
tence of TPM before
> > > > kernel drivers are loaded is possible via the exported EFI logs fro=
m firmware to kernel
> > > > or ACPI TPM2 table entry, and detecting optee and thus starting tee=
-supplicant in userspace too.
> > >
> > > One thing I am trying to find an answer about is why do we need to
> > > defer tee-supplicant launch if it's bundled into initrd? Once you
> > > detect OP-TEE then tee-supplicant should be launched unconditionally.
> > > As per your example below, the motivation here seems to be the TPM2
> > > device dependent on RPMB backend but what if other future systemd
> > > services come up and depend on other services offered by
> > > tee-supplicant?
> >
> > There is an annoying depedency between firmware side optee and TAs, and=
 kernel optee driver,
> > tee-supplicant in userspace and kernel TA drivers like fTPM.
> >
> > Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for =
RPMB, RPC etc.
> >
> > This patch series is adding kernel side support for RPMB handling so th=
at the dependency to
> > tee-supplicant in userspace can be removed. For fTPM use case, there is=
 still the optee RPC
> > buffer setup which currently requires tee-supplicant in userspace or fT=
PM TA will panic.
> >
> > So yes, currently, tee-supplicant must be started. But it would be grea=
t if kernel drivers
> > and firmware optee trusted applications would not depend on tee-supplic=
ant running in userspace.
>
> Agree, we are aligned here. With this patch-set we aim to achieve
> that, the user-space dependency for kernel drivers is hard to manage
> and it's better to get rid of it. However, backwards compatibility for
> distros will still require starting tee-supplicant.
>
> > The startup sequence is really tricky to get right. My fTPM use case is=
 using the TPM device
> > to encrypt rootfs and thus all SW components including tee-supplicant n=
eed to run early in
> > initramfs. Currently also switch from initramfs to main rootfs requires=
 unloading
> > fTPM kernel driver and stopping tee-supplicant in initrd, and then star=
ting tee-supplicant
> > and loading fTPM kernel driver from main rootfs. udev and automatic mod=
ule loading for
> > fTPM can not be used due to the tee-supplicant userspace dependency.
>
> This is one of the reasons for gating tee-supplicant loading which I
> was looking for. What happens if we want to keep tee-supplicant alive
> when we migrate from initramfs to real rootfs? Does it work?
>
> >
> > As an example, here is v6 of this series on rockpi4b using fTPM TA with=
 systemd based initrd
> > without tee-supplicant and fTPM TA panics because the RPC setup is miss=
ing:
>
> I think this is due to RPC allocation requested from tee-supplicant
> during RPMB operations. Can you try following untested optee-os diff
> and see if it resolves the problem for you?

Scratch that as I can see Jens has already reworked that code here [1]
and I suppose you are running on top of that. Can you rather add
further RPC debugging prints to see which RPC gets invoked when
running fTPM TA?

[1] https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/

-Sumit

>
> diff --git a/core/tee/tee_rpmb_fs.c b/core/tee/tee_rpmb_fs.c
> index 0ed30933b..b3d4d077a 100644
> --- a/core/tee/tee_rpmb_fs.c
> +++ b/core/tee/tee_rpmb_fs.c
> @@ -418,11 +418,11 @@ static void tee_rpmb_free(struct tee_rpmb_mem *mem)
>                 return;
>
>         if (mem->phreq_mobj) {
> -               thread_rpc_free_payload(mem->phreq_mobj);
> +               thread_rpc_free_kernel_payload(mem->phreq_mobj);
>                 mem->phreq_mobj =3D NULL;
>         }
>         if (mem->phresp_mobj) {
> -               thread_rpc_free_payload(mem->phresp_mobj);
> +               thread_rpc_free_kernel_payload(mem->phresp_mobj);
>                 mem->phresp_mobj =3D NULL;
>         }
>  }
> @@ -440,8 +440,8 @@ static TEE_Result tee_rpmb_alloc(size_t req_size,
> size_t resp_size,
>
>         memset(mem, 0, sizeof(*mem));
>
> -       mem->phreq_mobj =3D thread_rpc_alloc_payload(req_s);
> -       mem->phresp_mobj =3D thread_rpc_alloc_payload(resp_s);
> +       mem->phreq_mobj =3D thread_rpc_alloc_kernel_payload(req_s);
> +       mem->phresp_mobj =3D thread_rpc_alloc_kernel_payload(resp_s);
>
>         if (!mem->phreq_mobj || !mem->phresp_mobj) {
>                 res =3D TEE_ERROR_OUT_OF_MEMORY;
>
> >
> > https://ledge.validation.linaro.org/scheduler/job/87488
> >
> > [[0;32m  OK  [0m] Finished [0;1;39mFile System Check on /dev/mapper/usr=
[0m.
> > E/TC:? 0 get_rpc_alloc_res:645 RPC allocation failed. Non-secure world =
result: ret=3D0xffff000c ret_origin=3D0x2
> > E/TC:? 0
> > E/TC:? 0 TA panicked with code 0xffff000c
> > E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
> > E/LD:   arch: aarch64
> > E/LD:  region  0: va 0x40005000 pa 0x3061b000 size 0x002000 flags rw-s =
(ldelf)
> > E/LD:  region  1: va 0x40007000 pa 0x3061d000 size 0x008000 flags r-xs =
(ldelf)
> > E/LD:  region  2: va 0x4000f000 pa 0x30625000 size 0x001000 flags rw-s =
(ldelf)
> > E/LD:  region  3: va 0x40010000 pa 0x30626000 size 0x004000 flags rw-s =
(ldelf)
> > E/LD:  region  4: va 0x40014000 pa 0x3062a000 size 0x001000 flags r--s
> > E/LD:  region  5: va 0x40015000 pa 0x306b2000 size 0x011000 flags rw-s =
(stack)
> > E/LD:  region  6: va 0x40026000 pa 0xe50ce000 size 0x002000 flags rw-- =
(param)
> > E/LD:  region  7: va 0x40062000 pa 0x00001000 size 0x068000 flags r-xs =
[0]
> > E/LD:  region  8: va 0x400ca000 pa 0x00069000 size 0x01f000 flags rw-s =
[0]
> > E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x40062000
> > E/LD:  Call stack:
> > E/LD:   0x400a00c0
> > E/LD:   0x40062b40
> > E/LD:   0x400631b8
> > E/LD:   0x40081f44
> > E/LD:   0x4009b060
> > E/LD:   0x40063a2c
> > E/LD:   0x400a6298
> > E/LD:   0x4009b214
> > [    7.212584] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke er=
ror: 0xffff3024
> > [    7.213281] tpm tpm0: tpm_try_transmit: send(): error -53212
> > [    7.213820] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke er=
ror: 0xffff3024
> > [    7.214493] tpm tpm0: tpm_try_transmit: send(): error -53212
> > [    7.214996] optee-ftpm optee-ta-bc50d971-d4c9-42c4-82cb-343fb7f37896=
: ftpm_tee_probe: tpm_chip_register failed with rc=3D-53212
> >          Mounting [0;1;39m/sysusr/usr[0m...
> >
> > This series adds the RPMB support in kernel, if HW supports it, but som=
e HW doesn't and the
> > tee-supplicant is emulating it as fall back.
>
> That's just for testing purposes, right? It won't be used to implement
> disk encryption for that HW.
>
> > Userspace needs to know if tee-supplicant start
> > is needed. Thus to me, exporting the RPMB routing details is useful for=
 userspace.
> >
> > It's one thing to have a full control of HW and SW and force a policy, =
like always
> > waiting for a specific TPM device to appear, but then again distros sho=
uld be able
> > to have automatic detection of TPM devices if firmware used them too an=
d then
> > start the needed bits in userspace, which depend on the firmware and HW=
 configuration,
> > like which SW components are needed for RPMB storage, kernel or tee-sup=
plicant in userspace.
> >
> > These could possibly be just bugs in fTPM kernel driver and fTPM TA in =
optee world,
> > which should be able to handle missing RPC and RPMB too and retry later=
 on. Right now
> > without tee-supplicant they panic early in boot and become unusable for=
 the rest of the
> > power cycle.
>
> I very much would like to see fTPM working without dependency on
> tee-supplicant. If there are any further problems you see then please
> feel free to report.
>
> -Sumit
>
> >
> > Cheers,
> >
> > -Mikko
