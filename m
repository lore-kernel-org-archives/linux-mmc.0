Return-Path: <SRS0=obPU=EB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335AFC4363A
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Oct 2020 15:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31AC22450
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Oct 2020 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603726834;
	bh=KAl+a17RKAP8KypIuISMNDf6rpG0mE1AHoSQdwN/75Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tCeCWoQZXQmETX0GoH1gySgH+EqAZHlDdAaiDCfJJiq4jp3mhAHwBOXqOSvw7cW2j
	 GaSbBkHa47MhL65kq2Ssx0QpT7hUgWUIVLkP0ClpyGRNTkvqfCx8Edo5OW8Kw7UefJ
	 BULYmVOIpSjK+QZtPsW1/cuNmoZvupyjpaYFU2sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784252AbgJZPkd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773322AbgJZPkc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Oct 2020 11:40:32 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0391D2242A;
        Mon, 26 Oct 2020 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603726832;
        bh=KAl+a17RKAP8KypIuISMNDf6rpG0mE1AHoSQdwN/75Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5Dou+5oBBQu9B6fpTptjbMUWmxlwzDlG9DHDH4lwDGqyPW5GbO+WLe62AnoSr6cW
         fgBgANAJa1WwsZRr3EJTSYsgp4sDA2XbV5nRHA/n789N0HjdBUQCXq80as8CSF+xAg
         /ePe9Z3S3ZwFBJFGrBt1UqibfZMSNiWWJn6T8rWc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] mmc: s3cmci: enable compile testing
Date:   Mon, 26 Oct 2020 16:38:09 +0100
Message-Id: <20201026153810.89512-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026153810.89512-1-krzk@kernel.org>
References: <20201026153810.89512-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver can be compile tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 31481c9fcc2e..310e546e5898 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -631,8 +631,8 @@ config MMC_SPI
 
 config MMC_S3C
 	tristate "Samsung S3C SD/MMC Card Interface support"
-	depends on ARCH_S3C24XX
-	depends on S3C24XX_DMAC
+	depends on ARCH_S3C24XX || COMPILE_TEST
+	depends on S3C24XX_DMAC || COMPILE_TEST
 	help
 	  This selects a driver for the MCI interface found in
 	  Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
-- 
2.25.1

