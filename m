Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA98C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jun 2022 08:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiF0Ize (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiF0Izc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2022 04:55:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722256375
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2022 01:55:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id fd6so11965305edb.5
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2022 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RsBoiseaTkJc51iVjuUsait0HqgvtgtMrYkH57RHGCU=;
        b=skhj6rL+UZnb3uqF9ljVTdtpJi84kWTrupgEdBvRS3QgaOVnezJVrkAGrGgv6lwF1/
         3d+Cf7kpB4c6T3MDM1IHVWRw4zKkP5ErkBe5MiyNhOb3VHcLptGsyxMN86lyIkSPfLZ6
         8lbuEjmq4yaQwnRR9fvPslm2+S20+4kxiGjZwpc5HTiLopSQPYwhe2WUmzi5Hdz+E5cL
         gnhymObz/v31wdKPoKOsXoWXi99z7gzGLL6WwNDHZO+rx1vx9go6Z0/ebUX3FH4kM5JR
         MAt9z+4m9z7+EVx/bFKLzfIMBbG6Bva2+NVmJO7WBVSc1PcdLs+t9Tx5QU8lIiLWXGJ+
         LUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RsBoiseaTkJc51iVjuUsait0HqgvtgtMrYkH57RHGCU=;
        b=iiwD/xDd6DG+mlr3L6U576428OiwpKuFCY8H0alzAcxaGpLuahheBgYl5w0MIEdonK
         29RgvHSfdLvvL5LtBcYKiEQ6xYCUP0RP03h18A2kD2PHtHoXMRejGl8w/cShjIUYtjvW
         RLKe5Gtux8ioqU3n/GVKTqdVvUs8FdO2YgSdmva7usqozxVhnSNegcDqsRLxBoFP1VYi
         exvP+wPoy19byEi9+Fmb9qtmsr1B4jg+k74P3iIdOik0ZiXr89hK1MxlbR3alVGUSHYq
         ruOM0fK3FaNEnZ6bicNZs1Nv0t6FTBgtFZld4EJ8l5lW+uJ2MhaCqVdvO5swpJmcT64e
         /sXg==
X-Gm-Message-State: AJIora9a6GeCKsSeB0XxWXJB0BGZnq9P4eoSb8ZInwiOrjeVW8jr5Usb
        FqFF0ymHe+ImwTQutmS/JHFPiQ==
X-Google-Smtp-Source: AGRyM1uHTpdt+MsqhWdxTZPyIYF7oRz48lzwDRSQCGhJKEvO+cfipqWJDMQS+cbwyV3uuOPXNkhmjA==
X-Received: by 2002:a05:6402:452:b0:434:a373:f9f8 with SMTP id p18-20020a056402045200b00434a373f9f8mr15706814edw.290.1656320130078;
        Mon, 27 Jun 2022 01:55:30 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bg6-20020a170906a04600b00722e31fcf42sm4768843ejb.184.2022.06.27.01.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 01:55:29 -0700 (PDT)
Message-ID: <cd6fb785-50d4-8945-b7bc-951856f1c5ae@linaro.org>
Date:   Mon, 27 Jun 2022 10:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/5] ARM: dts: exynos: align SDHCI node name with dtschema
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Ulf Hansson' <ulf.hansson@linaro.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        'Jaehoon Chung' <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org>
 <CGME20220626120350epcas5p25a98e0669eeb11ce7959ace0f3634926@epcas5p2.samsung.com>
 <20220626120342.38851-2-krzysztof.kozlowski@linaro.org>
 <000a01d889c5$adb3bd30$091b3790$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000a01d889c5$adb3bd30$091b3790$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/06/2022 03:31, Alim Akhtar wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: Sunday, June 26, 2022 5:34 PM
>> To: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
>> <alim.akhtar@samsung.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>> linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> samsung-soc@vger.kernel.org
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Subject: [PATCH 1/5] ARM: dts: exynos: align SDHCI node name with
>> dtschema
>>
>> The node names should be generic and DT schema expects "mmc".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
>  (for patch 1 ~ 4)
> 
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Tooling does not handle such cases.

Best regards,
Krzysztof
