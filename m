Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88ED52F8B
	for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317774; cv=none; b=E77/D1U9MMkeZD1+o5khZaQgj7/IkLnvKKoAWjAGvSI+Cide56ijEIbpAMsE5kP2XYMA0He1gchsJzDK48ZKyJoNFKGBJQQo8kfrV7I1g1k2MyFoEs6nbrGN65OvSlLXaxzJn7Z1z0vaZz4xb1yqVQIB3iD1K/nL+FBJg8OZfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317774; c=relaxed/simple;
	bh=/QGGg48sn9sKA1F8TWZlfBuzKMx3jTk/2UYyPAjLJh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAkCXfOGosob8m73FT16F+3TfAn7WyA9QCLgZhfyre3kFqquRKaDRNbjhFB2/5UjrotMQqDsVEuGgT+iKJX5SAUoCrMKeWZ4qrj8Z1Zd9a53CJXyu0l0GUN6ayqFqja/0ATF7aVDwYmE/rIJCC6pZbDbhtIchJuM+MO9t0jJVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=ANybRDnE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="ANybRDnE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439baf33150so859463f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1773317767; x=1773922567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq4shlsXpyVXkpp2qtgEESfDg63q+osNt2mDVKvT2FU=;
        b=ANybRDnEJvrJJtvQIvc6h9Vsr9IC/G5Jv0SyhtiP6nWR3ntsoCEsi6yINDj+iULuq+
         azKbTGHlKHYutWB/eQs0Tl0uI6Jnxhy2L8I4v30Vz9MbxTid2p2bod3b6ZYuEoiO/qeY
         p1iS04YcqaacdE+9gdpzCWitFvVprdmUFJy/R9VnRlc+oEM7FtP+M0Ffu+btxSiD6nap
         MvyEq2RvO1lxLwtVOyfts9cvgu8wtCcZq0ikhrUocgIKY9wuvLbc3W97HLXiCpzshj2s
         rvvXQSV79HPD6L6sK+H1rS7nh2e5zdLB7KEEEakFepohiN3ahhh2CSLq4uqDmollyMR2
         fGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317767; x=1773922567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kq4shlsXpyVXkpp2qtgEESfDg63q+osNt2mDVKvT2FU=;
        b=ckgeVikHW++397KTKoKZkmOfzgmaW1ssa8ALsdVZmI5k7ScX8tBWF7sAlGsIKv8oI4
         7iAOLP0upnawYaT7Mu+V7lAe3rFvm30ReborRMOANPQUD+EIRAsRMZvuklwcx3dkZLQl
         m1YRQFH+WFVJjuqY5MKTtPKFOjAWXDtQ4WyDf+nEStpsSJVRN+AD/Nqge1Vzl99NjF0O
         q3bPQ+g5cJ5A84WJp5aG+7WWx5rnOd67LWobrlvLoTXc1Jzmd9Jt/l8yM1JtQQd9Pj3Z
         YjDk8vnjLLkNI7MJLQ0T1xgFiKVPeIw92AamaEhaP8dQvMk1FKsdOd5Jmq4Ahq9aU3fo
         i1dg==
X-Gm-Message-State: AOJu0YzOkco2+nmTMJ0GmB8CYa8Uny1HC7LRnE5amWuAekHx6MBZvDjL
	cDwTUNtwI8o8spe5mLGYOTxAwo/Bw2MQRwJNhAI1uM9RyGB5hDRpFBEYgnGM6PubYwG/UbOinc3
	eH4quMg==
X-Gm-Gg: ATEYQzwGxUXZETPER8mn4pXPSIRiiV7SpLSz210zPFbvkhlmFJqoOf/qoBwHnYjvhVY
	8tu4+K5ZisXwKjef6dJkixH66JDZloWLaLZHYf+yoNvFpt2cNQR82NmwEcRZyTrHhZkf0K+/u7v
	IqBVeFHW4uRMSxaaFzKKxpNTLcioL5ggNjUPTMwRVoIIuPut9GHoLPBedEYwNqRNf/am34cVcwR
	g5V1nKt0KWXDKwpaukBk54zYE8AVU2YwXJbl7+PA8CaCv+jr/5tcKVpTbZdeRF78s0sikSW3CEV
	r4PEfNMfzCCmEWymMPW8EeJjW+jiTHMZoZ5PXNid+788qlH+AGRabkF/EOgnfYvt7JKG+oW2B1K
	gd59FyFMmstcCiQ9Vi09w3wqlbSnERZe1R7yXaudYt6TMW8ptXT9g9gzMIRZiXXDM0VtPuJz39Z
	eQc83C7rhd0VMfsxqIEy0gY7+0I9gdKrQ5EfNrgEBPRvfGlGsOsPaU2zZcofmoAACNxd/ZMQ==
X-Received: by 2002:a05:6000:1a8e:b0:439:bde0:62ea with SMTP id ffacd0b85a97d-439fe1ae91fmr5920647f8f.29.1773317767462;
        Thu, 12 Mar 2026 05:16:07 -0700 (PDT)
Received: from starbook.localdomain ([212.105.129.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm8139874f8f.24.2026.03.12.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:16:07 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 4/6] mmc: rtsx_usb_sdmmc: program SD30 mode for UHS SDR12/SDR25
Date: Thu, 12 Mar 2026 12:15:57 +0000
Message-ID: <20260312121559.19197-5-sean@starlabs.systems>
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
