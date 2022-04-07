Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77ECC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 18:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346930AbiDGSrR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiDGSrQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 14:47:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3642C10BBC7
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 11:45:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g20so7476773edw.6
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e+8rPNKnLfR6UpydjUZMq2BlBGQud00Gc98TA7d84v0=;
        b=mHdbnkYUV7qoA7mUvCkZ6vtiJA4XI765mmOtA0TOn15pRL+yKSEwJ4XYnpTe4umwsM
         9h5refKEhX/Pjvykm/rHItmP9W3l2D2qyuJAap6zJUWbm4GKbWXerwr7ib65FuD8A1d2
         SeK3BFglrn4t6xbV/1SAZMw+cR/xW87vIIQec8zWAKD+/d5U2vVCpaBNPfEm4C/h1Hx8
         xie4qY8xMzntYrH0avFX5ev7sqcF68h71lj6MU0u59Ls116Mu9yXI1QmbBVyP4JQGH+H
         rabreLoJ9CbqyGYCAbyq1NxHmhnL3uTUiwvY6MWyPo7vyJEVjuevqdXHA2mQ/f625RY3
         xzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e+8rPNKnLfR6UpydjUZMq2BlBGQud00Gc98TA7d84v0=;
        b=kqAfChw2ZwyIObZQN4Ao7GvvLqZN5/4nrmOtrn4TDwDtrEbZjHgCzMglc7w1WTl8zW
         cjOgkWKLk+vEW9weF7MSEXN3qTRsxaqcfOfZgJpRSTSCjVn1gmRwYHQsjXnAw/GAOoHn
         BJkc/Zh8G5IkaMRjCGu1W/889Yoy4iSCDBQs9oUyEvw+VNlAkQ//kx/sFB9LQq/WQszf
         DuGlJhBVX8CSMsr/Oq6U6O+5ryLD/3HssleqGvC1ZnHEYWI+ooGMDqC4JDRm5+HOj02P
         hKR1bXXfREsNgw8g4kF1NSy1zrQ3NuGeLe/XnMZYLSg4mpRj4i1s+LMCZJmyg++aJZhH
         WJcA==
X-Gm-Message-State: AOAM530o8Xnl/54xl0T4nU0jJET+sTi0lS4/9j4FYbaL54G6H99V5xiI
        YGOak+jKf302Jz3cmhL7c91zjA==
X-Google-Smtp-Source: ABdhPJzzYTjExY7X2ZcWLPtIkr6f2qBYOma5eTVpOhgyjcbA6/L9HysH+GpGTNG8OZp2neDCUzltJw==
X-Received: by 2002:a50:9e61:0:b0:419:d8e5:6236 with SMTP id z88-20020a509e61000000b00419d8e56236mr15701582ede.327.1649357109799;
        Thu, 07 Apr 2022 11:45:09 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640205c900b00418d79d4a61sm9846078edx.97.2022.04.07.11.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:45:09 -0700 (PDT)
Message-ID: <05febd3f-bfdb-13c2-8cce-b9dc422c5eae@linaro.org>
Date:   Thu, 7 Apr 2022 20:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-2-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-2-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> Document the compatible for Pensando Elba SoC boards.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Add description and board compatible

That's a bit confusing... the subject is for v1.

> 
>  .../bindings/arm/pensando,elba.yaml           | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/pensando,elba.yaml b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
> new file mode 100644
> index 000000000000..61225f2d6ce5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/pensando,elba.yaml#

I propose just pensando.yaml, unless there is going to be hundreds of
different families of SoC from Pensando?

This patch should be after adding the vendor prefix.

Best regards,
Krzysztof
