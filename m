Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A947C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Dec 2021 03:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhLPDXr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Dec 2021 22:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhLPDXr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2021 22:23:47 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D0CC061574
        for <linux-mmc@vger.kernel.org>; Wed, 15 Dec 2021 19:23:47 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so27402504otl.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Dec 2021 19:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tu2NGSrgJfVwTrxV5gAyRVtFDdQnC1eWVUu1iP8zEN8=;
        b=BlF8OZZXcAlTD9yavJ/2Edp4bspRnEAudkBYiMjp27yXG0WM3UUR+WX7lrDx86g/r1
         1cF4LKNGY4eWGWN1q/+PQI32Xz/2UD9dyaH00o1Bz4yMSYof1gowQ25Tve05nMhwtSon
         wop7AtGlpomNS+xRb6S1LeTK1QzpnQW3IZsWf9wKeNNGmbThmoUzPGUrtYtVyJDWXZVt
         wU7Bn4o+5eYSEuG2glrrrM4VsVYeYQEZ8TlgZpzjNORHL/x4mK2tb55jxY3gxCfSOJPE
         y4DBlM7lzB+0PXsWSV0TlytbpgTRzp0ft0QMpIsyiDFnjweiDywaO4sraUrApVDXMWZx
         aLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tu2NGSrgJfVwTrxV5gAyRVtFDdQnC1eWVUu1iP8zEN8=;
        b=CjA9pYXp2SHNhHjHyx6rsuxghpJ9tPO//ZsP0GYIuoXcgYDpyJrGNX1In2bGNpdalR
         2iMyy3qOGtGACvFSJ40RWYQs0NZLqZcE5LPpGiuCncigcCRGycgrr9kqTkJPv42u80Ot
         cMA9rOO4oWnYpdIULOc6TyBj973vUnjxqnIEE7qVli9ET8rClDxFwLQpGGMXQJw6xYlQ
         Yo4z8YiGX7NEQniqqKotgy93dDZysoSNRx9Sg8EVQYeqzLlz2K3mcGiMygdgUAxxqJjX
         lzohl5wbUxWhqftR7YQj48pOlUXLffWHhif7FAM1U6BB/ph4i/Dsl9myHvSAdhf480KF
         VkEw==
X-Gm-Message-State: AOAM5310GaAOJIvRjFSWLFwpkVnhIYPU7EwX2U7WPf7vXtT+237DWAcX
        2ouOJkn6fDih4qCoY4pn0lLfb3HtLN+isI3ODi3tQQ==
X-Google-Smtp-Source: ABdhPJyY+kaKouB91L9mIADgugdeKmhVXLKaMwoLSKVdKhTyrm1W05U50db4LhIhM9NZuvZLM8U0AIG+vZRgFzXO658=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr10939446otl.237.1639625026377;
 Wed, 15 Dec 2021 19:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
In-Reply-To: <20211215141727.4901-1-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Dec 2021 04:23:34 +0100
Message-ID: <CACRpkdagP-UoSyWeOVoxitaMJru+Z_rRa-V3RbLg2jHOnq=_hQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: mmci: updates for STM32MP13
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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

On Wed, Dec 15, 2021 at 3:18 PM Yann Gautier <yann.gautier@foss.st.com> wrote:

> The new STmicroelectronics STM32MP13 SoC embeds a new version
> of the SDMMC peripheral (v2.2).
> It supports SDR104 and HS200 modes.

Patches look good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
