Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDA15B984
	for <linux-mmc@vger.kernel.org>; Wed, 29 May 2024 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960379; cv=none; b=a8zzDyCouOHblyR26kgsujRMma6YSqtLUPhbp3g/1o5+TGEi9LSesMZMTZcHs4Xc9ndbqUSIx0suoH0adRU4NFMa7bn5vlhtZPSx2to/GIbdA3DRZAgvkh0eA8PvDnNdBEHjWhH3GRd8pp62ul0C8JbnbOJpBZd0es966a5eAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960379; c=relaxed/simple;
	bh=sXgwCUC0sQjZAv8pdBXHiuXTQoFTMkYAXip7NzBwyqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SY3n390wy4qDsLzj4zfh1kQarI7AQEwqZLHYkpjI5YZ3aL25WRVqnIcHHmV9Ed1Gmpvp4rnqAV3UxdfYBomt9gCUlWgKiAEAsUbGsAIeFDguYQPA3FxJWUQb95B9B939jCjNFATmFka73WfM6+C5w34aFsYdM3hWUNhp8UeYDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p49MXVqc; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p49MXVqc"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-804cb4ad47dso272331241.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 22:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716960376; x=1717565176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15ENZisTgKP86u3z7+Gtpy0dd++13PTR5V24Sl4v+pI=;
        b=p49MXVqc63R5H+jkkrJnx3IJSdbZVsbxdeklEXpOAqT1TwQpSH9oyBF0ggUUq3RE9H
         lWa1IInuTQKV5oPd7QHKIfswbId4F27dCIcJWGCF8ukxuXcDYUU3nl7G/gQRWVbAEjRS
         7v3WFyPKuJ+4IvwvHTE++YDG0CSlklyTd4toZfKHqLBilBEy5hJBLgzsQkwW20BJnIaw
         PBywxYI0c9Y/4JF8JN3TIZ/4XKHn3yhDxRbAEbeNW5VRrinSECRKzmESb7+FdHYjppWT
         /b3oIX+skPsX/ohkGO8UnBzNDYd/uaSqxajRGf4oxBnY1Cm4HkdJrOz2ttBoZrchTclq
         CSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716960376; x=1717565176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15ENZisTgKP86u3z7+Gtpy0dd++13PTR5V24Sl4v+pI=;
        b=baRzq04OKwZtG2WjTjn2rFI+WvueJNqYM57iCfVqW+QpYzCzFkdGQwmHe+U34tXmUk
         6V9WAj2yx2xwbjh3eXGLjZmCw/1GsdC6GWCBdOzOYoCerpuSSbLem/n1lxKRu3oqBsOK
         koJVcGFISJ9xqncPaV42IpYqv2nPoodi3usZjBPzfczPagUVu0rSWwQeccfFMXk2btwa
         7x5ZK1jA0p1cJJKPfI3QtZnzGy8gEm0kWexIumxuyOFW+yizvMmD40D8Vi6TE1vULJXU
         8kcfaAhi79KKxxmPoE0vjiqc1kgJgVvabxRcdAgrEs2CU4RIoxsfMcmnEBWK6dHjdru1
         oBuA==
X-Forwarded-Encrypted: i=1; AJvYcCUG3D4OsQjWu/v8GAAwA/IBGBq/ENnkKk/wDXPxodhBe0HEi+cR1SPXbTSZELg7RfY52qzUAa9MBjZShD0ZxhqDlzSD71h7UJLg
X-Gm-Message-State: AOJu0YwTfAz4d60/iYPkvvEg2dPYCz4n+BrKCeVMCSx54oohJkqJ1Sh8
	17yS2GSp6LM8XmWOYuJwLyb2pzNYvlMEiBHminJFlCAnZJaqBbJVdeUBIb3tJZ6H7l0TftP0nwa
	d+N6c1FUF/1gLRfGT8DACz846iGG/T2YcL6JIvA==
X-Google-Smtp-Source: AGHT+IGlTxxgeYGP2YfV8+ZTwt7HTIl+R8Dwu5gdKq4zDJ3MAVZ5rbhlD8FwZvpwmiVig13ibCFackQouSPTKa4Nui4=
X-Received: by 2002:a05:6102:2404:b0:48b:8f15:8a8f with SMTP id
 ada2fe7eead31-48b9ce2e281mr698247137.8.1716960375838; Tue, 28 May 2024
 22:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com> <ZlWkSCCjJ2fbE2ML@nuoska>
In-Reply-To: <ZlWkSCCjJ2fbE2ML@nuoska>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 10:56:04 +0530
Message-ID: <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
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

Hi Mikko,

On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to prob=
e and
> > > > use an RPMB device via the RPMB subsystem instead of passing the RP=
MB
> > > > frames via tee-supplicant in user space. A fallback mechanism is ke=
pt to
> > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > available.
> > > >
> > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > devices until one is found with the expected RPMB key already
> > > > programmed.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Tested-by: Manuel Traut <manut@mecka.net>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > > >  MAINTAINERS                               |   1 +
> > > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > > >  drivers/tee/optee/device.c                |   7 +
> > > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > > >  drivers/tee/optee/optee_smc.h             |   2 +
> > > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++=
++++
> > > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentat=
ion/ABI/testing/sysfs-class-tee
> > > > new file mode 100644
> > > > index 000000000000..c9144d16003e
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > > @@ -0,0 +1,15 @@
> > > > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > >
> > > Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?
> >
> > Doesn't the routing model concern tee-supplicant more than a TEE
> > client? Then it might make more sense to have
> > /sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
> > devices representing the same internal struct optee makes it easier to
> > find. Anyway, I don't mind removing one. Mikko, what do you prefer?
>
> As simple as possible. A single sysfs file is enough. Even the existence =
of the sysfs file
> could be the needed indicator for userspace to queue tee-supplicant start=
up.
>
> Outside of these patches, I think the optee RPC setup with fTPM TA is one=
 area which
> currently requires tee-supplicant to be started. Detecting the existence =
of TPM before
> kernel drivers are loaded is possible via the exported EFI logs from firm=
ware to kernel
> or ACPI TPM2 table entry, and detecting optee and thus starting tee-suppl=
icant in userspace too.

One thing I am trying to find an answer about is why do we need to
defer tee-supplicant launch if it's bundled into initrd? Once you
detect OP-TEE then tee-supplicant should be launched unconditionally.
As per your example below, the motivation here seems to be the TPM2
device dependent on RPMB backend but what if other future systemd
services come up and depend on other services offered by
tee-supplicant?

-Sumit

>
> In userspace and systemd it's just important to know that service need to=
 wait for a TPM2
> device to appear in early initrd and when can things be postponed to main=
 rootfs and later
> stages. Kernel and udev will bring up the device then once discovered.
> Knowledge about the RPMB backend is important when something like TPM2 de=
vice
> depends on it.
>
> Hope this helps,
>
> -Mikko
