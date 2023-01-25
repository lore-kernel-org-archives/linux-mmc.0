Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E804C61DA2
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Jan 2023 10:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjAYKKp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Jan 2023 05:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjAYKKo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2023 05:10:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F110244
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2023 02:10:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e3so16476456wru.13
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2023 02:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YbmCODXrWbUn0nWKxLJPq1L6PfEga2OS1d1Yrw45IU=;
        b=EWZ+hu4S4a62p8gA2V9ZYPkv1qLN+s8IMtIROJN7y8CarZG2svVmLvXgd+cIXCTqYK
         NmDzRiCF06lhNIqcgTEj1tarMHcDsKa7kHDQPaG8pOtIq/W5AbCQB6RvTcD1myTpCzRp
         TRVPIsNn/MVN84z/l/E40mM1M3YZ9xN3d/JOW4gawseKTBi9l/HQ5vDPs0OzNhZfxYZO
         aDNpO0Ibc/PEQId4AU9aFKgNJhl4vADNywb3qlpc3BO7gpS9YHIB2cwG5XYpu1Xj9faD
         FC0dRFpKpviOy+GKJ1IlFSq1v3ihdct8DCv97iaxXiys1mUD8mQh4tZ+cpBZvSJ/9qt+
         sssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YbmCODXrWbUn0nWKxLJPq1L6PfEga2OS1d1Yrw45IU=;
        b=fHlqZClRzSd11UJWnw+kzKV8lki1C0E7JZpKitYi/gpENT/PaYa4c3lDbqt7sMpneo
         VuDcPPM5Ym80WnU1P533yPkcMU9Z4QS9LOxP5BZhuiCHmRwc4LAHUMeLlt9P9m5uJdQ8
         U9iFjSwS3IWYbdxFeGC5C+t9Efd5Fd+8Dusb/KbSJ6qdL6MGsYvajpPkHJbDvGIiuRMq
         ZGllO1Vn6SWrTJ2rLK+JkMMEjKY6n4nuvh4MUCklYqLkjAdW29/r+W+DP74a1uQ+LKJd
         f8avL4AXeJPqMlojqy2JgJiCmwh3lYK6vLPRSKfGfgTjQqpuMXHIkmnofJhOK802mIOW
         WnCw==
X-Gm-Message-State: AO0yUKW7+bJBFNNUQzz10fvBLJqUQMWPQ5oAfgdle03wn+OQNwzkVH43
        j1nahseunZ1yV6esMukT0whQSw==
X-Google-Smtp-Source: AK7set8k1yyqihkL7lEDeuIamGfJrPidQaf3VL7shCTdtPbifYjaUj0j3ZCA+tCz22qbl5k7/4CR7Q==
X-Received: by 2002:adf:facb:0:b0:2bf:b746:6224 with SMTP id a11-20020adffacb000000b002bfb7466224mr2062674wrs.0.1674641440862;
        Wed, 25 Jan 2023 02:10:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d69c8000000b002755e301eeasm4024686wrw.100.2023.01.25.02.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:10:40 -0800 (PST)
Message-ID: <859715d1-a442-7f64-2345-60d0fe28bdb5@linaro.org>
Date:   Wed, 25 Jan 2023 11:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dt-bindings: Add missing
 (unevaluated|additional)Properties on child node schemas
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230124230228.372305-1-robh@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124230228.372305-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/01/2023 00:02, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present.
> 
> Add unevaluatedProperties or additionalProperties as appropriate, and
> then add any missing properties flagged by the addition.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

