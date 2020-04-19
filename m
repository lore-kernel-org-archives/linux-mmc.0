Return-Path: <SRS0=MzXf=6D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BEDC2BA2B
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Apr 2020 05:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED082078A
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Apr 2020 05:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="DuPNGhMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDSFhx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:37:53 -0400
Received: from lists.nic.cz ([217.31.204.67]:37384 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgDSFhx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 19 Apr 2020 01:37:53 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 44575140079;
        Sun, 19 Apr 2020 07:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587274671; bh=zdZ5E6lSFk+r6arWOcn3KBR83L7Rdjb3OX60Z+CwHIU=;
        h=From:To:Date;
        b=DuPNGhMotHvxqZUGK2wDpRAJ3dLI4821ExzOHNC8PK6vm1PeYj2kjWm76NqlLT2xV
         +psPBQjlDUMB8wqTwFuPVJmbLs48jDtF4oO0GkV/mIsYtS1SDPn+Yhn0wJK4UI9DC2
         VRpRVYayWhaXJSYV8N+pQSd1hcO4HR5uFgB94cO4=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-mmc@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Zhoujie Wu <zjwu@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH] mmc: sdhci-xenon: fix annoying 1.8V regulator warning
Date:   Sun, 19 Apr 2020 07:37:46 +0200
Message-Id: <20200419053746.22443-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For some reason the Host Control2 register of the Xenon SDHCI controller
sometimes reports the bit representing 1.8V signaling as 0 when read
after it was written as 1. Subsequent read reports 1.

This causes the sdhci_start_signal_voltage_switch function to report
  1.8V regulator output did not become stable

When CONFIG_PM is enabled, the host is suspended and resumend many
times, and in each resume the switch to 1.8V is called, and so the
kernel log reports this message annoyingly often.

Do an empty read of the Host Control2 register in Xenon's
.voltage_switch method to circumvent this.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Zhoujie Wu <zjwu@marvell.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/mmc/host/sdhci-xenon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 1dea1ba66f7b..126ae723f8ab 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -235,6 +235,25 @@ static void xenon_voltage_switch(struct sdhci_host *host)
 {
 	/* Wait for 5ms after set 1.8V signal enable bit */
 	usleep_range(5000, 5500);
+
+	/*
+	 * For some reason the controller's Host Control2 register reports
+	 * the bit representing 1.8V signaling as 0 when read after it was
+	 * written as 1. Subsequent read reports 1.
+	 *
+	 * This causes the sdhci_start_signal_voltage_switch function to
+	 * report
+	 *   "1.8V regulator output did not become stable"
+	 * in kernel log.
+	 *
+	 * When CONFIG_PM is enabled, the host is suspended and resumend many
+	 * times, and in each resume the switch to 1.8V is called, and so the
+	 * kernel log reports this message annoyingly often.
+	 *
+	 * Do an empty read of the Host Control2 register here to circumvent
+	 * this.
+	 */
+	sdhci_readw(host, SDHCI_HOST_CONTROL2);
 }
 
 static const struct sdhci_ops sdhci_xenon_ops = {
-- 
2.24.1

