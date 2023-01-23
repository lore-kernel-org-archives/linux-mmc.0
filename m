Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC362C25B50
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Jan 2023 18:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjAWS6C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjAWS5s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2023 13:57:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F105832E50
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 10:57:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so11327890wmb.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 10:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ll7ZSjIpeSB6NE1hddkkSIG+LMmQi7hyj3TClP8BAtI=;
        b=te6qDaYUyo8TM8PT/tzMinlXhKN4bn75eXTu94yYWaIrKgvzLqWIwQmhL9Uw8SdWln
         CSGPyNRzoyl6j2EbrVkn+dxiwFyt1cnC4mG1+RWPzrYJTJBQjGfH6oKxpsOyhiU1fHV0
         1PqtgEzQrIJDqOfMvFRxm73G/9W1SiM52wxQEIGt7yZrvHxki9/Pz3P1MTbAg4V7xijK
         LD00SwMuu6ykgrkeZrIj4MRQ2SJXFy4zdE/1FGrwayN3Dis5HA8C5nU8T0za4UPZ9cZ4
         yL3ycNfYot+rtlCrs3++iYHo7UdY4RZ+VauPlRmMxmD+RlPZ4w+6ti27PYN8WidKYbHa
         niaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ll7ZSjIpeSB6NE1hddkkSIG+LMmQi7hyj3TClP8BAtI=;
        b=ZDDNcFuayfqFR8Xy16xt6kcwFVXme95DD/gV3z4jicJ9t8L76GerY+1QPa7UShuZh4
         AZC50vWMd4mcYOvHX2+Fu/n9uNjfh86GcgazUwIHcwz292b0j+54czaFw23+JyamPUYQ
         CcSaUV+oTGOd/guq6Tc032bAyjIBkObXL3E20P/sn297+ATmTdFJMo7POhmVTSNGmier
         wy92O1tIJb1peDCw1UtszKnA/G+Sm+/b0LoNV1IKF/UvfgxPF0f5eLmUzXBQxeQer/7p
         9rXTLAOzA+3zVjwj2z+P6kyV9BKn9XI0MpNTTfbAhfO+J7GB873FGjJM5GIPSorO0XhI
         RiQA==
X-Gm-Message-State: AFqh2kpnUQm934Cplbb5UynyIhQchRVmNGUyRzgpqMeu7OzMjkmvGFqr
        9bgzCIlIMGb15xnT1u6Rfe7vXg==
X-Google-Smtp-Source: AMrXdXvMpQT8hbdH3MYWCPRRes/tEObpS3tZubj0KJ2yKnFHSPQcLLM7GWtcB3sGoxQk43qdNi299Q==
X-Received: by 2002:a05:600c:4f06:b0:3da:f671:eded with SMTP id l6-20020a05600c4f0600b003daf671ededmr25257158wmq.12.1674500255502;
        Mon, 23 Jan 2023 10:57:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm12283570wmq.29.2023.01.23.10.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:57:35 -0800 (PST)
Message-ID: <04adfb17-5d66-1c24-19c5-c9f12ec7f9df@linaro.org>
Date:   Mon, 23 Jan 2023 19:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 6/7] dt-bindings: mmc: convert amlogic,meson-gx.txt to
 dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v3-6-e28dd31e3bed@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v3-6-e28dd31e3bed@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/01/2023 11:10, Neil Armstrong wrote:
> Convert the Amlogic SD / eMMC controller for S905/GXBB family SoCs
> to dt-schema.
> 
> Take in account the used variant with amlogic,meson-gx-mmc.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

