Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7C3D564B
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739662; cv=none; b=G24lKrrycYgcm8/6+MJbQlvSNXEYBAvk2KgRkgqAoxXbh1bEKLKs2K2L8jKBLTlAUToAuXD2PlJJuLdFZzjgkuOQkquGvHZ6874h7dgYX5VP1nN58esQMYvBYc9HafOJM4UZUSK+kIIz8/29hiazCT9zjxzi1I01oV+i8iTNTHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739662; c=relaxed/simple;
	bh=/QGGg48sn9sKA1F8TWZlfBuzKMx3jTk/2UYyPAjLJh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9SHWq007NpzDsnnLNlX8vq+ruZ49WUJ+Bwat7ucDh/E8MaiDlReD5E8JX94UD1XK+O/aIU8J/1IbOHafAxwgABVFr4wxKrc5zgc8EgRjkzNxC1Y9k+0QqQj13fP9n7rWmJ4LtwHTkHBiwP5taYvQln4e3/FPL/szjBqfgqeseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=KwYKcoaF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="KwYKcoaF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so96108795e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 11:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1772739658; x=1773344458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq4shlsXpyVXkpp2qtgEESfDg63q+osNt2mDVKvT2FU=;
        b=KwYKcoaFtp3Cc7lf2nPF2UwHPyq9mWXgRzRnDTMxFl65pW/1WC/JI35zssXlWKmPca
         xNISZnQFeVn5qzYImlYn406We5i8C0TCYSKblI/m6fHIDwytGn07cscaKJgPlrlVEqz4
         VBUMjRa28JVhQpa4JchjiE/JV7zSfkWV3gxE8k7gY11maolJkZiDXkzwnhrHgehbjQ1G
         kX8OxUdwNgihNHL+sAxzrU7eGS5px87nd1CHwCXr4sz27Lp93/DbGzOZHK8OpVQzrhjP
         iObss4qH66Vq0/RGtoWmR9/0PIkyS0ejBPLqhGp2X/DO9skaNA/fiVXFSTV74PFuUb/O
         oY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739658; x=1773344458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kq4shlsXpyVXkpp2qtgEESfDg63q+osNt2mDVKvT2FU=;
        b=OCofaLj+cGEEnYPzhLhtCQ5Ey+qXrt5in94qAeMCfSTda9AxzkxVNTz1RFZtE0wb/F
         cegmrJemk1vr5wL4CuccRn1aLN0iI5oQVNJCrGHhtonFpVOWdS+AobC7EdFFmF8JQ8Om
         nDqdjWPogSS+E6J7Xs3T0PX9Ftft7B5kHBu7iOBvNIZEpbb+Df53IvJvnaaqJukhWVE8
         Bhw4HjItt6hnUtPgKlIkbPFSniqRrvjhIUi181IQHQ7sX9OnN2z5ek74dWaQ05nAlwnj
         yrieJAx2oM7SaMU/M3swaC6CwnMfyJRM5FHqjgnqO2k+cuoL4GrsUVM7pQlatv/vqmPO
         jiVg==
X-Gm-Message-State: AOJu0YyKDh67+7vc1vbK19BtUqCg7NCs06uzWi5Yxd5bIuLbpC/FMMbp
	2fZnd+pgqC4OJ8mcpknG+mOKgqMFSkXieioNw63LUS5H83OjdZFjPEYjSEKUCG1OnZwQg9v0F1R
	eIizl5A==
X-Gm-Gg: ATEYQzzu5tBwKi2VV+NnC2yzU/Oq5taw4n96enda8HRzbKj9DH6YnLAIv/zM48oroCV
	z9TEHw0I2RIeeeb1Zgm6AeQaXBZkfJ8JT4hAes9AhzolOatrUf1VqVxovcTzOsB4cbUayPy0dIB
	BDbKkRIT826ej9dW9cusTLmKs+NZLG6iFPlE/62sMo+tIs57OP1h37GQnPrSdRQe+tA6GxGPHjC
	3NeHzLfFoCegRLFa+jFdtmtoFkXGIDAuWtQJDn4BanlrQuHXjygvuDg0NpEjONKGAVSy78SugBs
	x2U4piwnBD5ygh5EbN+8tD+nW508wf7w6wJP++UlW+oszKpdib0bBLU+dMLux0cZuyWWJu0hIaK
	uedg5xFyWbAT1j+lGbwLdTql7bCjytAC+ne6WKAqwRPptFkc+uBZ/c+edI08WjVVUOngvvdTqH+
	hF2pVsL+Eq5KnDmao7siJb9xr5fN2KUKnEk3yTvmkXMyc/EQ2+EEw=
X-Received: by 2002:a05:600c:1e8c:b0:483:79a6:e7e1 with SMTP id 5b1f17b1804b1-48523589b03mr12597475e9.7.1772739658401;
        Thu, 05 Mar 2026 11:40:58 -0800 (PST)
Received: from starbook ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246fd127sm3265e9.6.2026.03.05.11.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:40:57 -0800 (PST)
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
Subject: [PATCH v2 4/6] mmc: rtsx_usb_sdmmc: program SD30 mode for UHS SDR12/SDR25
Date: Thu,  5 Mar 2026 19:40:50 +0000
Message-ID: <20260305194052.5120-5-sean@starlabs.systems>
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

The driver advertises UHS SDR12 and SDR25 support, but sd_set_timing()
only programs SD_30_MODE for SDR50/SDR104. When the core selects SDR12
or SDR25 this leaves the controller in SD 2.0 mode.

Program SD_30_MODE for SDR12 and SDR25 too.

Tested: Realtek RTS5129 (0bda:0129) + tray + Lexar 2TB SDXC
Tested: timing spec SDR104 @ 208 MHz, signal voltage 1.8 V (2026-02-24)
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 8d5ebe92018e..62f6b3f76c7b 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1231,6 +1231,8 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,
 
 	switch (timing) {
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_SDR12:
+	case MMC_TIMING_UHS_SDR25:
 	case MMC_TIMING_UHS_SDR50:
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1,
 				0x0C | SD_ASYNC_FIFO_RST,
@@ -1298,13 +1300,14 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->timing) {
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_SDR12:
+	case MMC_TIMING_UHS_SDR25:
 	case MMC_TIMING_UHS_SDR50:
 		host->ssc_depth = SSC_DEPTH_2M;
 		host->vpclk = true;
 		host->double_clk = false;
 		break;
 	case MMC_TIMING_UHS_DDR50:
-	case MMC_TIMING_UHS_SDR25:
 		host->ssc_depth = SSC_DEPTH_1M;
 		break;
 	default:
-- 
2.51.0

