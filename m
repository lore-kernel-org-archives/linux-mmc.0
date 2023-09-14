Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680CDEDE997
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 08:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbjINIiR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbjINIiQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 04:38:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECDB1FC4
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 01:38:12 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d8165e3b209so1845983276.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694680692; x=1695285492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw+IM7T28OUZCuFvNNtZ4r0LwLPv3E7VBk0HU9CwOkM=;
        b=cFbmBs6YE5ogcBr0pGE7Gr0BSYHeT+XWSylTxMfjtJdE5FEGK3W88Zt3vwgrVtjA23
         WyOh1nU7GnQkovCxpbEd5kJJsRZmdYt/Vjw77qjDkACMgL2rS7mGJEZfX9fsDCLUYx0W
         TR/wdb5/OUQZSU2rPDIvSe+eFlNwkg0lkjI6dmAOsgfV4XSVROuGrT8TPcxSRbz7bvgZ
         0x0xzD4rXoR3ZWc7fmtMQAoo42pHNDHrkvdqJDAHonx5GB22MRx5orbPECcaa3rHGqaP
         VMhZlJTtWecczZov6hNSEVBKvW+HeK2tDRrMWSXopyLkIGodQ0blgAxMfErBny+8/ULs
         5bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680692; x=1695285492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw+IM7T28OUZCuFvNNtZ4r0LwLPv3E7VBk0HU9CwOkM=;
        b=nx9jtlPJuAlLvUTMWEok9kyDnJa2e746yuZNFetx8oyH9QIia8yM7JC/8OGBNgGHWZ
         eANxYSN9wwXWdWYAk3nLzSmRb+3EBmkfxwPuMr7VptZzm7sE8fwrxJAGQ7xNMDFXlKju
         LFxcLxjTium9IVaAwW1cycZQkgQQhjRJeDziMAMaTRHzc4PRL4xpG6srfH9bEut1Fz3S
         n/fHLWLTQAtvlIOg9GuUz/4EoS36hJQ8gGcxNulFs40MkuDo36jeMBI6eNjuC/op5aRP
         Te54hFK3mOXivBD6D8vb8L4VGWpSHIkwaB9eZE0wgSAPbmBEC6maFgqqMd4/tqwQ1B6J
         ufJA==
X-Gm-Message-State: AOJu0YyjvnlSTNxYhu1pI9Gx/+jN8yglvWREhTq4B1qnoPph553O6Xth
        i9RGGZkZ+aJ86UE67roQkk9mLk2YS/eqjfgUqWK8uA==
X-Google-Smtp-Source: AGHT+IFyY43h1oRCVKhhChEd117O1PDuUi9sFE50e09WDnGshfwxm7/vGR5ngRDde3sVsJopmuH3eR/c9W658nqJCQo=
X-Received: by 2002:a25:7714:0:b0:d07:b677:3349 with SMTP id
 s20-20020a257714000000b00d07b6773349mr806404ybc.25.1694680691812; Thu, 14 Sep
 2023 01:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230913115001.23183-1-brgl@bgdev.pl> <20230913115001.23183-4-brgl@bgdev.pl>
 <CACRpkdax-CrB42LeQ1bs3E7VqMncsgEwMs7b_v7J6R5AE+BjAg@mail.gmail.com>
 <CAMRc=Mdt0wbjzbwBLK5m--VLV2WE5JybgrNYWXtbinPu_c=psw@mail.gmail.com> <CACRpkdYVGR0Wj9zS9cuS3qa_tNZHE1t95wQ-4MXAEL6s_4jdFQ@mail.gmail.com>
In-Reply-To: <CACRpkdYVGR0Wj9zS9cuS3qa_tNZHE1t95wQ-4MXAEL6s_4jdFQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 10:38:00 +0200
Message-ID: <CACRpkdaar4UsYcnMmjMPd5NnhaJq-LMSW0gQfBnjS3_u0_UkYQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mmc: slot-gpio: use gpiod_set_active_[low|high]()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 14, 2023 at 10:31=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> On Wed, Sep 13, 2023 at 2:39=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:

> > Alternatively we could reimplement the toggle semantics locally in a
> > helper function in order to get rid of it from GPIOLIB.
>
> I don't know about that, the flag is inside gpio_desc so we cannot
> access it (struct is private to gpiolib...)

Actually I think the way the toggle call came about was for this one
MMC usecase.

Then other subsystems have used it without asking the GPIO
maintainers or without implementing the more proper accessors
or patching drivers/gpio/gpiolib-of.c because why not, probably
thinking something like "hey weird that it is just toggle I guess they
are not so smart, but it works, ship it".

Yours,
Linus Walleij
