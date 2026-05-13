Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFB3FF883
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672424; cv=none; b=Kqxazn7nhgfhorHvRdBR4fu4/zgrEc57sAATFMgU0jroXCtHoiCc5j7LCAhPlDkvX7ZHidf2RG09lq5G5k9LUv4kBoHvlRiNkubxd+CZC34tnactms6v9Mn4HbqOG3UxKKhaeMkUxCwTPRqObEOsjwVu/imY+0j7SNfpTH/twlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672424; c=relaxed/simple;
	bh=eMf2CLDG44C1jZ2p7u/edjuiS9xo64r85ao5+r/5ux4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twCHLIial0ZmKcbBieS3VWnrL5hA5lt6jrrv1UfuYjSTUe/4iebpPgngKwwA2lKNjcWuQrKRyyPgQ/UuFSVQU1MoxKZwTR3ieixfM47RX2zfAawiVOAZEB0n3EuBPMcPmvsiO2HSJAf+OATNzFgq1kQmB88wX4t9ne5ol0II2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=l4CWWQCP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="l4CWWQCP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48896199cbaso58765505e9.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1778672420; x=1779277220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQFvj5LmJIGIKjgLPEHd0VQ/ZMItSCOV0/e8nhf5n6k=;
        b=l4CWWQCPcZu7yzn0CNg+J78xhQ1MJumppuDVdKvB3ZSESP/0igH+6wdDyANWFqrlz/
         2tg9mrl2rVuy/V2CM9JvJylxKNyzvZEmhQAqxXgbUIZK1sNHBSoXdKwnE0PVOdv36BOP
         KXjMY3axE/H1eq/LltiRpPLLy3Ry6nr4xUYKK9XSq7H7wjac7Skh02I/NX0H2jehvigN
         tOOTjAtB2x6MPJZRSa7j0IJ5A/h2IeoVIVCVNtvo/uFTPqoCaYubCzc9SK6rnn0tkQbk
         Qyb00Cdy5nNpvJ412kE2agc0KrdgZc0bczbd2oAGHu/+6RnJG2QnSfC4ovNaan1dPJce
         6L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672420; x=1779277220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kQFvj5LmJIGIKjgLPEHd0VQ/ZMItSCOV0/e8nhf5n6k=;
        b=qHhiupv+Dcaej6KHyV1wE8OnJ666KIrnjVkpZpkmufDP+pdl+vFy9opGmORkZs4Gtx
         WbjDS9Vv6PDCpFwl8N57kYrbY0vMG0fphzcReP+Rnx2of/DoPRT6ZoUKgfPPXFzZ06gX
         XilGMFMXPa//pohaVPBLBM+YQaXEUfsU3qdySWge+wqHdzYrArfXTgl6ISNOjitlfsCW
         CJMib5jDAftfLPqH9ICOyYKllQpUgmBNYmkTdJs1GTcAixOIlMQL9TaZbLyn8A2lWRIm
         2dYH38fxk1Uwqjeq2HVz0/v/5eNHeK5nl12Mcy6v7HdTnsIwQZpRJ/8a9ufcxK88OHPP
         h2iA==
X-Forwarded-Encrypted: i=1; AFNElJ8hchtwP4uAm3iSBYOVz/+7RiBIZNxH35UK9dNSJe/chk1jWSM1TTj6t+4LWyKfsIRbvwFgv+LQBCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykufXFGso0M8V3AKwFyO+bTU4PvCQaSnOl48EyYsedQMGK9/+U
	PDAxRt7Ub+wvkAFWoSLRw0LxXTsN8O+s/DXQfdu71/JKYXf5Y+VQ1rCMqv9hBec94Q==
X-Gm-Gg: Acq92OFffQmSU6btDSCTUjUVe0uhpAoHg47MYv0rFQwZHB9qpdyiiZ7AMZsg4D1PpHl
	gK+jbqczOu/8OjAjrP7dVxrBkwwc2q07t5Ww7GYaZIu8ZvZjttwr99W6Bn96Tden7Mancr62k8I
	tkm96OlIw9siV8+QVxEkPRDjy/nY551dIZIzz39HLah+/RgBwomwJoFDyc+unWSbPwHb//cxQcZ
	lKpvpq2oLVFK3Oqwslj/4ctbuYOSRUqC0Sv7MjhqtNXwNM2+10J1rO6S1L6o7YGGE1ZKE6Uflez
	YkTXXFVxH627wJe9WrOSHXweYLMzN6VEhHZofIzQTKJ+Pnu2MEVDJNNfnpinXWbteomVhRoZu+T
	hl5ohodOcw2toLzP6zD87lyZCmXYPlOd/7FqTrgCA1jHy8yQ2yRSboYUy465rP+2PyUxTdHcKsi
	aoLdtuvRR4CGEzGuSM/mbB+kNdKuHwTpoPldaQlMgMSPIypvKgFwP8ksAggboxVyzKaDLN
X-Received: by 2002:a05:600c:6303:b0:48a:592c:e632 with SMTP id 5b1f17b1804b1-48fc9a2b921mr44740155e9.16.1778672419876;
        Wed, 13 May 2026 04:40:19 -0700 (PDT)
Received: from horizon.localdomain ([212.105.128.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fcdf64013sm53508475e9.2.2026.05.13.04.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:40:19 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Sean Rhodes <sean@starlabs.systems>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-mmc@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	rogerable@realtek.com,
	matthew.schwartz@linux.dev
Subject: [RFC PATCH 2/2] mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
Date: Wed, 13 May 2026 12:40:13 +0100
Message-ID: <7de637dbc99f1c2dc40cd255b078de9f1efd1ccb.1778672403.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778672403.git.sean@starlabs.systems>
References: <cover.1778672403.git.sean@starlabs.systems>
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
