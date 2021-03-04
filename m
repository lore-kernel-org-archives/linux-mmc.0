Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70964C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 03:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C5664EE4
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 03:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhCDDoj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhCDDoO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 22:44:14 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D906DC0613A6
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 19:42:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d8so4930888plg.10
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 19:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Zk1ArnKgiQng2MWBVvqO/05T1WJkKR0dBPbHxZP+Xc=;
        b=WCI7rfGobOQo7ZIRzOvOR8E6h4m8BYK0/i2nOSBcXEiOL+UHoQjYcgaOqgrziZEXnu
         AUmIGYvHDDpMWD7ThHSCaT643Ylq/G3hx4fR3zsPHCRTihQ0JcxB2UMyDpWvRiPZCOEq
         3Px52NRCItEH/LPP8x6f98azKYLL0kHP4sJy0UcXyXA4vxmvawFSM1kOBfB0oE/G7J1s
         imANFYLtJI7tmoub7Or1RTo1f09mjHtXdq3gdqfOH32zcsPcuCu8C6zmqe69JMJqRA9K
         BfeOiF6xdiUD8j/nCWQsLxe42qy/PCevHlSYhNq8R6stq5OPHAKrkcjo3A2PE2f8KsnH
         GYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Zk1ArnKgiQng2MWBVvqO/05T1WJkKR0dBPbHxZP+Xc=;
        b=hp6j0JUNritYXsnBhLMwF2hbVQBDk5VDJ2L91ocssCE3Z/5fyO+lsGRJcUG1PvcaDG
         eVbGdfCCpolKgVZ4TZdZCxNtq6bwW6fbLxBLqjzvQ7/QG+0nsVGyqI7st9cB5zds8DX8
         l7qXRLLisAKvgoOtl1Pbl3Fe6iGnUmhQvzzBuoSFk773ljfOaZms1zcPQ3umsIHNB2Ur
         DzlTEATBcd4I/yZYtzFDzt3Szp1wDl6ZEHkAE4k06vbP3yISjg0vXSAKzo6eFCVh/xJk
         7IqpNKj8pamrjt8rC/mOLVZBxcs0wTy3j8SNKR5aL3W28BhjPHSgF7368txYQOeHf4f0
         AJoQ==
X-Gm-Message-State: AOAM531Er8ShwPzyrPdvBNYo5VDR3Wv1g1wM5D2Vfn4C6b/H6YiZ/sAb
        hUrYpiLT17ffjUyfIHdbxPxEEA==
X-Google-Smtp-Source: ABdhPJzsnDrq+NKB04Vh8VktiH3DxPrBoZQLqc5w7qlpjTTBX7YkMv4Q9TC2pA6f066JihQfHzhZhg==
X-Received: by 2002:a17:902:c789:b029:e3:dcbd:843b with SMTP id w9-20020a170902c789b02900e3dcbd843bmr2062178pla.61.1614829355389;
        Wed, 03 Mar 2021 19:42:35 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:35 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] MAINTAINERS: Add entry for PENSANDO
Date:   Wed,  3 Mar 2021 19:41:41 -0800
Message-Id: <20210304034141.7062-9-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304034141.7062-1-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add entry for PENSANDO maintainer and files.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 973a937386fa..3f2eebda2396 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2246,6 +2246,15 @@ S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmz72.*
 
+ARM/PENSANDO SUPPORT
+M:	Brad Larson <brad@pensando.io>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/pensando*
+F:	arch/arm64/boot/dts/pensando/
+F:	drivers/gpio/gpio-elba-spics.c
+F:	drivers/mmc/host/sdhci-cadence-elba.c
+
 ARM/PLEB SUPPORT
 M:	Peter Chubb <pleb@gelato.unsw.edu.au>
 S:	Maintained
-- 
2.17.1

