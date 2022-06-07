Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2786C43334
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 06:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiFGGcy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiFGGcu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 02:32:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BA6286CB
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jun 2022 23:32:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 25so21336395edw.8
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2022 23:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rjBKgMIA6DGjXMFlTzioHivCQZHzgMmQu5iLSH46BUc=;
        b=BLyMiQRupKbvR9AUUboy9Pt5ayM9ZIe7cNWJcqRPqOsQKsJzpZLytl/mwGuTTVEFCq
         C7sFEYDPNMKR/OYZAO0oHb69gM2hwijtLlkUCrt7LeLoUbsBRDXd5VqzscVAUf48DwD3
         riE1w+MjGsh8rIUZG3efW3sEQlJql2teTYBC2EJEYVEeBub8ZqU5Wv6WOw5KNm6DOp9M
         pD9DWdSUMA0QdJP0T+jsv5f0q02Nb7fnpFRSt/++H9q4Wv+2oxDxtSzIxeaNQBnKCiVU
         YN/B4IMzdTf1yYwz19BO8XffdbmzpTcSCRyQsYbkZ2XKQ1jVytbIcXqLl81mCAJUKlPI
         sqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjBKgMIA6DGjXMFlTzioHivCQZHzgMmQu5iLSH46BUc=;
        b=B6qWclF1mcAt1rdcJcuinaRsXYel2DgLqkD7K4PvjCC5EjasV+w9q6nRgsCDXw/sAU
         Xzr3wbXSMHXfw1XMniwg3HaH/4IlFHIa6NCVwqmPqZlwmYntFNb/kcdd0onfJZVIupMZ
         w0HFh6FtU/L/D1VquKrMtwg/DTK09hKkTMVnsEf04G48n7yt5sb2bjkiLAWlsdRUmxmJ
         rcwdhctS7ahSZRoleroqx5HT5Yeg/kJR8cXuhDt6yP0Vu9wS+/x3bMAeZRu3AhqUTZYi
         WrkXT0XtFssXsfmJFKcvblsoDR8S3JcMkwX76xlmb88HAYGXPby5dxRdDJe7yl4RWGsv
         5eDQ==
X-Gm-Message-State: AOAM530yCAwC5tRRzZhKLRHHeUnC3S0f7sACE2XXOBPCuXAnkbJfWslc
        TssNmxAnFhn1ENKijzezqumJo1gBvnI4pw==
X-Google-Smtp-Source: ABdhPJyhkA7arn+z+7Ax9NSTsao2M4Cz7kf0NVphYJ4xQdeibZCmD6IZbYRvLy2gQ4YY4/ezmk0wLg==
X-Received: by 2002:a05:6402:3586:b0:42e:2a6a:218b with SMTP id y6-20020a056402358600b0042e2a6a218bmr25306770edc.208.1654583566694;
        Mon, 06 Jun 2022 23:32:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm9796349edb.13.2022.06.06.23.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:32:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mmc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 1/4] ARM: dts: exynos: align MMC node name with dtschema
Date:   Tue,  7 Jun 2022 08:32:40 +0200
Message-Id: <165458355453.6489.13773336622161446502.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605163710.144210-2-krzysztof.kozlowski@linaro.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org> <20220605163710.144210-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 5 Jun 2022 18:37:07 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and MMC controller dtschema expects
> "mmc".
> 
> 

Applied, thanks!

[1/4] ARM: dts: exynos: align MMC node name with dtschema
      https://git.kernel.org/krzk/linux/c/a07cadf80c85a3ee6a1688fafb71b8c5cabfa904

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
