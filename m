Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798103;
	b=NI33NfY8Pcv/epps9A8JrJuSuOPI+8Kr/pFIgh2tmDnMsoQ5XYNtaXym1uS8VrroTA53
	 2iEOfwTa6s4q56ceLSgbMVWjMhm2ij2CJCFk0lyFPaAw0qh8fxEoafuzO2BdNU9sN+3v9
	 K+GEaimMVLW0k7BeQLdGaNSwx1H7e2fHQdJSs2Zt2qGHwuQFPJPjtFJrXN4U7cqudLdfX
	 sQzTnptfkB1WDCNID77k3FRv+vxXezV2UHF4Q+g6O1glfSIU59+9MW2AIzTlQs+NIWlbn
	 ZSu98Bjpffc72hD2p8VXB6mX2EXRnS6AJQXkzA2u/4RmTi1BAfX68nz8WszJowvO3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798103;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aD1NeCTSQFP/h1543ayHvRQtPM3UgfGLx9ZvZ9SC0Ng=;
	b=sBH3/cUZnumi6i4aueW5tma+Rq3bceSmmnTm/BSHvJMNDzOIsxo9vahfbksVy/koqwH2
	 xWkBIR0YbWOHuvXLTlDleDniXH9dpWY1nihPN0Ndl+iF/cw+3zqKs94CXYx4oGCw/08AD
	 KBfaRhzbUTWwG2ND1AqfTKGHujSW8NpHKYd/QYACzJGiDb8ygHo+t0coZxNHqPSFeGsMl
	 ulJQR6KmHfblLsxTzp9kfIiCEZ1TwTaVjw4XaxN2tA1Jb9lTxA15sienVRz6LPCQ8JJCn
	 5q06G8d0MQz/SQFE8L4YEGi9QqzSVeL4zMxKz7H1Xmnqs6p1davXVp9Q675bjsR4wAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=RRRwpeA+;
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F145606A31D;
	Fri, 23 Oct 2026 23:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F145606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=RRRwpeA+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1792798095; bh=tfg1ElshdZOxkcjH8c2EZJI2VfCNk13rvStFhLrYuM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRRwpeA+Bd13lqePQ5WTUWJ3n2t9R+lEbUP5MA1Jm/eimkvAUdOCvDE/RAQAOELMj
	 0//jKq6ktg+8y68Wb/SeAsegVsAtgcTPAlVhfxPUo07VTFWkFhy+TfnoJ1ufUSizza
	 8Km4NzeoA3WrqFzFs8ex4XHxyORU27fDjnsxTlLWSKj67ryS1awsQ2gsYCQtEYgWvT
	 6XjzOM9faTmI2IKu6b6RtQPzwTtw0Zx6Zp7n1AkQxtgsbpGGDGXyLz/yXegc0HmsmT
	 m9QuSW2Up21hqHiFbWoUaD9RvW9fXu9WcSjXmTQf6we1xZ1ZtqJbDeinhsjK1oE4hg
	 58jt/5XIPEPSw==
Received: from nbf.lan (212-5-142-134.ip.btc-net.bg [212.5.142.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 066BA1271FF;
	Fri, 23 Oct 2026 23:28:14 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	Deomid rojer Ryabkov <rojer@rojer.me>
Subject: [PATCH 2/2] mmc: core: sdio: skip CMD11 if signalling is already 1.8V
Date: Sat, 24 Oct 2026 02:28:13 +0300
Message-ID: <20261023232813.2983368-3-rojer@rojer.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023232813.2983368-1-rojer@rojer.me>
References: <20261023232813.2983368-1-rojer@rojer.me>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the SDIO Simplified Specification Version 3.00, section 3.1.2, a card
whose signalling is already at 1.8V must report S18A = 0 in the R4
response, and the core relies on that: it only sends CMD11
(SD_SWITCH_VOLTAGE) when S18A is set.

Some cards don't follow this. The Realtek RTL8822CS (as fitted on the
FriendlyElec NanoPi R2S Plus, where the M.2 SDIO bus is wired to a fixed
1.8V vqmmc) answers CMD5 with S18A = 1 even though the bus is already at
1.8V. CMD11 then times out:

  dwmmc_rockchip ff5f0000.mmc: Unexpected CMD11 timeout
  mmc_host mmc2: Timeout sending command (cmd 0x10202000 arg 0x0 status 0x90202000)
  mmc2: new high speed SDIO card at address 0001

and the card ends up in 50 MHz high-speed mode instead of SDR104.

When vqmmc can't do 3.3V, mmc_set_initial_signal_voltage() has already
fallen back to 1.8V by the time CMD5 is sent, so the host knows there is
nothing to switch. Skip CMD11 in that case. ocr keeps R4_18V_PRESENT, so
mmc_sdio_init_uhs_card() still runs and the card is tuned to SDR104:

  dwmmc_rockchip ff5f0000.mmc: Successfully tuned phase to 64
  mmc2: new ultra high speed SDR104 SDIO card at address 0001

Hosts that start at 3.3V are not affected, nor are compliant cards that
report S18A = 0 at 1.8V. A non-compliant card that does need CMD11
before entering UHS at 1.8V would now fail UHS init; with the previous
patch it falls back to high-speed mode and keeps working.

FriendlyElec's BSP for this board works around this with a card
quirk, MMC_QUIRK_BROKEN_ROCR_S18A[1], matched on the "realtek,rtl8822cs"
compatible, which drops the switch request whenever this chip is
present. The misreported S18A is the card's fault, but ignoring it is
only correct when the bus is already at 1.8V: on a board with a
switchable vqmmc the same chip would then be run in UHS at 3.3V. A card
quirk would need knowledge of the board's supply that it doesn't have.
The core does know the current signal voltage, so handle it there, which
also takes care of any other card that turns out to behave the same way.

[1] https://github.com/friendlyarm/kernel-rockchip/commit/aee62cf7ae16b5ede6c6d92a8ee20e796482754e
Cc: Jensen Huang <jensenhuang@friendlyarm.com>
Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
---
 drivers/mmc/core/sdio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 6787fdf1c5..a986ee04ba 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -737,9 +737,11 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * 1.8v, the card sets S18A to 0 in the R4 response. So it will
 	 * fails to check rocr & R4_18V_PRESENT,  but we still need to
 	 * try to init uhs card. sdio_read_cccr will take over this task
-	 * to make sure which speed mode should work.
+	 * to make sure which speed mode should work. Some cards (RTL8822CS)
+	 * set S18A regardless, so don't send CMD11 if we are already at 1.8V.
 	 */
-	if (rocr & ocr & R4_18V_PRESENT) {
+	if ((rocr & ocr & R4_18V_PRESENT) &&
+	    host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
 		err = mmc_set_uhs_voltage(host, ocr_card);
 		if (err == -EAGAIN) {
 			mmc_sdio_pre_init(host, ocr_card, card);
-- 
2.53.0

