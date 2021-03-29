Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E622C433E9
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 02:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1AB6195E
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 02:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC2CAM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhC2B7v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Mar 2021 21:59:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED13C0613B6
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 18:59:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v8so3660497plz.10
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5evIgUHLH3iE2TL4J3188f+WN89LXupcPiWpSn3upRg=;
        b=mkI2MNoS6Q/el56D1urQ3F/hxkgi9Cc4jGujWEDbWa8KukNyFknpaqsBvLradFPCCh
         82Ajpw67gaE153YzbCFi+OZ7H3Y/JMaHNrphjBkXxNEJclXuWsBO0Qw/xBNAf3FMELPL
         vwNOq6BkK8fRMhkZeUp6pLGT6wsCBweI1AEYLBLoQHMObN4PMcxw+5XAw6BFLi7RR7NR
         8WaQ3l00nfuAHdb7GqPsXpyNFWE/ooiXYRksjlFwUKfw07uzx5TNIujOO8DZA20mKAor
         XhqIQuWMRN58d4Yhdyaisit7OyaUddCcZfH4JFlvCd0DiTwSHzCpqqHtU1E3IRb67s5/
         J8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5evIgUHLH3iE2TL4J3188f+WN89LXupcPiWpSn3upRg=;
        b=ZqO2p7btkO0njad6nXeg/c3RdvabCRsebisvURY1USJmGGoMwUDaTmp1Fhwd1/+/HC
         WjL6HbEsrW21xh3JBXNHgczBt2wjyCQr0xkcwq4HWbm0Oj0Mn6gY8Kh/fjsF0uDPOoG+
         1yfr4IHnbpWjBzmpqj76V/7uXV7Eir9iip2i7YhPv8JSS6dRojgv7rQGSMh2C4ZM8Dxa
         +J4ZQApQsTyYvhXyY2nniAqwjl2cD0eErzNW0POxKV1ehyQ8ZzyJWy8/UK2YKinEA2+k
         C9ZJPnnq1e/fmp+4y8l1vHjdBcIjikk/oMkZRhUVhc1D1qYq0piDWyTMONUIXxnQW5Qp
         2m3Q==
X-Gm-Message-State: AOAM530Ecpri+oWqwyrO12dQ+jAQjWrGORPmMaG4tMtCCfwC6WKW2rHM
        j9l7ufqtZSzhBaH8mhRxw8AEdw==
X-Google-Smtp-Source: ABdhPJzWcGlzZINaB0Jap/R7CzqpkSL0r8aRD9sbvqRTrnAhOddv0gNrJo7sUNFfZii8t877KZMCiQ==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr6189926pjs.189.1616983191306;
        Sun, 28 Mar 2021 18:59:51 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.18.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 18:59:50 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] spidev: Add Pensando CPLD compatible
Date:   Sun, 28 Mar 2021 18:59:29 -0700
Message-Id: <20210329015938.20316-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Pensando Elba SoC platforms have a SPI connected CPLD
for platform management.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 8cb4d923aeaa..8b285852ce82 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -683,6 +683,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "dh,dhcom-board" },
 	{ .compatible = "menlo,m53cpld" },
 	{ .compatible = "cisco,spi-petra" },
+	{ .compatible = "pensando,cpld" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.17.1

