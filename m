Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C18C33CB3
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B78F24686
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="x0WzuSX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgA1JHE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:07:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55820 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726166AbgA1JHE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2020 04:07:04 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S92i9h021525;
        Tue, 28 Jan 2020 10:06:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=vtrn8oNy0V5D1ILXEJrxYxOG5XROr16TBAvgkYNGlRY=;
 b=x0WzuSX1XndC0p5+b/E9nBVt0GDgGIhqCQGfXcQhkI62U5g99DIsTWQU5GjbXfvpnhAt
 dvHO8vmO2I2FwWyGG7N2vpP6mTWOasDL3CnrNj4iNp3X+lx25Gw6TstD6JCR+72J132q
 hu0uszTgG4FNlRw8rYRrFSzLJa52/GohXtmSyC6/wLsBwH0eoYTm8WQEldOupLsCQiRB
 lcvEdVbePm0Dffha/2XFFvjjB3UPmp7IDwTv+kOW+nmINFVvyq5Z8LIIef5avVD/+CX7
 v6pX6i1oXu60WoQ4GyI59d8wZB6CJINrdDENJacBd42oaqJEa5ttqtZjt56rujVFMVfY 4g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdekcuhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:06:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1063910003B;
        Tue, 28 Jan 2020 10:06:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 033EE212A38;
        Tue, 28 Jan 2020 10:06:47 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan 2020 10:06:46
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
Subject: [PATCH V2 7/9] mmc: mmci: add volt_switch callbacks
Date:   Tue, 28 Jan 2020 10:06:34 +0100
Message-ID: <20200128090636.13689-8-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128090636.13689-1-ludovic.barre@st.com>
References: <20200128090636.13689-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A variant may need to define some actions before and after
a voltage switch.

This patch adds 2 voltage switch callbacks in mmci_host_ops:
-pre_sig_volt_switch allows to prepare voltage switch before to
 sent the SD_SWITCH_VOLTAGE command (cmd11).
-post_sig_volt_switch callback allows to define specific action after
 regulator set voltage.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 8 ++++++++
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d0a041c9e6cd..24e630183ed4 100644
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
@@ -1217,6 +1218,9 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		writel_relaxed(clks, host->base + MMCIDATATIMER);
 	}
 
+	if (host->ops->pre_sig_volt_switch && cmd->opcode == SD_SWITCH_VOLTAGE)
+		host->ops->pre_sig_volt_switch(host);
+
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
 
@@ -1830,6 +1834,7 @@ static int mmci_get_cd(struct mmc_host *mmc)
 
 static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
+	struct mmci_host *host = mmc_priv(mmc);
 	int ret = 0;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
@@ -1849,6 +1854,9 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 			break;
 		}
 
+		if (!ret && host->ops && host->ops->post_sig_volt_switch)
+			ret = host->ops->post_sig_volt_switch(host, ios);
+
 		if (ret)
 			dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
 	}
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index ddcdfb827996..c3bc0a38d4cb 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -377,6 +377,8 @@ struct mmci_host_ops {
 	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
 	void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
 	bool (*busy_complete)(struct mmci_host *host, u32 status, u32 err_msk);
+	void (*pre_sig_volt_switch)(struct mmci_host *host);
+	int (*post_sig_volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
 };
 
 struct mmci_host {
-- 
2.17.1

