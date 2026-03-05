Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BEB3E0C66
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739660; cv=none; b=r/1oUqHgOH8vU4sAwrd3++huV2jU/xi+7Unj3QEgUR2zIjr7o+asVW8fRuwbg5ecd3hrSTshoA+bwzuOgws0JImYI3GQoU0mY0DlA9fQ3UMoYTiQNnC7xQZgnvw/4EW5Ljd8NDZ4X0jOKeSV3rDYWRi7BLNSD1E/0fINEIr3KJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739660; c=relaxed/simple;
	bh=N6Q3DV9Hf2gd5Ew9bki/uNf8ROrb8Qv6zbSptgVxae4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4dqur+tqUPw8Pe+AVUNbU/c18ejZEzE8mzc1yH76JoF5PM++MV71Azmkv0C9J051MaXvJZ+d81I+0wJCIHaFZ2fobD1aIAXW/od/kOJVVE+hUuwpHbPOhjx27WobqBa9FEgahe2+TQCc7X9cDK0A74bkZXstFYtC14IZ/xuTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=OLNkcY7d; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="OLNkcY7d"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso77831535e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 11:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1772739657; x=1773344457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl6zJ1Nk20DUYrjnz4TXPBNcE4uS38sMaZmdYaClkFE=;
        b=OLNkcY7dNIfTMHaTtJ0CEy59Sqc7iyPvfJGjfhhHc5jDT5ZBQOirzzhvrWaZpV3B0N
         kxyNKxH/W4RIrqd4CyVnZB6zFgnUyhzF+EP8YCaOwIj6UnGRJF4tHI/G4F6k9klNbaC+
         5yp2gR/r+RSRJGEP68GfupeYu7jglsEwczQ1t6qa4F38GFSV6MUABIpf7zKZIZZGE3yz
         HXPttSOHLcZAd1Cos7+irjTGpBfCydORMQyWZ7J1WKlBlzXLMHkU5mgVn4Jm59O1JlVq
         MTGxcmxWeahRQ08WJOSEEF5zEV15nJdPIEM30nx92nIwPRGndQMEbYKgNReN+hRaJvCe
         CyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739657; x=1773344457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kl6zJ1Nk20DUYrjnz4TXPBNcE4uS38sMaZmdYaClkFE=;
        b=Cnh6xsKnoBWfE7yGf4nia5qA1hmhEBLr+QTToeTUVK/pauV27u5KXfbImUWx3s7yPo
         LHMfR3rKk6Xe/fggaHOr4X7mbLVi8innp9j0Fu1OajL3uTuRTcAI2CtldEyN6SDRKDPK
         TfBzgIq9lVM7/JHAjRVUoVhhXCbNJmAV4uaAjANpF+o73LGqJqYLaW6YKaGGPJaz139Q
         pl254sddZdnA0YGFSt0m+XOhPF6WZDJRjEg+/Vhr3Fdm3WrfOVqNWnU8CX9EEJHWVWb2
         rCmbhwCvEGd//d2CndLrxH7mSP3padmlcwO8VCkOizVFcwx+XBXFOddrfYfDTF3d4WJg
         YCDA==
X-Gm-Message-State: AOJu0YynXuXZL+CBeKvCzwu5YZGuoLS/tGjeJ96FKj0LdwUuO9uY4EJZ
	gIyd30hwDh13HdgStJhXC1EoJp1T9p3EMBVqpCU7IMSJ3tgwZWijMojFGXllvbxaH9cHROCY/4L
	kaBfc9g==
X-Gm-Gg: ATEYQzx0McunM9Irwh1vT22sNcs24AUAJ0D5CR1p5EkysvslLsi+BhQSUxZ7xA8AoaT
	8t1wy0N3nLtW729GnryyDNzkJSLId8B1gxvzbKpnxqvqDIf3uNdW0dtD27Re/X3X9RPGwLJ1gBg
	wXH1BpB9m2p3eJBrgLAnLctEZvikA86c0Zx3KW1mQlEtsFkZ5d3lWrviFOJUL4sEFlSxtd4cR5f
	s8rDJ425K7J5XONC/ABnQDqF1QhM/oxMgiebh2XNTGnDXqUtWP1dZkG7JmqyEMzOpBZxHID8/Uk
	x9yuG2AsguLtXWkmrsoAhlfGKPZAGKpAraI4KoJB4Ib9QWsKZfRLrmSc8BHErmMRCQnIYdSsCeI
	G1evQtx7EAj3A6FsOHfDKzLGTJDKPUZZK4yTg5/NRsI6YYKH/ZHfJx3PCqmbdO21Kw8XkfHOLuR
	DX1zhbY7XjESG/ublp8BUqCy9EsoN78Wj51HpM1GDE33KA9bSS5SY=
X-Received: by 2002:a05:600c:8b67:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-4851989ca05mr122090905e9.24.1772739657211;
        Thu, 05 Mar 2026 11:40:57 -0800 (PST)
Received: from starbook ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246fd127sm3265e9.6.2026.03.05.11.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:40:56 -0800 (PST)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] mmc: rtsx_usb_sdmmc: advertise UHS SDR104 and DDR50
Date: Thu,  5 Mar 2026 19:40:49 +0000
Message-ID: <20260305194052.5120-4-sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305194052.5120-1-sean@starlabs.systems>
References: <1ca7b488a11e03b3f107f1829a40cf2c92c7d5fd.1771533586.git.sean@starlabs.systems>
 <20260305194052.5120-1-sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtsx_usb_sdmmc driver already implements UHS-I voltage switching,
timing setup and tuning, but it only advertises support up to SDR50.

Like the old rts5139 driver, also advertise SDR104 and DDR50 so the MMC
core can pick the best mode supported by the card.

Tested: Realtek RTS5129 (0bda:0129) + tray + Lexar 2TB SDXC
Tested: timing spec SDR104 @ 208 MHz, signal voltage 1.8 V (2026-02-24)
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 6be98926387d..8d5ebe92018e 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1487,6 +1487,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50 |
+		MMC_CAP_UHS_DDR50 | MMC_CAP_UHS_SDR104 |
 		MMC_CAP_SYNC_RUNTIME_PM;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
 		MMC_CAP2_NO_SDIO;
-- 
2.51.0

