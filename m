Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87E2C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 23:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A252420812
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658868;
	bh=w96C5JcmLJzPwAqpvSgNRFgF+RlRL5FkxBIIA1WKEbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bMVWb++oAhXgEypot7+PQfwzpHKVE2TaPrRC4qu6Sbk7xVtSiSU7ZxX6IW+utgtnR
	 smKg8FbBRHGjNHgzAvn5Yqakxxxu5X2ruRhk1fKLJjgjN0sV1p9uYxlNFDkEqFdg3I
	 dW1q5AlwZviKUqgR7/Gif0MnMW39OxvYgqEoORvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgFHX1r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732152AbgFHX1p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jun 2020 19:27:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46FF62076C;
        Mon,  8 Jun 2020 23:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658865;
        bh=w96C5JcmLJzPwAqpvSgNRFgF+RlRL5FkxBIIA1WKEbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1Ti9rV/3Ohrg5OcnuiwoUOlCwtAIlxV+oqXuyvtEIdYsjg1/301fzRGgaYhEiBId
         5keuRLCN2Ad4s4kJY1t5LqCnmi3J4Vt68pxFCvLurTElz1jO+HSkADNGDDE8PtQgGI
         mwOYOS8y6Sxf8PWqfhMnk8p+H1TdUFaoeRFSFBcc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 47/50] mmc: sdhci-esdhc-imx: fix the mask for tuning start point
Date:   Mon,  8 Jun 2020 19:26:37 -0400
Message-Id: <20200608232640.3370262-47-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232640.3370262-1-sashal@kernel.org>
References: <20200608232640.3370262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit 1194be8c949b8190b2882ad8335a5d98aa50c735 ]

According the RM, the bit[6~0] of register ESDHC_TUNING_CTRL is
TUNING_START_TAP, bit[7] of this register is to disable the command
CRC check for standard tuning. So fix it here.

Fixes: d87fc9663688 ("mmc: sdhci-esdhc-imx: support setting tuning start point")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/r/1590488522-9292-1-git-send-email-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 445fc47dc3e7..b4336534f628 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -79,7 +79,7 @@
 #define ESDHC_STD_TUNING_EN		(1 << 24)
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
 #define ESDHC_TUNING_START_TAP_DEFAULT	0x1
-#define ESDHC_TUNING_START_TAP_MASK	0xff
+#define ESDHC_TUNING_START_TAP_MASK	0x7f
 #define ESDHC_TUNING_STEP_MASK		0x00070000
 #define ESDHC_TUNING_STEP_SHIFT		16
 
-- 
2.25.1

