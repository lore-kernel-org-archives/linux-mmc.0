Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5AFC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 06:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbiDKGpM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 02:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245001AbiDKGpK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 02:45:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A7289A0
        for <linux-mmc@vger.kernel.org>; Sun, 10 Apr 2022 23:42:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so17039916edu.10
        for <linux-mmc@vger.kernel.org>; Sun, 10 Apr 2022 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LSzv58nBkA+R90RIZ6HMgs1Sf8Kdw1DEQuIT8NvmTLQ=;
        b=d+v/gvITQ1Y2LUYM7zzqwlwy19c/S43Re/LX2hDa3CJQTImXu1JcZQAMwjBGJbniwe
         NO5O6Of0yNp7XhKr4tyFGJtlIPqzseOXRdcOEF1vEThz413KF1h3GAc/ycnO7aHDn8o6
         Svvxl0/XwftyY+mH4QS0qeZK12O8IyTxdWzE1rCO497BMsoNAwPYxJty9j6+DNgEoKQ5
         f9vyuZ3i6nFDztMNMVSZsrqn8CaabrRCtWboKRwK2Ti88QBGbkGHYnFNF8twGwC7wTlg
         v9ZUBwBXk26EQoJ5jNdI5Ms3yDE44kWOk0khHkmyWEywO8diJAm8qhcRT5snNNEcb1CO
         jMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LSzv58nBkA+R90RIZ6HMgs1Sf8Kdw1DEQuIT8NvmTLQ=;
        b=4gsogwgCv/0+gw4VAuH17SzIVOCwtJJjveOqS9owRLqCxgB+A2y0612fPMXO5DQvKj
         7VRoplyGTcTxJ02Oqo8XcaWwGJ59mgszbk9BC0+UAI42k9MIrVLBdwAS6TcPPs+ucOwd
         T5cxNKhLDhoXBZxxBs1KNq2psdyCiFraUDxOP7u+Kd66rVRtd+QO20XoJB7IdtGwsfJf
         QC2mtQ+Xe40MaFm6pglc4T2+Rroohus7Ru8n934UGdp8D3YHXcvzyoYO9W+SsTNSQQzK
         Jokz8IJXYShM7mOOwyKJNQn/O+AQfsuIDSD6FNWqqfEowWeT5FnkrjtBS5Y8ITO5EIJa
         Foyg==
X-Gm-Message-State: AOAM533pGNOMnNgbM6nNcHyzmiZIg2H5luYy77x5qRU5OmbQby07s9FC
        2qBm9AdXqG86yaN8Ls+XKY62Ajc/ebNpJibJ
X-Google-Smtp-Source: ABdhPJyIfNJlUqbXK2jSR+BEoY1rEx7VZMuvim0+1+SfEpiM6Dr32FXbWSqp8i3oUbEc6Qkycufchg==
X-Received: by 2002:a05:6402:696:b0:41d:7345:41e1 with SMTP id f22-20020a056402069600b0041d734541e1mr7460059edy.179.1649659374503;
        Sun, 10 Apr 2022 23:42:54 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p24-20020a056402045800b0041614c8f79asm14379330edw.88.2022.04.10.23.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 23:42:54 -0700 (PDT)
Message-ID: <49a8a43b-471b-2b62-c7e3-4dac9fdf61ec@linaro.org>
Date:   Mon, 11 Apr 2022 08:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 2/3] arm64: dts: imx8mn: Enable HS400-ES
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-mmc@vger.kernel.org
Cc:     aford@beaconembedded.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220410193544.1745684-1-aford173@gmail.com>
 <20220410193544.1745684-2-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220410193544.1745684-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/04/2022 21:35, Adam Ford wrote:
> The SDHC controller in the imx8mn has the same controller
> as the imx8mm which supports HS400-ES. Change the compatible
> fallback to imx8mm to enable it, but keep the imx7d-usdhc
> to prevent breaking backwards compatibility.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
