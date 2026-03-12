Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671812D4B68
	for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317771; cv=none; b=BK8IiTIAjsLszURBN+FaHLTHid6wj9/GnmOSRAtXH/z+e5EWEQ/WDRN4gTakP1m68XWt6nLWyB2Jn/Bak6NIxVDXk0bl0MKFKZvzbbt6c0AZTZQQ8omLRMZNy6bCkHEEigTxf+mD+3nmG3AuSt/q2R5M58yhPiE+831QXGJ64uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317771; c=relaxed/simple;
	bh=AbncytGo/OWfyaXKOnMZkV2SkbCa9h8pOQP7KxGY75g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcsudglyyqftsVLiQd43CXyNdM8TE0NKbtevSTkUfY9wpvHcOuzskW3lPixXOHnbbcIsp4DUb9naRCoJZ8hxsud4HBeF+fL6HKHzdQXkdUtvzv/dCk6DlftyojRI8rT6veltdOYVqLyQaOy57Y27VNZ4i3uRMwKPNL1v9qsqvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=O7j6T6Tx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="O7j6T6Tx"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c4a93841so703645f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 05:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1773317765; x=1773922565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eeZ0mjv866Z0Uw5ZhaTkSoek9Tp9x+KF8G9Qscf4X8=;
        b=O7j6T6TxI3y1c05eDrwObgR3/xPQPselhI1c8+6nlO22Dno0n1nDcI71B+Mq1pDZxz
         bjq0JmCuHMA9sxSfP5dhNiaPZayL9X0wKbU7FqIK85apxyZSkDlYy2h1VKwlVoFuQJ5r
         ydwfw3j0gDrN/VdkW6RirVMms2nLhOMggfeytwBeFI8WHhtpfrIKWU/hGgySW8WBT8y0
         CqGPpOJ94iZlY8tT+z3e21VH32RwwXch57RxgbrX2L3Z9XDpavR2YivDB+dgJCq3/9wJ
         2zWr3SCCpNDtGASeILsEQLsQrwN156jEZaLDoK5yWZXMeuECZbMkR4HFbZW2wlMbAMxM
         LK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317765; x=1773922565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/eeZ0mjv866Z0Uw5ZhaTkSoek9Tp9x+KF8G9Qscf4X8=;
        b=VyFJntpjo7wM4SyQ8k3FmshreztS8eJWzGifT0+E9QKMeVVcAE8l/LWVzVP8FAf/Z7
         r/q+rRhI9mR8gnvfdaDBAL2FynKpEqoUtnd69UbODAqT+BW2i8MrtE8wQ0nqoqj5dqlT
         fi2tfXzfycqAMoPpDsUzbSBi3O1XzcPKnOVvxE3b8xTUTi2OMgqFn48HwUnyJnpHMY/J
         rE2E9EZY0JgFO4K+seOQiT4cYV040VUgKwl4rmyWOvsh3oZ6yQk8cuzo1z/ALxLi4ANH
         odkmbV/Z6QqN5vPqrdkbcE9excklZnzMtaLEEiOyz7xkrxwioyoymqTMwQSE64EGfpYN
         LAyQ==
X-Gm-Message-State: AOJu0YwsbI/d5O/vtcv3T6g3RMUKxDBay/eREZOtct2mNC0leDuMAfSP
	fMoEshOK51i9I+rQuB32ZPa+Mxt2YP2AYqySA9vEREllcN0Amxo5uKNlt+QiLxc2QHrRQoViZC8
	bECswkQ==
X-Gm-Gg: ATEYQzz4wR9OZNeyuk95oi/2kws6APy220W7kqJkQpoac22DxaTEQZTiZMZ3CHSaNwu
	C75a1PgBfrfKU9vkBa8E+7Zk7m2BTUM7GgQFHjJ2+I+4REKWLZwiAqSUD/5zoVBNz8ruVg3uDO/
	2BAifK7SDR6vouDaksVdx60a8fWiqVuI74JYLNG1IFKvEswlJPVCPNwd7txYjhZ2/0lPSm+13id
	T45+v9wwngUjlH2ptoVxJRch8cX4C0Fg7V4Q8K4CzA/IpbGzCN2JXyEt9eKOMfMaDXJYdIZrP8E
	Ojtk6B5NvvxXW8YMkytOpyRHo1I9eDcZwyb1scdIfjPMdZzKtBZSDIwzRI8aANfMRAhBBNWMwi+
	he+Rm/bdYFWx7+7ldLEPMrekhwPTUW8iKILJbPMDoOGrnPRX9qoal30l3kkuiHB5pQMlVn16Ypy
	P/nBHPkL4Rpy8xTYIgcoV5qfE4PosBYX4ZUVW7xkom6pjTaGX5vpz9B1Oa/ZPiWj5bACQ028wk0
	/qhFMY7
X-Received: by 2002:a05:6000:2681:b0:439:cbf3:4a8f with SMTP id ffacd0b85a97d-439f8434f2amr12147772f8f.41.1773317764802;
        Thu, 12 Mar 2026 05:16:04 -0700 (PDT)
Received: from starbook.localdomain ([212.105.129.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm8139874f8f.24.2026.03.12.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:16:04 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 2/6] mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
Date: Thu, 12 Mar 2026 12:15:55 +0000
Message-ID: <20260312121559.19197-3-sean@starlabs.systems>
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
