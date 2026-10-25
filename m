Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956079;
	b=vlIdIuCtUezoFAw+Jq+PWDgKJZTDIxsbIEb6Iio3ye/tgmLW8tZkcV3ii+u7o891CdtH
	 qyaBUUs1x4bPsg1bef2LApecw2o2Z3rHijJFfBxBsrxnIX7gLAR3Nngue3fqW3dL5C1eA
	 EPYcp0n7jfiqlM0bhpflMlkM14JlxaaEgsegruEPh+Rc31fnLbhP7wwhxv5iMptzJ63uS
	 we46wSMbrXnWYyVxtIYasXBbr3aFVfarG3lYylI2HpZEsMBxLQpM0iaynliwsOg2sis+i
	 APeuV2l5muACUPFbFSxL57NSSzJbkyc6XT22BBcLBQ/nL2dfzZnYEwlwpzFe/LeeDRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956079;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=VZCgXEGk8gn25schLnnYeMptMnn1cMJhy1WitpRraNA=;
	b=woHZZ/hYRvJ0seVIv/MPAOCdFKKOpC0cR945c03xG59ysa8lyA5GwRwAZHZoBA65IIgF
	 6zC5LL44fj/WhsOBAE/GLcsLRmcZNTMgWS29rUgkDiXwTSNCXblul9OSDJYWsR11omCxz
	 QLd+KKhllequ1r77LuaQ2UOyWHwsEhrN56UX/fMQ8gBVbY6VgRBGyxDnOl2Mm7gh3RPjE
	 gte5MF6U0MT4mYzLuXdLANCkAS3ZYA1ljnprvQZ4ZoNhIcuBGtXOzKuBem9Ybz51ng/EJ
	 5EdAoHq/VsTb/GDixRZNEhHTKfcAgjTz0UIRKHWL6kuQDximun/AhbAMP8cbPOKY8QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=FPRPiAoC;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2C606A327;
	Sun, 25 Oct 2026 19:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E2C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=FPRPiAoC
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJL1Gv515970
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:21:08 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJL1Gv515970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956068;
	bh=VZCgXEGk8gn25schLnnYeMptMnn1cMJhy1WitpRraNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FPRPiAoCzBC0ddZb05Ox6Fz/koxRK8hNOj7ZmWMpMpuuWJJXb7hczGOsFWMGm84ry
	 Iqn8LNjmYpyHsih7cgwah5EzjUGccxiQUHaQ8TWxl+/dk8uLsA/pwpDaPZRPcwd+1a
	 tZoqbTpylLIa/EYPHjaSi3rfWcHWJ3jAYkDvutyY=
From: christian.koever-draxl@student.uibk.ac.at
To: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 2/2] mmc: meson-gx: allow the core clock phase to be set from DT
Date: Sun, 25 Oct 2026 20:20:59 +0100
Message-ID: <20261025192059.208792-3-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192059.208792-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192059.208792-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The core phase is hardcoded to 180 degrees. On an S905W2 board the SD
card fails with CRC errors (-EILSEQ) right after switching to high
speed at 50 MHz.

Sweeping the core phase on the live controller showed that 270 degrees
works on that slot, as the vendor kernel's init_core_phase setting
does. With it the card runs at 50 MHz: 21.7 MB/s sequential read,
6.3 MB/s write, data verified by checksum.

Read the optional amlogic,core-phase-degrees property and keep 180
degrees as the default.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/mmc/host/meson-gx-mmc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3..42c855248675 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -425,12 +425,25 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	int i, ret = 0;
 	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
 	const char *clk_parent[1];
-	u32 clk_reg;
+	u32 clk_reg, core_phase = 180;
+
+	/*
+	 * 180 degrees suits most boards, but some only sample reliably at
+	 * high speed with another core phase (the vendor trees carry this as
+	 * "init_core_phase"). The field is in 90 degree steps.
+	 */
+	device_property_read_u32(host->dev, "amlogic,core-phase-degrees",
+				 &core_phase);
+	if (core_phase % 90 || core_phase > 270) {
+		dev_warn(host->dev, "invalid amlogic,core-phase-degrees %u, using 180\n",
+			 core_phase);
+		core_phase = 180;
+	}
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	clk_reg = CLK_ALWAYS_ON(host);
 	clk_reg |= CLK_DIV_MASK;
-	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
+	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, core_phase / 90);
 	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
 	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
 	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
-- 
2.56.0

