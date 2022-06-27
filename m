Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05596CCA482
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jun 2022 09:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiF0JQT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jun 2022 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiF0JQM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2022 05:16:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4AB60DA
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2022 02:16:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eq6so12017155edb.6
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2022 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VqBk/8Hwtlk5l1lEMXH4Lz9X+gANSMIiMS6ItePJCEo=;
        b=z8KsPADtEjBi3xPkm+J4AOtWRV2sE0stBnlXjJKnKTBOTlAQBOQb5uYJ2xmpolq5U3
         ocCJsZeUor7iToT21YjzM6HZhP8rVlUv6zq+N2mCD2UcYZ5ZnrkAgK8HQDzDPNLKvbHP
         Bf8PGXlvq2HXMv+fJlRtZKQbd0KDJkwHerPohyYx+PD97+7xj0N2qLz8SSZ8/hYSFIpQ
         vKuTgax0ILAtxlPHsvrO0gxWE8VYZ4q7nJbkT3g+jXMYDrqt8gtqoGIjTuebQEOZSpmm
         EVmBdKx8B2suyA2rpUhm+q9p4Ew9gwpwOlUiFiiohDlQlozH/NzUI1c52+fgI2vyGOHS
         SUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqBk/8Hwtlk5l1lEMXH4Lz9X+gANSMIiMS6ItePJCEo=;
        b=KifPv1o0lgViAMvMkBUJ0ZxOC/SCk6l4N+uG66qx3lQaBQCc7IoUFs7wXlo2AS08H4
         dqOSGH6+Cv/mC5q9AHIobQPudecuR9ZkhwYkUTd8+YLCau9/hIrEOft3koleqX05WU6O
         5NQJmqPwNmp9gdYR/6CBvaWbyVusaVw1Os9fXV6vEx68YQWVCq/Va3Ngbovd5t9g10LR
         vaK4U2+demW4cA3HTO15LVoycNYthmgNK/Nr6gn358KqQQ4PwxOUba92zYiXQAWiUPYJ
         0YMEEhr+bmwvEX/FoK1pNJQPjMdi/pOdwBtGAxth6784CYz04yaFt7buNDbE11Dh5IA8
         xzpA==
X-Gm-Message-State: AJIora+8G93PlCPN0ZiEuCHCihFW4xURh1WYIAouiMTpuD+d6JDu/vnx
        QOjxC0iB2I4xscrbuKdVxfn/uA==
X-Google-Smtp-Source: AGRyM1sIlY9+BFEaIrTAiYrbO/fYxIU8/y7+0k9+W6N9ST4u5b7lpn0NtO1pJLt2xZL3cWjGiLzQ+A==
X-Received: by 2002:a05:6402:94e:b0:437:8d58:4ece with SMTP id h14-20020a056402094e00b004378d584ecemr6511659edz.396.1656321369928;
        Mon, 27 Jun 2022 02:16:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        jh80.chung@samsung.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Subject: Re: (subset) [PATCH 4/5] ARM: dts: s5pv210: align SDHCI node name with dtschema
Date:   Mon, 27 Jun 2022 11:15:45 +0200
Message-Id: <165632135507.81841.18368489193365782587.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220626120342.38851-5-krzysztof.kozlowski@linaro.org>
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org> <20220626120342.38851-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 26 Jun 2022 14:03:41 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects "mmc".
> 
> 

Applied, thanks!

[4/5] ARM: dts: s5pv210: align SDHCI node name with dtschema
      https://git.kernel.org/krzk/linux/c/6a82ef85c4a4de42214e0c5a79242d54436541c3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
