Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DF1AA78E
	for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540999; cv=none; b=flhrPe/8TCC/Ae8AS91L1Vw+vU54YbTx6KX/mQmtJOHX/TJWQwGkDf634XY0BgjICb4QQOMLp/pmEIjgQ6/oNYVNybiCOjpsP+6ED4LcA/6EBp6Gs9a4vWAhnHd+4lLLc42xN7WsJQniZ+kHb6BLgs49+oDPcnBg5wh6rw58CPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540999; c=relaxed/simple;
	bh=tsGjL3oAXbXazFnaNHNq78HYCtcbKhPU8bS3LUWF9sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WyxkyuHLJgzaq10XM7hXJKAG5etntaayhQPkf3NtnPhytTKMAT0YEYjUTEtJJmqkLeXL7E334UkP0af6HYuS3CubytE3B1x3WuriMnRMgdbGHUhRYJeTt3ryPHQU2LpFJN0uktTxEdfV0brS5hydPAniceLH0CTcCxOMQ8Ehrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaAZ2TEp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaAZ2TEp"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so4037028e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732540995; x=1733145795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZJPVNAx/alEFALNFU1/rflNdzfT+JgwsBAa7B0VlDA=;
        b=zaAZ2TEp6yKRjSJe0i6+pg8+QSPF3SwXjONhVGoc5Y9m8ui0nJlH+qOPl3i67Bk87S
         9j1MJjGPRROS45RqMc2vDG8WNQUjHf3zeSd6lJp2bl4nsQeRWFcNhP47+YitwnnD0dT/
         IayMdOJeIVBp0ANaeb3AEgGTLRA1OiaAlLP3NWzBNwCeozdjzHigKawlN6EMrMkp7EPi
         DfufChDocei73Gns4AF6dObkrHKAK7q70OhUAqewd4yUCwRDNaKIsD78ZrW2Iq2EWUe/
         bNwmkH6QSOqNW5cYT1QRBLfQndwdHfWv+jfhfqCq0CQMA4uBXHjKPFXwFURScD1uhUo4
         lVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540995; x=1733145795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZJPVNAx/alEFALNFU1/rflNdzfT+JgwsBAa7B0VlDA=;
        b=pjm40nMT7Lm3uN/6n8NKLY3KWOFjgo7qYdXkYbiPG/4qUQvbYDjsdJ7O4SUe5t0ENp
         EhVEpauG8PrxYiOxfBTKU+1eSqvv6yMGp9M/IbE3h2G/a5zh1NUtH22Jj0/uhOTHEH8g
         At25XYueW6aZ06p8Hz1H/z1870HVvclgsVM6QK4JD+RgQ5cgvHyif/xG4CXzOP2cPxsS
         bc+5eMdXEnL8uJaLxI/uYW+yfPc3tP949KnKN+w7CMo5MOEHomrVzrU3/fDuoH9psko9
         MNyx+kspJ4Q0zJbpoYH8NJckpBwoc3IEbN7hz9D6Y8xTPfukIIZPx9BKyXdWxDnVyttc
         fGXg==
X-Gm-Message-State: AOJu0Ywpk3c+0tnXYBLmZyxVCGR97jtvJBg4vPlDzDW9lCrpZI8wMStS
	XQhKqM0fJwLy0P5WbVpkUp2AqU8lJGxO/KpjVwOSb+veVziaJ1dKEx4Gd2EeDWzcecB27QZgIg4
	H
X-Gm-Gg: ASbGnctBr3vmLp6Zql08JHnUMPg8t40IZit9gWdgGvex+js+ZBPUsh0XIpRmmbZu4lT
	gyWX0ohXWqV+ZV4fJVPoiQwyFJzzCi71OMSJPVkz9m7YqxkEOwE/pL6xA6hsfKUnWU5O10ZBmsY
	KYkUv3bMw1OXIUP4avRWeHBJxEJY+Elnvlwg6XIsTrLRkFRqU3R2I8Vg4v1Hf0E1CAoM391B7HF
	7dA2a7+ACfoj8zebb4Enz9NzVvjumizVZ1KoXf3beHOeqcgnU4xxwSL6Uw/8GxjAss4H9Y/laaM
	2phtXslRCKqtELPU1NdyId5p
X-Google-Smtp-Source: AGHT+IGOxHk25jTLFTha4OAsOGW8H0e5H22tj6vbvzfjfKUzjryuPdA/e7p3sWP9nnHla+J7nmIvOQ==
X-Received: by 2002:a05:6512:39cd:b0:53d:e47a:1642 with SMTP id 2adb3069b0e04-53de47a1701mr1966433e87.35.1732540995377;
        Mon, 25 Nov 2024 05:23:15 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481424sm1682598e87.133.2024.11.25.05.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 05:23:14 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Drop the MMC_RSP_R1_NO_CRC response
Date: Mon, 25 Nov 2024 14:23:11 +0100
Message-ID: <20241125132311.23939-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMC_RSP_R1_NO_CRC type of response is not being used by the mmc core
for any commands. Let's therefore drop it, together with the corresponding
code in the host drivers.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 --
 drivers/mmc/host/rtsx_usb_sdmmc.c | 3 ---
 drivers/mmc/host/tmio_mmc_core.c  | 1 -
 include/linux/mmc/core.h          | 3 ---
 4 files changed, 9 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 48d3b0aae5a0..0c6eb60a95fd 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -115,8 +115,6 @@ static int sd_response_type(struct mmc_command *cmd)
 		return SD_RSP_TYPE_R0;
 	case MMC_RSP_R1:
 		return SD_RSP_TYPE_R1;
-	case MMC_RSP_R1_NO_CRC:
-		return SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
 	case MMC_RSP_R1B:
 		return SD_RSP_TYPE_R1b;
 	case MMC_RSP_R2:
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 107c78df53cf..d229c2b83ea9 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -313,9 +313,6 @@ static void sd_send_cmd_get_rsp(struct rtsx_usb_sdmmc *host,
 	case MMC_RSP_R1:
 		rsp_type = SD_RSP_TYPE_R1;
 		break;
-	case MMC_RSP_R1_NO_CRC:
-		rsp_type = SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
-		break;
 	case MMC_RSP_R1B:
 		rsp_type = SD_RSP_TYPE_R1b;
 		break;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 45a474ccab1c..04c1c54df791 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -297,7 +297,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
 	switch (mmc_resp_type(cmd)) {
 	case MMC_RSP_NONE: c |= RESP_NONE; break;
 	case MMC_RSP_R1:
-	case MMC_RSP_R1_NO_CRC:
 			   c |= RESP_R1;   break;
 	case MMC_RSP_R1B:  c |= RESP_R1B;  break;
 	case MMC_RSP_R2:   c |= RESP_R2;   break;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 56972bd78462..e13856ab6ad0 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -64,9 +64,6 @@ struct mmc_command {
 #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 #define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 
-/* Can be used by core to poll after switch to MMC HS mode */
-#define MMC_RSP_R1_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE)
-
 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
 /*
-- 
2.43.0

