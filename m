Return-Path: <SRS0=mkSb=27=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3117C33CA3
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B502084D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bCQGPrkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgAJNtO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:49:14 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17194 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbgAJNtM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2020 08:49:12 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ADlx48013148;
        Fri, 10 Jan 2020 14:49:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=jylU7FoT+8vq4ShVG0cv762qm/YKM/4499aDPkVYi+w=;
 b=bCQGPrkJtmc2Ng3g642xzxAk26v6YfRaiKp9grAUwFrjcM4II3g8RyjbSxFUBzEAorBn
 qs7yEaq51xp4LS6d5OlVimvOjC1UNzxNZya8powVN3gdvtjmHdS7nSKy2MMMCcBxSmiy
 cjVw/O9V1ZUilLul1q/7G8rLzwRhmhN6/pIXwNxBPeee6f2pptvhZ4/GrZ1cfr6xMufe
 BlTUqBlRsFI+pNT7McG5yY6g3ogMMgxb5rIc//CrX2/Ej7cPRqtMNCrx+yp6rs92k+zd
 KkQXMsyr/tN2IEYEZ7cEQp0im+rB0YF47TBJ+3ipDnwDwFBtbvMVPuIO3FxZSV8PbCgK Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xepyt8w0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 14:49:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 503EF10002A;
        Fri, 10 Jan 2020 14:49:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 423C22BC7D1;
        Fri, 10 Jan 2020 14:49:03 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan 2020 14:49:02
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
Subject: [PATCH 6/9] mmc: mmci: sdmmc: add execute tuning with delay block
Date:   Fri, 10 Jan 2020 14:48:20 +0100
Message-ID: <20200110134823.14882-7-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110134823.14882-1-ludovic.barre@st.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The hardware delay block is used to align the sampling clock on
the data received by SDMMC. It is mandatory for SDMMC to
support the SDR104 mode. The delay block is used to generate
an output clock which is dephased from the input clock.
The phase of the output clock must be programmed by the execute
tuning interface.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 147 ++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index df08f6662431..10059fa19f4a 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -3,10 +3,13 @@
  * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
  * Author: Ludovic.barre@st.com for STMicroelectronics.
  */
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/of_address.h>
 #include <linux/reset.h>
 #include <linux/scatterlist.h>
 #include "mmci.h"
@@ -14,6 +17,20 @@
 #define SDMMC_LLI_BUF_LEN	PAGE_SIZE
 #define SDMMC_IDMA_BURST	BIT(MMCI_STM32_IDMABNDT_SHIFT)
 
+#define DLYB_CR			0x0
+#define DLYB_CR_DEN		BIT(0)
+#define DLYB_CR_SEN		BIT(1)
+
+#define DLYB_CFGR		0x4
+#define DLYB_CFGR_SEL_MASK	GENMASK(3, 0)
+#define DLYB_CFGR_UNIT_MASK	GENMASK(14, 8)
+#define DLYB_CFGR_LNG_MASK	GENMASK(27, 16)
+#define DLYB_CFGR_LNGF		BIT(31)
+
+#define DLYB_NB_DELAY		11
+#define DLYB_CFGR_SEL_MAX	(DLYB_NB_DELAY + 1)
+#define DLYB_CFGR_UNIT_MAX	127
+
 struct sdmmc_lli_desc {
 	u32 idmalar;
 	u32 idmabase;
@@ -25,6 +42,12 @@ struct sdmmc_idma {
 	void *sg_cpu;
 };
 
+struct sdmmc_dlyb {
+	void __iomem *base;
+	u32 unit;
+	u32 max;
+};
+
 static int sdmmc_idma_validate_data(struct mmci_host *host,
 				    struct mmc_data *data)
 {
@@ -226,12 +249,24 @@ static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
+static void sdmmc_dlyb_input_ck(struct sdmmc_dlyb *dlyb)
+{
+	if (!dlyb || !dlyb->base)
+		return;
+
+	/* Output clock = Input clock */
+	writel_relaxed(0, dlyb->base + DLYB_CR);
+}
+
 static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
 {
 	struct mmc_ios ios = host->mmc->ios;
+	struct sdmmc_dlyb *dlyb = host->variant_priv;
 
 	pwr = host->pwr_reg_add;
 
+	sdmmc_dlyb_input_ck(dlyb);
+
 	if (ios.power_mode == MMC_POWER_OFF) {
 		/* Only a reset could power-off sdmmc */
 		reset_control_assert(host->rst);
@@ -323,6 +358,102 @@ static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 	return true;
 }
 
+static void sdmmc_dlyb_set_cfgr(struct sdmmc_dlyb *dlyb,
+				int unit, int phase, bool sampler)
+{
+	u32 cfgr;
+
+	writel_relaxed(DLYB_CR_SEN | DLYB_CR_DEN, dlyb->base + DLYB_CR);
+
+	cfgr = FIELD_PREP(DLYB_CFGR_UNIT_MASK, unit) |
+	       FIELD_PREP(DLYB_CFGR_SEL_MASK, phase);
+	writel_relaxed(cfgr, dlyb->base + DLYB_CFGR);
+
+	if (!sampler)
+		writel_relaxed(DLYB_CR_DEN, dlyb->base + DLYB_CR);
+}
+
+static int sdmmc_dlyb_lng_tuning(struct mmci_host *host)
+{
+	struct sdmmc_dlyb *dlyb = host->variant_priv;
+	u32 cfgr;
+	int i, lng, ret;
+
+	for (i = 0; i <= DLYB_CFGR_UNIT_MAX; i++) {
+		sdmmc_dlyb_set_cfgr(dlyb, i, DLYB_CFGR_SEL_MAX, true);
+
+		ret = readl_relaxed_poll_timeout(dlyb->base + DLYB_CFGR, cfgr,
+						 (cfgr & DLYB_CFGR_LNGF),
+						 1, 1000);
+		if (ret) {
+			dev_warn(mmc_dev(host->mmc),
+				 "delay line cfg timeout unit:%d cfgr:%d\n",
+				 i, cfgr);
+			continue;
+		}
+
+		lng = FIELD_GET(DLYB_CFGR_LNG_MASK, cfgr);
+		if (lng < BIT(DLYB_NB_DELAY) && lng > 0)
+			break;
+	}
+
+	if (i > DLYB_CFGR_UNIT_MAX)
+		return -EINVAL;
+
+	dlyb->unit = i;
+	dlyb->max = __fls(lng);
+
+	return 0;
+}
+
+static int sdmmc_dlyb_phase_tuning(struct mmci_host *host, u32 opcode)
+{
+	struct sdmmc_dlyb *dlyb = host->variant_priv;
+	int cur_len = 0, max_len = 0, end_of_len = 0;
+	int phase;
+
+	for (phase = 0; phase <= dlyb->max; phase++) {
+		sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
+
+		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
+			cur_len = 0;
+		} else {
+			cur_len++;
+			if (cur_len > max_len) {
+				max_len = cur_len;
+				end_of_len = phase;
+			}
+		}
+	}
+
+	if (!max_len) {
+		dev_err(mmc_dev(host->mmc), "no tuning point found\n");
+		return -EINVAL;
+	}
+
+	phase = end_of_len - max_len / 2;
+	sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
+
+	dev_dbg(mmc_dev(host->mmc), "unit:%d max_dly:%d phase:%d\n",
+		dlyb->unit, dlyb->max, phase);
+
+	return 0;
+}
+
+static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	struct sdmmc_dlyb *dlyb = host->variant_priv;
+
+	if (!dlyb || !dlyb->base)
+		return -EINVAL;
+
+	if (sdmmc_dlyb_lng_tuning(host))
+		return -EINVAL;
+
+	return sdmmc_dlyb_phase_tuning(host, opcode);
+}
+
 static struct mmci_host_ops sdmmc_variant_ops = {
 	.validate_data = sdmmc_idma_validate_data,
 	.prep_data = sdmmc_idma_prep_data,
@@ -338,5 +469,21 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 
 void sdmmc_variant_init(struct mmci_host *host)
 {
+	struct device_node *np = host->mmc->parent->of_node;
+	void __iomem *base_dlyb;
+	struct sdmmc_dlyb *dlyb;
+
 	host->ops = &sdmmc_variant_ops;
+
+	base_dlyb = devm_of_iomap(mmc_dev(host->mmc), np, 1, NULL);
+	if (IS_ERR(base_dlyb))
+		return;
+
+	dlyb = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dlyb), GFP_KERNEL);
+	if (!dlyb)
+		return;
+
+	dlyb->base = base_dlyb;
+	host->variant_priv = dlyb;
+	host->mmc_ops->execute_tuning = sdmmc_execute_tuning;
 }
-- 
2.17.1

