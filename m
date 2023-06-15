Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A11EB64DB
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Jun 2023 13:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbjFONVB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Jun 2023 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbjFONU7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2023 09:20:59 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5C12728
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2023 06:20:50 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57001c0baddso19766467b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2023 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686835250; x=1689427250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aX97xCToWV5//RvNXLNZC2c3J5Dbjde6RJhRL1H+eSE=;
        b=Z7Vt+tJ6ZXAT2LMJTiuoQ4nJjIelvhefnByDBbvXpt8TZcUd8RDeuFg7udKdaqRbAV
         coYNEisPjOGrp1ArWfKkeAS3dltxJqa+Tx6R5v5/Qvp28sHYnb8CRmoeUU9KzGP78y2k
         n5lY8y00Gbrvp9tbOl++/Gzhg2y1yzHKXLW/2vYk9TuxbAzc2FKUoCcgukT2W32nvTGc
         jP5iNG7m4UeqYq5dp4oLbAUfWWoTh/lnVvssrjTWwhP8hBHxlgJSktu+kllPHlxZRPNM
         tczsTr+tYWs81+5oGtdledEpN+aCpaUeem933gLMQYq3B5vY7kICltVUUKcq22ZR9nB5
         jF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686835250; x=1689427250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aX97xCToWV5//RvNXLNZC2c3J5Dbjde6RJhRL1H+eSE=;
        b=SWt8DIPT7dZ0TKUk1oSYlH6gbIkcpThggQddaeKvgVeyNZoCOn1kR+IbqK4ltmk/AO
         YrM65S/W55LZV07ShkFLDsiQlY5yoU/rY9hsSRv1w5nMo9j0CvOMmWfhW382lsmYs85j
         9kxvjJbOa+iHHAr35wHs3oR3iPCWQrXFC0tJKz2eRZlGvTgYFN+vBfEDTwj7/DlgVC+2
         w4QrMzaa5u4snfEnvWYFwOduThIrL4VWwp70JAVcF85Kpc4yjWewyhe8MEEV4LxVeyus
         HMoxHnnmGJnmqUDZcdQyC8g2OEgWmaXqcP8EDfbjDBHWtlWsjzXBH7+xyARr82g51iv6
         eE5w==
X-Gm-Message-State: AC+VfDzwAXlck0IJeEjZ8qusLyqtJC9mK4Qn9AY++ANVjmDyLbj0oUc1
        4Qa/KV+r602EDFgi9Y8sKY5yMAGYnJchdYIj9uPvlvSB36V3mHNI
X-Google-Smtp-Source: ACHHUZ7cc7qLuWFlmewZHndMeTGJ1lCp7+tWMjE+IKpjzV597WRvXEOfvUA5tnyK2rMjzUksHUpC1md88NP3KWhBAFU=
X-Received: by 2002:a81:a50d:0:b0:56d:278:fea0 with SMTP id
 u13-20020a81a50d000000b0056d0278fea0mr4849499ywg.7.1686835250160; Thu, 15 Jun
 2023 06:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230615092001.1213132-1-yann.gautier@foss.st.com> <20230615092001.1213132-2-yann.gautier@foss.st.com>
In-Reply-To: <20230615092001.1213132-2-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Jun 2023 15:20:14 +0200
Message-ID: <CAPDyKFqJsqmNzeRg8hj55yUEMSycOWsmKVKsMWk4Qu7Y8_dNzg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2 compatible
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

On Thu, 15 Jun 2023 at 11:20, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> For STM32MP25, we'll need to distinguish how is managed the delay block.
> This is done through a new comptible dedicated for this SoC, as the
> delay block registers are located in SYSCFG peripheral.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 1c96da04f0e53..e47b3418b6c77 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -59,6 +59,12 @@ properties:
>            - const: st,stm32-sdmmc2
>            - const: arm,pl18x
>            - const: arm,primecell
> +      - description: Entry for STMicroelectronics variant of PL18x for
> +          STM32MP25. This dedicated compatible is used by bootloaders.

What does this last sentence mean? Can we drop it?

> +        items:
> +          - const: st,stm32mp25-sdmmc2
> +          - const: arm,pl18x
> +          - const: arm,primecell
>
>    clocks:
>      description: One or two clocks, the "apb_pclk" and the "MCLK"
> --
> 2.25.1
>

Kind regards
Uffe
