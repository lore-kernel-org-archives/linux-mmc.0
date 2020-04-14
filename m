Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635E5C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D13820678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkQKPfPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbgDNQO7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390532AbgDNQOr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6EAC061A0F
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w145so216012lff.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMaec8mWMGgXBuaiFP3tH4b1b1cDIYOxK4IXyRFu+Dw=;
        b=ZkQKPfPWw39M+b18G+5yDS4CgY8qAJxK1czbQlkXUvwQ6ABr+9X9vRIJK7AfuEAQek
         DRoNqmdULa9cNVyVCt8SMU4hxy82qVDyplxE0uHZlQF0HbmnFaGnxQb0WGBGSahSk0Qo
         iw9lx8COygDkr92pF3A5llzXcoiqaYaxtyW1BiV6csj2Vmegn3hq3n+YDjnAHn60RiSQ
         mLbSA9p/ZW0kmJHPNpCD02J6gOaQTcvLpMW3tF7sgWsHV23DYPRNysdUjBNFcP+yuhbP
         sjpsPMQi7NMnw5Iei1A8cD6vKb2IZ8cIaGtX+jc+M2TvSEqN++mj6mga3n+p/3iGffRn
         AGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMaec8mWMGgXBuaiFP3tH4b1b1cDIYOxK4IXyRFu+Dw=;
        b=WEjr1cBMf4pCylE5ZmmpaHMc03hc80URhjrniilBwJ2l3sO+MuhJE4HMIa7sEhKna7
         CINCrTEOCcLspLa8gYd/CE39UehJz6u+rbTF0w9z2E0yt17CmNUGVZ3DphyZ6qtV4FpP
         pfLehq7pLV/+W5vJXyv0mOBd1v4J7rwZz3yxaxSX6A5TDdcJTexxFIEdbrDXM4aOSXm6
         ZB7Uvh7T1jLJlwUJX/Y5KIUDURsJchEtRopPWwPRHT/IHHw1g3YphBjwULptgtl/Deie
         mYmWk8mf02kUL2HkYLOvKivGVYnkoZF11TEvZxAy3UlwLSIIH2bzBHxF8JT9/1z7bddR
         e15Q==
X-Gm-Message-State: AGi0PuZrHX302MTPYL5f7bEv9vXi1bDlxTlikPwtOuIEcvJQISgpHQr6
        B0KAneCfP1PuZ8boScH+MMOE+DGWlUY=
X-Google-Smtp-Source: APiQypKcHfUONHVLUePGtZy2gcEGlrLSGkNd3Y9zreb4CnGqewO95145PU1TnmyQ3HrJmkuYIMFgFg==
X-Received: by 2002:a19:ca13:: with SMTP id a19mr359794lfg.68.1586880885559;
        Tue, 14 Apr 2020 09:14:45 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 16/19] mmc: via-sdmmc: Respect the cmd->busy_timeout from the mmc core
Date:   Tue, 14 Apr 2020 18:14:10 +0200
Message-Id: <20200414161413.3036-17-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Using a fixed 1s timeout for all commands (and data transfers) is a bit
problematic.

For some commands it means waiting longer than needed for the timer to
expire, which may not a big issue, but still. For other commands, like for
an erase (CMD38) that uses a R1B response, may require longer timeouts than
1s. In these cases, we may end up treating the command as it failed, while
it just needed some more time to complete successfully.

Fix the problem by respecting the cmd->busy_timeout, which is provided by
the mmc core.

Cc: Bruce Chang <brucechang@via.com.tw>
Cc: Harald Welte <HaraldWelte@viatech.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/via-sdmmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index e48bddd95ce6..ef95bce50889 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -319,6 +319,8 @@ struct via_crdr_mmc_host {
 /* some devices need a very long delay for power to stabilize */
 #define VIA_CRDR_QUIRK_300MS_PWRDELAY	0x0001
 
+#define VIA_CMD_TIMEOUT_MS		1000
+
 static const struct pci_device_id via_ids[] = {
 	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_9530,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
@@ -551,14 +553,17 @@ static void via_sdc_send_command(struct via_crdr_mmc_host *host,
 {
 	void __iomem *addrbase;
 	struct mmc_data *data;
+	unsigned int timeout_ms;
 	u32 cmdctrl = 0;
 
 	WARN_ON(host->cmd);
 
 	data = cmd->data;
-	mod_timer(&host->timer, jiffies + HZ);
 	host->cmd = cmd;
 
+	timeout_ms = cmd->busy_timeout ? cmd->busy_timeout : VIA_CMD_TIMEOUT_MS;
+	mod_timer(&host->timer, jiffies + msecs_to_jiffies(timeout_ms));
+
 	/*Command index*/
 	cmdctrl = cmd->opcode << 8;
 
-- 
2.20.1

