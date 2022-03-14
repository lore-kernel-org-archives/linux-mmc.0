Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B1C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Mar 2022 22:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbiCNWoq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiCNWoq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2022 18:44:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3752833E26
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 15:43:35 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id u10so33732521ybd.9
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBz4KR/tbzFCQ7Rg6AbL2tIN/kz8QPBlTu1AMO28qtU=;
        b=r7NNd/At5KMqFw3i9SvlUx564e3HPd17qxW7CY1V/KYHkMDg2c205EYOqfvZ+Feie0
         k78b8IkyX6wYfgmqwiJYaa+1N2M3Tc3DuQd210amcQeoZkCentBLNGI7opmuGm1zFmpo
         kXCRTEs3pkdklEykPP7O3IbVmZrH84YOUuGa9bsDHpjS94GVCLF+z1R6OdlcMcwhpKM9
         ZCEfs1XlbOpMBbRh6nRznEnzHtaiMfaHSIK4invfukZGxDmq7l6EgYHLk76Efz86Bed0
         cYcdgIHO4n6h2Ms4mnZJKpewAoUOD+al7/xMp/5P2wRBwOJ3B1tjADUlF3+iqwg3HNZE
         jjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBz4KR/tbzFCQ7Rg6AbL2tIN/kz8QPBlTu1AMO28qtU=;
        b=1AAl9uXMuZOJhoW6T/5+HqpszipGkSZgAfrRiF1VZsw5WYkwy9R6LIeXzupITbMxea
         bWEJF1/1gYFRXQJV027UwrFaDej4rJH6zlzgIHkvWHvLPtmPALA4Y225ujVtmBhTYLZo
         sSUFe2qo7yF6A1WYdt8vgV0WMg9dht/Xzlt0d5Mp4As/PimRg2H4fvG5TKi9fr+Gyvyf
         twPP6vzFiH1+h2/+knKDWzRTiZ176tO+wsnJpiYpwDR08z7rp2EN9W3TgK3MwFV/tlgp
         T0a2aYnqln+l8G1LOOKViwpuJO+DP4b3YgEkia8fgRAaRqiOf/+QAiNaVk56EfYtDzIp
         EQrw==
X-Gm-Message-State: AOAM533mQQinx0UQxpAecHkw1Fuo+ewFVdfZpwpq/ry8USmdmvsd4hJ3
        wpRYuI5c915uwYqZkxCou9H0u9d5UI91twxbfw/iXV1buaGQ1w==
X-Google-Smtp-Source: ABdhPJzdH5EAlui5zL/pWz9DIDbKqOBoB1cvh3rT4dgsBx/UFynGgA6bujxHdHry3cd2exdH6seuYB8+4pdVXpKfX60=
X-Received: by 2002:a25:ab64:0:b0:633:6d02:ebc8 with SMTP id
 u91-20020a25ab64000000b006336d02ebc8mr2106711ybi.492.1647297814409; Mon, 14
 Mar 2022 15:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com> <20220304135134.47827-2-yann.gautier@foss.st.com>
In-Reply-To: <20220304135134.47827-2-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Mar 2022 23:43:22 +0100
Message-ID: <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

"On Fri, Mar 4, 2022 at 2:52 PM Yann Gautier <yann.gautier@foss.st.com> wrote:

> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> starting from revision v2 of the peripheral. But it has limitations,
> as all the buffers should be aligned on block size (except the last one).
> But this cannot be guaranteed with SDIO. We should then have a property
> to disable the support of LLI.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Actually I think this is present also on the ux500 variants. See:
commit 2253ed4b36dc876d1598c4dab5587e537ec68c34
"mmc: mmci: Support any block sizes for ux500v2 and qcom variant"

Spot the variant data "dma_power_of_2".

So whatever property you add
to the variant data (not in the device tree please) should
be added to the ux500 variants as well, it will *VERY* likely
have a problem with LLI elements not being a power of 2
as it is the ancestor of later STMicro variants.

It might actually be the reason for some annoying WiFi error
messages I have seen :/

Yours,
Linus Walleij
