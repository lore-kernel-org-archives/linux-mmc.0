Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CD23EAB0
	for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2026 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994595; cv=none; b=MKZQJMFu1aDq/j1ykb3xQk8JFY/woVrIqVn/TAWKfxdj8xLcQaPFF3b2qRKXYyZcHkzc5P79q2bPECJtvUdkQZccPmQofDAqbyN/jnXneczdgMGI7/lzVWYe43fkKIoqM7fcLNMVFS/GFIi9ob3e/6IkoC7yvGfErhJZ4Yx242U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994595; c=relaxed/simple;
	bh=SULlwrLYeHAjqGLk9FtKoUcVp0Tb9Q3WwZW1/0ymmyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcORcKnvVHfiggZ8ar+R6tTRCNWCJNiuMFeTIODjIVMo4KSskl8lQs9+01Tqqmcglbs3q9moWxaerMCdnlJb7vvtM3/XMsdUb531wWdb4RHnGoNjYZCyMoqla2BJf0Ke4FDbmcXXHWetpBGCeaON1fzSWfYXMf8zPXJaB2Ucjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJkGFlhe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJkGFlhe"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so2739884a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2026 18:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776994594; x=1777599394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSBISmHMXjpT1nha7+dc7Az7PrdCp45jgNF07Auzfbs=;
        b=JJkGFlhezAj7vmsTfH+nDK9vkM2RJPS5ux7Zo4etSM9im6I/MTsgyG7QwedtP9x8Mv
         Ty+UZnLqIFr1j+pfvcPvINVpWquM2vkQsAomyalnikwGn+AgD62dm6hQ1288TPro+D1B
         ocKsiuMNkWwrSVKdrjUXtruc2/hclMCt6EckVUvi3gK2w2NXrZGHto2f2X9QnRX6sdwG
         cjur3bDGvLCI6FXogg3XE/eN7JISfS4UTjbEZKv8sN2BJXcVnjf4Lqz/A8VWMYa+xiUS
         LvXWsTxBqlx3U3hFpkITQrgwUiijE78F1Syvwo2Y/7taH3SeVkFA4kMrpj7sXQpUs4rO
         BAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776994594; x=1777599394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSBISmHMXjpT1nha7+dc7Az7PrdCp45jgNF07Auzfbs=;
        b=UBikC96ZcvEjqUUcu0yziXGQGLo6vPUZPAlhuaN1qiMXXqzRCqcJBfHmAd/Ai55BcT
         xisaLxq4Cibw4Eog3A4NXPoMQZ75FfjseqCsUsKgtsDdhFFRYvPm1hU+w6SIKiPcUZf/
         mX4TO8Yeyqc5WSjUnLD3iI6tpECyTuLpOe34Wv91UEF4UmPYWGOb5UWPcCUcjKe4NBmK
         TGXjhVWsdSNVcHD3/TOBcl36tqj/qD/JZ3aPo5Z9E+eRoUylRzw4l5GFV5m2YOG0ReKE
         0xUwPYUFhWXP4Kwz5J4USm/Es1x5dfhXdHRmFDBfkoNjYwahEbQfA3AooMAmDmTUmbz/
         j8SA==
X-Forwarded-Encrypted: i=1; AFNElJ+smPHcq5KTlWU85/Ejt8M6ANr7glvr8T+h3k2MrlZDHQnO56wF41YYyobhikLa7s6AlRchygRV2cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeynAGQSIw5dkUlMXqks/XaoNZRWzb5TkDcC0AktOBBaV33Xwv
	qfePR8mrSUJI2Cp1OXlx81O83MdYcNCA8nRSiU+yQkGzzc34F4iElKQU
X-Gm-Gg: AeBDietefvMI2P1jDh8GCOQk4eW6noboLCDJhuEgSjimTyQ17Lab1ebMywY/fKsPOnN
	NFIwNhi9uI527W9IOe/jKCbdHszgKF2qcO4u+QLE13MxtnxJKEySoX/KuNbxRQ/ito+xA2jnsr6
	qqzUltpFgAL+LB4o1o3N8kJbWt0AlbaDAk/jLCA/Hig1MHLzrO3WFmo5XxVvAfejkDQZG6j57de
	cTfUNMwefsbZU3yxQ7ed1EegDk23CaotLXB1bomPL/PmUZ81eUPbGrLl4sNUn833aP9jyv9JIMw
	DRBeQkQOyMzO7VIVQxbGfu7q0OS9j3q0oEzrSRCQioJKSEzXT6VwIZ/FWvExh0/ZLlw4hxJIC0j
	nN0EPU2hVObMyTmsgyOgGs67cFmts2t1gMZslDZn1hJ02ReF65aeF3BA9fx+y6QcMP6pmjOOKWS
	/W26jw3GP1gD2ql1AG687kvDZQbGQZaSEdeA==
X-Received: by 2002:a05:6a20:734f:b0:3a1:90fd:dcd6 with SMTP id adf61e73a8af0-3a190fdf242mr24150696637.31.1776994593698;
        Thu, 23 Apr 2026 18:36:33 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797702faaesm16187056a12.23.2026.04.23.18.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 18:36:33 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Kamil Rakoczy <krakoczy@antmicro.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Date: Fri, 24 Apr 2026 09:36:14 +0800
Message-ID: <20260424013615.470325-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
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
Change from v1:
- https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
1. use fsleep to replace udelay
---
 drivers/mmc/host/litex_mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index d2f19c2dc673..ac0b47604c02 100644
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
+		fsleep(SD_INIT_DELAY_US);
+	}
+
 	litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
 	litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
 		      cmd << 8 | transfer << 5 | response_len);
--
2.54.0

