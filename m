Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED12D8DB0
	for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317773; cv=none; b=Sp/AN5CdGzYRPb2BVeKwFL+YgwtloCtplQHqS18W20zmrLLz6qEsiCR2HSBExXxOmqz0NroRLDq0IzbmGZRbHG6xvBlwVqp15DN+j24plBGp1fNGZxtv5t0bgm9/61r9k5sEs8/u7/OQXMdixdx1BRYv18cJ5kxvq0c26mAxpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317773; c=relaxed/simple;
	bh=N6Q3DV9Hf2gd5Ew9bki/uNf8ROrb8Qv6zbSptgVxae4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZegFQngAArYFhhGM+W6EN1RBVz2rbjdtiwHmqMaPa6IfhquQLHmJNYfpEoty3vYez3pyMyJ77YV+U3wXkYnYX8f99wQtSlPSnjEGfGyoQvtBaNWQbP2G87u0I0/o4pqDrkKBPvjBatTmPwwKzbDMKstCtoXdP0yeytwAl/uQMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=A8KpD5ul; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="A8KpD5ul"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso824595f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1773317766; x=1773922566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl6zJ1Nk20DUYrjnz4TXPBNcE4uS38sMaZmdYaClkFE=;
        b=A8KpD5ulghKvBkQ5O2j1uxHSfbWoEYQX9TIu72fkFPsUUZI7QjjEOcKbdq98hvsSdq
         4nSSfEKVzNtjTNwkGWWH4j8lvaCdz57Q/NolcZCuQu+iBSKJ4+STYb8tlynyWFQ3J/mh
         Oc46000GKibWnnTCDAmE+h1sAW3YGC7tdBgUNEvDcS5/u3I0cncFpOe+H0bDMvtxvcFA
         zUzsgMejiHZIO8JeO/xtavHCGMNWeZUJARvwchLgBDRBkPAO9WTHxdj/Rg38g58mfF2N
         tuUpYCgQjyxQUVE69pIQ38b4wsRh+PFwKM5X0dIhaXj4N6/0wg0Fiuo25+0MrNLt2BQt
         hVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317766; x=1773922566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kl6zJ1Nk20DUYrjnz4TXPBNcE4uS38sMaZmdYaClkFE=;
        b=UuONCOufAiNy6MOEle4tA9uZl2ATk/ZKdB1y6UAf1XzaXK5WfcSysEalVW2phL/Bmw
         gceJUu5faoJp4/EJybLKgd299bsaRGI0PWVHs/B33pPhf9sm4aa6aph0d1Race/J324U
         IY6h/kDHzGwsQ82FUF3D8rzcirdryt3MgdGiwlWfD6QGgr2JXWhZmXZ/ZjQ60/RBsNf5
         JRoVjuzgoCexV8acIKk3K3WvgPccf3WsNncbyDNunfOCD0Az0ovlstf/P++6tCX8xNFY
         kvmYIE5AwHYKAIfwM8C1RRKHQuOXyA2iQpNtzigwyP6KwZdB9vKX9y9yy4zBqbUBaarr
         34Xw==
X-Gm-Message-State: AOJu0YxGyF6xQk2W3IDW0FobvEbyHRJ1tBOygbxcg3MbRBJqFrnIJgNT
	uTjiiOOoe8uYEDDiA1pthFAUNr/8zJPh6w4EMomomBVhSEN2qeYaVcuec7YxrBe+8a845WLF9mB
	0Jz5pSQ==
X-Gm-Gg: ATEYQzxZ0xYe4QlPabRKw2VHuS9Ocj7HRz43fc3GKyF+rPBau80CISpt3jDeyYABBQ+
	lGmH6i67gcCpvb5UM9w0hmiPbAqcjNhzoPrqbcKgkjfNDECUXmcGqYi2Rmwb8n2h1tqHNwuLW4U
	YhxwqgZitAB5F3TscLRpSDXHVR/9Kbol3qeKQD8QB9mxv7X2iK43qaqnr9+gzFuA49x9RYkKWsN
	quj7bd4YWsVweX6nxYxCKT1Zv+J6AC6a8tObQopyfEbj+3HHEL6a/DQe4xaFiMRFwfBTc1JX66j
	CRfzG9VeStpTZbDl5t8Rz1kZeFg0he+5DsciZ6VOKeTN139UtOtLXq7+UVwrjcsH2zrDGXFTvT/
	yGC4sivJlsWpVsiwsZHNPBhJVRK6V9C19iRFjM/rzpNicyxxNCCrB95qVvYWMypvnx9utmtE4yf
	0CYvw3Pcexjp+ogVbmFLMZ934d3A2nPHk8gD9l7KhWgFdDL2BOhuzkSH1rrQZprkMNnvhAbA==
X-Received: by 2002:a5d:5f86:0:b0:439:a897:6515 with SMTP id ffacd0b85a97d-439f842a386mr11340398f8f.36.1773317766189;
        Thu, 12 Mar 2026 05:16:06 -0700 (PDT)
Received: from starbook.localdomain ([212.105.129.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm8139874f8f.24.2026.03.12.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:16:05 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 3/6] mmc: rtsx_usb_sdmmc: advertise UHS SDR104 and DDR50
Date: Thu, 12 Mar 2026 12:15:56 +0000
Message-ID: <20260312121559.19197-4-sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312121559.19197-1-sean@starlabs.systems>
References: <20260305194052.5120-1-sean@starlabs.systems>
 <20260312121559.19197-1-sean@starlabs.systems>
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
