Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7828C05027
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Jan 2023 23:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjA2XK6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Jan 2023 18:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2XK5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jan 2023 18:10:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0931ABE3
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 15:10:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qw12so11330817ejc.2
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc/LaO0TaIYFb0bbamxZIEYNdnsiW48p7UWNVXC+zYY=;
        b=H6lC9QtAtM6NuyszabX9xTiNmX1mOx2cfyBo11WaQncIQSIILTgLC6BLixqqpoTd9w
         eZoZSxCVjRABpUkoRBHEwDzop2G7BgtfeJqDWZIBzvHjwkYppOT0qXoMuFJfAJPH1l+2
         zZhxKKxQvDNDR+ULqsL2HM6WpJ+pwFjoKE+OcE8LOBq29RCsa/FDNlaWGxXRqI07kCHZ
         jOAoEJ+I4V00d5JsC1mDQJLv7KgQsYUf0QhEfdJ6J9CLh0z0vR79poNMSbJrHWKyhUMV
         +w0mLAFHLykICnM8RC/AB+qnkxmzY2n8K6+dUcGmehRlrNPK3aHr1QIVyxH9afzJSX/a
         KgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nc/LaO0TaIYFb0bbamxZIEYNdnsiW48p7UWNVXC+zYY=;
        b=j60edOMPu2Ha4xAaP4BKkU4pPkQ1pkT9tt0c3WdgYbL5HGue9TYc0glWRYZTUVRAdQ
         IBZA4Uztb84svB/hudwZ06fOz+GxcapPy4iV6ix/WMxypXobIKyPraPqIJVORipM8Gqi
         P/M83m/tw5ghQlnj1IZy3zcNE84GKIADQtrSR8eTUsYIBuvwVWkQmt8gZtdTNiewOokf
         Fb8BKD8C42Z0EkAZS9GxWIsWCZBYGvlahJWRmjQfX5wVpFpzNNU/sKECwAt7jqPedcg1
         EzywgeSH+F9OwvFEDk4hwInpq+UU+rGAzzmNPevU9F9Bd5RmdbMuN0WxqSk6zkkSR3PR
         c2rA==
X-Gm-Message-State: AO0yUKUGChqPDrfdhjyV2xfd/02B7mIdIt/IFTXuvXujO+76KrUJcP6h
        XK4/+AENvXoBwRmfav2kZO4=
X-Google-Smtp-Source: AK7set/dD8yIV885soDzwkEGuHnNYc6wpe4EDujJMlUDDgHZCDw7ENrImpWS1ZpTbqOJm1eMQhlsdw==
X-Received: by 2002:a17:907:9054:b0:878:6519:c740 with SMTP id az20-20020a170907905400b008786519c740mr6282212ejc.44.1675033854602;
        Sun, 29 Jan 2023 15:10:54 -0800 (PST)
Received: from ?IPV6:2a01:c23:c5b5:3100:78bb:34b6:bd6e:6fb4? (dynamic-2a01-0c23-c5b5-3100-78bb-34b6-bd6e-6fb4.c23.pool.telefonica.de. [2a01:c23:c5b5:3100:78bb:34b6:bd6e:6fb4])
        by smtp.googlemail.com with ESMTPSA id c19-20020a50d653000000b004a0b0cd2e45sm5941749edj.75.2023.01.29.15.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 15:10:54 -0800 (PST)
Message-ID: <9e08411b-20cb-874f-8915-6f8dc32e9fcf@gmail.com>
Date:   Mon, 30 Jan 2023 00:10:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com>
Subject: [PATCH 2/2] mmc: meson-gx: support platform interrupt as card detect
 interrupt
In-Reply-To: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use a new mmc core feature and support specifying the card detect
gpio interrupt in device tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index be1a972c2..c87bc31d0 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1236,6 +1236,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
+	/* gpio card detect interrupt */
+	mmc->cd_irq = platform_get_irq_optional(pdev, 1);
+
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(host->pinctrl)) {
 		ret = PTR_ERR(host->pinctrl);
-- 
2.39.1


