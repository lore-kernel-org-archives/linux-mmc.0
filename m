Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE5C46467
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 08:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjAPIQ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 03:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjAPIQw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 03:16:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D98612056
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 00:16:43 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b4so20144338edf.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 00:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8cMkL5O+R5UHz0MTznhw0N8Y2MnvMwa4G0K/Uk5DY=;
        b=XwCCB/dUGoPSnxpOonrdZxZKIGs9W6ogKpG3FYf2anua8cyYVagueTpu0CeGKIy/ZT
         bh0jOTTW9KE2PFPhYfTzlTE4xBUT3iIp9JLR5wE/Qx/dR36tp7+/hN5AgNRvVd3WM8Bf
         W7jVqvwEiLbx2uiMhxySpJnYljVRGfKcrq81opTMUycntZn/6g7wx7am3ntUc3mopAj8
         rQKNT1rIHdeENsfnMLjpvkn1b3+eTLWrx7x5WhrG54ekcHcWxXdNMwF2LK1knb+pFMO1
         ZzY9/QEXSBBLISzhYhEkY7sPiMZFUhwbvUpEzTaNL3FlcPORMt1GHm/AhrJVqTvtIXSh
         Lbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8cMkL5O+R5UHz0MTznhw0N8Y2MnvMwa4G0K/Uk5DY=;
        b=QvTQqoog1q5ElBhA9hIh9Kye58jM29Qm1spzie1j4D8U4R+oiFJUbFlEPmnMIvCG01
         zNmdqaxu3a001LD2qpjfDRsBEH+8BWzbl3mOeK9LSR5f3MmLaFnS7+I7GmHxL2zOazEZ
         lLn8xZu/LRMfdz6OdFPztvLcOSo/L82vA4M7bjOcSWptb+duo6ohiO1XRTEWmS/zFwZf
         r3h5rJqwxM5ZQrPrFbQlj6w4cVABs3osiNZqc3fwKGU3F/YPNlyB80mpF64z1utTlsYZ
         QeH7LdiBSv/moQsPuLXymZKYCF8XOoZPomUANla+bbH5QCqXNI3VGk6hrcdds0sEZEh4
         ztpg==
X-Gm-Message-State: AFqh2kqcTR9eK0vP73HMrxdrkjZmnZxkczTZBNgUCgErfShb3x1l5ZqQ
        R9FykMND73owrdBjEdLcKD7ZKQ==
X-Google-Smtp-Source: AMrXdXtMJ+lhZIkdo/i7T4g2H6tenS/EKwGX72KxaU718yp0/i8U1XQHbm70fe84R8Yyc3rczDN9Uw==
X-Received: by 2002:a05:6402:515b:b0:49c:5a27:c1fa with SMTP id n27-20020a056402515b00b0049c5a27c1famr13887286edd.24.1673857001646;
        Mon, 16 Jan 2023 00:16:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7c3cf000000b00467481df198sm11118932edr.48.2023.01.16.00.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:16:41 -0800 (PST)
Message-ID: <57fee7e2-9a89-47cf-b5a2-9bb4960c07ce@linaro.org>
Date:   Mon, 16 Jan 2023 09:16:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] dt-bindings: mmc: fsl-imx-esdhc: Add some compatible
 fallbacks
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230115195212.2530087-1-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230115195212.2530087-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/01/2023 20:52, Andreas Kemnade wrote:
> Currently make dtbs_check shows lots of errors because imx*.dtsi does
> not use single compatibles but combinations of them.
> 
> Add fallbacks for imx6sll/ull which are useful for U-Boot.
> 
> This will significantly reduce noise on make dtbs_check.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

