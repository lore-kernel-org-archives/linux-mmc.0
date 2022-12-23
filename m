Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F8EC3DA6E
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Dec 2022 08:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiLWIqK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Dec 2022 03:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiLWIqJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Dec 2022 03:46:09 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB53F36C4C
        for <linux-mmc@vger.kernel.org>; Fri, 23 Dec 2022 00:46:07 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f20so4336898lja.4
        for <linux-mmc@vger.kernel.org>; Fri, 23 Dec 2022 00:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QE5x/YHXDWRPjvo3INvzf9eW0AqWG4KOCYcWWHFNs5c=;
        b=HfK2iqtUqLynVYeF98KolAv3uTHiyOMJJ/YXBu7eoF2bPaMHrs7xsw1qOVHtEBx34C
         oiTiNTQ6Ri11ubFhqch4tNxKg7yd1/PvT1iEeoeGrxVLCrG824uRZyhJhDdjORtqIk8G
         9wadQ2uVm7aaBvpkMhRvpxlyoHK+pn3GDc6EwjP7AQhrlnDsp0Oh+v0WxvoSbLwHEAZG
         D3tAjhWlXsV6HA7posZa5shSGNb1js/ByrlgPeqTlbzAO36fxqPFqHItc8ivbnhkchgA
         n7zI5/5h9B8NXM0MhizgVYSYxOx4ai/VAetVzoE2Ic5g6cq+xdFqSTcVlkLJ2QsxeZJG
         1Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE5x/YHXDWRPjvo3INvzf9eW0AqWG4KOCYcWWHFNs5c=;
        b=c2OJlDzecmgVpM2B0bhQ+ttg8MIwII+piEh8H2jIEnIxQSclA8n0DYH1wV31a6Zf8X
         W9zqRPWsyaV9qJOV4DDsD8na0hJDuzVKcO5d/b0cbOFWyPk3WQ7wLE/9j/AaFBSHpb42
         AZ+oQizWY5F8FQ2hobRqcQCezue6KlWECT0YFEpzGsOAhjDrnM1QGSXIDZ+YPH7wsL88
         Ay7b0xSrF9zYdg0zEzYyb6joh0oTdIGX8/WjtsQ2Ctpvyt6BBdO3+SatcJoWOmI6pvyB
         K0PRXZTlkMknbLR30oijlr8IsWtBGKYyFmwuA3bzzv6DPTEZBSWYe4/UK7AARIxpdWZT
         nTsA==
X-Gm-Message-State: AFqh2krdH6UYvL7dvj2U6rIaVtVir3p90Ork/bDjJGV5YjfuTnb6mqJD
        9CcVPfIBY5gRk+OlNLwMY0BL3w==
X-Google-Smtp-Source: AMrXdXs2CRlbCqLBwpb0LzmClNpcjd5TMplYWOYDQVh9ajQ5CIofJoWeX6+m3SQlTXSznTBsgJ4doQ==
X-Received: by 2002:a05:651c:12c1:b0:277:42bd:dfe6 with SMTP id 1-20020a05651c12c100b0027742bddfe6mr2429045lje.3.1671785165984;
        Fri, 23 Dec 2022 00:46:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f4-20020a05651c02c400b0026c42f67eb8sm322977ljo.7.2022.12.23.00.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:46:05 -0800 (PST)
Message-ID: <1f5ccf57-2e20-691c-eee9-3f800a93c3a3@linaro.org>
Date:   Fri, 23 Dec 2022 09:46:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: update binding for
 i.MX50 and i.MX7D
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20221223030347.17093-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221223030347.17093-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/12/2022 04:03, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX50 eSDHC is compatible with i.MX53. i.MX7D uSDHC is compatible with
> i.MX6SL. So update for them.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

