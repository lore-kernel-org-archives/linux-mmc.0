Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2CCDB46E
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Oct 2023 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjJLSmc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Oct 2023 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLSmb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2023 14:42:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B783
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2023 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697136149; x=1728672149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cE+Ovmdif0klOaUfZsBoFastK7bPX6jSv6/7TS40OGc=;
  b=DxnqVFlPq54DnM4gpwt7xwiMaBmTnezncrHB94tflwxUWbGzXteoVqx/
   aaN1HItiEzymM0QuiwKX67Tgb+UAWtTON30KiRcw88+wYl4UdX1J62c34
   Uqg0KYmfCvZLFCPeLjJYCBGS5f9+8znCTJ5CereMGiet3kcxjDg0vDjbe
   c1ccgP4WzwMqUaRlyx2RAlDAL1WTTjfu4RHTH/Xf0UBuTEKeqT+E1+EMQ
   sU/JZE3tWy2lJUHghyxAOEoYWvMTcahYaMPfODYRViodHFEqw6MA/UgKf
   HyPy+MA+yLcjX+7WKJOGFQ/RLzUb+3oL5iV/Q0fIFxvNRLujzIb+HyJ48
   A==;
X-CSE-ConnectionGUID: YH/bN/XLRJarU2AtpfP9qA==
X-CSE-MsgGUID: gM3U8KHITIikxuNt53pIIw==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="351770274"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 02:42:29 +0800
IronPort-SDR: NMQIm44Qt9O/TKm8xM2r33IIzj5bqsMd+HjKVA1THCzGvAkYtrS85IC2I5ZVkec5glmgyMaBJr
 OoDv0rSQMBGhok7ysEFd/wVRLNALPg2Usjrg6h6pOmr8MoCxUtM25ujA7G9WXkg9tHuuH4To9s
 +rpe/5WtAI6/NrsmbxMKpQehUOca0ZYW64wpqBMh6SzRHMPNDqm5zz0AzAGJp0bwFk8hRb2O6R
 /XlGcK2Ow52Jis9qNstcMoFu9qGgNrWr6PEWmbThpj8lnEsyOJ2HfydeKTDx1dOwRzYOB0aGUs
 Y3A=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 10:48:56 -0700
IronPort-SDR: Yzm2cnBlSeBnhdybEc9+IoBZGK7SovfuwP5lRDXEfpReLfwBFacJmnvv9szajZ5FLqqDT8Y51R
 z3rgQ62A0+/AOXrh1NesvSwxl/X6DK1+QKAgHrVhoOkN6AfuSf/ahHxBU2kn/eOYAU74U6ZnB6
 bAeezdv9I58sUGD5oaCzdbl4h0czxc6WGi4JOU6Xv0gMpNZfL+tCfFO4YGIXgn2LmhgO1FRHb4
 o8j1t+GMCLT4nUwW+Bgt4CASwZ0LfnBMRRNdd+HulGbOhysCP9FYMT73gIuv9DbEFsUuI6FYes
 IOA=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Oct 2023 11:42:26 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/3] mmc: host: Quirk - Disable auto-cmd12 during ffu
Date:   Thu, 12 Oct 2023 21:40:39 +0300
Message-Id: <20231012184041.1837455-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012184041.1837455-1-avri.altman@wdc.com>
References: <20231012184041.1837455-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Field Firmware Update (ffu) may use close-ended or open ended sequence.
Each such sequence is comprised of a write commands enclosed between 2
switch commands - to and from ffu mode.

Some platforms generate auto command error interrupt when it shouldn't,
e.g. auto-cmd12 while in close-ended ffu sequence.

Therefore, add a quirk that disable auto-cmd12 while close-ended ffu is
in progress.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/host/sdhci.c | 8 +++++++-
 drivers/mmc/host/sdhci.h | 2 ++
 include/linux/mmc/core.h | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ff41aa56564e..6d58f71f926e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1389,11 +1389,17 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en)
 }
 EXPORT_SYMBOL_GPL(sdhci_switch_external_dma);
 
+static inline bool sdhci_dont_auto_cmd12_ffu(struct sdhci_host *host,
+					     struct mmc_request *mrq) {
+	return (host->quirks2 & SDHCI_QUIRK2_FFU_ACMD12) && mrq->ffu;
+}
+
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 				    struct mmc_request *mrq)
 {
 	return !mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
-	       !mrq->cap_cmd_during_tfr;
+	       !mrq->cap_cmd_during_tfr &&
+	       !sdhci_dont_auto_cmd12_ffu(host, mrq);
 }
 
 static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f219bdea8f28..ccab3a76883c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -485,6 +485,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
 /* Issue CMD and DATA reset together */
 #define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
+/* Controller generates auto-cmd error interrupt during close-ended ffu */
+#define SDHCI_QUIRK2_FFU_ACMD12				(1<<20)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 6efec0b9820c..aca4e84f648c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -161,6 +161,9 @@ struct mmc_request {
 	/* Allow other commands during this ongoing data transfer or busy wait */
 	bool			cap_cmd_during_tfr;
 
+	/* Be aware that ffu is in progress and avoid auto-cmd12 */
+	bool			ffu;
+
 	int			tag;
 
 #ifdef CONFIG_MMC_CRYPTO
-- 
2.42.0

