Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6801AB6EF;
	Fri,  1 Nov 2024 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457612; cv=none; b=O8qiC2XdnXzw6gIdH6mdM7vmvjohZI8Dj3bWl4dI00qRiHP6++1hiLmLMgcFHnUXCL7KzmC6BHcoV1RfbynsG60uTdRObv97mkZDYv7ho2MgUoEai3dOKmwBzBO7Z+jvSDOdgz3UHeAcmm71Pxyud1NNi/1JOuQ/+/+4F8RMJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457612; c=relaxed/simple;
	bh=v+qxwvGY1m0dlY7yDb24hPEIzmLjNV/bOx2C3HqmrjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5EisBhnrD/Sn8CPF6pGefsyGMhUE5qC9bxgnNZ3BmJwZN5C9EPMneNzfbvJJEsYjXWd7rL7Vx4qFTuWTYjMMDHnNc4S7CfjFRpDzZyyLq0VpacZPSUHx/kvbiY3OlOW7c9cHdCQJCws0Q2VHmDpvGzo2J0kjlvVBP3rXENCp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv3zmiqt; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv3zmiqt"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84fe06fbdc6so590531241.0;
        Fri, 01 Nov 2024 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730457609; x=1731062409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xGyDEYNWfKOFJLpEkm/4qBVP0ZMK9b+NBJIWM6trnI=;
        b=Xv3zmiqtmj56skaXxFNGzhFG05139QBMq02kI9vYpobyXNCodBrZFryELnoCOLfK3b
         ediAgxxQOv56JOd34UNsEKLQiAeQfFSF0VuUXXbkAWXF4S0PaFMvOtPnQjJPs6Hpoy0l
         /5iOjE4Lf63lCNWwYj6Q6U25dAHKbClyJfBI1YyL/LGW9r7GflCpwSF/7teav52UycEH
         NM3kXdJdQgjkUaYEAIjVzR+KbOUU4nUgwmOhkVUS50vC2eQ3HF5sL7Js+9MZxjCwOU4d
         8v5aCevSeG6SCthbyXdRp9ccSW9ha+VjcEJrNOaEXNhosBgjPimulLQKPbNQyKd+3bKS
         mfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730457609; x=1731062409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xGyDEYNWfKOFJLpEkm/4qBVP0ZMK9b+NBJIWM6trnI=;
        b=vO9GCHkD0fqcU+GK+uqhr3PJzO0uTmYqAXyMg8XBRnZPlziutlzsU8PxebeuYrowE+
         Zd2TgFB7aa14YCG6nfCyRODLCHy/oD9Byih85SDQlT0o9jzRGPJqKGczmdtbcviyOroF
         vYqM5OIGmjymH8Cn0HGUrQAFvNOYYBMI+gjdK475rlcPSPeAifZNfem522H3ibuqFx96
         TQF/QBPDAbTfud8lQRshwazVR1sIojBImMGVK9RkEEK9ei2ioU9gMHJTUAqO7vI19HWC
         T+zWkpeSEQFUDLh4ANAXuwZyG0AoYLmio3Xq4eq/XV3OGa3qA7A+o/tnSTJ975LuwV1t
         kd9w==
X-Forwarded-Encrypted: i=1; AJvYcCUD6XDElJOOuFsxkQx5rb5k+VwiXWg0GDdFWXKdfqPLpnTc+wp0qZoc1m2QK2LPzwm515OswcsvkteN@vger.kernel.org, AJvYcCWX0WHtg7rP4vJjJGrYZwkVpYrPxoDNX2XXc14FwPTYFrSVg1S+nn2dwsKOipxPvmceKFAWZ7BBJD2H01Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBIQqY7ri4a8P+F7VS/mglFUuLrwPRfKPCdnfxrlDzGQNN/A0
	Uw3t3v8n+AKfrKUnkH9u9IlzXuaFLqMMTU7RDK/spvA8vf37i03PCsuKE2PxMxE3hs+8PO9q+q2
	x3HxG8D6EImUFCSeI+yLbqx+xPDQ=
X-Google-Smtp-Source: AGHT+IELxio5Fp4CUQ+VZXCAxZlg5M8PwN/Sj96D+5cfX+mjsg9Cac1Dy2zxi8TLd1qqdkZNY0fF9eMI8oqq6k8ie/k=
X-Received: by 2002:a05:6102:3753:b0:4a7:487d:88e4 with SMTP id
 ada2fe7eead31-4a9542630e2mr8288542137.4.1730457609208; Fri, 01 Nov 2024
 03:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105333.4569-1-victorshihgli@gmail.com>
 <20241018105333.4569-4-victorshihgli@gmail.com> <CAMuHMdWQWxSsSC=LhG7wcF=gaQhr45A_bE_RneCAG85WQU+2mA@mail.gmail.com>
In-Reply-To: <CAMuHMdWQWxSsSC=LhG7wcF=gaQhr45A_bE_RneCAG85WQU+2mA@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 1 Nov 2024 18:39:57 +0800
Message-ID: <CAK00qKDxbdOoYx9UJEdEBb6uggof5fZV3JNar7s_cGP6ERSdzg@mail.gmail.com>
Subject: Re: [PATCH V23 03/16] mmc: sdhci: add UHS-II module and add a kernel configuration
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:56=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Victor,
>
> On Fri, Oct 18, 2024 at 1:14=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This patch adds sdhci-uhs2.c as a module for UHS-II support.
> > This is a skeleton for further development in this patch series.
> >
> > This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> > in the following commits to indicate UHS-II specific code in sdhci
> > controllers.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Thanks for your patch, which is now commit 2af7dd8b64f2fd6a ("mmc:
> sdhci: add UHS-II module and add a kernel configuration") in
> linux-next/master mmc/next next-20241025 next-20241028 next-20241029
>
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controll=
er
> > + *  Interface driver
> > + *
> > + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> > + *  Copyright (C) 2020 Genesys Logic, Inc.
> > + *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > + *  Copyright (C) 2020 Linaro Limited
> > + *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> That is a very extensive copyright header, for just a small piece of
> boilerplate code?
>

Hi, Geert

As I know, the copyright is for the complete sdhci-uhs2.c file
and subsequent patches added the code into the sdhci-uhs2.c file.

Thanks, Victor Shih

> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#include "sdhci.h"
> > +#include "sdhci-uhs2.h"
> > +
> > +#define DRIVER_NAME "sdhci_uhs2"
> > +#define DBG(f, x...) \
> > +       pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> > +
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Driver init/exit                                                   =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static int __init sdhci_uhs2_mod_init(void)
> > +{
> > +       return 0;
> > +}
> > +module_init(sdhci_uhs2_mod_init);
> > +
> > +static void __exit sdhci_uhs2_mod_exit(void)
> > +{
> > +}
> > +module_exit(sdhci_uhs2_mod_exit);
> > +
> > +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
> > +MODULE_DESCRIPTION("MMC UHS-II Support");
> > +MODULE_LICENSE("GPL");
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
