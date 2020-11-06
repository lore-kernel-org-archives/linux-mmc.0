Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2907C5517A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D3420786
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4l5b9za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKFC2q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKFC2n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:43 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1BC0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:43 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 1so1733222ple.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nsPN94n1n+TqzMZKBqH2HrUDrXH3mf0VWWmS8hMBwk=;
        b=A4l5b9zaNAXv2mt7fjgN5ByMw8GOCnqvGz2Zk5X0V71U4aDo4pcNanfPaugat51Ity
         B4P5/HGcT3RNxrmLVwoqjl3S2dtmLr+V88OQBHbjsR7eHrelAm9iFSX/MkV+fOeLH2Ur
         gh9XDLCJ3/wVMBJbk7LJWHp+B3BvRi6p+gB2X57+luYxsR/VMao1dAkWIWe74rGaLp20
         RdtAVu+4SWi40cFdFM5xZU9BTc7IRohFbRx8cs1gwcgvyrZah7cj6Jw0k7J4JAwD61m0
         2RjFHEl/IluRkVamhKEvkEVqcvb7iWxBUNh2C1TTea4gzYk+hkDhEHjszsrA1eCnmL/x
         hN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nsPN94n1n+TqzMZKBqH2HrUDrXH3mf0VWWmS8hMBwk=;
        b=pROorl4i93CwvQ9q9ykoCgXr6aVzJXZfT1Anvcbct9AZ1HOITlsJZoGarEbcUn0RWE
         63ObJv2DyQr7kOJU09DZddoVncXGD4+Lyd6VOlmye+wsBo7Oww1HxDDxoyTX93/nUipY
         OJduhSFSRjvET2EXQPeswCu7sCYUjkN4REsPD2SNHsWrXImQphyTd32jGsIlvoUnd7Rv
         7rJtiwWGbf0QTnREvPblel6Np6AehbVP+0S0iu4apmJ9z+KEoqZNDto6ey3bJEIWwYQB
         43SQP+DS66Np1MzpMdbAO06kF5s0D4MK9NsHCV75ICHMtKHahuNMCbJifbK0ui5mFnS3
         BzIg==
X-Gm-Message-State: AOAM5331IyJyqG0XTt2bJSfJn1QbO6Dq8F3e3MtXt+DXZIv7G8y23A0g
        h2918yO5iHghf3dzv1TaCQOOJg==
X-Google-Smtp-Source: ABdhPJzaugLX40BJYvw6ATcn0p+ocmss9VCZ9zglHiaTKtVbmBssCgxbxQ+NKtanMG/BZrWk5QFXtw==
X-Received: by 2002:a17:902:9a44:b029:d3:f10c:944a with SMTP id x4-20020a1709029a44b02900d3f10c944amr5044928plv.11.1604629722925;
        Thu, 05 Nov 2020 18:28:42 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:42 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 15/27] mmc: sdhci-uhs2: add set_timeout()
Date:   Fri,  6 Nov 2020 11:27:14 +0900
Message-Id: <20201106022726.19831-16-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a UHS-II version of sdhci's set_timeout() operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 85 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 2 files changed, 86 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 1eca89359351..d9e98c097bfe 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -178,6 +178,91 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res,
+				  u8 *dead_lock)
+{
+	u8 count;
+	unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
+
+	/*
+	 * If the host controller provides us with an incorrect timeout
+	 * value, just skip the check and use 0xE.  The hardware may take
+	 * longer to time out, but that's much better than having a too-short
+	 * timeout value.
+	 */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL) {
+		*cmd_res = 0xE;
+		*dead_lock = 0xE;
+		return 0xE;
+	}
+
+	/* timeout in us */
+	cmd_res_timeout = 5 * 1000;
+	dead_lock_timeout = 1 * 1000 * 1000;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < cmd_res_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*cmd_res = count;
+
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < dead_lock_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*dead_lock = count;
+
+	return count;
+}
+
+static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
+{
+	u8 cmd_res, dead_lock;
+
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+}
+
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	__sdhci_set_timeout(host, cmd);
+
+	if (host->mmc->flags & MMC_UHS2_SUPPORT)
+		__sdhci_uhs2_set_timeout(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 3c19d8e44c36..efe70577bc74 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -213,5 +213,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 			  unsigned short vdd);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.28.0

