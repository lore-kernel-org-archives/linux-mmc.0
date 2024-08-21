Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535918C348
	for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2024 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250025; cv=none; b=XqcDJBmqeoCsv8wcYtSzXXQqZV0ECHJBYJ7UP1+hQUFPWluDOcG2gkGb5CQ/d3E7TQYjkz9jsfH88VAbEqdzeKwEcLbJ4yZ2SyAnxlnAt6xa8JL0ThQHBMDBK4R0WzmVrcLGm025XfPErnKar5MFoZsPzE8A+fngcS63RUu5Qu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250025; c=relaxed/simple;
	bh=f00LSwSVjf02ZjNSvqpm7PvTpjKFJdoacCIuoBWnFZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLmog6KdMqq7oDLie+lILTjkW7qLvA1AYtb+zkPiKKqfNAqaRRIdxkHMfiDBAHO1hQHLQ1wLNMaOu9oghfDtHivppbyNfQZ8IDRaOnbb/kAEsRFZsWM6cfteZZs7jBkK2/AzEDGnRkDujBFDR0a4Hh6pDUVJ8ivSMQixIpb4zTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhMPZ9Pc; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhMPZ9Pc"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e13cda45037so4987883276.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2024 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724250022; x=1724854822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+aX0Q23pYT72FgEHHAlvxlUdwQDTB5i7YPf8r2RH8s=;
        b=lhMPZ9PcujH5xtxFaydstOQmG7eGDEfayOYRGs2R+BJiEokKQlFQ0evlAV4WVI2hRw
         YQjXmCfmbmj7Oe9g0WyAxuvAkZfOXmuAuaqz3juLMe3cVOmC3MIRelmPyWi+CdUFC3YC
         XH2f7/132iJDLXugSVyiqh/aKtQhvkvVJ9sjTqfiwx6e7IAjNYww7ISbfHL64O5MGy13
         zZ1RQVKtOzJhARuFn57HyTnH6/XLZvYiXGfnfb1KJ0k+ZySP7WVS810BXd+X0tHv0s0m
         CiKQBemhfkN21b5L5qDxVpc+8ZW4PzzEY4Ul+GNeANw02I5zJgEnCBRuqtvj9cZK4xsh
         wu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250022; x=1724854822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+aX0Q23pYT72FgEHHAlvxlUdwQDTB5i7YPf8r2RH8s=;
        b=bfu/AGT1JUx4Zw6LYqO8MJflZrWD1X+1hYzvuos7snN+sY7IoIWLvWCMlUTMgHDP9x
         i8uGGBM0GRQezs1FgbsNmcLCP8brNvwxRqQWuDLRPGbMJQ9VIqelWvsqbCu3mjz4tyTn
         udmMxX0iz1sC/kmjgzGqMmuE3qVzFErxPqztaR5P0spNES5nosu1afymBdQzLhfejypT
         xISEd/SSkPqqZgIdBqzBhLkEn13YLTa5AO39HnBEuEFjZbV/H24WjKZwP9Mnde0GaKgu
         QKEMM6Vhk5MmAJ3dJkD7cz6HQ+UCIM5Ym+1s/Xoe/By612mdNatLbKLaB58CF8j4aSJk
         4Gdw==
X-Forwarded-Encrypted: i=1; AJvYcCXb0MKOSktr2ieAgKnq1V1WSTJVhid4JJEx5HfcYi3n0cY/xN49gMcBgzdDTa9CS+Uc81rBrxTvr1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJm8KtVUfhjVAHvUKHXEF4QKskURNRH2mNTYkl17Jp4lJ7e1Wx
	L3QvkcAZ5TSz0piW3pjTfNRpenmgoiDPcRdOuzNLp9VXfKCovD/JqRe3pb58OGuy/XGBw2cQukv
	E4mmXy6TpPwvr/4XNfY2lzOP+esKX0xfDBpvhhg==
X-Google-Smtp-Source: AGHT+IEOtXSivx3Il4xDnfxzUK2H/4SjwtMMpJuLVQnrvKpl902/bPhQ3oU3o/HDRy/YUpFm6s6aQ1nhdRo2hnEm29Y=
X-Received: by 2002:a05:6902:2508:b0:e11:5e69:3791 with SMTP id
 3f1490d57ef6-e16654961d4mr3611382276.34.1724250021811; Wed, 21 Aug 2024
 07:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814153558.708365-1-jens.wiklander@linaro.org> <20240814153558.708365-2-jens.wiklander@linaro.org>
In-Reply-To: <20240814153558.708365-2-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Aug 2024 16:19:46 +0200
Message-ID: <CAPDyKFpt-LhozHcd99nqA1u5p0TcG1MG59jHdhi-VYsYycpAMw@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands. Such a partition provides authenticated and replay
> protected access, hence suitable as a secure storage.
>
> The initial aim of this patch is to provide a simple RPMB driver
> interface which can be accessed by the optee driver to facilitate early
> RPMB access to OP-TEE OS (secure OS) during the boot time.
>
> A TEE device driver can claim the RPMB interface, for example, via
> rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> provides a callback to route RPMB frames to the RPMB device accessible
> via rpmb_route_frames().
>
> The detailed operation of implementing the access is left to the TEE
> device driver itself.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  MAINTAINERS              |   7 ++
>  drivers/misc/Kconfig     |  10 ++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++++++
>  include/linux/rpmb.h     | 123 +++++++++++++++++++++
>  5 files changed, 374 insertions(+)
>  create mode 100644 drivers/misc/rpmb-core.c
>  create mode 100644 include/linux/rpmb.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..716011964b18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19838,6 +19838,13 @@ T:     git git://linuxtv.org/media_tree.git
>  F:     Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-=
rotate.yaml
>  F:     drivers/media/platform/sunxi/sun8i-rotate/
>
> +RPMB SUBSYSTEM
> +M:     Jens Wiklander <jens.wiklander@linaro.org>
> +L:     linux-kernel@vger.kernel.org
> +S:     Supported
> +F:     drivers/misc/rpmb-core.c
> +F:     include/linux/rpmb.h
> +
>  RPMSG TTY DRIVER
>  M:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>  L:     linux-remoteproc@vger.kernel.org
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41c3d2821a78..21403392d809 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -104,6 +104,16 @@ config PHANTOM
>           If you choose to build module, its name will be phantom. If uns=
ure,
>           say N here.
>
> +config RPMB
> +       tristate "RPMB partition interface"
> +       depends on MMC
> +       help
> +         Unified RPMB unit interface for RPMB capable devices such as eM=
MC and
> +         UFS. Provides interface for in-kernel security controllers to a=
ccess
> +         RPMB unit.
> +
> +         If unsure, select N.
> +
>  config TIFM_CORE
>         tristate "TI Flash Media interface support"
>         depends on PCI
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c2f990862d2b..a9f94525e181 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)           +=3D lkdtm/
>  obj-$(CONFIG_TIFM_CORE)        +=3D tifm_core.o
>  obj-$(CONFIG_TIFM_7XX1)        +=3D tifm_7xx1.o
>  obj-$(CONFIG_PHANTOM)          +=3D phantom.o
> +obj-$(CONFIG_RPMB)             +=3D rpmb-core.o
>  obj-$(CONFIG_QCOM_COINCELL)    +=3D qcom-coincell.o
>  obj-$(CONFIG_QCOM_FASTRPC)     +=3D fastrpc.o
>  obj-$(CONFIG_SENSORS_BH1770)   +=3D bh1770glc.o
> diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> new file mode 100644
> index 000000000000..c8888267c222
> --- /dev/null
> +++ b/drivers/misc/rpmb-core.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> + * Copyright(c) 2021 - 2024 Linaro Ltd.
> + */
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rpmb.h>
> +#include <linux/slab.h>
> +
> +static DEFINE_IDA(rpmb_ida);
> +static DEFINE_MUTEX(rpmb_mutex);
> +
> +/**
> + * rpmb_dev_get() - increase rpmb device ref counter
> + * @rdev: rpmb device
> + */
> +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> +{
> +       if (rdev)
> +               get_device(&rdev->dev);
> +       return rdev;
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_get);
> +
> +/**
> + * rpmb_dev_put() - decrease rpmb device ref counter
> + * @rdev: rpmb device
> + */
> +void rpmb_dev_put(struct rpmb_dev *rdev)
> +{
> +       if (rdev)
> +               put_device(&rdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_put);
> +
> +/**
> + * rpmb_route_frames() - route rpmb frames to rpmb device
> + * @rdev:      rpmb device
> + * @req:       rpmb request frames
> + * @req_len:   length of rpmb request frames in bytes
> + * @rsp:       rpmb response frames
> + * @rsp_len:   length of rpmb response frames in bytes
> + *
> + * Returns: < 0 on failure
> + */
> +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> +                     unsigned int req_len, u8 *rsp, unsigned int rsp_len=
)
> +{
> +       if (!req || !req_len || !rsp || !rsp_len)
> +               return -EINVAL;
> +
> +       return rdev->descr.route_frames(rdev->dev.parent, req, req_len,
> +                                       rsp, rsp_len);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_route_frames);
> +
> +static void rpmb_dev_release(struct device *dev)
> +{
> +       struct rpmb_dev *rdev =3D to_rpmb_dev(dev);
> +
> +       mutex_lock(&rpmb_mutex);
> +       ida_simple_remove(&rpmb_ida, rdev->id);
> +       mutex_unlock(&rpmb_mutex);
> +       kfree(rdev->descr.dev_id);
> +       kfree(rdev);
> +}
> +
> +static struct class rpmb_class =3D {
> +       .name =3D "rpmb",
> +       .dev_release =3D rpmb_dev_release,
> +};
> +
> +/**
> + * rpmb_dev_find_device() - return first matching rpmb device
> + * @start: rpmb device to begin with
> + * @data: data for the match function
> + * @match: the matching function
> + *
> + * Iterate over registered RPMB devices, and call @match() for each pass=
ing
> + * it the RPMB device and @data.
> + *
> + * The return value of @match() is checked for each call. If it returns
> + * anything other 0, break and return the found RPMB device.
> + *
> + * It's the callers responsibility to call rpmb_dev_put() on the returne=
d
> + * device, when it's done with it.
> + *
> + * Returns: a matching rpmb device or NULL on failure
> + */
> +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> +                                     const struct rpmb_dev *start,
> +                                     int (*match)(struct device *dev,
> +                                                  const void *data))
> +{
> +       struct device *dev;
> +       const struct device *start_dev =3D NULL;
> +
> +       if (start)
> +               start_dev =3D &start->dev;
> +       dev =3D class_find_device(&rpmb_class, start_dev, data, match);
> +
> +       return dev ? to_rpmb_dev(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_find_device);
> +
> +int rpmb_interface_register(struct class_interface *intf)
> +{
> +       intf->class =3D &rpmb_class;
> +
> +       return class_interface_register(intf);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_interface_register);
> +
> +void rpmb_interface_unregister(struct class_interface *intf)
> +{
> +       class_interface_unregister(intf);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
> +
> +/**
> + * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsy=
stem
> + * @rdev: the rpmb device to unregister
> + *
> + * This function should be called from the release function of the
> + * underlying device used when the RPMB device was registered.
> + *
> + * Returns: < 0 on failure
> + */
> +int rpmb_dev_unregister(struct rpmb_dev *rdev)
> +{
> +       if (!rdev)
> +               return -EINVAL;
> +
> +       device_del(&rdev->dev);
> +
> +       rpmb_dev_put(rdev);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
> +
> +/**
> + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> + * @dev: storage device of the rpmb device
> + * @descr: RPMB device description
> + *
> + * While registering the RPMB partition extract needed device informatio=
n
> + * while needed resources are available.
> + *
> + * Returns: a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
> + */
> +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> +                                  struct rpmb_descr *descr)
> +{
> +       struct rpmb_dev *rdev;
> +       int ret;
> +
> +       if (!dev || !descr || !descr->route_frames || !descr->dev_id ||
> +           !descr->dev_id_len)
> +               return ERR_PTR(-EINVAL);
> +
> +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +       if (!rdev)
> +               return ERR_PTR(-ENOMEM);
> +       rdev->descr =3D *descr;
> +       rdev->descr.dev_id =3D kmemdup(descr->dev_id, descr->dev_id_len,
> +                                    GFP_KERNEL);
> +       if (!rdev->descr.dev_id) {
> +               ret =3D -ENOMEM;
> +               goto err_free_rdev;
> +       }
> +
> +       mutex_lock(&rpmb_mutex);
> +       ret =3D ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
> +       mutex_unlock(&rpmb_mutex);
> +       if (ret < 0)
> +               goto err_free_dev_id;
> +       rdev->id =3D ret;
> +
> +       dev_set_name(&rdev->dev, "rpmb%d", rdev->id);
> +       rdev->dev.class =3D &rpmb_class;
> +       rdev->dev.parent =3D dev;
> +
> +       ret =3D device_register(&rdev->dev);
> +       if (ret)
> +               goto err_id_remove;
> +
> +       dev_dbg(&rdev->dev, "registered device\n");
> +
> +       return rdev;
> +
> +err_id_remove:
> +       mutex_lock(&rpmb_mutex);
> +       ida_simple_remove(&rpmb_ida, rdev->id);
> +       mutex_unlock(&rpmb_mutex);
> +err_free_dev_id:
> +       kfree(rdev->descr.dev_id);
> +err_free_rdev:
> +       kfree(rdev);
> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_register);
> +
> +static int __init rpmb_init(void)
> +{
> +       int ret;
> +
> +       ret =3D class_register(&rpmb_class);
> +       if (ret) {
> +               pr_err("couldn't create class\n");
> +               return ret;
> +       }
> +       ida_init(&rpmb_ida);
> +       return 0;
> +}
> +
> +static void __exit rpmb_exit(void)
> +{
> +       ida_destroy(&rpmb_ida);
> +       class_unregister(&rpmb_class);
> +}
> +
> +subsys_initcall(rpmb_init);
> +module_exit(rpmb_exit);
> +
> +MODULE_AUTHOR("Jens Wiklander <jens.wiklander@linaro.org>");
> +MODULE_DESCRIPTION("RPMB class");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
> new file mode 100644
> index 000000000000..cccda73eea4d
> --- /dev/null
> +++ b/include/linux/rpmb.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2015-2019 Intel Corp. All rights reserved
> + * Copyright (C) 2021-2022 Linaro Ltd
> + */
> +#ifndef __RPMB_H__
> +#define __RPMB_H__
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +/**
> + * enum rpmb_type - type of underlying storage technology
> + *
> + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> + * @RPMB_TYPE_UFS   : UFS (JESD220)
> + * @RPMB_TYPE_NVME  : NVM Express
> + */
> +enum rpmb_type {
> +       RPMB_TYPE_EMMC,
> +       RPMB_TYPE_UFS,
> +       RPMB_TYPE_NVME,
> +};
> +
> +/**
> + * struct rpmb_descr - RPMB description provided by the underlying block=
 device
> + *
> + * @type             : block device type
> + * @route_frames     : routes frames to and from the RPMB device
> + * @dev_id           : unique device identifier read from the hardware
> + * @dev_id_len       : length of unique device identifier
> + * @reliable_wr_count: number of sectors that can be written in one acce=
ss
> + * @capacity         : capacity of the device in units of 128K
> + *
> + * @dev_id is intended to be used as input when deriving the authenticai=
on key.
> + */
> +struct rpmb_descr {
> +       enum rpmb_type type;
> +       int (*route_frames)(struct device *dev, u8 *req, unsigned int req=
_len,
> +                           u8 *resp, unsigned int resp_len);
> +       u8 *dev_id;
> +       size_t dev_id_len;
> +       u16 reliable_wr_count;
> +       u16 capacity;
> +};
> +
> +/**
> + * struct rpmb_dev - device which can support RPMB partition
> + *
> + * @dev              : device
> + * @id               : device_id
> + * @list_node        : linked list node
> + * @descr            : RPMB description
> + */
> +struct rpmb_dev {
> +       struct device dev;
> +       int id;
> +       struct list_head list_node;
> +       struct rpmb_descr descr;
> +};
> +
> +#define to_rpmb_dev(x)         container_of((x), struct rpmb_dev, dev)
> +
> +#if IS_ENABLED(CONFIG_RPMB)
> +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
> +void rpmb_dev_put(struct rpmb_dev *rdev);
> +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> +                                     const struct rpmb_dev *start,
> +                                     int (*match)(struct device *dev,
> +                                                  const void *data));
> +int rpmb_interface_register(struct class_interface *intf);
> +void rpmb_interface_unregister(struct class_interface *intf);
> +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> +                                  struct rpmb_descr *descr);
> +int rpmb_dev_unregister(struct rpmb_dev *rdev);
> +
> +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> +                     unsigned int req_len, u8 *resp, unsigned int resp_l=
en);
> +
> +#else
> +static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> +{
> +       return NULL;
> +}
> +
> +static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
> +
> +static inline struct rpmb_dev *
> +rpmb_dev_find_device(const void *data, const struct rpmb_dev *start,
> +                    int (*match)(struct device *dev, const void *data))
> +{
> +       return NULL;
> +}
> +
> +static inline int rpmb_interface_register(struct class_interface *intf)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void rpmb_interface_unregister(struct class_interface *int=
f)
> +{
> +}
> +
> +static inline struct rpmb_dev *
> +rpmb_dev_register(struct device *dev, struct rpmb_descr *descr)
> +{
> +       return NULL;
> +}
> +
> +static inline int rpmb_dev_unregister(struct rpmb_dev *dev)
> +{
> +       return 0;
> +}
> +
> +static inline int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> +                                   unsigned int req_len, u8 *resp,
> +                                   unsigned int resp_len)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_RPMB */
> +
> +#endif /* __RPMB_H__ */
> --
> 2.34.1
>
