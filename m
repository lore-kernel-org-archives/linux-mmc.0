Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCDCC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhLUNDx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbhLUNDw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:52 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55087C061401
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:52 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a37so21273142ljq.13
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f2qNHvJhKpBToIPZLW+xA9E++P4QeJXFYGdCU5RbRp4=;
        b=i4ybpobrbhYH8rGHIz8VjkuKIUjswGujDq6RvnRu6v/DHLQsgIG/QNo4JX9vbqMPM6
         F4jirxxP4cNtBrqfr5h6Q+dLOwufNyDRCRM50xjkIcOEmP1qTB6aW46WI4aHPba19hCL
         /vx5tfCM7uI5jFP/uRoGfFUNND/gyDF4AHCrHiNepmTaq5JbgkkxMd4R956+G7KluBtP
         0RAmbrDHQPypkBOlNk1WONuas0tloi3uiJtJ73lTUZaO50Xs4jwiogskLT065/OQDhzH
         6QaGJ3hfpqtkAMs1dieZU+AUnoGmqRkKBkVJgHFB38eOdBxBown0L9MaZKypvN4Xqg3y
         7HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f2qNHvJhKpBToIPZLW+xA9E++P4QeJXFYGdCU5RbRp4=;
        b=3Vy1mxusV6DqtQtz00X0bFNyN3uLdnIrjA4BXUs1W1wTfB1fR+Gnf1GgnzibYtxhi3
         K0Y7np2t7QTg3J0iInB6Bvnruen4BqMGZ97E3FPAVUZGhQrIJ9O03q4mgPygOEcoSPyz
         u9i2skvgfV4K54cA1K9LjeE5cYQMHpjKityrH1bVdBwrcSrmmNpk5Hh+P4qwRslVSwVC
         b8lITDo53qRsAm7nK0LU47lU9DtPAfcYVYdv4DSbXpYZe7rtM0TTEnAPLv4eO7gIE1X2
         jd/Xwf4lHZmOin5KmsQTxXiejyiU4wt0oSlNhkfVzc7zMmM9a7ASNtn5ch5/Yv8l+Zz1
         rYOA==
X-Gm-Message-State: AOAM530tOYC9Veoy5EOokZNIiF5iEkpMn0yFYcJ9PKy9pYl7vBPu5DdB
        1/ouaqgDlelVtuZlPRQGaMAgdqAjwKOYd8ivgZxalQ==
X-Google-Smtp-Source: ABdhPJwrR40iX4q94vc7P5eziaIve1UqbfpZWl0g0Tma4tdKA3wHUhPJ0j7+H+zpmtA31EDgoS9GGwaHb4e+o0Dl1fg=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr2525087ljm.16.1640091830640;
 Tue, 21 Dec 2021 05:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20211220113026.21129-1-marten.lindahl@axis.com>
In-Reply-To: <20211220113026.21129-1-marten.lindahl@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:03:14 +0100
Message-ID: <CAPDyKFrsR2fN-M7dO9194i9Uj8pFqg4rGiR_apqnvQwAiaFuNQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add ARTPEC-8 support to DWMMC controller
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Dec 2021 at 12:30, M=C3=A5rten Lindahl <marten.lindahl@axis.com>=
 wrote:
>
> Hi!
>
> The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
> Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
> does not support HS400 and has an extended data read timeout. To run
> this controller we need to add compatibility for ARTPEC-8, because we
> need to separate the configuration of the TMOUT register from the non
> ARTPEC-8 versions.
>
> This patchset is dependent on 2 changes that has been added to the mmc
> git next branch, but has not yet been merged to mainline:
>
> Patch 2 of this patchset depends on commit 0e6f2c4c2072b ("mmc: dw_mmc:
> add common capabilities to replace caps").
>
> Patch 3 of this patchset depends on commit d5bc33487eab3 ("mmc: dw_mmc:
> Allow lower TMOUT value than maximum").
>
> Kind regards
> M=C3=A5rten Lindahl
>
> Changes in v2:
>  - Change compatible string vendor prefix
>  - Removed unnecessary comment
>  - Change 1<<0 to BIT(0)
>
> Changes in v3:
>  - Add callback for implementation specific control of data timeout
>  - Add callback for implementation specific read of cycle count for
>    data timeout.
>  - Move definition of DW_MMC_QUIRK_EXTENDED_TMOUT from patch 3/4 to
>    patch 4/4.
>
> Changes in v4:
>  - Add Reviewed-by and Acked-by tags from Krzysztof Kozlowski
>
> Changes in v5:
>  - Remove redundant '0x' prefix from debug message
>  - Add Acked-by tag by Rob Herring
>
> M=C3=A5rten Lindahl (4):
>   dt-bindings: mmc: exynos-dw-mshc: Add support for ARTPEC-8
>   mmc: dw_mmc-exynos: Add support for ARTPEC-8
>   mmc: dw_mmc: Add driver callbacks for data read timeout
>   mmc: dw_mmc: Do not wait for DTO in case of error
>
>  .../bindings/mmc/exynos-dw-mshc.txt           |   2 +
>  drivers/mmc/host/dw_mmc-exynos.c              | 101 ++++++++++++++++--
>  drivers/mmc/host/dw_mmc.c                     |  21 +++-
>  drivers/mmc/host/dw_mmc.h                     |  10 ++
>  4 files changed, 122 insertions(+), 12 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
