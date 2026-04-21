Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9C1DD0EF
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739870; cv=none; b=NXDSmgdXavQ989zM3xytIoZZ2JUHacVs8gypttg9mLay7+p80Wwr86MfkBg3JXwDvR02Q+u0yjYs+TH+5RoULmd713XNHaExFcJ3Ea9RVdq8uCnIkwBaMADuhVFDtJbClxAq19TlKN8W/UaSF3K4ESwcX7ZkONCJgUmMFId9JEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739870; c=relaxed/simple;
	bh=cmRVTAvX9wr+QcScrRAUGWAsOLTeS5OCKNRy1RLhclE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAwfl70KUUaZc3+rBGAM86sB6gYORcLsHSpajGKCpTN25ZCwrctpt9iiA9ur1QM/DlAMnFcot9usbiFiLsgtNMcz5h6/xxTxgAmoaCzZyz4lGFo7THIASmJkMSaZ5g5QAL33ZPDR1ie2Ic0SB1Rp5fJmX04Q7P3tBiyUU+R6fJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4o2Ut4Q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4o2Ut4Q"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso2264834b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2026 19:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776739868; x=1777344668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bRxYIOqSnJmWzxqs4bJD7O6X9Bp8SCddV3M/HzCCV8=;
        b=Z4o2Ut4QiCCb1LX6Gs7Vun54ARHPQAuToQt4NiG7Z7YemoOwl7PqngYF5IwVhoidoJ
         rNzzLlqThEs/g5273FnErQZ6FqaMwisINS4j2NpRprcZFR2RLnenrMP8nkLyg0q2sA+N
         oMMEeGn5tbw8JdEqc8FAdIiqImNog0p5Y+9LX1Ey3Kd74myxbesED1aH8FgWwoFJIFVc
         6/DBFtAG+ibnNEJDRnccuoBR1M41G/nUhHK2p8ZhUHPA37x2q1J5GWROTAjqhQpVTIUQ
         Q2iv1q5LovHWx05BPaVIue9fxUosCiD4LZK2/bCjo7LMkxAg4DDxl+L48qZ63yN7itSW
         ON7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739868; x=1777344668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bRxYIOqSnJmWzxqs4bJD7O6X9Bp8SCddV3M/HzCCV8=;
        b=l9FJnYT0rHeiR1RWzgosJL3mTZpfU+vZEuEXkEbWDPPJSnLWuNxcRxjdl4Og61rXsb
         yq9hMI4f7BktIBWX3dsKUX2OEK7H9H/mj789KKqJ7EJaCNQAnZwF4HRWo0etRU1RYGn8
         Ty8TGYLCLwOUXt85A4YkTDl2lhzs8esL+DZzqEtIFJ855ZjMfxnCAw6QJgYV+vwYu1FJ
         zP8q7rtgYkm5s4ZaHvJ3rmW2HQTZxLajbOqhMPuVYP1JYZ9IJBt2InGqHvDJDdJwWIKy
         3PToR48XISOsMODm08/tSqP48uIpElbYOCjRbqtdHUS0ueVptoXpRqmm0BtRbnriunkj
         /2/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8+4yXaW3lYKBayutSesqiP4EiGIW5tOQdhxeMeGUZGq9vyREgAsgVLcIgKtr4G88WMzgmbnw0ayZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHfHLISTZzPAp1Eeag+jdRfc2DeC4TwmpobCsvvf0anRY/PzY
	oZGrFDf/ghM5aRTXzmMMMkvG03+mXQIsurvVeaoJcb+0OO4ywl0m38lB
X-Gm-Gg: AeBDiev2yvohrJb9PEvo3lHyPyrVa1SiHEu45+Fr01VW0LNd98Ybm743chXaJlGFHH1
	ymbG/9W1TG7h84BIvrfkyt1UaH2pDukQsnmiQCOsWOT/+tcS6kmoaszWHKxbKAKHGzuEJzrV/Hz
	g7lQtYWaNugmLwMsCDYS6k7iozW0SW51d1dKzDgZSFbUmibjZau9s0DrrSuQNlcc0PrBU8zbj8X
	VMRfTmmlU1lzZoI0AEPFh4e0XlevVOBUmoEcBGmodTz5VR31dQ753GEZrJmsD+R8sfpjJX4LFuK
	aHWr4AvUgccryrbY2UDclXFykjDWx1hgCvTAPwpjw8VCptULeZuDNcgtnS/tCEUfd3lIsG7Ij2/
	2QzWKRuU7TWXEPPYeqbpVcV6sFH0wafzm2E3B4K+xyi3IEGxq/ZAnzqDVpDJZPkkoxzJsdjNg/g
	Miz+AMx/hHHlSQ8bl3S96BgtgkoqFZO/+f7w==
X-Received: by 2002:a05:6a00:2190:b0:82a:76ab:3279 with SMTP id d2e1a72fcca58-82f8b32345emr12563208b3a.4.1776739868186;
        Mon, 20 Apr 2026 19:51:08 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm12822882b3a.20.2026.04.20.19.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:51:07 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Maciej Dudek <mdudek@internships.antmicro.com>,
	Kamil Rakoczy <krakoczy@antmicro.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Date: Tue, 21 Apr 2026 10:50:51 +0800
Message-ID: <20260421025052.755471-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The litex_mmc driver assumes the card is already probed in the BIOS
and skip the phy initialization. This will cause the command fail
like the following when the old card is unplugged and then insert
a new card:

[   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
[   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110

Add required clock settings and initialization for the CMD 0, so it can
probe the new card.

Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/mmc/host/litex_mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index d2f19c2dc673..dde9b491a320 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -68,6 +68,9 @@
 #define SD_SLEEP_US       5
 #define SD_TIMEOUT_US 20000
 
+#define SD_INIT_DELAY_US  1000
+#define SD_INIT_CLK_HZ    400000
+
 #define SDIRQ_CARD_DETECT    1
 #define SDIRQ_SD_TO_MEM_DONE 2
 #define SDIRQ_MEM_TO_SD_DONE 4
@@ -99,6 +102,8 @@ struct litex_mmc_host {
 	bool app_cmd;
 };
 
+static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq);
+
 static int litex_mmc_sdcard_wait_done(void __iomem *reg, struct device *dev)
 {
 	u8 evt;
@@ -128,6 +133,12 @@ static int litex_mmc_send_cmd(struct litex_mmc_host *host,
 	int ret;
 	u8 evt;
 
+	if (cmd == MMC_GO_IDLE_STATE) {
+		litex_mmc_setclk(host, SD_INIT_CLK_HZ);
+		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
+		udelay(SD_INIT_DELAY_US);
+	}
+
 	litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
 	litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
 		      cmd << 8 | transfer << 5 | response_len);
-- 
2.53.0

