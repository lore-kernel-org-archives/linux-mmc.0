Return-Path: <SRS0=vSIZ=ZY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E6C432C3
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3CF20833
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwVHpEcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLBOlb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:41:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36163 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfLBOla (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2019 09:41:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so18561679pfd.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2019 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=4JVaie1wKwbF/eE0x2jamXEgMwRcra2vbyk9yLgEYR8=;
        b=pwVHpEcIT1sHACwQ7+9kcf6Yne/nC43A86UnrCMyRq0S24voaGFsqBhlNu5dBu22On
         nPOO55SKDBil+llsZXpyhXgfwkjSs62UROY5fDd8IJzyNetr25/gUfzQt5XiJlMjo4oy
         m6iy82qxO6Ke00Sky8rtJ6LPBJr5PMWWflvNDxJ61qX6PIfcPauWgit9Gy/XrnDwLrnc
         YstZP9Pxe5ghWbsujegWn8KzcNMp2JHEnOj+UhMDPFQU5UMtac7h5EIEHg+c/t9gbvKA
         +bZVR88ZZLrRQUneB6Z83ZlB6JirYDceWgI3rPBR2yUCyDPMXZfIICL5asvlEqle5ink
         guvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=4JVaie1wKwbF/eE0x2jamXEgMwRcra2vbyk9yLgEYR8=;
        b=CaDwLhahaEcVkHI9xmEwIlorBvQbV/b7lcfPTtvofZUbzPkZ8yE6tQ6WByZGybb5uJ
         yCfz/PLxPSe6FjUoRjrcPAPQd6hll3GdWJwHjVpHaVGWr+UyhAP70w8Y3ol9n5FBW1j4
         3XodWk4wV1hptS/wVYYTZbNwuLzdS/UTPTR6Fh5ERZO3oPVLmNouLqV7880+oocby4lD
         +SpvKHj7VYuvUMYSN0uZOx3sPiPtHvwVwUU3eT8T7j+SVNugMexf4/h/but6wtROqND0
         /20nJxNt7DA+MF5fgr1dziObOfkBMEht0MtpRISWD2PQLQMg3/gSZg0K+XmG3Uvpbrme
         bnLg==
X-Gm-Message-State: APjAAAW/2cK1a512xEH4qcjBu5eUx0AfQMmgC6EsRZHkxZSDnwlsraGF
        QZc0fuJr39A2sKo40AoaFTEDKg==
X-Google-Smtp-Source: APXvYqw9yNrxcCqTlBzbkVnq0xVt8hq5c2fMB4lZm5ZBHo725UjUR7/G96+1Op2dM7BDAr/el90XAQ==
X-Received: by 2002:aa7:9f9b:: with SMTP id z27mr24887087pfr.102.1575297690097;
        Mon, 02 Dec 2019 06:41:30 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id f30sm33985090pga.20.2019.12.02.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 06:41:29 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] mmc: sdhci: Set ctrl_hs400 value in dts
Date:   Mon,  2 Dec 2019 22:41:03 +0800
Message-Id: <20191202144104.5069-4-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202144104.5069-1-jun.nie@linaro.org>
References: <20191202144104.5069-1-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Because ctrl_hs400 value is non-standard, add support to set it
in dts.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/mmc/host/sdhci.c | 9 ++++++++-
 drivers/mmc/host/sdhci.h | 6 +++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a654f0aeb438..d8a6c1c91448 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1899,7 +1899,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		 (timing == MMC_TIMING_MMC_DDR52))
 		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
 	else if (timing == MMC_TIMING_MMC_HS400)
-		ctrl_2 |= SDHCI_CTRL_HS400; /* Non-standard */
+		ctrl_2 |= host->sdhci_ctrl_hs400; /* Non-standard */
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
@@ -3635,6 +3635,13 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 	of_property_read_u64(mmc_dev(host->mmc)->of_node,
 			     "sdhci-caps", &dt_caps);
 
+	if (of_property_read_u32(mmc_dev(host->mmc)->of_node,
+				 "sdhci-ctrl-hs400", &host->sdhci_ctrl_hs400))
+		host->sdhci_ctrl_hs400 = SDHCI_CTRL_HS400;
+	else
+		WARN_ON(host->sdhci_ctrl_hs400 > 7
+			|| host->sdhci_ctrl_hs400 < 5);
+
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0e6f97eaa796..cac4d819f62c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -184,7 +184,8 @@
 #define   SDHCI_CTRL_UHS_SDR50		0x0002
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
-#define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
+/* SDHCI_CTRL_HS400 is non-standard value, can change it in dts */
+#define   SDHCI_CTRL_HS400		0x0005
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
@@ -605,6 +606,9 @@ struct sdhci_host {
 
 	u64			data_timeout;
 
+	/* SDHCI_CTRL_HS400 value */
+	u32			sdhci_ctrl_hs400;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 
-- 
2.17.1

