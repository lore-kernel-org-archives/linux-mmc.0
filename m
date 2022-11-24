Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626F9C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Nov 2022 07:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiKXHMm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Nov 2022 02:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiKXHM2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2022 02:12:28 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA9CEFCF
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2022 23:16:35 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s196so886353pgs.3
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2022 23:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9beI1qbDaBEZGBMzOodYXezAJNnkCn943LXJypsps08=;
        b=jN9Iu2JG6Jbf9f/Vtx6/x8W99mbfvmkmA5JpUTuuOhHuX9hE65G+zwT360z98Yxh2l
         i6PqDF91yJmzwCKNYEVFuLVfqGCqoHx9I7wNV8pa819eMDoiMR27SZF1GHdGnGDHcMWz
         pqI4i03rsZDpQ60ONyvQHuYR+N3femATVqrSC4hLc3ih0MmJpf23tjAqEmigk+Q4lN5p
         TjriD73VK+kqD8Wil5LA1NXQ4waHtGM3IZBFIczk95hCWTGki63dLVXFv0wvyqKSahPp
         nd3iHhwTtHF7fG/CtXcp1E5PNjqsgHvp71L23Lt4pdmYQDMtQS6xnA3gM9hUIGynee9E
         kaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9beI1qbDaBEZGBMzOodYXezAJNnkCn943LXJypsps08=;
        b=UxgXHy1lsBpD6zig/V/N2dnLMdKL2cXiU9dJmlX6hxcYvnuYxO4CpjHA2i7Ntd9U3o
         gf6TMImDw/qDRpJFtUvfPe08xxnZIccjZThzKYdhGvmTp0VVtHVeZVGgys5znxnj505z
         UHY1yPnYW6M5QYmZcS1Um+vVjlyAsqTL20KclJyYfo0EKwuM7bI2kJc+mp6Y4S45QCPg
         2SI9yLO/Jwzy54F6eC1ZOEykRz/HWTkZKlGSYfkHSnrxE5UWOt8rXHCTu0H4jUZUmabt
         8r71g6EYQWhtM77owqOS+UW/wTpXTD8ldaO6ucBqYhEs9JFQoywMCWRPsVx1XCE5Tbm/
         Y/Ew==
X-Gm-Message-State: ANoB5plus88N9MY20hUz1IC9Bo679OEotLk0l7/rxjI++o1QBNL+hnSt
        v8wMO/bUN2vzvabVyOB/bMmbYQ==
X-Google-Smtp-Source: AA0mqf539xW7yp+XmSaeh7QyKEx/uI4+Px0TRaTKiiPa7cXAYmK2DoSN46/6FwkQRO+vECyNwcPwTg==
X-Received: by 2002:aa7:8c19:0:b0:573:620a:3b1c with SMTP id c25-20020aa78c19000000b00573620a3b1cmr13160104pfd.50.1669274195379;
        Wed, 23 Nov 2022 23:16:35 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b001867fdec154sm414181plk.224.2022.11.23.23.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 23:16:34 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:46:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 0/9] dt-bindings: cleanup titles
Message-ID: <20221124071632.5cadtc6pbdvdv3xb@vireshk-i7>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21-11-22, 12:06, Krzysztof Kozlowski wrote:
>  .../devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml        | 2 +-
>  .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml         | 2 +-
>  Documentation/devicetree/bindings/opp/opp-v1.yaml               | 2 +-
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml          | 2 +-
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml      | 2 +-
>  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml    | 2 +-
>  Documentation/devicetree/bindings/opp/opp-v2.yaml               | 2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
