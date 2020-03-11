Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B47C10F25
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AA52192A
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgCKFHA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:07:00 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:44562 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728116AbgCKFG7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 01:06:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1110E1801917B;
        Wed, 11 Mar 2020 05:06:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fire41_1f93db2263a23
X-Filterd-Recvd-Size: 1699
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:56 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 009/491] ARM/Amlogic Meson SoC support: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:23 -0700
Message-Id: <f2e2456d01101a52b20c012b378faec2aa30ad67.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 8b038e..d35d81 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -291,7 +291,7 @@ static void meson_mx_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		vdd = 0;
-		/* fall through */
+		fallthrough;
 	case MMC_POWER_UP:
 		if (!IS_ERR(mmc->supply.vmmc)) {
 			host->error = mmc_regulator_set_ocr(mmc,
-- 
2.24.0

