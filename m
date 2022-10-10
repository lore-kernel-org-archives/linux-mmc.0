Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A4C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Oct 2022 10:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiJJKiM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Oct 2022 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiJJKiG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Oct 2022 06:38:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A95C9E6
        for <linux-mmc@vger.kernel.org>; Mon, 10 Oct 2022 03:38:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id bb5so870292qtb.11
        for <linux-mmc@vger.kernel.org>; Mon, 10 Oct 2022 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLRVHcDP2n3/T7u+DLZw38Iwf+Q2v9rJvcCuBMIDabA=;
        b=f9Qda9xTp4bHsuGvwL9zsZmqtYzvNGczwpochsMYKN3ONXezZwSJ3YBDB1VbOmjW2B
         aejJft8F7FPKDb/VxlIFFbkOuVyuzmLX330Vc8PC+H63qEFrJjJlgS7/6e8OKi5SQEni
         i8+4ffqImNiBniTGY/3rvcR5xM2qiwznx2iWsFBnglSfYJuQRJ8yx4tsfMC0RkPegeYm
         nf4KTKgkICkyouSEPp3x1Y2et13uPQxHGC4MkEryS2mvqFljHMKIvbOq+StNnK4Beu+D
         txstZNziYEBdJDhrRX4VB0oDpDzDvlidT3NgG2jFcXPgsOhCJP4x1JE3/DsZgIfRRH0d
         nv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLRVHcDP2n3/T7u+DLZw38Iwf+Q2v9rJvcCuBMIDabA=;
        b=su3wvnwWOygK4DJWi/D8WRvfblj0V0YGNQCIZCPQToZd+JJF0Jtb4g+JeAJF9fX7YE
         wcQEIMVnaRgnIBVnhMuS+pV2ho6zPFonswoEoSRo4xwtA3NnUKiHoTwcG7DBxjeHWtcN
         /b9jnusQ6urmLbhMDfA5bFk/09c7kCXxqpwRyvsHzLkEs+efIz+UmflBOhkAkubnl14r
         0PWpiFPe0VmQJz4rmQV8rE9v4GyMJA6bqNN/370FIzA0NRN6g25z+tby430FJLO5VeeF
         jZn7q3StfH2hScsiPjIYFqYQdHTH5wLtRqMJ6M1N16tITPVuH7JO2TafQKsulV46mFcA
         NUrw==
X-Gm-Message-State: ACrzQf1v6GQOCSQ1tjpukoXwQw3QnZhUka4aH28JsU4x06i6VB13o8uI
        Ze0qLrFZ532btTwKEdTKlisiCw==
X-Google-Smtp-Source: AMsMyM7qDRzB5OaEeCZNoAzPYyh1IDm+Q8NlP4KpMd6imNLo7nGADIy0b581X8htTnLSKFNiWf9GcA==
X-Received: by 2002:a05:622a:1a1b:b0:39a:f20d:b277 with SMTP id f27-20020a05622a1a1b00b0039af20db277mr1326519qtb.204.1665398282927;
        Mon, 10 Oct 2022 03:38:02 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006e2a1999263sm9777314qkp.62.2022.10.10.03.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 03:38:02 -0700 (PDT)
Message-ID: <756def2a-f1b0-2900-61e6-f2cfe4c69e85@linaro.org>
Date:   Mon, 10 Oct 2022 06:35:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-binding: mmc: fsl-imx-esdhc: update i.MX8DXL
 compatible
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20221010101138.295332-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221010101138.295332-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/10/2022 06:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8DXL is compatible with i.MX8QXP, so update binding doc.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

