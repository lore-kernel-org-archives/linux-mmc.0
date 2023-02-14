Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB4C64ED8
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 21:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjBNVoW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBNVoU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 16:44:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CDD29400;
        Tue, 14 Feb 2023 13:44:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id rp23so43469076ejb.7;
        Tue, 14 Feb 2023 13:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LqJXdxxFstKfYubhTeoAWTHHu54RXhCthHqvhTdxVw=;
        b=qPz+gKBIC/R8A6gtUZ8ceyazI706kmMBJgDlbAJ55QeqC9llqy5M4oPP92aAhOMmdL
         LWY84jGU18KQFjObsGNOtO9LD3yECwJaNZ9tntFSoQxhfFbKthtGafSoJ8Vc/tRRAuVw
         C+OnZB1r39zbuG4pRsxyCwgqSqpMe8icb2wC+5xnMYb7fYePk7BmGXqDqPJQ+1CqdVti
         IcB3RdfDuHOg078AU//wVFbsi6L5L4YJROes2Dpqxn2wB3PK8QE2aZKEUR2/K3QeG6jL
         /19hR3kD4Ey35+eK9Y+E3iMXIoN1TmWkJ2f8Ukuf8veCGBcwsDD0h6i+zgrobOOPxWIs
         MX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LqJXdxxFstKfYubhTeoAWTHHu54RXhCthHqvhTdxVw=;
        b=VX2gWaNYHmSwDTapzCFgip1hu+WKsanKwtolpK1tSuvqB1a2UgMk6q+NVAxGdo/6iN
         5eoIvfpGe9NUSzHHUy1pBsbc3pyBjz68wce14cs5EKiitf75PJq/IQdNtMrIHOyFDdnJ
         3t44Kv4hPzDZJsbb4EVyxf4guA6QdaaJoYDLv5ps9mD0bbdepv1PAGt8c9eieUv+tgNS
         zV0SvgGbz/k5mW9ebnTfFqcXKmnDU/KrmGeosVfqps8QHwU25f8pdGQcrPYgMjgNIx9J
         8IO1R6muhyfjnAsqbkLl5ChxZEOn/bLcSpgAtb8e24M2mM85Z0LfvSWBa9Z+lnkrX/Vc
         7/FA==
X-Gm-Message-State: AO0yUKXNf9nUkI6RhWq8E5r8pqBs54SGwm14GkOpxpCLULBxmE9tZx5G
        v2K8LexVg5z9Ynn8tUunO1M=
X-Google-Smtp-Source: AK7set/az3JscyAMvJVE9MKuOV/yeIlPmFr6p9Be9W8jefOVLPXcDrovvENpnkqW2DXiWXUtMV9sPA==
X-Received: by 2002:a17:906:850e:b0:7c1:765:9cfc with SMTP id i14-20020a170906850e00b007c107659cfcmr328840ejx.34.1676411056936;
        Tue, 14 Feb 2023 13:44:16 -0800 (PST)
Received: from ?IPV6:2a01:c22:7234:f800:b56b:f43d:948c:eede? (dynamic-2a01-0c22-7234-f800-b56b-f43d-948c-eede.c22.pool.telefonica.de. [2a01:c22:7234:f800:b56b:f43d:948c:eede])
        by smtp.googlemail.com with ESMTPSA id j9-20020a1709066dc900b008b1294f7f63sm1669820ejt.221.2023.02.14.13.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 13:44:16 -0800 (PST)
Message-ID: <2bb70611-5dea-1144-51bd-93c46b455392@gmail.com>
Date:   Tue, 14 Feb 2023 22:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH v2 3/3] mmc: meson-gx: support platform interrupt as card
 detect interrupt
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
In-Reply-To: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use a new mmc core feature and support specifying the card detect
gpio interrupt in device tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- adopt the changed way to pass the cd interrupt number
---
 drivers/mmc/host/meson-gx-mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f4b50793e..079c52dbe 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1166,7 +1166,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct meson_host *host;
 	struct mmc_host *mmc;
-	int ret;
+	int cd_irq, ret;
 
 	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct meson_host));
 	if (!mmc)
@@ -1213,6 +1213,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (host->irq <= 0)
 		return -EINVAL;
 
+	cd_irq = platform_get_irq_optional(pdev, 1);
+	mmc_gpio_set_cd_irq(mmc, cd_irq);
+
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(host->pinctrl))
 		return PTR_ERR(host->pinctrl);
-- 
2.39.1


