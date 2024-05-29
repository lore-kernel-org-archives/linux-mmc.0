Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB19163A97
	for <linux-mmc@vger.kernel.org>; Wed, 29 May 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966600; cv=none; b=XVsL+xtfCLYVQug8tsjrdPQ13TMaFugAXlKfgAbAqYWbJFq0Mbb0MunxnOgeYRJaj9GydgE5r9g4LnkSU2OdktPmcsD4dOaF2ESGcfQhFovps7xg5plyVh5FOeuZ5W/iZ/wtYtp70eFPGC5E4sbJG+n4OBahF0DpKTc/Q1fSwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966600; c=relaxed/simple;
	bh=IR+RvCK+/4xLwGVx3D0HTnj+/AXe+O8Ox+ve92jpdXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbb4T0GoaIgne7uoQMVwdaiFVzUuEOBqSm2yfWjimP+vMci2JCG3Eh58FiN0GHXLkD3zdSPjnw5Lk20rFYE17E3XfFQq7L7My6npyn1pU2ryVfZEUh2BOpc8SuNn6DvXZ6Ad0F1poRr0IUxcmtE5j7DmqmeysTf9hWOdP1SUR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqA3SE9g; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqA3SE9g"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52965199234so1937286e87.2
        for <linux-mmc@vger.kernel.org>; Wed, 29 May 2024 00:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716966595; x=1717571395; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ppWh6NKQYdWs0IByPlxTYWyYUwCJ5vCPvljvtNRXhi8=;
        b=nqA3SE9gaRmf3ztoNBRaHHts8MyafMP7sr6aMMi8mq36h6WNlF6x9+ixvIxrFw7UlZ
         IAuO7b4pwpE8r++FXzjgJNjcL0dosM2cM6FeXHipn0HeFmrK8bYRZkp03q0RTdjcsxvC
         xB/9EfCxdyHAaDnOQpYvl8w/exn1fm84Eh75/8y/mm9JzJYxH5UVo6FASHxiile/15y7
         vdALEimC27EzFoG8PZs4vASaLS/fY/26d8dP3pguwA+fau6mqxnirGvXMFtOEJcJ1bE4
         /S+LeysSuOhCB9MGFG7FnHBZA+GPJbjdFzfbQ92FN5RdeVE+PkM1ZX6DKcdp60ZHShNx
         zShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966595; x=1717571395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppWh6NKQYdWs0IByPlxTYWyYUwCJ5vCPvljvtNRXhi8=;
        b=TalYdvmnxlsRlnOeGUkGLWmN/n57eVPWT3XTz/N+ZMJYFTwW//BaCBHwHtVwv5d8eb
         ehUr01otC2AtkArEVhQ1W2jwPw3Xix9tv4GB3KAkgn0F8WeRZVZfoo6/x0ISgTDwsZEP
         eZuL51mNWn7j08ulzwpyOi+6GXTAyeJj38QSyzNymYj5nHfykg1jT4+Oq1q5CyF7nUL3
         IFnTBdYdZt66cfUlBSF6I7lThEvxRIVI8Yn7BwHy/uW+9Hvfg6hJYm5LXZ/mCb+Nig2y
         aBVw1lcXbY+qhqXG7+44cpQ3rYyNAL1WDB6fJwEN5oP+hoM3vytdFCxKj7TsL7yomRwa
         V/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm2OO+Cd4EW3glQehgOjSOEF6fASstjKIqJEyTa0c5qaw0tMPPxr3n2T8DGAwmtlZuBjmrd5G7+/Bkzqi3mgh1ncGDr50ul05G
X-Gm-Message-State: AOJu0Yyc0F3LjAN9zHdNoYIMYmG5MlzTdrWV4Ud4FYNT+kOxs8nVOGYm
	lwejddtpxZzoDFBCqgzuNMpnSd7qdIwuhL3M8S1BjLgFGBgxArVt/bVCzZuOXUk=
X-Google-Smtp-Source: AGHT+IE7o2uN79r0sgg4WFBLqbMPFaFhyXoHZRR8FldfhiqvqQHJeK4RqvGxIzkO8Tm/iLsqVYB7aA==
X-Received: by 2002:a19:4319:0:b0:523:b261:3dde with SMTP id 2adb3069b0e04-52965199475mr8481737e87.41.1716966595081;
        Wed, 29 May 2024 00:09:55 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296ee4a8f2sm1169381e87.87.2024.05.29.00.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:09:54 -0700 (PDT)
Date: Wed, 29 May 2024 10:09:52 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Traut <manut@mecka.net>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Message-ID: <ZlbUwI0G3HGvioNm@nuoska>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
 <ZlWkSCCjJ2fbE2ML@nuoska>
 <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>

Hi,

On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> Hi Mikko,
> 
> On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> >
> > Hi,
> >
> > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > On Mon, May 27, 2024 at 3:00 PM Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > > >
> > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> > > > > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > > > > frames via tee-supplicant in user space. A fallback mechanism is kept to
> > > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > > available.
> > > > >
> > > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > > devices until one is found with the expected RPMB key already
> > > > > programmed.
> > > > >
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > Tested-by: Manuel Traut <manut@mecka.net>
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > > > >  MAINTAINERS                               |   1 +
> > > > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > > > >  drivers/tee/optee/device.c                |   7 +
> > > > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > > > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > > > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > > > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > > > >  drivers/tee/optee/optee_smc.h             |   2 +
> > > > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
> > > > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > > > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> > > > > new file mode 100644
> > > > > index 000000000000..c9144d16003e
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > > > @@ -0,0 +1,15 @@
> > > > > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > > >
> > > > Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?
> > >
> > > Doesn't the routing model concern tee-supplicant more than a TEE
> > > client? Then it might make more sense to have
> > > /sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
> > > devices representing the same internal struct optee makes it easier to
> > > find. Anyway, I don't mind removing one. Mikko, what do you prefer?
> >
> > As simple as possible. A single sysfs file is enough. Even the existence of the sysfs file
> > could be the needed indicator for userspace to queue tee-supplicant startup.
> >
> > Outside of these patches, I think the optee RPC setup with fTPM TA is one area which
> > currently requires tee-supplicant to be started. Detecting the existence of TPM before
> > kernel drivers are loaded is possible via the exported EFI logs from firmware to kernel
> > or ACPI TPM2 table entry, and detecting optee and thus starting tee-supplicant in userspace too.
> 
> One thing I am trying to find an answer about is why do we need to
> defer tee-supplicant launch if it's bundled into initrd? Once you
> detect OP-TEE then tee-supplicant should be launched unconditionally.
> As per your example below, the motivation here seems to be the TPM2
> device dependent on RPMB backend but what if other future systemd
> services come up and depend on other services offered by
> tee-supplicant?

There is an annoying depedency between firmware side optee and TAs, and kernel optee driver,
tee-supplicant in userspace and kernel TA drivers like fTPM.

Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for RPMB, RPC etc.

This patch series is adding kernel side support for RPMB handling so that the dependency to
tee-supplicant in userspace can be removed. For fTPM use case, there is still the optee RPC
buffer setup which currently requires tee-supplicant in userspace or fTPM TA will panic.

So yes, currently, tee-supplicant must be started. But it would be great if kernel drivers
and firmware optee trusted applications would not depend on tee-supplicant running in userspace.
The startup sequence is really tricky to get right. My fTPM use case is using the TPM device
to encrypt rootfs and thus all SW components including tee-supplicant need to run early in
initramfs. Currently also switch from initramfs to main rootfs requires unloading
fTPM kernel driver and stopping tee-supplicant in initrd, and then starting tee-supplicant
and loading fTPM kernel driver from main rootfs. udev and automatic module loading for
fTPM can not be used due to the tee-supplicant userspace dependency.

As an example, here is v6 of this series on rockpi4b using fTPM TA with systemd based initrd
without tee-supplicant and fTPM TA panics because the RPC setup is missing:

https://ledge.validation.linaro.org/scheduler/job/87488

[[0;32m  OK  [0m] Finished [0;1;39mFile System Check on /dev/mapper/usr[0m.
E/TC:? 0 get_rpc_alloc_res:645 RPC allocation failed. Non-secure world result: ret=0xffff000c ret_origin=0x2
E/TC:? 0 
E/TC:? 0 TA panicked with code 0xffff000c
E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
E/LD:   arch: aarch64
E/LD:  region  0: va 0x40005000 pa 0x3061b000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0x40007000 pa 0x3061d000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0x4000f000 pa 0x30625000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0x40010000 pa 0x30626000 size 0x004000 flags rw-s (ldelf)
E/LD:  region  4: va 0x40014000 pa 0x3062a000 size 0x001000 flags r--s
E/LD:  region  5: va 0x40015000 pa 0x306b2000 size 0x011000 flags rw-s (stack)
E/LD:  region  6: va 0x40026000 pa 0xe50ce000 size 0x002000 flags rw-- (param)
E/LD:  region  7: va 0x40062000 pa 0x00001000 size 0x068000 flags r-xs [0]
E/LD:  region  8: va 0x400ca000 pa 0x00069000 size 0x01f000 flags rw-s [0]
E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x40062000
E/LD:  Call stack:
E/LD:   0x400a00c0
E/LD:   0x40062b40
E/LD:   0x400631b8
E/LD:   0x40081f44
E/LD:   0x4009b060
E/LD:   0x40063a2c
E/LD:   0x400a6298
E/LD:   0x4009b214
[    7.212584] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
[    7.213281] tpm tpm0: tpm_try_transmit: send(): error -53212
[    7.213820] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
[    7.214493] tpm tpm0: tpm_try_transmit: send(): error -53212
[    7.214996] optee-ftpm optee-ta-bc50d971-d4c9-42c4-82cb-343fb7f37896: ftpm_tee_probe: tpm_chip_register failed with rc=-53212
         Mounting [0;1;39m/sysusr/usr[0m... 

This series adds the RPMB support in kernel, if HW supports it, but some HW doesn't and the
tee-supplicant is emulating it as fall back. Userspace needs to know if tee-supplicant start
is needed. Thus to me, exporting the RPMB routing details is useful for userspace.

It's one thing to have a full control of HW and SW and force a policy, like always
waiting for a specific TPM device to appear, but then again distros should be able
to have automatic detection of TPM devices if firmware used them too and then
start the needed bits in userspace, which depend on the firmware and HW configuration,
like which SW components are needed for RPMB storage, kernel or tee-supplicant in userspace.

These could possibly be just bugs in fTPM kernel driver and fTPM TA in optee world,
which should be able to handle missing RPC and RPMB too and retry later on. Right now
without tee-supplicant they panic early in boot and become unusable for the rest of the
power cycle.

Cheers,

-Mikko
