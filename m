Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D67C432BE
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9992E61131
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbhHTJbX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:31:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62509 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbhHTJbW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2021 05:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629451845; x=1660987845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWsatgcloSsqrB7wvaudTGqBX8SMP/WQ4Wac0C232F0=;
  b=fTGn1AWnH9fqf+DeiKnPX9FadbSAy74ipTyIICq0QeqN3J8IusM5PyT0
   8oCkT243Bp73SPGKzlW+7er3kWc03qYRdkpf4ZoEbZut2UPwAkmUobm5j
   NLAn3wri1frAOCKuIcD//ilYYGJPR5/7XdEfxfol9H84oHq+I0rPvrPHL
   C5w7JQXQV6Sw/o7YtQChDrSvpEPfHt5VsJoNkJluQzGtmdj+qRJykBbPy
   VTwxGvbgDVTzyWDxYY+nzP1OSmABoYPVcgs8f5mYPqbmIy6Hah3efbzUU
   +p0CuwmiV2yvIbo3wFpffYVnqgZTjhS9sT/hshgD065tcV81FZdepjdg6
   A==;
IronPort-SDR: axBQfu99mh2MP5drdD03Mt5YY0UKpht3ziYIn5eluHyjkM42+dSnHeEzqi+nzp+NdFxzDaMUzO
 Km4oRrrHeO01gW21j8kTyy1JavB7KZO25hTy55N7cmHERCewVJhbkDmPSo23guvwu6/pvjy60z
 re/Dbvd0lf0oMmYGqoFFQxjjeOlWYmOf6UyF29iulrvjcyjdRZNwUmC2RdiyTC+k7sZGR7nUNc
 3uP5FsjHNGS+5ojZgcUWn0II9gK/hqnOAhJV/eZ+nXGMqBkNv221w3TQi0ircVhj6vTrcIbuOL
 MazMWioMTLIGrbAth1W4GrOf
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="128997122"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2021 02:30:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 02:30:43 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 02:30:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/4] mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787
Date:   Fri, 20 Aug 2021 12:28:02 +0300
Message-ID: <20210820092803.78523-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820092803.78523-1-claudiu.beznea@microchip.com>
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

pwseq_sd8787 could also be used with wilc1000_sdio driver. Add
a dependency for this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mmc/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index ae8b69aee619..6f25c34e4fec 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -15,7 +15,7 @@ config PWRSEQ_EMMC
 
 config PWRSEQ_SD8787
 	tristate "HW reset support for SD8787 BT + Wifi module"
-	depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO)
+	depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO || WILC1000_SDIO)
 	help
 	  This selects hardware reset support for the SD8787 BT + Wifi
 	  module. By default this option is set to n.
-- 
2.25.1

