Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE2EB64DC
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjFTKPB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjFTKOi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:14:38 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C0E71
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:14:35 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-be3e2d172cbso3361793276.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687256075; x=1689848075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJJmgVmTa9f7iC7uetyObrO68r9W6Xg4F51QYpcRfPM=;
        b=KnoTmyXWN5md3fERuYS0Dm1jkxj7MOSAMZonVdYOgYkrdxFKHgtTDDuTuK8KUTyj9F
         ez9ntj+NgYS95fgZWQPJruaiSIYe6DmuXCqTZQamUic/P9E35BVDJiSd5vsyEyaM16Bf
         wR7r7uhN3GgiQOopbgClgUByAhApfqvyZiHfIyx+REd7jzadhjy2+7y5PDGqudOU1rso
         HZPvU8QWJkIZAib7qlTYb56ZiOVD/k7bfSdUgw3xVD682z9SxYylNhf2o0v/tn0e3OAH
         TL9ffDVzjAWeQR5L6BktCyIelKExgehj76tEmDiT/DeraQ/v0MKdX9v8kXJhXq7XI5GI
         I/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687256075; x=1689848075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJJmgVmTa9f7iC7uetyObrO68r9W6Xg4F51QYpcRfPM=;
        b=OKbA/oXFAvLXr6HqGiJFTMZPF3CH9YLsUYtRCNWqSrPP2KKrlQIkeEB6t6jMik6R6+
         vdLaa97elFKSWz+e83zpt3nK0RsZ5p+JIvW3XRRB7lqo97uAurc+pZVmZmGq3BiCX0nu
         1bk9yfRKgIxSwh/ez1HtatnijJXLhVoMTn08g5/0E2qtlae/45b3SH9j5ks2Zb8PflgE
         3g4ypxXVHNXfb09xZ6kJbAXkCSmwZagMgJiRdftA+2HCqb8ppfehsfgUQstPsFk9af5j
         pwK1LCXzR0gW3HFqIRvKsMX+AjyJzAaG9JW8Snkx/E8pjU3tRjUGC3JMiIGNMF1FrdMH
         oWPQ==
X-Gm-Message-State: AC+VfDw6JBLReOuwyCaATgZOXcXyR+apdOZn8ca2AY4Vtna5XJg7QUVN
        b+Wf3kj/DrHrl07+FaX1iOaHC0sBE07K6trywVawTA==
X-Google-Smtp-Source: ACHHUZ6iVAXtSlfEagdTRkw6Q+YSAN1J8b9rGKXips/cn5kKkmDKHU27IPuCLZFV6BZvBtFEqfel4P+d3RXAqP/kWDA=
X-Received: by 2002:a25:d310:0:b0:bc8:f082:2301 with SMTP id
 e16-20020a25d310000000b00bc8f0822301mr2837948ybf.6.1687256075120; Tue, 20 Jun
 2023 03:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230619115120.64474-1-yann.gautier@foss.st.com>
In-Reply-To: <20230619115120.64474-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 12:13:59 +0200
Message-ID: <CAPDyKFrYfZHovci0ekTi3WWUrQDWv60MACEe0A_Sd0RmOdW=oQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Update MMCI driver for STM32MP25
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 19 Jun 2023 at 13:51, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> STM32MP25 is a new SoC from STMicroelectronics. The machine was
> pushed by Alexandre [1] in his tree.
> On this new SoC, the SDMMC peripheral, using PL18x/MMCI driver
> has been updated to v3.
> The driver has been updated to manage this new version, and the new
> features it supports:
> * FIFO size increased from 64B to 1kB
> * IDMA size alignment/mask updated
> * New block gap hardware flow control
> * Delay block updated and dependent on SoC
>
> This series was pushed on top of next branch in Ulf's mmc tree, as it
> requires feedback clock update patch [2].
>
> [1] https://lore.kernel.org/lkml/59f4a900-34ee-d991-c350-265d38e7c862@foss.st.com/T/
> [2] https://lore.kernel.org/r/20230613150148.429828-1-yann.gautier@foss.st.com
>
> Changes in v2:
> - update dt-bindings file (remove bootloader reference and use enum)
>
> Yann Gautier (6):
>   dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2 compatible
>   mmc: mmci: add stm32_idmabsize_align parameter
>   mmc: mmci: Add support for sdmmc variant revision v3.0
>   mmc: mmci: stm32: manage block gap hardware flow control
>   mmc: mmci: stm32: prepare other delay block support
>   mmc: mmci: stm32: add delay block support for STM32MP25
>
>  .../devicetree/bindings/mmc/arm,pl18x.yaml    |   7 +-
>  drivers/mmc/host/mmci.c                       |  35 ++++
>  drivers/mmc/host/mmci.h                       |   8 +-
>  drivers/mmc/host/mmci_stm32_sdmmc.c           | 149 ++++++++++++++++--
>  4 files changed, 179 insertions(+), 20 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
