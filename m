Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02772127B67
	for <linux-mmc@vger.kernel.org>; Tue,  9 Apr 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651563; cv=none; b=HwKn87cCCclMht3l8/EPhqjakCQCpnwsUqtUWZ8/mRAGmCfbtOHxyT7brKLWnCnrzsgUWX+tXNHjxc0KJgaVS0dYaXmR/cnK0miOn0BCXB6JmSc2KDUaiWafbs2Wh3eFFIoinajFttpLsyfE9rUmNdw/QIXhd7GMOpJ54m2ZvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651563; c=relaxed/simple;
	bh=Dpn8MR4nhIt8ge/rBHDPkpyx6ABtUHgj9mzhMzWOtGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+3uhzOi/Lw0zLfD+sAZBEIR5smzR5sAp/ZTVpihTy7Bn5NpEgRqmmqNI7WI+bLBwoa06c7Xy3gSSqKebnPwxFznw5cdyXLyHd2JiHncUNZ8XNZnQZT20V5ZKuzDnktQOSKrnm2xsn19fXi6GPw9Oj2+D7b+HX0+skOAtEDAcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idtkfc6M; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idtkfc6M"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22f32226947so1005486fac.2
        for <linux-mmc@vger.kernel.org>; Tue, 09 Apr 2024 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712651560; x=1713256360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uAodPsYjRsPrLmdLzL3BRTckxAm/m9XO5FXRuJnr4o=;
        b=idtkfc6MGbap+Yl87M3F3GMxHAEavlp0M9fNQsYW9pVPtAK9Pa3U+JLNmk0n75Wyrm
         gUBEAiXz7mLoyMpvuK/rMhbwJhUspXLwzyTrAnpRI9ti+kSxdoDCy8B7t/5NS0rkPfH5
         x8ivm61RZ4LI2AVjkJ442lO9JmC31KPu6a2Ko+4O6LNE+0juKxH1pGvDuBkxH3+RkBBL
         8veFOFUawwXrue3SZiJjWPj7JHTG/Nh98d8io0gSN1ckZSc0W6kY0zAqQeijToRD/HGX
         3geRuRVjKa0N+ZRujEBXojmI/BMqhCB4N38bFf6IHLDOguSJD9oUIz12vJkpZHjCMORy
         Slog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651560; x=1713256360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uAodPsYjRsPrLmdLzL3BRTckxAm/m9XO5FXRuJnr4o=;
        b=Ufspjs0jfl4QMUl0o7dsKE6fqLvfR7/1gwlnAmUXLApgs18F4gfWHjdZelb/0bJHq+
         enJfCfDeAa1sRjSriOnTJvhANfw31ogdkTmRjnYI9QkhZX0IdrKvNjEgZtzDw+H6OSr4
         SUiUv7lP9CjlSZYj0729qiMFn9SjKD4NkAAvswt7RNI3FvRs6PcmdoqLgCTYbVynBZTB
         xqiSOplAZ1VGngybc9mCOH++XSR5Zn0W2XD8XAXMd4kJNKR6gIqUycYtlgpiDkS3W8qM
         45a2SmqqUhoZM5pu1EnktP9nvlV1sK0cVJs7lvIjstQ2DBuyCZUVHq4ydNMXHHAkKJog
         H43A==
X-Forwarded-Encrypted: i=1; AJvYcCXBgw7aPWPNg4h/biVf5xApFD6n7yZp4AOVFY3dV3f5PG5adjI7YH4R42JItCpkmb0UZcofJxxnLGb6bOgoch9fva1h6zE95XXa
X-Gm-Message-State: AOJu0YzwngTnwWJZK0ILT5fvZQ3fzvKlFErQ4/NViXGQUCr2BdzjEerR
	ZmF0ZQ8dspgCZyTd7hrRcbTdI7iDlWQlSEeBhrBNMbuyqoWiQ3EJ52h1BV4w4Miq4bUyNeWfCTR
	lfAFb3RQy5ul8mqMBkkSOpirFG4MsVEcPvEa/5A==
X-Google-Smtp-Source: AGHT+IH7JHDXhhK5XHKAYXEHO/Peaa07VhvA3DF/OYJg6/MoyNjNmPTZXZGiO92FclWgq/qAqeYZ6Kc2HK0e9KQDf44=
X-Received: by 2002:a05:6870:1a8f:b0:229:7f3f:bb6a with SMTP id
 ef15-20020a0568701a8f00b002297f3fbb6amr9084872oab.32.1712651560033; Tue, 09
 Apr 2024 01:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-2-jens.wiklander@linaro.org> <DM6PR04MB65757A966792C93334DE4BF1FC022@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65757A966792C93334DE4BF1FC022@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 9 Apr 2024 10:32:28 +0200
Message-ID: <CAHUa44H5q26XjRQnaP4-kAjWT_Pdo2UMsS=xqqOJC6Prra256Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 12:27=E2=80=AFPM Avri Altman <Avri.Altman@wdc.com> w=
rote:
>
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY.
> What about the other rpmb operations?
> There are 7 operations in eMMC.

I'm sorry, I don't have access to the spec currently. Do you have a
special operation in mind? Is it better to mention no operation since
UFS has even more operations?

>
> ............
>
> > +/**
> > + * rpmb_dev_find_device() - return first matching rpmb device
> > + * @data: data for the match function
> > + * @match: the matching function
> > + *
> > + * Iterate over registered RPMB devices, and call @match() for each pa=
ssing
> > + * it the RPMB device and @data.
> > + *
> > + * The return value of @match() is checked for each call. If it return=
s
> > + * anything other 0, break and return the found RPMB device.
> > + *
> > + * It's the callers responsibility to call rpmb_dev_put() on the retur=
ned
> > + * device, when it's done with it.
> > + *
> > + * Returns: a matching rpmb device or NULL on failure
> > + */
> > +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> > +                                     const struct rpmb_dev *start,
> > +                                     int (*match)(struct rpmb_dev *rde=
v,
> > +                                                  const void *data))
> > +{
> > +       struct rpmb_dev *rdev;
> > +       struct list_head *pos;
> > +
> > +       mutex_lock(&rpmb_mutex);
> > +       if (start)
> > +               pos =3D start->list_node.next;
> > +       else
> > +               pos =3D rpmb_dev_list.next;
> > +
> > +       while (pos !=3D &rpmb_dev_list) {
> Why not just list_for_each_entry instead?

We want to continue from where we left off last time.

>
> > +               rdev =3D container_of(pos, struct rpmb_dev, list_node);
> > +               if (match(rdev, data)) {
> > +                       rpmb_dev_get(rdev);
> > +                       goto out;
> > +               }
> > +               pos =3D pos->next;
> > +       }
> > +       rdev =3D NULL;
> > +
> > +out:
> > +       mutex_unlock(&rpmb_mutex);
> > +
> > +       return rdev;
> > +}
>
> .....................
>
> > +/**
> > + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> > + * @dev: storage device of the rpmb device
> > + * @ops: device specific operations
> > + *
> > + * While registering the RPMB partition extract needed device informat=
ion
> > + * while needed resources are available.
> > + *
> > + * Returns: a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
> > + */
> > +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> > +                                  struct rpmb_descr *descr)
> > +{
> > +       struct rpmb_dev *rdev;
> > +
> > +       if (!dev || !descr || !descr->route_frames || !descr->dev_id ||
> > +           !descr->dev_id_len)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> > +       if (!rdev)
> > +               return ERR_PTR(-ENOMEM);
> > +       rdev->descr =3D *descr;
> > +       rdev->descr.dev_id =3D kmemdup(descr->dev_id, descr->dev_id_len=
,
> > +                                    GFP_KERNEL);
> In addition to the dev_id, wouldn't it make sense to have your own IDA as=
 well?

Currently, we don't need it.

>
> > +       if (!rdev->descr.dev_id) {
> > +               kfree(rdev);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       rdev->parent_dev =3D dev;
> > +
> > +       dev_dbg(rdev->parent_dev, "registered device\n");
> > +
> > +       mutex_lock(&rpmb_mutex);
> > +       list_add_tail(&rdev->list_node, &rpmb_dev_list);
> > +       blocking_notifier_call_chain(&rpmb_interface,
> > RPMB_NOTIFY_ADD_DEVICE,
> > +                                    rdev);
> > +       mutex_unlock(&rpmb_mutex);
> > +
> > +       return rdev;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_register);
>
> ............
>
> > new file mode 100644
> > index 000000000000..251d6b7e6d15
> > --- /dev/null
> > +++ b/include/linux/rpmb.h
> > @@ -0,0 +1,136 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> > +/*
> > + * Copyright (C) 2015-2019 Intel Corp. All rights reserved
> > + * Copyright (C) 2021-2022 Linaro Ltd
> > + */
> > +#ifndef __RPMB_H__
> > +#define __RPMB_H__
> > +
> > +#include <linux/types.h>
> > +#include <linux/device.h>
> > +#include <linux/notifier.h>
> > +
> > +/**
> > + * enum rpmb_type - type of underlying storage technology
> > + *
> > + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> > + * @RPMB_TYPE_UFS   : UFS (JESD220)
> > + * @RPMB_TYPE_NVME  : NVM Express
> > + */
> > +enum rpmb_type {
> > +       RPMB_TYPE_EMMC,
> > +       RPMB_TYPE_UFS,
> > +       RPMB_TYPE_NVME,
> > +};
> > +
> > +/**
> > + * struct rpmb_descr - RPMB descriptor provided by the underlying bloc=
k
> > device
> The use of the term "rpmb descriptor" may be slightly misleading.
> This is because in UFS there are various descriptors that identifies vari=
ous characteristics,
> e.g. device descriptor, geometry descriptor, unit descriptor etc.,
> and recently UFS4.0 introduced a new descriptor - RPMB descriptor....

Would RPMB description be better? Or do you have some other idea?

Thanks,
Jens
