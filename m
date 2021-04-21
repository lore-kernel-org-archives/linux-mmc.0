Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBB1C433ED
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 09:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA94D6144B
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 09:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhDUJ1h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDUJ1g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2021 05:27:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B34C06174A;
        Wed, 21 Apr 2021 02:27:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bx20so47384636edb.12;
        Wed, 21 Apr 2021 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hH6gOY5Krjw8Rc2Sxt75fVQdHpdQjhafzlD6HdCfVc=;
        b=hJNclq7CenzlSQ5Zhk5Ww/3t0wzxy9F/QcPiPW4f0ljxEUi2HXp8kTEaZdeUDawaLe
         dkhPonR9EENLcqruGCcYlhDBX10TWvnKCLkuSdwin4DSt3D88dhN2bhnoibh1FZO7HXW
         GcvBpik5Eht2Tx5XeM+HkiQbJKz7Q7SaSYCHdmPxCNpYpyfN30/SXnpMvGsH/2qJGkT2
         gvFuah46Fe6/S91lMoV0wa8PvdWDVY+aRjpu1fldBQ4f7tmAQ5ztfmqGtT13IdXyRqIo
         I2xkmlcEH8lwPoTu8Xdx1SjFRr8jw4tIYsL5bqOxNbWxRg+wh/m0TOhAtzNsPx2xsZGc
         rBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hH6gOY5Krjw8Rc2Sxt75fVQdHpdQjhafzlD6HdCfVc=;
        b=fnumQGvn4iLtIRdeysVXfJVMuUaek+5HHmUAzhOmzji2EVk23BJLJFxmC7DzDPS+w5
         QLpaBHT6WPxgJIgJTvzfs7RCz/6KR/WG1/Td5UNvGNdUwaWvdjRVfTiDI+TTXd4DPrxy
         i6SFhHTzZFqQLkTsLaLmGSHXBIcXl45jleZf0txEQ+yfi/IWZEWTQZ1OSt2tCdhylaJv
         B6eHdRIYyWj9EhlK0o8uSuCvpmFwx7ZL7osXAhqE1frgJ5ze2ckaEVBC0af/TjLl5Teq
         PACbd69sE8Q4R5C0LdKJ8GCm1NgnzAAa1vkO2+jeIN2BxSzi1iIthtYT2PijGE36FFwb
         p71w==
X-Gm-Message-State: AOAM532NFE6IOObHUqZW8vj5ZHHWDLMgqGpvQU4/mFvcet1WxMOMpdLA
        nDPtcaKmS/ER5rnfNkQZ2g4=
X-Google-Smtp-Source: ABdhPJyhKDP7bQ6iqb8kCTWEN9iCqDKVLP4xB+AE90OA08e7doKGYDxLySzFZ32pdT5LcVqvSNVmZQ==
X-Received: by 2002:a05:6402:350:: with SMTP id r16mr29860142edw.227.1618997221534;
        Wed, 21 Apr 2021 02:27:01 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j9sm2496474eds.71.2021.04.21.02.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 02:27:01 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] dt-bindings: mmc: rockchip-dw-mshc: add
 description for rk3568
To:     cl@rock-chips.com, heiko@sntech.de
Cc:     robh+dt@kernel.org, jagan@amarulasolutions.com, wens@csie.org,
        uwe@kleine-koenig.org, mail@david-bauer.net,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        jensenhuang@friendlyarm.com, michael@amarulasolutions.com,
        cnsztl@gmail.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-i2c@vger.kernel.org, jay.xu@rock-chips.com,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com
References: <20210421065921.23917-1-cl@rock-chips.com>
 <20210421065921.23917-4-cl@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <7dde9617-9d71-9fdd-6f91-3fc327fa9bc1@gmail.com>
Date:   Wed, 21 Apr 2021 11:26:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210421065921.23917-4-cl@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/21/21 8:59 AM, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> add "rockchip,rk3568-dwcmshc", "snps,dwcmshc-sdhci" for mmc nodes on
> a rk3568 platform to rockchip-dw-mshc.yaml.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 3762f1c8de96..2a6c1cee4887 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -27,6 +27,8 @@ properties:
>        - const: rockchip,rk2928-dw-mshc
>        # for Rockchip RK3288
>        - const: rockchip,rk3288-dw-mshc

> +      # for Rockchip RK3568
> +      - const: rockchip,rk3568-dwcmshc

Remove.
This would create two descriptions.
"rockchip,rk3568-dwcmshc"
"rockchip,rk3568-dwcmshc", "snps,dwcmshc-sdhci"

>        - items:
>            - enum:

>              # for Rockchip PX30

Remove comments.

> @@ -41,6 +43,8 @@ properties:
>                - rockchip,rk3328-dw-mshc

>              # for Rockchip RK3368

Remove comments.

>                - rockchip,rk3368-dw-mshc

> +            # for Rockchip RK3568

Maybe remove the "#" comments in this enum part too.
This was one of the first Rockchip documents that was converted, but is
not really needed, as it both mentions the soc name.

> +              - rockchip,rk3568-dw-mshc

Sort this below rockchip,rk3399-dw-mshc

>              # for Rockchip RK3399

Remove comments.
>                - rockchip,rk3399-dw-mshc

>              # for Rockchip RV1108

Remove comments.

> 

