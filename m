Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F35C433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Apr 2022 10:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiDWKF6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 23 Apr 2022 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiDWKF5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Apr 2022 06:05:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C81187470
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2022 03:02:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b24so13136906edu.10
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2022 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VxTbz/61EBkYnAtoeVOTreTiohwdB8m5aatXEPOs56Y=;
        b=wKwr4PjmG2iH3MjybUlBF5EEF1KoicnTRf+lsmPwz/8ptiW4BTVJ8iPtTACg9Qw8cg
         LSxrriHlFZ1JDnPpgSEt0PgdYJfWnW1eW1UMO3dwLrsE+lT5oBNOFQhs1BUd2JNNc8mM
         CwObPksUx0Ydxp+FB+3Ebhos6a2qMrp425q9F17hscPkjCXSbg8jQRjyYjiYJ4ifSwb8
         7qvRLVYuvbPzt96bRxRJgsmNwRJCm5u9Lxl67O4G3s87tzJSaK1R8NW+h1X+upmQDxZx
         xTLUmtnsmOH7eL/URcE1HbqJZYxmyeyBKPNMOrXjlvyFkixMvEZW6eL1FB9mwHq86HKw
         jezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VxTbz/61EBkYnAtoeVOTreTiohwdB8m5aatXEPOs56Y=;
        b=2c4Bpc0ZFVFzM/6HpBhrsAnyFT0NSLSSpVKlKFA7njsC3PR7wcPndUQLGHntrn0dTN
         XsJVzYSRCuuTn/F0a4p5lQOaMBCFW6YYCQNTsO6ES6rvdaWwKAiglCYTJK1sQhBF+8Ca
         En0xc0RqlzOjefFXf9AGICvIeAbi+9h+sI51/mw12OGg3EuWxlw6C+bNoJI9AQK8xmf2
         tjq6xHgetd/BSR1WWEoe0BY9COPID+0jAuKvzosJeTWzTUtRKEzh7tc6lpbjakKeMA01
         5CRxQ+9cswSaY2DA2TwJ7eCEOc9ASBDZ0gS+kjE9ybNwI3IsOOt+CXwu493VviLVToA6
         7ToQ==
X-Gm-Message-State: AOAM530RhSoOnOHOg1D4A/uDdLcjtDVxLyGljwVs+z4sjS0cEdE+b0TQ
        ji85lbWHIcJs4dd6M2+e0tCgPg==
X-Google-Smtp-Source: ABdhPJxDW43NqQtrujSc4G0sjErIulv8al4rq9aXoSm0TYEn0LCABwGp2SAZ+HfqhRpD2xKNmOcETw==
X-Received: by 2002:aa7:de93:0:b0:418:d700:662a with SMTP id j19-20020aa7de93000000b00418d700662amr9313643edv.107.1650708177812;
        Sat, 23 Apr 2022 03:02:57 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm1508043eji.67.2022.04.23.03.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:02:57 -0700 (PDT)
Message-ID: <1903537b-ff19-d261-aca7-43bc28978521@linaro.org>
Date:   Sat, 23 Apr 2022 12:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1 15/19] dt-bindings: serial: snps-dw-apb-uart: Add
 Rockchip RK3588
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-16-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422170920.401914-16-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/04/2022 19:09, Sebastian Reichel wrote:
> Add a Rockchip RK3588 compatible.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
