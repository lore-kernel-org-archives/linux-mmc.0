Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E313C35242
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 01:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B6024686
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828809;
	bh=8EYe6y5wyOfEea0xvGBOkJ7h0WnL6V5YlGvBrH3c06k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zpfzS6X9nuWzB//svT+l2mdWZXWDojUe7pl0TU1si/Jni0g3MIwAXbR4bGLfmTr85
	 4LLAEvrBqThZGqoo8p73jjqgVn/frSzqhwqcWs3cDeuFf1Ai9t7eistE1V28cTR036
	 VtiobJxo1qV0MYst34aYdwJZlDbpvZlO4HzSdq+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgAXBUF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbgAXBRd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DEA521D7D;
        Fri, 24 Jan 2020 01:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828653;
        bh=8EYe6y5wyOfEea0xvGBOkJ7h0WnL6V5YlGvBrH3c06k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEy4eZLcIGSS2XJ21GCIUM7HVzQDIsRglT5tLXKtn3QAAT6UmK9/jNisH9LO6ndxL
         UG6uYQ8APl33HfhGdPgLovmAGV5Dy2iDHj8pEx524xsy5ferwdS9FlUps6VBDky/I/
         ALHJqDPYvqtanoQoGiyTdHgzATEFG1k81dEbqkS0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 21/33] mmc: sdhci-pci: Add support for Intel JSL
Date:   Thu, 23 Jan 2020 20:16:56 -0500
Message-Id: <20200124011708.18232-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 315e3bd7ac19b18ba704d96cbb9b79bad485c01f ]

Add PCI Ids for Intel JSL.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 ++
 drivers/mmc/host/sdhci-pci.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 96a163f36a395..c9ea365c248c0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1730,6 +1730,8 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(INTEL, CML_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(INTEL, CML_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(INTEL, CMLH_SD,   intel_byt_sd),
+	SDHCI_PCI_DEVICE(INTEL, JSL_EMMC,  intel_glk_emmc),
+	SDHCI_PCI_DEVICE(INTEL, JSL_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(O2, 8120,     o2),
 	SDHCI_PCI_DEVICE(O2, 8220,     o2),
 	SDHCI_PCI_DEVICE(O2, 8221,     o2),
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 558202fe64c67..981bbbe63aff5 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -55,6 +55,8 @@
 #define PCI_DEVICE_ID_INTEL_CML_EMMC	0x02c4
 #define PCI_DEVICE_ID_INTEL_CML_SD	0x02f5
 #define PCI_DEVICE_ID_INTEL_CMLH_SD	0x06f5
+#define PCI_DEVICE_ID_INTEL_JSL_EMMC	0x4dc4
+#define PCI_DEVICE_ID_INTEL_JSL_SD	0x4df8
 
 #define PCI_DEVICE_ID_SYSKONNECT_8000	0x8000
 #define PCI_DEVICE_ID_VIA_95D0		0x95d0
-- 
2.20.1

