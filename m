Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294FAC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbhLUNDe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhLUNDe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6758C061574
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id k37so29232380lfv.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqXlLV8SePaGC+y3/vdaOf1H0E4thOEsiFPNapXQwSc=;
        b=YyYPK9tu3NmScrecLS1MccIJvkhdJy4nQ05x9Z3bt/8vALw1x+ChKGPtvKCnZY5xvi
         s4WV5IxCq8WSDBv2lm3jUZPwAN3lYjxzCTki+vYHcztUd3Z893htrpRORBgTB/r8ARsS
         K0OKXOBmn41TVqOgRYMdG4ebbv3TOsci2xjntYGbZvUW94hh9kZqEZ53DDRR3Gh6dQrc
         +IZx6HEWuvQGmStWddnzGBtvp2zCJ0nnFIoOvxb2lfRMifH5uwNLatShXB1/xGgqBhdU
         HsfgFm7/neLDbVqqD03e2p+Y3lkxRPxzBzfjifTjzsiWHArWZJeaA4J26WB4c/6kWMOx
         RgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqXlLV8SePaGC+y3/vdaOf1H0E4thOEsiFPNapXQwSc=;
        b=bO+UUdvCUPgvR3r8Z7yhlUz/qsMzfhPOcOPmRvTUq6Q1ozE5XDbVDq+67WDGMLDyKD
         nampH7EhJ0MJMhMB11VT81neeV+dTSjggeNZs4eZ7qw6DhjQXDs0sOpK244PoRtlhfPt
         rZTwbd8DZFzbRmYik2kVoYZZgY0CXwMCKnXZfBV+lQdR43h82n558XNgn5/T0H04fi4X
         hGRCWMDSSH0Hnw8v8U8GUOHSYlAiE2acEnjR1gRfO2tx/RiObrrXbwttjoZx44SQ1jdK
         bMJ1VlpG6yWLkYq8ZyABovSZA/YCWyX6QAl9aSV8cqyYCP1dkYdj6UtRoFuXgeBlXCUd
         T6sQ==
X-Gm-Message-State: AOAM532RFVmZxrtW8oXmpxFXzeJ57o1qsN8ph0lSL5/mbIjwGttsFwqd
        6WJxgf0V+88vZJOhEHsemU7Vu2fdCCj6ftPPRAZXcw==
X-Google-Smtp-Source: ABdhPJz29OYTxN/YI/nfoGqSbzGzFH8lQFfuOhtkX+emAf6tcx5jyjh7QQeKtEVugrVqanaBliR1j4kwByF6Bzl9MiU=
X-Received: by 2002:a05:6512:3bb:: with SMTP id v27mr3010113lfp.71.1640091812018;
 Tue, 21 Dec 2021 05:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
In-Reply-To: <20211215141727.4901-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:02:55 +0100
Message-ID: <CAPDyKFpxionwX-OZwPGbwCmRmqTkWbcf7XQsZyHMh7Ht=smPbQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: mmci: updates for STM32MP13
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        u.kleine-koenig@pengutronix.de, Marek Vasut <marex@denx.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Dec 2021 at 15:18, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> The new STmicroelectronics STM32MP13 SoC embeds a new version
> of the SDMMC peripheral (v2.2).
> It supports SDR104 and HS200 modes.
>
> Yann Gautier (4):
>   mmc: mmci: Add support for sdmmc variant revision v2.2
>   mmc: mmci: increase stm32 sdmmcv2 clock max freq
>   mmc: mmci: stm32: clear DLYB_CR after sending tuning command
>   mmc: mmci: add hs200 support for stm32 sdmmc
>
>  drivers/mmc/host/mmci.c             | 7 ++++++-
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 7 +++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>

Patch 1, 2 and 4, applied for next, thanks!

Kind regards
Uffe
