Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770C2C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 08:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E94060F41
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 08:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbhIXIad (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 04:30:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53699 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244581AbhIXIac (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632472140; x=1664008140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S1KXt06OJPu2r95MO0dmkGtrMLkOjczdUQlL0LpvFh4=;
  b=mijAFSbXQxSZ7V02tUfXTuJocLmzvFfp+DZkkGKkjxgZbC/SL+KZlIwK
   Y+rwq0QUUE1ZnfO3WhraRz17T1+qPXtPTQhaubRjPG3gmdTyq8haLTsVP
   ND4MHPw+Eybj15T61JjFwuIF6aYj77zy+VTlmhxJ8oQ/Kp6Nd0QZXrciY
   YwkJKBKa829kakAdQtMeMb6HVxM7b90TTdtNVoD8WqhKQm8Blz3P1BJss
   uWRRU+4BibPJD8TE0AeyuBOsfinUEeV3nfr94RKSb45PQeYNECrvzDlPk
   TBDMevxu0L7bwn8OH3Z1pW7ITW4txz6c56avAEiRQGZMhS1SkqFP2jLt+
   w==;
IronPort-SDR: JNHtt+6+j+5XEtW9YbRwsXKgMxOcKK8/TrFql8EXG9uYPm5yLMG1+aFhOcCoC4XImCawD7BYeE
 qs89us9RvsJAWLfFOiQEfrklBxnLd4I/7xkKj5VH1ekt2Iy3Y5L9Zr4Oe8+HWh+iJ2BaOUn/uS
 3zJDyuV7PijbOqQ2w3Kz5ALg+J95UrWn5RHZWoGS2QDMq48anefO/fF/Ctb7U3Sd5wXLkrwNk4
 ABo9ZQ69Yo8tSKFOoMVEb5E/H99ltrTFG9ztpiK+rlnSwGe33pI0PQxFSEIA6KUJvbblJF4/e0
 Efwdd8grEAMPbArA9Gob2kjJ
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="145463938"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 01:28:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 01:28:59 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 01:28:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] mmc: sdhci-of-at91: fix for shdci-of-at91
Date:   Fri, 24 Sep 2021 11:28:49 +0300
Message-ID: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

This series adds a fix for sdhci-of-at91 driver (patch 1/2). Along with
it patch 2/2 replaces a while loop + timeout with read_poll_timeout().

Changes in v2:
- use read_poll_timeout() in patch 1/2
- add patch 2/2

Claudiu Beznea (2):
  mmc: sdhci-of-at91: wait for calibration done before proceed
  mmc: sdhci-of-at91: replace while loop with read_poll_timeout

 drivers/mmc/host/sdhci-of-at91.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.25.1

