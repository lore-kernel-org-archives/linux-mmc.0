Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635241A81;
	Wed, 15 May 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760289; cv=none; b=WClsduHvo3Xx5lw7P6BJdShxDUyomVGqm1H/VckUDhRKfzhmWv8NipgNWBNnOFgMRy2z17WKfMQf4OtQvj7qxk4jqdfJdx4N9NQ0x4juMuDlll/URefF3v1AyxcCtD2IQNQ5hrGlpxfwI/8Pjb3MRK+BDUqMW2PqZ5CBffwDLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760289; c=relaxed/simple;
	bh=wuudiOglpt4DKThuTsQfr2VxE75TJXgXe+nOKLcrb2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmV1L4XZ+uq8EceEvIunBsyjggT2VSor58aVOOZfKeVKoUIHaRZTAE7WGrQi2ipf3UxbE9o8SUKj+qcClFCM1sQreBTMHXYmkoxbh+7yuAYgoTjOjsrI7Wn53Sn29V+KMaJfIdo6gv7JZbirkIUx3sguZcDm0G7gbwsY+Dt9GsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bMvEhrfB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bMvEhrfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96358C116B1;
	Wed, 15 May 2024 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715760289;
	bh=wuudiOglpt4DKThuTsQfr2VxE75TJXgXe+nOKLcrb2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMvEhrfBqRiY2euQIMEkNUl+hu9/oe7AG09doTeoKUeu3QaebnrnVeeo/nYim0r28
	 Jh8v1B7k0WGqpu8CywYKlhAjQHmqG3E3E97youlEhLuVqh904ZS/joQA7t+hS/EvCa
	 sjhexrDmt75QkYxIJ3j3dzH63Ij9Az99VbmfgW+o=
Date: Wed, 15 May 2024 10:04:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Manuel Traut <manut@mecka.net>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v6 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Message-ID: <2024051544-clarinet-baffle-c9d6@gregkh>
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
 <20240507091619.2208810-2-jens.wiklander@linaro.org>
 <2024051424-shack-blinking-547a@gregkh>
 <CAHUa44FepEVKYPhmH1zvSHOiCMPBwagLSgMmqMyDxewsTxT_-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44FepEVKYPhmH1zvSHOiCMPBwagLSgMmqMyDxewsTxT_-w@mail.gmail.com>

On Wed, May 15, 2024 at 09:51:32AM +0200, Jens Wiklander wrote:
> On Tue, May 14, 2024 at 5:45 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 07, 2024 at 11:16:17AM +0200, Jens Wiklander wrote:
> > > A number of storage technologies support a specialised hardware
> > > partition designed to be resistant to replay attacks. The underlying
> > > HW protocols differ but the operations are common. The RPMB partition
> > > cannot be accessed via standard block layer, but by a set of specific
> > > RPMB commands. Such a partition provides authenticated and replay
> > > protected access, hence suitable as a secure storage.
> > >
> > > The initial aim of this patch is to provide a simple RPMB driver
> > > interface which can be accessed by the optee driver to facilitate early
> > > RPMB access to OP-TEE OS (secure OS) during the boot time.
> > >
> > > A TEE device driver can claim the RPMB interface, for example, via
> > > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > > provides a callback to route RPMB frames to the RPMB device accessible
> > > via rpmb_route_frames().
> > >
> > > The detailed operation of implementing the access is left to the TEE
> > > device driver itself.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  MAINTAINERS              |   7 ++
> > >  drivers/misc/Kconfig     |  10 ++
> > >  drivers/misc/Makefile    |   1 +
> > >  drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/rpmb.h     | 136 +++++++++++++++++++++++
> > >  5 files changed, 387 insertions(+)
> > >  create mode 100644 drivers/misc/rpmb-core.c
> > >  create mode 100644 include/linux/rpmb.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 8999497011a2..e83152c42499 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -19012,6 +19012,13 @@ T:   git git://linuxtv.org/media_tree.git
> > >  F:   Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-rotate.yaml
> > >  F:   drivers/media/platform/sunxi/sun8i-rotate/
> > >
> > > +RPMB SUBSYSTEM
> > > +M:   Jens Wiklander <jens.wiklander@linaro.org>
> > > +L:   linux-kernel@vger.kernel.org
> > > +S:   Supported
> > > +F:   drivers/misc/rpmb-core.c
> > > +F:   include/linux/rpmb.h
> > > +
> > >  RPMSG TTY DRIVER
> > >  M:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > >  L:   linux-remoteproc@vger.kernel.org
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 4fb291f0bf7c..dbff9e8c3a03 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -104,6 +104,16 @@ config PHANTOM
> > >         If you choose to build module, its name will be phantom. If unsure,
> > >         say N here.
> > >
> > > +config RPMB
> > > +     tristate "RPMB partition interface"
> > > +     depends on MMC
> > > +     help
> > > +       Unified RPMB unit interface for RPMB capable devices such as eMMC and
> > > +       UFS. Provides interface for in-kernel security controllers to access
> > > +       RPMB unit.
> > > +
> > > +       If unsure, select N.
> > > +
> > >  config TIFM_CORE
> > >       tristate "TI Flash Media interface support"
> > >       depends on PCI
> > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > index ea6ea5bbbc9c..8af058ad1df4 100644
> > > --- a/drivers/misc/Makefile
> > > +++ b/drivers/misc/Makefile
> > > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)         += lkdtm/
> > >  obj-$(CONFIG_TIFM_CORE)              += tifm_core.o
> > >  obj-$(CONFIG_TIFM_7XX1)              += tifm_7xx1.o
> > >  obj-$(CONFIG_PHANTOM)                += phantom.o
> > > +obj-$(CONFIG_RPMB)           += rpmb-core.o
> > >  obj-$(CONFIG_QCOM_COINCELL)  += qcom-coincell.o
> > >  obj-$(CONFIG_QCOM_FASTRPC)   += fastrpc.o
> > >  obj-$(CONFIG_SENSORS_BH1770) += bh1770glc.o
> > > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > > new file mode 100644
> > > index 000000000000..e42a45debc76
> > > --- /dev/null
> > > +++ b/drivers/misc/rpmb-core.c
> > > @@ -0,0 +1,233 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> > > + * Copyright(c) 2021 - 2024 Linaro Ltd.
> > > + */
> > > +#include <linux/device.h>
> > > +#include <linux/init.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/list.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/rpmb.h>
> > > +#include <linux/slab.h>
> > > +
> > > +static struct list_head rpmb_dev_list;
> > > +static DEFINE_MUTEX(rpmb_mutex);
> > > +static struct blocking_notifier_head rpmb_interface =
> > > +     BLOCKING_NOTIFIER_INIT(rpmb_interface);
> > > +
> > > +/**
> > > + * rpmb_dev_get() - increase rpmb device ref counter
> > > + * @rdev: rpmb device
> > > + */
> > > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > > +{
> > > +     if (rdev)
> > > +             get_device(rdev->parent_dev);
> >
> > Odd, why are you thinking the parent reference has anything to do with
> > this device's reference?
> >
> > Why isn't this a "real" device and part of the driver model properly?
> > This way of "hanging onto" a device and attempting to influence it's
> > reference count is odd, please make this real and not "fake".
> 
> I did this in response to
> https://lore.kernel.org/lkml/CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com/

And I would argue, "Yes, we do need yet-another class and sysfs entry".

This is a "device" that a driver controls, it is NOT the parent device,
it is a class device, so as such, make it one.  That's what the driver
model is for.  Trying to avoid it causes problems.

> Perhaps "parent_dev" isn't the best name. The struct rpmb_dev can be
> seen as another representation of the underlying device.

I.e. a class device.  So use that :)

> The life
> cycle of struct rpmb_dev is tied to the underlying device with
> rpmb_dev_register() and rpmb_dev_unregister(). Just as
> rpmb_route_frames() forwards the frames to the device, rpmb_dev_{get,
> put}() does the corresponding thing.

You should never be modifying the reference count of a device you really
do not control, unless you are trying to make sure it is present to use
it yourself.

> > Bonus, you get that notifier callback "for free" if you do that.  But
> > really, notifier callbacks are a pain, are you sure you want that?
> 
> Yes, they are needed because the device may show up late and the
> OP-TEE driver doesn't know if any device will show up. As Ulf pointed
> out in the link above, at this point, there's no need to tell user
> space about this kernel internal abstraction.

If this is a representation of how the device is interacted with, then
yes, you do need to represent that.

thanks,

greg k-h
