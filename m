Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62632C77B7C
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 17:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjEERth (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 13:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjEERtQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 13:49:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040B1A606
        for <linux-mmc@vger.kernel.org>; Fri,  5 May 2023 10:48:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965d2749e2eso212658066b.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 May 2023 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683308870; x=1685900870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Wzob2dHF0KkWSNjIRIz2tGtcAjsnWSRmcTEAPISVmA=;
        b=q2zdx9ulSlYse92yCHhBae4x+PK8Hejlf0LWzBFknr8Ldbpw26zX0dEXRNVhTFWOpL
         I+OYMYWFWmsfZASQ2o914lqreCQAJRwtNLih4PS8aLD79zddeWZ2I9xEsnA9oka3KG1h
         v4JRqgPLBFqol7AQUMRtucTbS+d/c9krj6adlDrZdOHTg/RCngTF20O1voqZT0hLhcHi
         NczlLjg9WGuUHqBizZDE9FSAfC+q9yW4850ENwU1Mjc06C3gWGCbMXOxBoLO1VDpoUTA
         UDhQNzsjABWRNEjh9uAmDQgudkphJXCSEm4DxySZebBz6hc0qABhJ8CIjJwAg/h/83T4
         kUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683308870; x=1685900870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wzob2dHF0KkWSNjIRIz2tGtcAjsnWSRmcTEAPISVmA=;
        b=UEEG/7CF8EY6ZQZJiNoKL2C6Sd/Q29D1N9T/qMsFBkTbruSBDwddnpcO01Xbvqmr+W
         9PE1DjFhlU/h68vXG5VIZQdszzxaDF8Zs6kjT+/kI17UQpVEFWb1dHuTyVUf8Omlqfyf
         7GamMI0Nq7VX95K84u3EzV568AZXLUm7wOFhISf1gYhm2yxmch7bbzf87FhYxnkwE/c5
         vv68pD0Wz97cS14ZUmMiUCRrzCpEpub/+Ou8xki6lV7qhNbt774ydE0u4b4Pvz+DZeuy
         +WMITmzDyda5bkwrHAGkjYIKzkxq/96I+H0UnjVLp3/Kz3BD0GHzlDrryk/tL39ArCdD
         A1UA==
X-Gm-Message-State: AC+VfDxZDswfDbOMVKf7Prt4id5v0L9awrrwd1knvcn6dSxXwVo/BmZ2
        s1r29PTqJVs7q4TS0Yzk64oAQA==
X-Google-Smtp-Source: ACHHUZ6uPKGDcp2DmGLEX3+8Z1M0GITzeM9xO1FejUN7zVZHHMNHwEoHNK54Lh5bglLls5QlQYdr1w==
X-Received: by 2002:a17:907:9415:b0:94f:395b:df1b with SMTP id dk21-20020a170907941500b0094f395bdf1bmr1754098ejc.21.1683308870218;
        Fri, 05 May 2023 10:47:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906858c00b0095334355a34sm1221569ejx.96.2023.05.05.10.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:47:49 -0700 (PDT)
Message-ID: <fe8c1063-b8d4-1707-5434-89b3d1edf1a8@linaro.org>
Date:   Fri, 5 May 2023 19:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Content-Language: en-US
To:     haibo.chen@nxp.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        cniedermaier@dh-electronics.com, devicetree@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230505101246.289278-1-haibo.chen@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505101246.289278-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05/05/2023 12:12, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Driver do not use this property, so remove it here.

That's not true, it uses. I got only patch #3 and nothing else.

> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ------
>  1 file changed, 6 deletions(-)


Best regards,
Krzysztof

