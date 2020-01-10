Return-Path: <SRS0=mkSb=27=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A986C282DD
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D591120838
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tcfLqYtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgAJNtV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:49:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44927 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728237AbgAJNtS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2020 08:49:18 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ADlv32031935;
        Fri, 10 Jan 2020 14:49:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=NLjg1B5h+ASCcN62lZ3aN5vVT+hw/N/+lePHW81bf2s=;
 b=tcfLqYtUpbbZpK5tqQI+QMVZ9Fwbq5VTmxpWGsyYUErshZS8siHdXO8BBdnROlU49ekw
 18qUG2K9BOMcScJbYvdP2PiYPSvJjnGl2APcYaBjakZ3ioXShJizhpN5dSkcldE5Tirn
 zgT24pccFwmjhU8cVqKiNnLqwC9m6e4kyo5JhXvBYbJ1Cf+a8Y6QGT3PNIFRJ5PZg58t
 zIQTHdHlHTtonojP1cfVI4clmuP0Ij3bV/jgwiArWYqyOV7LTNZSu4gb5CoWBzdErnui
 eP+CifU7KeV80e0nGhoRgA07BzSFZIc3IeGW/1eC66kw0vHYZr1Zf4JHyefYokLG1wg2 Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur7dtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 14:49:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 622F4100038;
        Fri, 10 Jan 2020 14:49:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 543672BC7D2;
        Fri, 10 Jan 2020 14:49:04 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan 2020 14:49:03
 +0100
From:   Ludovic Barre <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 7/9] mmc: mmci: add volt_switch callbacks
Date:   Fri, 10 Jan 2020 14:48:21 +0100
Message-ID: <20200110134823.14882-8-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110134823.14882-1-ludovic.barre@st.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds 2 voltage switch callbacks in mmci_host_ops:
-prep_volt_switch allows to prepare voltage switch before to
 sent the SD_SWITCH_VOLTAGE command (cmd11).
-volt_switch callback allows to define specific action after
 regulator set voltage.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 8 ++++++++
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 00b473f57047..d76a59c06cb0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -22,6 +22,7 @@
 #include <linux/mmc/pm.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
@@ -1207,6 +1208,9 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		writel_relaxed(clks, host->base + MMCIDATATIMER);
 	}
 
+	if (host->ops->prep_volt_switch && cmd->opcode == SD_SWITCH_VOLTAGE)
+		host->ops->prep_volt_switch(host);
+
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
 
@@ -1820,6 +1824,7 @@ static int mmci_get_cd(struct mmc_host *mmc)
 
 static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
+	struct mmci_host *host = mmc_priv(mmc);
 	int ret = 0;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
@@ -1839,6 +1844,9 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 			break;
 		}
 
+		if (!ret && host->ops && host->ops->volt_switch)
+			ret = host->ops->volt_switch(host, ios);
+
 		if (ret)
 			dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
 	}
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index ddcdfb827996..c04a144259a2 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -377,6 +377,8 @@ struct mmci_host_ops {
 	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
 	void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
 	bool (*busy_complete)(struct mmci_host *host, u32 status, u32 err_msk);
+	void (*prep_volt_switch)(struct mmci_host *host);
+	int (*volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
 };
 
 struct mmci_host {
-- 
2.17.1

