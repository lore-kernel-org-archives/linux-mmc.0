Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B21DE3B5;
	Mon, 16 Jun 2025 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750056756; cv=none; b=QOoC0bvGEMnr1pZFBijS/AYLi3gi+uOKk3S9WX5xkKN673skGdqveTpz1lfbHtEwpGQZDucCW5SCx70s2pXtRR9SedIDGRlz3aUzbfiu6RBIQViDeWPdHldRlc2jgTQ4MDi17q6jXBTBxgyOrUaQhl0F+t8qag0bPJ3dpgeJNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750056756; c=relaxed/simple;
	bh=c3Abq9r0WKT5CRHfIudmhf9++9t9ilHe9MWq4ef4008=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DdQi915Oqvb37HZGEJdInRwyi7OlPi1KTQr+2E5rDaP3BaaT96t3Q2Cv1ivGkW2sMeJdXuXO5tVpgXrdpDpEtmQPpulP9M+G4Y9umrVWyGq2emyij8BEPiKaxz9ACHcq8Zu039gs672BUB+P7k9bBAKCSDptJRpqQ1uvno7V7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ezob7mt/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ezob7mt/"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G6qOSX1028700, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750056745; bh=uQJRs8JPrDgseyBh1Kdw8v61KB5kB5LLlsaWCnTBDjY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Ezob7mt/vaBIPrwIeexPyCbYK36eBN+hxBNraVuWobVEIJVL9I1cLM05QNC/PWBQs
	 t03JBTBlCtG2ZNWZTeLMmCjua/1yNlP3iFGg4e3tVVPHHl8c5oZDpwZ5CsRzBzuQ//
	 hugy5b/e7hnnzBDIxw+ZqbqyBOxJudOY0D3dlFjS+wVGq1tAzmqddoh0E+rGBW5fyf
	 4jy6WJGprBzG2OMH2iFADI+9wUxmW4LivgrTAQnHFhAuwq96998fMibUdLm6/pVCcK
	 BC7Yj8JsmJ1CU+ReaFW89tldkrsqvxKmSvDCA3pUlnA4pMkrmX1x3CDXTnIX9GP84O
	 l0hO1hiq9BlhQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G6qOSX1028700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 14:52:24 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 14:50:04 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 14:50:03 +0800
Received: from localhost (172.22.144.1) by RTEXH36506.realtek.com.tw
 (172.21.6.27) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Jun 2025 14:50:03 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <ricky_wu@realtek.com>
Subject: [PATCH v4] mmc: rtsx: usb add 74 clocks in poweron flow
Date: Mon, 16 Jun 2025 14:49:56 +0800
Message-ID: <20250616064956.1846258-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

SD spec definition:
"Host provides at least 74 Clocks before issuing first command"

add issue the clocks when power_mode is POWER_UP
and stop the signal when power_mode is POWER_ON

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
v2: remove delay 100ms in power_on
v3: Use switch-case instead of if statements
v4: re-base on the patches
https://lore.kernel.org/all/20250610111633.504366-1-ulf.hansson@linaro.org/
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index c1fdcc334c8f..239eb9acf7a7 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1014,6 +1014,7 @@ static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		unsigned char power_mode)
 {
 	int err;
+	struct rtsx_ucr *ucr = host->ucr;
 
 	if (power_mode == host->power_mode)
 		return;
@@ -1031,9 +1032,13 @@ static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		err = sd_power_on(host);
 		if (err)
 			dev_dbg(sdmmc_dev(host), "power-on (err = %d)\n", err);
+		/* issue the clock signals to card at least 74 clocks */
+		rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
 		break;
 
 	case MMC_POWER_ON:
+		/* stop to send the clock signals */
+		rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
 	case MMC_POWER_UNDEFINED:
 		break;
 
-- 
2.25.1

