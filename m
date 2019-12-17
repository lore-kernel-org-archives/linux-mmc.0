Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D52FC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CC924655
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ANgepo85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLQCwU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:52:20 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:46181 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfLQCwS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 21:52:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551137; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=XqcWpfP2FAYmwHb7ctixO6eLZe+tGA9sizqXcSh3r3w=; b=ANgepo85CZZeFC2qd43XTMqMeA1dAstjCAOtBG4qGCZMnsg81fHYkb+jjbY9soE1EMrK6zbh
 925Gkz5yEH9fonxuQLCwBBkeC6uWGAbGKuXlzLyOhBBJoWhGvfKm/S0F8PQtsDF+oINAw85+
 geYf9oDKiwQwqJ1cbmoZnt5FtMQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842de.7f2d92f3cea0-smtp-out-n03;
 Tue, 17 Dec 2019 02:52:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5857EC433A2; Tue, 17 Dec 2019 02:52:13 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3A0AC43383;
        Tue, 17 Dec 2019 02:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3A0AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 1/9] mmc: core: Add a cap to use long discard size
Date:   Mon, 16 Dec 2019 18:50:34 -0800
Message-Id: <628141610bd44235b0cea04ff110dd4c67027aba.1576540907.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add MMC_CAP2_MAX_DISCARD_SIZE cap which allows setting the max
discard size value if needed.
Setting a high value for the max discard size is to fix an issue where
some SD cards take a long time to perform the card format.

Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 include/linux/mmc/host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba70338..f1a767d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -348,6 +348,7 @@ struct mmc_host {
 #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
 #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
+#define MMC_CAP2_MAX_DISCARD_SIZE (1 << 8)      /* use max discard, ignoring max_busy_timeout parameter */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
