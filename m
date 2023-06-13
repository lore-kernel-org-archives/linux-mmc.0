Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAECBC7EE2E
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 06:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjFMG3M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 02:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjFMG3L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 02:29:11 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500FC183
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 23:29:10 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bc5566538fdso3057410276.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 23:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686637749; x=1689229749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtXnfqbUClqS5WlWWSWJJSXAag1DuivP2vgqQcYQFEg=;
        b=X1KPp/8Vz3dGrJCMcgdEDKY6Dca3FRT+SS05CZNaFCr8BJm5ej+OjpdjRJmZerYMgM
         bzpIXXFFDK6bDpiIWvKuo5xzfqZx7Ao1DmMCir6ottRAKsqlLDEO+dKM6RHvmLBhgGyD
         3Kvd4FGcJ5XTPE3wYsLFZPENlgdh+7aLNHNvqI14F9z5zj8rbOAWbRzDNEx/grVgQ6m6
         yAypBL+6rqYMyWm7I2pr4RCi3ULD3ktNDdKh1KGyV1fYfmNoBjUzl3FQARLCNTQWFUND
         y4uIdh6Z9SbV1onvhWSwfDTwIdfnx4QKA1INq0d49WNraAYNGDMtVFpWgO1d2LSMsSLe
         dGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686637749; x=1689229749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtXnfqbUClqS5WlWWSWJJSXAag1DuivP2vgqQcYQFEg=;
        b=Wit+9uC0BSRLl8gxq+nhyO++daSzk4R5MN68rJpkUhNP5BR+AibUBWSRsgqGb+S+f4
         veTfdgDJc3TwIQwOq3dC+xyCMuVME87JIyMdnJtd5zXV/YKUAfR+qK98/T2To0OjD4bU
         1Ecl0xknmEcwkrc40O/RWpVxU8mp5ig6mcl9tJnwJws6D+gPDKGwSmQxJFT+duAOjGV6
         F7Mmcl7HjiPzO4eiaIlhb1ZnByRNZw+3YYYGbOPmRgZNUhyYKoHICRpZ5KZDrIM0uBF2
         5EV6x5N3iTAVZT+0jnUNN3VJRmZeI6fjWPBMp3o4iNHkFXc4b/no3UjGxbUDVEGRwHAj
         uf4w==
X-Gm-Message-State: AC+VfDwYUzHpLYr8n2Dd92HZ8ZSZrS7qbzvNcdZKzZLFB4XMSAb2ZbxH
        3fXRI/Fa8/b+5FVay7/vLh7mxIfK99iY/ne0/osvOgb/71gOX99v
X-Google-Smtp-Source: ACHHUZ7Sy7pbiuZjXDqk3JnRmV338jlZH12ywUqRe28RY/58qEbA/cWUcpI+PknUGlOW+uG1ER/RJ0ILeLdNG3d/MpE=
X-Received: by 2002:a25:dacf:0:b0:bb8:2eb4:4f10 with SMTP id
 n198-20020a25dacf000000b00bb82eb44f10mr931636ybf.22.1686637749518; Mon, 12
 Jun 2023 23:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230612143730.210390-1-ulf.hansson@linaro.org>
In-Reply-To: <20230612143730.210390-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 08:28:58 +0200
Message-ID: <CACRpkdafRdxZKsHMvS868ya_3mAnUan_iRq24idRLOTsVYzOcA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Dennis Zhou <dennis@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jun 12, 2023 at 4:37=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> All mmc host driver should have enabled the asynchronous probe option, bu=
t
> it seems like we missed to set it for mmci, so let's do that now.
>
> Fixes: 21b2cec61c04 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that=
 existed in v4.4")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

As I had the test system up I applied this on top of the busydetect
fixes and tested on Samsung Skomer, works fine!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
