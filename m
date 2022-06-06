Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3295CCCA473
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jun 2022 08:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiFFIHb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jun 2022 04:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiFFIH3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2022 04:07:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB8BE10
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jun 2022 01:07:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so27321439ejj.10
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2022 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TGWju0tIPkfnzyMNfYLOgyyDjvrvrvL8dK2m1zYPwnE=;
        b=dCCpRntKyQvzI3ixIO+EwDNQgCHC0bUE0MZzhV4q8NYiQ+Uhc/H5mZjI9F7GVI8wTq
         aG9Cvs7j40Z9zWIKBIzm7Jz06BTcVCzcPHUWrKHz9hkqvLrkjmOFRuoXPNt0Uk99MG5t
         yT8LzuAicyJyq78tRX6rUjgDTnWaFLEKJGE2ZPCCYw1WReweGp2bV3vknEMThMfjnjUT
         RUC0KDphWSdc3BFJNlNp58vmxCwzIuiwSSP7QmJTt+LKJYzmkCbEwevpOZ1QMgTUcfLY
         9VqlwD/nbhGWxnhvq6D7D0cdRWIYCkU3YkznntCgh3qBMqqiC8MaahiF4c6NhdU/kPNq
         Enaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TGWju0tIPkfnzyMNfYLOgyyDjvrvrvL8dK2m1zYPwnE=;
        b=vbrtvzbGhU+JU7NAhB049SW2aclnc20OZfa4ELepy35vk/yZAhj/0D/Mw0D2Cqplrv
         gTj5Rse7FV8JbDEUUM49J5uOUNGKs1ZFIm38N5OzDo04On6bIbTQ0qHy4mA/9pnUfgbt
         nc1IcOZsgY/LSijp6GzULheagSjlqFbcRj+pmusfSIrzg7LDiHUgYZcUIXBOaFAWMK+T
         dYAH4BpxBG/I/vUJqobgU2h5SBWTTF93hbluk5VxMrOrY0jk6Cw7tSULAKVJyAQfOB0L
         wya8TLaEtosyHU+i8z9ltx6OeJXSwimhBizWSupDZ759zjR/Y7axXtE1f7aXGjqvJPUR
         HrWA==
X-Gm-Message-State: AOAM532Xls5Kv9KaWG6nLd5KmLAHjVWk5lTkNU/XAeWqaiMgiUFWh8hJ
        LgOLbk4W4t9IrvjXMb031Q5vsg==
X-Google-Smtp-Source: ABdhPJzbdodYa0NEHEGhpxHxSru/eoKMvM57JCkkhJ0mxJARezlwyh/UOZNTcO7zaYhj4H3gI0/IkA==
X-Received: by 2002:a17:906:dc8b:b0:6fe:920b:61ff with SMTP id cs11-20020a170906dc8b00b006fe920b61ffmr20325733ejc.565.1654502843972;
        Mon, 06 Jun 2022 01:07:23 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e2-20020a1709062d4200b006fec2097d53sm5990274eji.118.2022.06.06.01.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 01:07:23 -0700 (PDT)
Message-ID: <ba71d707-1d5c-7b31-3819-aec60b2c7365@linaro.org>
Date:   Mon, 6 Jun 2022 10:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 6/6] riscv: dts: sifive: "fix" pmic watchdog node name
Content-Language: en-US
To:     mail@conchuod.ie, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atul Khare <atulkhare@rivosinc.com>
References: <20220605133300.376161-1-mail@conchuod.ie>
 <20220605133300.376161-7-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220605133300.376161-7-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05/06/2022 15:33, mail@conchuod.ie wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> After converting the pmic watchdog binding to yaml, dtbs_check complains
> that the node name doesn't match the binding. "Fix" it.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
