From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH 0/3] mmc: sdhci: Card detection fixes
Date: Fri, 26 Jun 2015 13:00:07 +0300
Message-ID: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34035 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbFZKAP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 06:00:15 -0400
Received: by wicnd19 with SMTP id nd19so40680379wic.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2015 03:00:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

Following changes aimed to fix some aspects of card detection, when
BROKEN_CARD_DETECTION quirk is set.

Ivan T. Ivanov (3):
  mmc: sdhci: let GPIO based card detection have higher precedence
  mmc: sdhci: don't use card state polling when CD GPIO is defined
  mmc: sdhci: properly check card present state when quirk
    NO_CARD_NO_RESET is set

 drivers/mmc/host/sdhci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--
1.9.1

