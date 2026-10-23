Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798111;
	b=OBzUxqAP8KgJP6mvkXmq7Je/skgZZyvUOo2pY/JMU9c5ft7lEkMYOmc5H4BbDH5kmotT
	 mwhICdWQ6RFpQECDxQ9nHE4bHJ6pguyt8+zlxt9htVnG67SgIqecuGGjjDreCo23ZCfJa
	 805yPaI+hM3lWItNzB/fg50LPD6z3MS301yQSxomn5md6iBtY5cKOk8kmVNIfxKPQ6gS1
	 NHtsgm01CnwqfpTnDSbJHEbZ+UkXqHW/Z1vurb+L4P0gXcoX4NFVilEIo0nR4s+ZASjcb
	 V0g9zPNvSZGpQHdzX26l/1f3vhusvggVRctRRh+bnqD+4bL0873pPlNbqSaEg629+hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798111;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hDU6f29ghJe9hyJnNDwqo+/sZgn+XaJjPnZBukdTI0w=;
	b=dzf17H4l2Hc1VrpU0L/0BPW49erhIQ1VIhuuG0AIwoxh7tIFn+1m+3uyfhGrzf3PBe65
	 /hXJw2ojTPxPD71xYJo2AcFo9FtzTUzXZK//q582Ht0TPijuKdywsXQWKFpJU/TyP7UhH
	 yZSUZrG7Nig1wVAZwF0whysfDGSmHVcmzvE4fMEFZo2w5VPPuiov738NUbNSkw7X+kKo7
	 qgsBYQfEutcSiY8ODTY1lzdOWqZxhwWIaf4VIQlosHcEN4CEl3ev3dMSMqJZgMs1zjBeP
	 LywDF0cqWUdoA7J5iERwkOhZY5Ox3x/zuzUZhEPB2zww2Gu1zBUuf0jOQefA8upi1sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=gvp6RsKE;
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190A606A324;
	Fri, 23 Oct 2026 23:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5190A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=gvp6RsKE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1792798109; bh=4HAcl55rvgbwvXeXRWkrEX0djWNdzZsXCLO+9FVeuok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvp6RsKEk6AFtQtEe+wJ52z6JsnCfWma8e4JABBiZ0huv4OZLCy/2aER4BtOnkczI
	 q98meknu7VtBAnkSpuB0QSGeAvwrzQRZRwHbftB1NQGexmZ6ZyNq/Gq5L3PQSxKw3F
	 bJ0bl9B3trQslbcIPSfEftiYtpvd2np/JtYCryHDFebIptK8us9Re5cJ65WWH6JDUC
	 kiT6EtXlq6Wa1FaQJbRDPfEabLjuFXpBro3Lr/BkYDHGcP3Hq/wBq0IXD7ejVSvGf1
	 lsXpXD4l768ZMCDUgINocNeoHw0j9UX8rByuWC0n6bw2dQOVw2dat4LNqmwD5dk1AW
	 eblbBZe1C8u2A==
Received: from nbf.lan (212-5-142-134.ip.btc-net.bg [212.5.142.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 525C6126B27;
	Fri, 23 Oct 2026 23:28:29 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	Deomid rojer Ryabkov <rojer@rojer.me>
Subject: [PATCH 2/2 alt] mmc: core: sdio: retry without CMD11 if it fails at 1.8V
Date: Sat, 24 Oct 2026 02:28:28 +0300
Message-ID: <20261023232828.2983454-1-rojer@rojer.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023232813.2983368-3-rojer@rojer.me>
References: <20261023232813.2983368-1-rojer@rojer.me> <20261023232813.2983368-3-rojer@rojer.me>
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
1.8V. CMD11 then times out, the core drops R4_18V_PRESENT and the card
ends up in 50 MHz high-speed mode instead of SDR104.

Keep sending CMD11 as before, but if it fails and the signalling is
still at 1.8V after the power cycle (i.e. vqmmc can't do 3.3V), there was
nothing to switch: power-cycle and retry init once without CMD11, keeping
R4_18V_PRESENT so that UHS init runs:

  dwmmc_rockchip ff5f0000.mmc: Unexpected CMD11 timeout
  mmc_host mmc2: Timeout sending command (cmd 0x10202000 arg 0x0 status 0x90202000)
  mmc2: CMD11 failed at 1.8V, retrying without it
  dwmmc_rockchip ff5f0000.mmc: Successfully tuned phase to 66
  mmc2: new ultra high speed SDR104 SDIO card at address 0001

Cards that handle CMD11 today, compliant or not, are not affected, nor
are hosts that can switch to 3.3V, as they are back at 3.3V after the
power cycle. The cost is the failed CMD11 on affected boards: on the
R2S Plus the card comes up about 0.85s later than when CMD11 is skipped
outright (1.65-1.71s vs. 0.82-0.83s after boot).

FriendlyElec's BSP for this board works around this with a card
quirk, MMC_QUIRK_BROKEN_ROCR_S18A[1], matched on the "realtek,rtl8822cs"
compatible, which drops the switch request whenever this chip is
present. The misreported S18A is the card's fault, but ignoring it is
only correct when the bus is already at 1.8V: on a board with a
switchable vqmmc the same chip would then be run in UHS at 3.3V. A card
quirk would need knowledge of the board's supply that it doesn't have.
The core can tell from a failed CMD11 at 1.8V that there was nothing to
switch, so handle it there, which also takes care of any other card that
turns out to behave the same way.

[1] https://github.com/friendlyarm/kernel-rockchip/commit/aee62cf7ae16b5ede6c6d92a8ee20e796482754e
Cc: Jensen Huang <jensenhuang@friendlyarm.com>
Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
---
This is an alternative to patch 2/2 ("mmc: core: sdio: skip CMD11 if
signalling is already 1.8V"); apply one or the other. 2/2 follows the
spec and skips CMD11; this one keeps sending it and only retries without
it if it fails at 1.8V, at the cost of ~0.85s on affected boards.

 drivers/mmc/core/sdio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 6787fdf1c5..0a96469fd4 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -665,6 +665,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	int retries = 10;
 	u32 rocr = 0;
 	u32 ocr_card = ocr;
+	bool skip_cmd11 = false;
 
 	WARN_ON(!host->claimed);
 
@@ -737,14 +738,23 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * 1.8v, the card sets S18A to 0 in the R4 response. So it will
 	 * fails to check rocr & R4_18V_PRESENT,  but we still need to
 	 * try to init uhs card. sdio_read_cccr will take over this task
-	 * to make sure which speed mode should work.
+	 * to make sure which speed mode should work. Some cards (RTL8822CS)
+	 * set S18A regardless and then fail CMD11; if that happens at 1.8V,
+	 * retry without it.
 	 */
-	if (rocr & ocr & R4_18V_PRESENT) {
+	if ((rocr & ocr & R4_18V_PRESENT) && !skip_cmd11) {
 		err = mmc_set_uhs_voltage(host, ocr_card);
 		if (err == -EAGAIN) {
 			mmc_sdio_pre_init(host, ocr_card, card);
 			retries--;
 			goto try_again;
+		} else if (err &&
+			   host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+			pr_warn("%s: CMD11 failed at 1.8V, retrying without it\n",
+				mmc_hostname(host));
+			skip_cmd11 = true;
+			mmc_sdio_pre_init(host, ocr_card, card);
+			goto try_again;
 		} else if (err) {
 			ocr &= ~R4_18V_PRESENT;
 		}
-- 
2.53.0

