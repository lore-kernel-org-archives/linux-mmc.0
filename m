Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281846426;
	Fri, 19 Jul 2024 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367230; cv=none; b=mJjc01vmiKKq6xRMXLjTjqEDwHJipwL0gB5bGyJJNpfj7Jkdy5pJbghcvRu6MUAvFfBeSCu55+ktafmhGxAyh15JRu2Xj5+rTI3IRz+haKpoiOpkPp9qGIk6a6z8ZXGPGOr7s7sh2cVZ+kWv9EXAll80KW4pUNWkqJ30ANH6120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367230; c=relaxed/simple;
	bh=IY2J+0vdYsWdvNxxBAMhcfSEOBsFNWQkJPdds8HbbeQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXeS17vgg4p6qBuw17GVeiiPNPwRi6TT+3A0hYEmweWoBXLnS+3AjgWxKwy4q/adPUHZVAlk1lMtOu2CZI6qfWL7vzYfGAmne6YwdBv8lKPszpgXFPyOG1Y7uMROhEQ/aNw+jCuUK/VyEqPqyk2swz259f3Gzn25Af5yHEg7KEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cltnpI3W; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cltnpI3W"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J5XZHl8148586, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721367215; bh=IY2J+0vdYsWdvNxxBAMhcfSEOBsFNWQkJPdds8HbbeQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cltnpI3WtBNq3Zp3BnS50K2F+LN2UbVHX6SFCkWIV3EB5LpbbSdY9KgkU0RD6Ql/c
	 L06qXJjg+/njLF0T9lRVzoGMnA8zCP9v++y3ITq0wIAqmSIAJYcqpk3uSe9CJMml2A
	 qqNbK/GyJ8dgd7g1OVW4x2OYHjX6vjg8J1g1ZyNCPqOEmcm2vKAq61S6WkNgsKuMLF
	 Ib0ojFU83qBX4huOq1eEc76+8+x/WRi96zNhdlmw6Ay2WtPkvvHDeIhjU7qhHO07/F
	 gwM5zV+hfTYKMdYClehlZNrjt/1WgTgM0eI18KH3/eL5ghx5iUKaId8I2ZINGxxGfZ
	 1SpRw0X6qG3Jg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J5XZHl8148586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 13:33:35 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 13:33:35 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jul
 2024 13:33:34 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <ricky_wu@realtek.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ricardo@marliere.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
Subject: [PATCH 4/4] misc: rtsx: add Realtek card readers to support SDUC
Date: Fri, 19 Jul 2024 13:33:14 +0800
Message-ID: <20240719053314.1636649-5-ricky_wu@realtek.com>
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

Realtek Card readers to support SDUC
RTS5227/RTS522A/RTS5249/RTS524A/RTS525A/
RTS5260/RTS5261/RTS5228/RTS5264

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5227.c | 1 +
 drivers/misc/cardreader/rts5228.c | 1 +
 drivers/misc/cardreader/rts5249.c | 1 +
 drivers/misc/cardreader/rts5260.c | 1 +
 drivers/misc/cardreader/rts5261.c | 1 +
 drivers/misc/cardreader/rts5264.c | 2 +-
 6 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index cd512284bfb3..020cc7f7cdc2 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -331,6 +331,7 @@ static const u32 rts5227_ms_pull_ctl_disable_tbl[] = {
 void rts5227_init_params(struct rtsx_pcr *pcr)
 {
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	pcr->extra_caps |= EXTRA_CAPS_SDUC;
 	pcr->num_slots = 2;
 	pcr->ops = &rts5227_pcr_ops;
 
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index 0c7f10bcf6f1..11598adb03c6 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -686,6 +686,7 @@ void rts5228_init_params(struct rtsx_pcr *pcr)
 	struct rtsx_hw_param *hw_param = &pcr->hw_param;
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	pcr->extra_caps |= EXTRA_CAPS_SDUC;
 	pcr->num_slots = 1;
 	pcr->ops = &rts5228_pcr_ops;
 
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 6c81040e18be..10c6b97a41e9 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -540,6 +540,7 @@ void rts5249_init_params(struct rtsx_pcr *pcr)
 	struct rtsx_cr_option *option = &(pcr->option);
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	pcr->extra_caps |= EXTRA_CAPS_SDUC;
 	pcr->num_slots = 2;
 	pcr->ops = &rts5249_pcr_ops;
 
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index d2d3a6ccb8f7..b35914af593b 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -586,6 +586,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
 	struct rtsx_hw_param *hw_param = &pcr->hw_param;
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	pcr->extra_caps |= EXTRA_CAPS_SDUC;
 	pcr->num_slots = 2;
 
 	pcr->flags = 0;
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 67252512a132..b4faf831ecbd 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -766,6 +766,7 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 	u8 val;
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	pcr->extra_caps |= EXTRA_CAPS_SDUC;
 	rtsx_pci_read_register(pcr, RTS5261_FW_STATUS, &val);
 	if (!(val & RTS5261_EXPRESS_LINK_FAIL_MASK))
 		pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
diff --git a/drivers/misc/cardreader/rts5264.c b/drivers/misc/cardreader/rts5264.c
index 8be4ed7d9d47..bd2ae5c525fb 100644
--- a/drivers/misc/cardreader/rts5264.c
+++ b/drivers/misc/cardreader/rts5264.c
@@ -845,7 +845,7 @@ void rts5264_init_params(struct rtsx_pcr *pcr)
 	u8 val;
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
-	pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
+	pcr->extra_caps |= EXTRA_CAPS_NO_MMC | EXTRA_CAPS_SDUC;
 	rtsx_pci_read_register(pcr, RTS5264_FW_STATUS, &val);
 	if (!(val & RTS5264_EXPRESS_LINK_FAIL_MASK))
 		pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
-- 
2.25.1

