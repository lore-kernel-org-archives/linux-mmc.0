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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A2C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 09:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F666144D
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 09:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbhDUJMB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbhDUJMA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2021 05:12:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AEFC06174A;
        Wed, 21 Apr 2021 02:11:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j7so11560403eds.8;
        Wed, 21 Apr 2021 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Q0QOgBFAHEX6JOMcIulNXzdx8L/HYfeVOnvhHwPTHk=;
        b=BpQwADd0LfkthEA9rTpDz7MyHVsNL7HKb6Vo72I6JZ1WqquBul3E114txhXpDCH5+J
         RdyKHlRW98AryXY8987m1M8SWjoUXUQfeTBj4C38NjNwzaJO/Qs4ldTgUMJZ+XGpXPZn
         udC18gY/vZBAT3SY82lDo3f50aBPRi7mBu7tmsFYSkp+uTCJwFRAk5XKS6MOAOnuV7Z2
         x1blOC2+6U6kYV73GRCPne42IZvkyWBWOapBkYoyzvTc7gqAxO4kQU2BKBaugSSjC5UG
         Hhs6SLJzG2/dDJJadx2EB88+3bQ22c3OI8SJw+8mLhxaqxhzOYn+iJykTmw1PZPXwZGI
         1SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Q0QOgBFAHEX6JOMcIulNXzdx8L/HYfeVOnvhHwPTHk=;
        b=MYdOD82QhIFJaDLsb8GhuALxpWQOhT9wTyoxMXzKtkVw8qkCUQRu2s/gHP6Y3bEO4v
         +q3xiT1cJo/EfmwbMOVOa2u6rJzAehDv29Tu0/obqMeCzgEjAGiXpbKLtNeEfUbEALK3
         zTuH6M09wFFst9dwwMSCg4lQnDctfbZ26KtWF0Lz1jsa9glF9x6qU1K0cV/Ilea1hUTj
         bxbGo5yG9xA/tVn6gee5+4goSwNLLPzjZtuJJ3hmXHjVus08tFnzU86KIEM8rCgM7KcB
         9XVyULsDqyC+5BORPGhfJwnM1wf2wJjxssBk8XALrmyte2DWYoHoU5Q3yHxhh3FRdoEF
         HguA==
X-Gm-Message-State: AOAM532uL9yKtArRHWDs50gEYBLNDShwj/5LMPn1e1Un2EXYHt3FbYSf
        dFo9YAgHNm9IEfHmv1zHvFg=
X-Google-Smtp-Source: ABdhPJy3z1cKSNS7BjPEFsBpeZdR1m/tRdpWeLixQFDvBD8w/AaxyB3CPX0KyTGhe+yLWUjp6WQZEQ==
X-Received: by 2002:aa7:d94c:: with SMTP id l12mr31508473eds.290.1618996285880;
        Wed, 21 Apr 2021 02:11:25 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s11sm2487783edt.27.2021.04.21.02.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 02:11:25 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] dt-bindings: serial: snps-dw-apb-uart: add
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
 <20210421065921.23917-3-cl@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <b5e0b661-7dfd-1456-f8a9-0f23539fbae1@gmail.com>
Date:   Wed, 21 Apr 2021 11:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210421065921.23917-3-cl@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/21/21 8:59 AM, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> add "rockchip,rk3568-uart", "snps,dw-apb-uart" for uart nodes on
> a rk3568 platform to snps-dw-apb-uart.yaml.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 87ef1e218152..9bbe4afc26a4 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -30,6 +30,7 @@ properties:
>                - rockchip,rk3308-uart
>                - rockchip,rk3328-uart
>                - rockchip,rk3368-uart

> +              - rockchip,rk3568-uart

Sort this below rockchip,rk3399-uart

>                - rockchip,rk3399-uart
>                - rockchip,rv1108-uart
>            - const: snps,dw-apb-uart
> 

