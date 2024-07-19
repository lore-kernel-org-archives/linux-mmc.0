Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661647A4C;
	Fri, 19 Jul 2024 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367231; cv=none; b=WCItxIQ3FShoHlcNsHgd9n0BWQBkfpAwPFP95+WpU473k5u2vZS9XuCFWR9u66ADVWBHYswuSUqNjJT8RXzcv8DVxd3X0WwjnSmeA7QO2wofVt7pgWpVfTUv2BfqpaUTI54HFk3TlgK4WI/PdigxZjEsBfjkDBz58wwEQwmqsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367231; c=relaxed/simple;
	bh=EKC8vxwZdPdFVnf/xaq9SKigBmIV5g23J/ARvrurlpE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8PP5Qywxt2w0abCUuM1qLzc1Rub7zS3sf8XsBypCaFElObEhIfzZNk2MNtFKRdaA5lWxGxypZ4F0vszFZmVSZciqfUic8slTwthKAU1QDTdPtqHVUoc7QUhQzn1Pd7rT8Ty4gXUzE4NQLGXP1BIjWsu+2No9/bq6PnCoscPkIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=px0qfYkG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="px0qfYkG"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J5XV5M0148411, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721367211; bh=EKC8vxwZdPdFVnf/xaq9SKigBmIV5g23J/ARvrurlpE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=px0qfYkGLokDDTfT6Al7u4JUV21kvnxNZ+klMw/9MJXsCm3s4nkIbFFisZaAk8UFe
	 Ys5GJlUvr98Kti3suJL2072qeC0Sl3FxZvr9Mmr4nkkF/g47MDY1OVXoVPu4B+WFjw
	 tHolYOcycjhLT2kULioN5OBguh0QJOzgufUwxousuoKWeD295cBt3rlWYJ3vP1B3ml
	 cTUJpi1329B+/00N5lXq+QMmmDleU2C+5PzYgjqcAzE0ZkbSnNsLVWdfOHEEDJdlQ1
	 d4VguPvXzEb9dPuSra3GSuGxBcXrYTb7rtS35V0SmKn2TlSoUWupV6HKOt7mofLRgh
	 PnL6sl96Qi21g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J5XV5M0148411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 13:33:31 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 13:33:32 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jul
 2024 13:33:31 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <ricky_wu@realtek.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ricardo@marliere.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
Subject: [PATCH 3/4] mmc: rtsx: make Realtek sdmmc to support SDUC
Date: Fri, 19 Jul 2024 13:33:13 +0800
Message-ID: <20240719053314.1636649-4-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719053314.1636649-1-ricky_wu@realtek.com>
References: <20240719053314.1636649-1-ricky_wu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Add Realtek sdmmc host to support SDUC
Send CMD22 before normal read/write when the card is SDUC card
Add MMC_CAP2_SDUC to caps2

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 6 ++++++
 include/linux/rtsx_pci.h          | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 7dfe7c4e0077..919aa0454345 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -839,6 +839,8 @@ static void sd_request(struct work_struct *work)
 	if (!data_size) {
 		sd_send_cmd_get_rsp(host, cmd);
 	} else if (sd_rw_cmd(cmd) || sdio_extblock_cmd(cmd, data)) {
+		if (mrq->ae)
+			sd_send_cmd_get_rsp(host, mrq->ae);
 		cmd->error = sd_rw_multi(host, mrq);
 		if (!host->using_cookie)
 			sdmmc_post_req(host->mmc, host->mrq, 0);
@@ -846,6 +848,8 @@ static void sd_request(struct work_struct *work)
 		if (mmc_op_multi(cmd->opcode) && mrq->stop)
 			sd_send_cmd_get_rsp(host, mrq->stop);
 	} else {
+		if (mrq->ae)
+			sd_send_cmd_get_rsp(host, mrq->ae);
 		sd_normal_rw(host, mrq);
 	}
 
@@ -1445,6 +1449,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 		mmc->caps2 |= MMC_CAP2_NO_MMC;
 	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
 		mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
+	if (pcr->extra_caps & EXTRA_CAPS_SDUC)
+		mmc->caps2 |= MMC_CAP2_SDUC;
 }
 
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 4612ef09a0c7..a36c87a52f39 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1228,6 +1228,7 @@ struct rtsx_pcr {
 #define EXTRA_CAPS_MMC_8BIT		(1 << 5)
 #define EXTRA_CAPS_NO_MMC		(1 << 7)
 #define EXTRA_CAPS_SD_EXPRESS		(1 << 8)
+#define EXTRA_CAPS_SDUC				(1 << 9)
 	u32				extra_caps;
 
 #define IC_VER_A			0
-- 
2.25.1

