Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B130C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Dec 2021 20:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhLQU1W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:27:22 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:56204 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhLQU1W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Dec 2021 15:27:22 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 5962720CF560
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: [PATCH 0/2] Add IRQ check to the Meson MMC/SD drivers
Date:   Fri, 17 Dec 2021 23:27:15 +0300
Message-ID: <20211217202717.10041-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Here are 2 patches against the 'fixes' branch of Ulf Hansson's 'mmc.git' repo.
The affected drivers call platform_get_irq() but forget to check for the error
case and blithely pass the negative error codes to devm_request_threaded_irq()
(which takes *unsigned* IRQ #). Now stop calling devm_request_threaded_irq()
with the invalid IRQ #s!

Sergey Shtylyov (2):
  mmc: meson-mx-sdhc: add IRQ check
  mmc: meson-mx-sdio: add IRQ check

 drivers/mmc/host/meson-mx-sdhc-mmc.c | 5 +++++
 drivers/mmc/host/meson-mx-sdio.c     | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.26.3

