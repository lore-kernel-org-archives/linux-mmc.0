Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C117BA6;
	Wed, 27 Mar 2024 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507579; cv=none; b=rBuFRLkP9Vkjaf3tXkHdlw9nBCjBGPRcl2loHtEGLU0ihYPbbRMMmABYlxZYCybf0WCS75q529j/HNcVbVkI3zjD9F013FXqBuxA1N1+WEOX+hYk6JuuTfP1LrOVcuH+pfrvGPyV7HaxoUktKEmWpVesdBlHZc8ujaPhjMqojKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507579; c=relaxed/simple;
	bh=azgjSy85/wUZ8NadfZuqevl4MalJBeHpf6RNHzPsmSo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K3VQrN8yev9YcbePnndTlbyj9tB9bevfslrkICq7TdATxR6HNXd799D0IpLAVnNf/p58iT8qV+pOnNOvGoaD2xsCEiZPR+2Kg81P+GyHyB4rJ9hvBKJsisivrpY3ObfHseGK01nSn+QRA8ZK2F63httDUV+WPAmNpA0JPSAogBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42R2jqAP3307072, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42R2jqAP3307072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 10:45:52 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 10:45:52 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 27 Mar
 2024 10:45:52 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <ulf.hansson@linaro.org>, <ricky_wu@realtek.com>,
        <wenchao.chen@unisoc.com>, <ricardo@marliere.net>, <marex@denx.de>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: core: resume not check card exist before powerup
Date: Wed, 27 Mar 2024 10:45:45 +0800
Message-ID: <20240327024545.138351-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

_mmc_sd_resume
add get_cd before call powerup, make sure the card exist

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/core/sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1c8148cdda50..35e036672cfb 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1750,6 +1750,9 @@ static int _mmc_sd_resume(struct mmc_host *host)
 	if (!mmc_card_suspended(host->card))
 		goto out;
 
+	if (host->ops->get_cd && !host->ops->get_cd(host))
+		goto out;
+
 	mmc_power_up(host, host->card->ocr);
 	err = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
-- 
2.25.1

