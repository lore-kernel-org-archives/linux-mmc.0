Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7447F78
	for <linux-mmc@vger.kernel.org>; Wed, 15 May 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759507; cv=none; b=RiSv7hvTvkp5Wes19DM4ZR2lCpPzIIcoXF65ifycr1VMMcXGECG7qtzKv2iw6jgqmP1Ie42ImR6bt1hKP4lgZfU3gsjblQ2FDhApsEGr3bzD+J0XB+W3zOLdnbbOOX7UJ+kS4fY2Mkyp/GM5twCu7PtJJekY8H7b5vcdjdHDr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759507; c=relaxed/simple;
	bh=4Q5HAZ1PCI7nfhlzx21vRPaImJU5ov2Hn7/gHcPDvM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Loo/ZEiF5mgrANCAaFjGoOvOLUwD24TQW8+nouSrm2eHGtdnmYkHR8Y4TwQqOBqYz36So+wLvYlVBtUuATYQ4J69l1B7oC/B5l0Tf/BViT6RSLYa50YuKPPpTBEoeTM0HHkNPUGA1hvXEnw4NS/89e5LS4d/RVWi98J3S3E71vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jm4yOnaJ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jm4yOnaJ"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b295d6b7fbso2508358eaf.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 May 2024 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715759504; x=1716364304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwTCo9VTJAEG2xNDHnMRcYBUbCjFDYNq/NO91z/5vQM=;
        b=Jm4yOnaJf6tYMmUdh1qhg43jyWGx5KGHDeIAZAavPnmgBJnqFiWRzvybASznRWKN1y
         K8Q3YxiUERnZ+bHvaZJrF6U2o6MG10B9/nYtcyJj9GrYn+G0nSj9FsoN0tfsXVL3N++7
         p83ypAdzDrCscHY6hCIVTKXWMuyVNYICSG6LnYtkRr+/lcQUCM9L3HkJV0/QHodAtXYF
         cOfZj1Nff8YBnGiuVYeaw7U0nwFuC6cWr8w49YCIOLQmbhJgeX32YCTuCsz+orWEg3h+
         yULeF4tamOgQuStgk2uk6VJBfk26q8W3St8qOmLRv8Xl2pnnjBAR2ZDTsI6K17YT40Rs
         +C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715759504; x=1716364304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwTCo9VTJAEG2xNDHnMRcYBUbCjFDYNq/NO91z/5vQM=;
        b=C5pewOQmMQRreHWvEXYhDLHhHAsqT6uxP7c7+3GHy1gkpr2AVaTJrQejKkde+lvQ1M
         H99C7zalU5KyjpqPYJOtuDL3w7yH98x2jCtbiWWa5NX/eWcrzd61OWkENmBB6/u5+x3y
         BFe2e81LdTOv9WvfFxK66bMzZ7Gj3Ca9L54jMgqx+ddDU3CnjLt8YuesU6XxYMAlhGiJ
         uMM5/Ny2bnD9KVehhr20hzOz63ll58UFDGKbx9+ynUaPiAPKhe0rlg3IK0vlVnk5HiH6
         Dc5MO9IkfA2eN0rDDvF7sqg2fYql2JaA6tTRWVcNqu8y/4RuRV3mdneLIdolXJKt/IFn
         X6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVq0jgzOvIkJQgKregX2TR4nJfsbHQMvYCPg+MxVozZ3x5uoqP4c4KahqWD8mWf/Br/685WCfXJcDRXsXj8JHbNWOpbYRhdm5zi
X-Gm-Message-State: AOJu0Yw+hMt7LqZvBbE28hXyTogJm0tzAdq7H42nK4xmKduyoI8q0n8u
	tudTTkV16ufUNTthY/qhCOT+9HhIuZh3+JuAsPirC1SUdtfu2kQt1NDFiyb+wTO17QRO9yK9u/I
	0AjHrUDqg2yrEkmaTzsgPU2dehaEtSDHDOGuM2w==
X-Google-Smtp-Source: AGHT+IGAburtXOMNRa7ZyxNW9TgscmwnnyZHwK1918jbeXwXl7Z8rxObuqnWcA8q5eaZVbj9xIt0lwpW7MbBrkNlKP8=
X-Received: by 2002:a05:6871:58a3:b0:239:61ce:9a53 with SMTP id
 586e51a60fabf-24172a236b9mr17661545fac.5.1715759503579; Wed, 15 May 2024
 00:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
 <20240507091619.2208810-2-jens.wiklander@linaro.org> <2024051424-shack-blinking-547a@gregkh>
In-Reply-To: <2024051424-shack-blinking-547a@gregkh>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 15 May 2024 09:51:32 +0200
Message-ID: <CAHUa44FepEVKYPhmH1zvSHOiCMPBwagLSgMmqMyDxewsTxT_-w@mail.gmail.com>
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

On Tue, May 14, 2024 at 5:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 07, 2024 at 11:16:17AM +0200, Jens Wiklander wrote:
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands. Such a partition provides authenticated and replay
> > protected access, hence suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB driver
> > interface which can be accessed by the optee driver to facilitate early
> > RPMB access to OP-TEE OS (secure OS) during the boot time.
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  MAINTAINERS              |   7 ++
> >  drivers/misc/Kconfig     |  10 ++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmb.h     | 136 +++++++++++++++++++++++
> >  5 files changed, 387 insertions(+)
> >  create mode 100644 drivers/misc/rpmb-core.c
> >  create mode 100644 include/linux/rpmb.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8999497011a2..e83152c42499 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19012,6 +19012,13 @@ T:   git git://linuxtv.org/media_tree.git
> >  F:   Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-=
rotate.yaml
> >  F:   drivers/media/platform/sunxi/sun8i-rotate/
> >
> > +RPMB SUBSYSTEM
> > +M:   Jens Wiklander <jens.wiklander@linaro.org>
> > +L:   linux-kernel@vger.kernel.org
> > +S:   Supported
> > +F:   drivers/misc/rpmb-core.c
> > +F:   include/linux/rpmb.h
> > +
> >  RPMSG TTY DRIVER
> >  M:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >  L:   linux-remoteproc@vger.kernel.org
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..dbff9e8c3a03 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -104,6 +104,16 @@ config PHANTOM
> >         If you choose to build module, its name will be phantom. If uns=
ure,
> >         say N here.
> >
> > +config RPMB
> > +     tristate "RPMB partition interface"
> > +     depends on MMC
> > +     help
> > +       Unified RPMB unit interface for RPMB capable devices such as eM=
MC and
> > +       UFS. Provides interface for in-kernel security controllers to a=
ccess
> > +       RPMB unit.
> > +
> > +       If unsure, select N.
> > +
> >  config TIFM_CORE
> >       tristate "TI Flash Media interface support"
> >       depends on PCI
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index ea6ea5bbbc9c..8af058ad1df4 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)         +=3D lkdtm/
> >  obj-$(CONFIG_TIFM_CORE)              +=3D tifm_core.o
> >  obj-$(CONFIG_TIFM_7XX1)              +=3D tifm_7xx1.o
> >  obj-$(CONFIG_PHANTOM)                +=3D phantom.o
> > +obj-$(CONFIG_RPMB)           +=3D rpmb-core.o
> >  obj-$(CONFIG_QCOM_COINCELL)  +=3D qcom-coincell.o
> >  obj-$(CONFIG_QCOM_FASTRPC)   +=3D fastrpc.o
> >  obj-$(CONFIG_SENSORS_BH1770) +=3D bh1770glc.o
> > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > new file mode 100644
> > index 000000000000..e42a45debc76
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2021 - 2024 Linaro Ltd.
> > + */
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/rpmb.h>
> > +#include <linux/slab.h>
> > +
> > +static struct list_head rpmb_dev_list;
> > +static DEFINE_MUTEX(rpmb_mutex);
> > +static struct blocking_notifier_head rpmb_interface =3D
> > +     BLOCKING_NOTIFIER_INIT(rpmb_interface);
> > +
> > +/**
> > + * rpmb_dev_get() - increase rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > +{
> > +     if (rdev)
> > +             get_device(rdev->parent_dev);
>
> Odd, why are you thinking the parent reference has anything to do with
> this device's reference?
>
> Why isn't this a "real" device and part of the driver model properly?
> This way of "hanging onto" a device and attempting to influence it's
> reference count is odd, please make this real and not "fake".

I did this in response to
https://lore.kernel.org/lkml/CAPDyKFqNhGWKm=3D+7niNsjXOjEJE3U=3Do7dRNG=3DJq=
pptUSo9G-ug@mail.gmail.com/

Perhaps "parent_dev" isn't the best name. The struct rpmb_dev can be
seen as another representation of the underlying device. The life
cycle of struct rpmb_dev is tied to the underlying device with
rpmb_dev_register() and rpmb_dev_unregister(). Just as
rpmb_route_frames() forwards the frames to the device, rpmb_dev_{get,
put}() does the corresponding thing.

>
> Bonus, you get that notifier callback "for free" if you do that.  But
> really, notifier callbacks are a pain, are you sure you want that?

Yes, they are needed because the device may show up late and the
OP-TEE driver doesn't know if any device will show up. As Ulf pointed
out in the link above, at this point, there's no need to tell user
space about this kernel internal abstraction.

Thanks,
Jens

>
> thanks,
>
> greg k-h
