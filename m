Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1212C433E3
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F4422C9F
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739379;
	bh=5nwPKu2c7dkQrGtzL6LA+yW44/UqSKxYq4VNokfpuKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c+/ACbmukme6OBWf/ApEdxHS7o3lr2m+s2nJ6CwGm+HfwrNnTVf8XXT6NcZTEDggr
	 Zuh/VTo/NSElmnt8rClhVsj2tzb7Haj3dbB8iPxvOamJemzwS1nM7Ijx8kHJ4YbcVD
	 TjGz9UdlNAp60viEBclLd0P8iJLZUyPeYy8B7fN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHFSmg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgHFSVv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 14:21:51 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AACD122CE3;
        Thu,  6 Aug 2020 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738105;
        bh=5nwPKu2c7dkQrGtzL6LA+yW44/UqSKxYq4VNokfpuKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEgyjomsMoi1BFSWY8gCec2B4/q2Pq75dQpIw60bSofKWB72/qyz5rcT+tpYSEhE/
         agpw62Ugw4k3jgXE5TpFTFC8Rvy6hcmfjCWN8qOhxQsQ5uYZo4Vhh8bOBfGJEtEnRS
         PEy1pSyBCQLsfnXBnVNsplmQIyAdng8RyS1xKyHI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 02/41] mmc: s3cmci: Remove unneeded machine header include
Date:   Thu,  6 Aug 2020 20:20:19 +0200
Message-Id: <20200806182059.2431-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The s3cmci driver does not use machine header mach/dma.h.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/s3cmci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index b5df948f8155..60fc3fc30fb4 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -26,7 +26,6 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include <plat/gpio-cfg.h>
-#include <mach/dma.h>
 #include <mach/gpio-samsung.h>
 
 #include <linux/platform_data/mmc-s3cmci.h>
-- 
2.17.1

