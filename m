Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5873BA24F
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739659; cv=none; b=QXfdr8ImNKW4M6Y4oxHOw8Xg3RApzAAW98ebYHTMU357TFh+J3MxiHtbjnWSdzmyhjE2QyHPMaimvLe/sC882T8vsVtRhpuTWncNxrT0m36NGHBBzjmXuPcYhlWWxt7g0ZIf8SuCqz9oEzWO3uUCVcBowoRGk71EokhPFw/Icc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739659; c=relaxed/simple;
	bh=AbncytGo/OWfyaXKOnMZkV2SkbCa9h8pOQP7KxGY75g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFkFAcsLzgTMyZAzQY2YLNqI1A1ZUJlUdytVELJn0nm93H2YzueJQKfTDGk4zV/DhcLmFk85UDHtiN94zCMcq4fDL//t5ZPlrToTSOQG6PTT9VVPFthmXXA/WOO+JxYcipuIVnaVZKItqfRQtUnFzdEzOMEcnHoNOOpDUWCVnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=LemOkAvk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="LemOkAvk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48371bb515eso125212285e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1772739656; x=1773344456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eeZ0mjv866Z0Uw5ZhaTkSoek9Tp9x+KF8G9Qscf4X8=;
        b=LemOkAvk6gWs/d3s08Hyng5pT90vv7aihrLGxfVoAEEQLZ9SsNjWDmq+C4WK6i1Q1n
         Xx/epNag61mwmoPFKxxr3GvSY6zu1qHoXKnVJ5NJGvSJALjBDoAM+Np/EadGKZjYyl98
         EAlJkB4SnM+WKVbUz7ehlrojUd5CVDr0r5jSLhHdL8yaM5KqrzQDjd5Q++fuBEDVjAG2
         1UW60DSSVYTZfAElQTfaVYLYXDjrc8FfaVr3ZmM/BTvZHo5DSqZ6+QQ2ry5cgGWR0lB3
         YYsJMa9hkymFN4KQXpzw8iCahQt0wsQUmsQkfebuAPnMrducfMVjcMBsqtHDDAgrIcUx
         NTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739656; x=1773344456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/eeZ0mjv866Z0Uw5ZhaTkSoek9Tp9x+KF8G9Qscf4X8=;
        b=dEM4moqdvXw1EZQEOGxYtFj2u9SDXGihOms5ifKV6lq0m9d9ZMG1BhFWryVyW0tYWy
         w8YDCZ2+HWQ3Ab4HuaUV7PZD3aAHKIGh+7YqI7LOL3ifIPTPp6a1PqdEkigNXKEQxQl2
         4xRL90/riTINysvQCi+p8ZCsOzYy+GPpu2zWEIvd5hPUtyXCEugP7S4mcXCG1mLIJDha
         UrDF/G5BIfX7WjGQGIQXfVTVMRNR4kW2YGtcqDIV+74jWq65YHL2W7vM8XUli0g9umoC
         PqW74J/BQ7fr4k5LZ8Olli2pwZyRIf+yRNEZMmCAG28A3SrLyikORsWC9/tqI1YzR9QV
         m69g==
X-Gm-Message-State: AOJu0Yw2cLgbb9O8hhBTt0qGjCVjD9bhu+4IOeycZbvYUMvkYBwkXf/g
	H1qlyyG2n3xx67VqWiGhnVatKOe9/8RwJiFwdAfGXOHEAdfBR89i95QrfZjgygWtwKvozfol3dH
	LrUhlGw==
X-Gm-Gg: ATEYQzxz/6s6NO//L5KFezA0rKk5ru+15RHMCmOtO27mxtSEe+vBfpGChMpifP2iHsG
	ym3pin17sHnj0leA/g69h8CveXN5Tzo/Nh9a24VV4sTjcF5lCKp7Xib2pSHSP8dVx61wd9UwKKF
	3FEecIeMI37sh5OthGI4EyfJOnF6/1sMqJxSedmCWNyvKE44iymgCW4C3VEUQKo0pvu2gHLz0j0
	mvL6KypCkBhrDAI3atBeubTVTvtZJP942HE/s1+NKPBtflYGQv9GL+RN+eXeiYB5wrGMSPeqDzn
	YYF5RArq0sWPRW/O7p3cDGfKpPx7v9XCUTw58NUuyv7XI+jU6IvL63Ps0dt8B5nPatsCGHpX+l1
	Du6WrLatVCXZko93mAGFwtU+LHUpCqA5KWp9HwzWxgV2TOXe43q6yTgyOcNGbVi84akoOJF/4jn
	Janc1r897/KTrq7TfF0mL245MhWTEpzZBakTHNzOOorM5fWLaAZcs=
X-Received: by 2002:a05:600c:3510:b0:483:badb:6191 with SMTP id 5b1f17b1804b1-485235b42ebmr10938365e9.8.1772739656215;
        Thu, 05 Mar 2026 11:40:56 -0800 (PST)
Received: from starbook ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246fd127sm3265e9.6.2026.03.05.11.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:40:55 -0800 (PST)
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
Subject: [PATCH v2 2/6] mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
Date: Thu,  5 Mar 2026 19:40:48 +0000
Message-ID: <20260305194052.5120-3-sean@starlabs.systems>
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

Some tray-based readers keep SD_CD asserted even without a card. The
rtsx_usb_sdmmc driver now validates insertion with a minimal probe
sequence. That probe must start with the SD pads in 3.3V mode.

Like the old rts5139 driver (sd_init_power()), force the SD pads to
3.3V and tune the SD18 regulator to 3.3V before powering up the card.
This avoids spurious probe timeouts when the reader is left in 1.8V
from a previous UHS session.

Tested: Realtek RTS5129 (0bda:0129) + tray + Lexar 2TB SDXC
Tested: cold boot detects mmcblk0 (2026-02-24)
Tested: hotplug insert enumerates mmcblk0 (2026-02-23)
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index ec3eeea78e95..6be98926387d 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1108,6 +1108,11 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
 	}
 	dev_dbg(sdmmc_dev(host), "%s\n", __func__);
 	rtsx_usb_init_cmd(ucr);
+	/* Start SD init at 3.3V, like the old rts5139 driver. */
+	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PAD_CTL,
+			 SD_IO_USING_1V8, SD_IO_USING_3V3);
+	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, LDO_POWER_CFG,
+			 TUNE_SD18_MASK, TUNE_SD18_3V3);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SHARE_MODE,
 			CARD_SHARE_MASK, CARD_SHARE_SD);
-- 
2.51.0

