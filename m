Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D436D;
	Mon, 21 Apr 2025 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745205347; cv=none; b=cvH8UZqVcz5JYo4R2ZDtBG5iN7ELsC9sZRlITY9nbuLKqlvpZGaxrbmQc375qkdUjm7WGZOFtGoViwOAeBVfL5GAWtpwkx9rlzv6bN7CSg1QA9B98MhJtVYT8xyU3K8qPy4n0iqOvH6VMmgh+bcv5q+wtmzp/ItwOdqdTqoulR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745205347; c=relaxed/simple;
	bh=Xss18Csvtjq6OP5uIXnOSn0c/AN+3lw7xL7NwaMHPQw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kt9R5AaM2v0PnqnwiSHl4QA/Csi7ttYN45qZAd0IywmnxS0kVgfwmy0/TCHqsLFdV7q13EwTB3B7UL+62ioDueBZ+AFszTJKWgcmryw4tKZNemShbuJQXDyhYo1szgkitTpM6h+2j2zarSPl4t9ESS79M0a/xt4Kt1eFPZuGRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Uu8aWpE5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Uu8aWpE5"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53L3Fe0U21406473, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745205340; bh=Xss18Csvtjq6OP5uIXnOSn0c/AN+3lw7xL7NwaMHPQw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Uu8aWpE5mc6xtRcI2rMcK6lefjOMWLd/tQHYjGu37/4D903pGN2p+7pmxHATAM1sj
	 RTBW0kkHsggMG7yt1izYmIm/oRqwkY6FCm2AMgaWsKeHthwCXzvdfaHAbO616kwzYk
	 8TCmgRsah4Dv9vNn2AHgo0iqwHfkLQDaZ1AvO2E/7rBbhCm9zVX9zP1SSQH5mrUuiK
	 CY2zx+5kXdfxm55cko5Zuo56GK+miYQuWbYM9d8LLmKGa3U0FqArs0i2ej2hqYQunE
	 zCcvGlXJ0dUAUsi6zPNs9aNHGwgJh6oUCNIoHMfPw3rz8/446nLmKPXz4+ar8lWZT/
	 bMpchr0i9CFGA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53L3Fe0U21406473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 11:15:40 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Apr 2025 11:15:41 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 21 Apr 2025 11:15:40 +0800
Received: from localhost (172.22.144.1) by RTEXH36506.realtek.com.tw
 (172.21.6.27) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 21 Apr 2025 11:15:40 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <ricky_wu@realtek.com>
Subject: [PATCH] mmc: rtsx: usb add 100ms delay before power on
Date: Mon, 21 Apr 2025 11:15:36 +0800
Message-ID: <20250421031536.1173373-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

this delay make sure the last time power off did the discharge clean.
During the card recognition process, card power will be toggled in 1ms，
and 1ms is not enough to discharge cleanly

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 1edfe2acf809..e5820b2bb380 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -952,6 +952,8 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
 	struct rtsx_ucr *ucr = host->ucr;
 	int err;
 
+	msleep(100);
+
 	dev_dbg(sdmmc_dev(host), "%s\n", __func__);
 	rtsx_usb_init_cmd(ucr);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
-- 
2.25.1

