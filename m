Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E200206066;
	Tue, 29 Oct 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210186; cv=none; b=BvmWXucZ4/wfaoben+zr1rQAERfcoHtZGVtz1lwvdTWUMps4JpZ6Uop2FlgCelBH/y4m4/xcMqRhWxjTxxIN3/kOkzfNGvc24kWLeK84fFV4YkJeQYhdJw1uHegsK9q3f0wJGsVgpE3goGDriqm+D2hcJApABNuxzkyVOajU9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210186; c=relaxed/simple;
	bh=Iq60rsL3snD+4mAtP55nH5fjU7OWs0V+QHDjHW9lHXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maj9hebiVwdLnuhFj6gFk6ve8KCYUxyAPtGmCG/jrCj3R2JYT4kVu9oPs3zeLl30hgaLI8TeIOzl0zwkA4unEVTyXRH5Pdz4KFSb2RZ1xoLtv1a3m1yn69SWtYp2I/Ngt3gLKWO6VpRkPE5k8iTJ3ZjUEyCG2zve4A/aXUh+nfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso5899666276.0;
        Tue, 29 Oct 2024 06:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210183; x=1730814983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seMJ/vrkxm7Shquz7OWS7884KCfNOjPWquBFun9uTXw=;
        b=UWjOyaHWFgY7NDC8ZvnBrUwbB/4HLjmtpMUyJXCuFa66uUH44DXjy+xavuo/XhpN+v
         BVtDasz6rhh3OYTESAOPrX+zF6d0MIffsxf7VV6Mi6e7TuI1aCaMFITizxru08kyIMXi
         czEZWcgJyTDMnxxWOKjrr8kU9Ig5Zad59Q39+l1kl2lMlp3DHV+UDUTyT37zcof/CKey
         6w8NrS22wYM/4gz8AkpDhDPrtxxt5h60a2dxzV9RsEY9T3Lb1Pn02xkgzXLgy5GzKlGe
         /ozV+Caxc/IP9S9/Q2sKUcYE40a525gX+XpU7863FIFUnmUN2KdhjaxeBy3fPnbkg3LH
         ktbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQwnB+ZPaMgWBv8pPyz4ts66UnXBc4TuoHYgQBgEfIr1kcnHfoLd98pinsjNdApmWdi0Xplh8f7QdL@vger.kernel.org, AJvYcCXENuEBnAO6KRvDo7fFf1Ga9qhbh/O9Hebq8afGwV+f94WztZ6W1j0XtwXp4A7/7VIYdSozJIJr2iJi4+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8di9ZSfOO21ugPQBrzpMyRS/tMLXvv8JLvfbzMYxDNlUCNv3W
	oF5Pc+ZnsvOBKRYkovQ3lpNLjVXCFzQeSNmTN0qJr693RIcd4rG3JEzytKOV
X-Google-Smtp-Source: AGHT+IGUZzsC+/N1Badz6xHPJJ2izgJ9sc6eV1sYCmH22WXtRahnYWAGahnYrSJMLlN59SijW/S0+w==
X-Received: by 2002:a05:690c:9a8d:b0:6e3:120a:71f1 with SMTP id 00721157ae682-6e9d896fca2mr116398907b3.15.1730210182944;
        Tue, 29 Oct 2024 06:56:22 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bae832sm19522557b3.12.2024.10.29.06.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 06:56:22 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e38fc62b9fso48116227b3.2;
        Tue, 29 Oct 2024 06:56:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtekmbs+LSbCTu80S7QzZZLJwYh6LRU9HA18DdIksPBZc2K9RVvNyoqt7EIauM9KsmNyazYTrHk/H0@vger.kernel.org, AJvYcCWUMJGvdBXLZ2z+UmMgkgRc/HJBLkSQXTfcDWVtRg4Tz1EY2rLhujiCjjaL9gN2gla/ogWFGa0IfWdYh74=@vger.kernel.org
X-Received: by 2002:a05:690c:6085:b0:6d5:7b2f:60a0 with SMTP id
 00721157ae682-6e9d8afb26dmr123988437b3.34.1730210182383; Tue, 29 Oct 2024
 06:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105333.4569-1-victorshihgli@gmail.com> <20241018105333.4569-4-victorshihgli@gmail.com>
In-Reply-To: <20241018105333.4569-4-victorshihgli@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Oct 2024 14:56:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQWxSsSC=LhG7wcF=gaQhr45A_bE_RneCAG85WQU+2mA@mail.gmail.com>
Message-ID: <CAMuHMdWQWxSsSC=LhG7wcF=gaQhr45A_bE_RneCAG85WQU+2mA@mail.gmail.com>
Subject: Re: [PATCH V23 03/16] mmc: sdhci: add UHS-II module and add a kernel configuration
To: Victor Shih <victorshihgli@gmail.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Victor,

On Fri, Oct 18, 2024 at 1:14=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This patch adds sdhci-uhs2.c as a module for UHS-II support.
> This is a skeleton for further development in this patch series.
>
> This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> in the following commits to indicate UHS-II specific code in sdhci
> controllers.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Thanks for your patch, which is now commit 2af7dd8b64f2fd6a ("mmc:
sdhci: add UHS-II module and add a kernel configuration") in
linux-next/master mmc/next next-20241025 next-20241028 next-20241029

> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
> + *  Interface driver
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + *  Copyright (C) 2020 Genesys Logic, Inc.
> + *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *  Copyright (C) 2020 Linaro Limited
> + *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>

That is a very extensive copyright header, for just a small piece of
boilerplate code?

> + */
> +
> +#include <linux/module.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-uhs2.h"
> +
> +#define DRIVER_NAME "sdhci_uhs2"
> +#define DBG(f, x...) \
> +       pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> +
> +/***********************************************************************=
******\
> + *                                                                      =
     *
> + * Driver init/exit                                                     =
     *
> + *                                                                      =
     *
> +\***********************************************************************=
******/
> +
> +static int __init sdhci_uhs2_mod_init(void)
> +{
> +       return 0;
> +}
> +module_init(sdhci_uhs2_mod_init);
> +
> +static void __exit sdhci_uhs2_mod_exit(void)
> +{
> +}
> +module_exit(sdhci_uhs2_mod_exit);
> +
> +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
> +MODULE_DESCRIPTION("MMC UHS-II Support");
> +MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
