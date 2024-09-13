Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFC1C2459;
	Fri, 13 Sep 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222699; cv=none; b=f/XvxZ3Zxf6hiA8V8Q7x8CF8nanhw23jPXqPOMzvLj0P/f6MWepGIYvt8kcttSu4EwBf+NAogiGVfMUlflXTMF0Op7Gy1NcJ1W4rMwy/zWWt0LKISRLebBV1JDH5KHtwl4iACd++ALDUpCRkdkc+YpOyE+LEZArB66bGXzGmYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222699; c=relaxed/simple;
	bh=H86TmwR5hlm4agsriix5lyIe7ekoAvAlzPGik5tNXCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US2J0/OpuVsE0FOnHkFX4+1AQApIxOPk5U/RN/uNU/QZ4QVvM27sencyUurGjmT7oJqeEA3Y2Q1tqVQeOayLEKyglg3iTlHaW5Sf7lDR/GBqy9lPM1ByFUoMuNsytKrDKtwItmnaIyDLJg9rPohY6rmHOqTDoiiNiW0VYT4kJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9ch+CeR; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9ch+CeR"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50108b3749aso203365e0c.2;
        Fri, 13 Sep 2024 03:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726222696; x=1726827496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahw9DFRn9vWzH+ctFf8kXiCPP1Wa2CPdWOklcIMfD8Q=;
        b=U9ch+CeRVrTRcND99OEVrZSv7dRFmZopoYUGEk1MfCFvZ8RunDErekCXOfvmYUgxHW
         bIk57zNSQQwUzUhD6rxnMWFAAKFOTR2a8cDZbYruejAJECWSoFjfHB7N9eC7uR6uSIdu
         T4IqTIkGDtcpxp95mEgQlTWd8CkRAXZmnFhVZKSZF092CjyZ8YfdmWPVooN9BBPq/Bs7
         S0qSgwFgBWgDFfFCjypjtjyyNft5f2+eRhS1SSy/EbiGgmgviXsOISMbOJ2NgUe699xs
         Kxs4nFm7zq/9WWMrfzQXRJGnR4IktCHmfLGdlTw7z+BnNQQ/la07ZiN4I7AkSYGlqIWR
         L+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726222696; x=1726827496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahw9DFRn9vWzH+ctFf8kXiCPP1Wa2CPdWOklcIMfD8Q=;
        b=cvTiRaZN62T7ho0AnrjZA8arCABXQ5gu/QzGz2+0vhn5I6/SxjvOssDIG+73Ga1+ma
         THu8R7NdwHf4CfY+To1mYvvb1o7/i7iu/zxn93K7IIf6TxC4R6UwQXfINqcZ98X0lr+X
         phoQjRW10o8eIRirrO3u2lGB8wPqDyff6IU0vWlULyt03/8K3BlNysWqReqEYYPgaLYM
         xdvljL3DBbWet6PMX9/cmEay2hXZlEjkh48CPLj3b/ca75Kb1dvzuiQTWKbEU+3mNjfi
         w1YsURAMUBODyyejmSZJ8hzdX09ST9TckMUC+JwoY4qFpghdE+iu5gYSlMYpubq9WfCP
         pEKA==
X-Forwarded-Encrypted: i=1; AJvYcCUobdPtZm+mUWQ0fH/RqGN6d4qxQQHZAMKyQxvgUPgebh2lefL1AQaBi0UnTTyzbngtlgUnFAw7cMbsYjo=@vger.kernel.org, AJvYcCWJAcIflZkuigvLFkWJH+3TiN7YuWmkj7L3xenRcrE74PW8GPJCQcodP9tZv6LYPyhoIru7L9jUaZQn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx745fvdWSVnZC9Vsu/HVnZeO8uOoeZckPNcjbqaLAVev8BKhau
	nUjMccNH3eB7T9TTM+s2LV8/O/m7DPynOUo+6IlQUro7h9Mj4/fxIhHkSE1/MP2vEeQGCeFkLA8
	8AsKDJ1Vpy5DIhMgk4efVZWYd35M=
X-Google-Smtp-Source: AGHT+IH7eRwb9LItLEud7I/9W0DqQXv6KuHd8imhcTkH9PLW3IJF9Cp9ER5M6ubFW0Dvs85r38aKdghiGcL2LgaHAOs=
X-Received: by 2002:a05:6122:3690:b0:501:3b5:ae01 with SMTP id
 71dfb90a1353d-50344b91d4bmr1134880e0c.5.1726222696391; Fri, 13 Sep 2024
 03:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906102049.7059-1-victorshihgli@gmail.com>
 <20240906102049.7059-10-victorshihgli@gmail.com> <5ab812d6-da62-4337-8495-3a906c60a2a0@intel.com>
In-Reply-To: <5ab812d6-da62-4337-8495-3a906c60a2a0@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 13 Sep 2024 18:18:00 +0800
Message-ID: <CAK00qKADqSd3UO0axYuCoNgyqEVjgRv3ozU4u5Cz2n=9dwsBeg@mail.gmail.com>
Subject: Re: [PATCH V21 09/22] mmc: sdhci: add UHS-II module and add a kernel configuration
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 4:06=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 6/09/24 13:20, Victor Shih wrote:
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
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Doesn't compile:
>
> drivers/mmc/host/sdhci-uhs2.c:28:12: error: =E2=80=98sdhci_uhs2_host_ops_=
init=E2=80=99 defined but not used [-Werror=3Dunused-function]
>    28 | static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:244: drivers/mmc/host/sdhci-uhs2.o] =
Error 1
> make[4]: *** [scripts/Makefile.build:485: drivers/mmc/host] Error 2
> make[3]: *** [scripts/Makefile.build:485: drivers/mmc] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
> make[1]: *** [/home/ahunter/git/review/Makefile:1925: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>

Hi, Adrian

I will correct this issue in the next version.

Thanks, Victor Shih

> > ---
> >
> > Updates in V9:
> >  - Modify the commit message.
> >
> > Updates in V8:
> >  - Modify MODULE_LICENSE from "GPL v2" to "GPL".
> >
> > Updates in V6:
> >  - Merage V5 of patch[7] and patch[9] in to V6 of patch[8].
> >
> > ---
> >
> >  drivers/mmc/host/Kconfig      |  9 +++++++
> >  drivers/mmc/host/Makefile     |  1 +
> >  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 56 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 7199cb0bd0b9..f636af8a98df 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -98,6 +98,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> >
> >         This is the case for the Nintendo Wii SDHCI.
> >
> > +config MMC_SDHCI_UHS2
> > +     tristate "UHS2 support on SDHCI controller"
> > +     depends on MMC_SDHCI
> > +     help
> > +       This option is selected by SDHCI controller drivers that want t=
o
> > +       support UHS2-capable devices.
> > +
> > +       If you have a controller with this feature, say Y or M here.
> > +
> >  config MMC_SDHCI_PCI
> >       tristate "SDHCI support on PCI bus"
> >       depends on MMC_SDHCI && PCI
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 3ccffebbe59b..5147467ec825 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)               +=3D pxamci.o
> >  obj-$(CONFIG_MMC_MXC)                +=3D mxcmmc.o
> >  obj-$(CONFIG_MMC_MXS)                +=3D mxs-mmc.o
> >  obj-$(CONFIG_MMC_SDHCI)              +=3D sdhci.o
> > +obj-$(CONFIG_MMC_SDHCI_UHS2) +=3D sdhci-uhs2.o
> >  obj-$(CONFIG_MMC_SDHCI_PCI)  +=3D sdhci-pci.o
> >  sdhci-pci-y                  +=3D sdhci-pci-core.o sdhci-pci-o2micro.o=
 sdhci-pci-arasan.o \
> >                                  sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > new file mode 100644
> > index 000000000000..608f8ad5aaed
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -0,0 +1,46 @@
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
> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#include "sdhci.h"
> > +#include "sdhci-uhs2.h"
> > +
> > +#define DRIVER_NAME "sdhci_uhs2"
> > +#define DBG(f, x...) \
> > +     pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
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
> > +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int __init sdhci_uhs2_mod_init(void)
> > +{
> > +     return 0;
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
