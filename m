Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899B4F606
	for <linux-mmc@vger.kernel.org>; Wed, 15 May 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766336; cv=none; b=llZ04JmUFUpaU79u7k5gKNGtHDHvBJk4fSwtiXPAM74KB6NAxR5frBP4AtpA5Q5FQ+G4P+euFhm886gTcAc+fmHOzrftREcPXwrgSZV37UVNo3kQRUhpudxtbgp0lNjIvg8vMf7IphzJXDrlMGORX0MEmaS1Ov5FSctgLFZzft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766336; c=relaxed/simple;
	bh=JRLsaes2n+fx1g7fTVlLvO0GErQiuRGa5Ukv0jsD8JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCWzrIIGWwl5ltInDAxlw+HnNZmK9PF+8ZI60WQyXa0IJDgY+vAHGD3nAadDidCOEWvuRTC2a+H7YEPsA8rL1lOWZCcvDyftNopBPYfW/01rH8nti+VAmiNNlFIUVvk/8JvDlSKhF2IswRUU3i7RLo/rs+hm2XUQCIrmXt+W1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WmWbDqtN; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmWbDqtN"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23f02e15fd6so3289569fac.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 May 2024 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715766332; x=1716371132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6EkIVd0v6k33+WDHvOH1msWEs1FiIcoXhRYw7Xr9mg=;
        b=WmWbDqtNry4Gl2cIJTlpeGQQlf6abdKndgdSRP+G47fnyyeddMNCL5MMusKIshNxE7
         w5in/ubKi5tcx4bYpA1SgUgceRAkJQSCXUXyZYkiKopfXWImD/mTD4ZAa6vah0qXjVn/
         awBBHoYd587s/6sGKblc3FqHtRZAJWTDb2NNzBPRTTxBpG6HknqcA+dzU2U5SUHiFWWE
         1u8UJqqRZ02o77FAFXCi9pgJepkH7nB/Rz42cDhn87OrPQfioavGQlzIGix8EeuhP/h+
         N4sf+pM22p0ov4wXj1DFKghk8uirc/LKp/NUOvBwmOx1qvzPY/+Axkel+Hal6ohCzdw3
         7Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715766332; x=1716371132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6EkIVd0v6k33+WDHvOH1msWEs1FiIcoXhRYw7Xr9mg=;
        b=UQkL24k9Tm30f7fITctbRJeg2c2U3K/gBUlppzQTzc1oGcHCLP9ohpn3KaW8YCIE/F
         r+LDuOVeVWg4O+cl8iB+jyyKV1t+65H3IvbbjJwhw9eRq4QE1o3lwOUV9gVgZ4xL546O
         eddMKc/zqpGHIIEkEq54du5RpQ4pv/A8Df1P1C7Pb/SaZVK46bOBKiW5WnDZLjX8Ol3Y
         IOwpq5Nu8gnsjLayvRtqmZPkT0hxv14b0+epuZCl9htAuyRtpRcfiVmPO0LJeaGv5cco
         aifNc9GXwbRjwbhGHiWcSoPZN4vtKo6Ckit0na8qTopVeVFMpOi2C+DyMqknIA+m/LiH
         17+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYf4od2Qaq4XL52gZXx2mSX3BENr6mdysi7JoIRkXhu13q/O8AUssa3xqeU29zZ19HoNih5DL/jAoXYqOnRYtZMzguHBvCSCp2
X-Gm-Message-State: AOJu0YwDN8vnvlfYWlVlcLbE6eZ+C5VAOsh8oMUIYPu3JNQBZrsggc9p
	jJB4xHv/DR4Li1bfswr5QPJks+k5OQUzjytFQeIBpM864Qe+7vKFWD2YbrqFbU7YIj0IIkxiCb4
	YMeY4PnO1PC6K1Y5CEcZ3CxGIC//d3kveFX4MRQ==
X-Google-Smtp-Source: AGHT+IFA1vxSoRZCoQ+lFYHsLhSUmYQ1wNrbJVvrzY97iQcCxrXCA1lV/tz8D1PjoD7etTD3pYPf5QhBB5GJyU5irx4=
X-Received: by 2002:a05:6870:8552:b0:23c:ca10:cc23 with SMTP id
 586e51a60fabf-24172f84d1emr16783291fac.51.1715766331748; Wed, 15 May 2024
 02:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
 <20240507091619.2208810-2-jens.wiklander@linaro.org> <2024051424-shack-blinking-547a@gregkh>
 <CAHUa44FepEVKYPhmH1zvSHOiCMPBwagLSgMmqMyDxewsTxT_-w@mail.gmail.com> <2024051544-clarinet-baffle-c9d6@gregkh>
In-Reply-To: <2024051544-clarinet-baffle-c9d6@gregkh>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 15 May 2024 11:45:20 +0200
Message-ID: <CAHUa44FwksL_1506TLv-06UMub_7Ot43bcSPuhkP=dX9CZhESg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Manuel Traut <manut@mecka.net>, 
	Tomas Winkler <tomas.winkler@intel.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 15, 2024 at 09:51:32AM +0200, Jens Wiklander wrote:
> > On Tue, May 14, 2024 at 5:45=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, May 07, 2024 at 11:16:17AM +0200, Jens Wiklander wrote:
> > > > A number of storage technologies support a specialised hardware
> > > > partition designed to be resistant to replay attacks. The underlyin=
g
> > > > HW protocols differ but the operations are common. The RPMB partiti=
on
> > > > cannot be accessed via standard block layer, but by a set of specif=
ic
> > > > RPMB commands. Such a partition provides authenticated and replay
> > > > protected access, hence suitable as a secure storage.
> > > >
> > > > The initial aim of this patch is to provide a simple RPMB driver
> > > > interface which can be accessed by the optee driver to facilitate e=
arly
> > > > RPMB access to OP-TEE OS (secure OS) during the boot time.
> > > >
> > > > A TEE device driver can claim the RPMB interface, for example, via
> > > > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB drive=
r
> > > > provides a callback to route RPMB frames to the RPMB device accessi=
ble
> > > > via rpmb_route_frames().
> > > >
> > > > The detailed operation of implementing the access is left to the TE=
E
> > > > device driver itself.
> > > >
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > ---
> > > >  MAINTAINERS              |   7 ++
> > > >  drivers/misc/Kconfig     |  10 ++
> > > >  drivers/misc/Makefile    |   1 +
> > > >  drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++=
++++
> > > >  include/linux/rpmb.h     | 136 +++++++++++++++++++++++
> > > >  5 files changed, 387 insertions(+)
> > > >  create mode 100644 drivers/misc/rpmb-core.c
> > > >  create mode 100644 include/linux/rpmb.h
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 8999497011a2..e83152c42499 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -19012,6 +19012,13 @@ T:   git git://linuxtv.org/media_tree.git
> > > >  F:   Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-=
de2-rotate.yaml
> > > >  F:   drivers/media/platform/sunxi/sun8i-rotate/
> > > >
> > > > +RPMB SUBSYSTEM
> > > > +M:   Jens Wiklander <jens.wiklander@linaro.org>
> > > > +L:   linux-kernel@vger.kernel.org
> > > > +S:   Supported
> > > > +F:   drivers/misc/rpmb-core.c
> > > > +F:   include/linux/rpmb.h
> > > > +
> > > >  RPMSG TTY DRIVER
> > > >  M:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > > >  L:   linux-remoteproc@vger.kernel.org
> > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > > index 4fb291f0bf7c..dbff9e8c3a03 100644
> > > > --- a/drivers/misc/Kconfig
> > > > +++ b/drivers/misc/Kconfig
> > > > @@ -104,6 +104,16 @@ config PHANTOM
> > > >         If you choose to build module, its name will be phantom. If=
 unsure,
> > > >         say N here.
> > > >
> > > > +config RPMB
> > > > +     tristate "RPMB partition interface"
> > > > +     depends on MMC
> > > > +     help
> > > > +       Unified RPMB unit interface for RPMB capable devices such a=
s eMMC and
> > > > +       UFS. Provides interface for in-kernel security controllers =
to access
> > > > +       RPMB unit.
> > > > +
> > > > +       If unsure, select N.
> > > > +
> > > >  config TIFM_CORE
> > > >       tristate "TI Flash Media interface support"
> > > >       depends on PCI
> > > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > > index ea6ea5bbbc9c..8af058ad1df4 100644
> > > > --- a/drivers/misc/Makefile
> > > > +++ b/drivers/misc/Makefile
> > > > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)         +=3D lkdtm/
> > > >  obj-$(CONFIG_TIFM_CORE)              +=3D tifm_core.o
> > > >  obj-$(CONFIG_TIFM_7XX1)              +=3D tifm_7xx1.o
> > > >  obj-$(CONFIG_PHANTOM)                +=3D phantom.o
> > > > +obj-$(CONFIG_RPMB)           +=3D rpmb-core.o
> > > >  obj-$(CONFIG_QCOM_COINCELL)  +=3D qcom-coincell.o
> > > >  obj-$(CONFIG_QCOM_FASTRPC)   +=3D fastrpc.o
> > > >  obj-$(CONFIG_SENSORS_BH1770) +=3D bh1770glc.o
> > > > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > > > new file mode 100644
> > > > index 000000000000..e42a45debc76
> > > > --- /dev/null
> > > > +++ b/drivers/misc/rpmb-core.c
> > > > @@ -0,0 +1,233 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved=
.
> > > > + * Copyright(c) 2021 - 2024 Linaro Ltd.
> > > > + */
> > > > +#include <linux/device.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/list.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/rpmb.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +static struct list_head rpmb_dev_list;
> > > > +static DEFINE_MUTEX(rpmb_mutex);
> > > > +static struct blocking_notifier_head rpmb_interface =3D
> > > > +     BLOCKING_NOTIFIER_INIT(rpmb_interface);
> > > > +
> > > > +/**
> > > > + * rpmb_dev_get() - increase rpmb device ref counter
> > > > + * @rdev: rpmb device
> > > > + */
> > > > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > > > +{
> > > > +     if (rdev)
> > > > +             get_device(rdev->parent_dev);
> > >
> > > Odd, why are you thinking the parent reference has anything to do wit=
h
> > > this device's reference?
> > >
> > > Why isn't this a "real" device and part of the driver model properly?
> > > This way of "hanging onto" a device and attempting to influence it's
> > > reference count is odd, please make this real and not "fake".
> >
> > I did this in response to
> > https://lore.kernel.org/lkml/CAPDyKFqNhGWKm=3D+7niNsjXOjEJE3U=3Do7dRNG=
=3DJqpptUSo9G-ug@mail.gmail.com/
>
> And I would argue, "Yes, we do need yet-another class and sysfs entry".
>
> This is a "device" that a driver controls, it is NOT the parent device,
> it is a class device, so as such, make it one.  That's what the driver
> model is for.  Trying to avoid it causes problems.
>
> > Perhaps "parent_dev" isn't the best name. The struct rpmb_dev can be
> > seen as another representation of the underlying device.
>
> I.e. a class device.  So use that :)

I see your point.

>
> > The life
> > cycle of struct rpmb_dev is tied to the underlying device with
> > rpmb_dev_register() and rpmb_dev_unregister(). Just as
> > rpmb_route_frames() forwards the frames to the device, rpmb_dev_{get,
> > put}() does the corresponding thing.
>
> You should never be modifying the reference count of a device you really
> do not control, unless you are trying to make sure it is present to use
> it yourself.
>
> > > Bonus, you get that notifier callback "for free" if you do that.  But
> > > really, notifier callbacks are a pain, are you sure you want that?
> >
> > Yes, they are needed because the device may show up late and the
> > OP-TEE driver doesn't know if any device will show up. As Ulf pointed
> > out in the link above, at this point, there's no need to tell user
> > space about this kernel internal abstraction.
>
> If this is a representation of how the device is interacted with, then
> yes, you do need to represent that.

Thanks for straightening out this. I'll bring back the class device in
the next version

Cheers,
Jens
