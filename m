Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=88.99.92.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370153;
	b=Sr+uw+VRh1BJcIxtsKF7NpXG1imfacbypBIAWm4Qy10YGjS4k0yojvrRFDTQ/XvpT+n5
	 rE0lsbTwoVFz1F8yGTRtgytnIbhKaxfu+AgXAOgFMSwqcOcWBP2ak3js0quHYQBejbCh4
	 eGLAi+SJnj6p+lllsuE5lLQRVDSCgc49TmAEthPpyTLZprao329rIvoCz1VF/7hC+GE2d
	 /1dS/r6ML017v0o6iWCWG28jXGj0CJ0M53OaTqEnFSf1F6utkuBxQclFEzB1rLUpF4Itn
	 d5Lb60P9LTJNpc5wT8yHuyItHq0SCMtV3qhq1c8Z7kEdy1unXGNgeIlU6qS25sF9Vtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370153;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sZSnUaH5e0KM+Xb9Aj8auTUlaUisKXJsjD6/B6ZesrE=;
	b=dA/BJXVpFlpfJzfugUHPERMPFEw2JGrTWT76lbQHr0XR+SqHRkRVNrznpbNiixjnAiT1
	 OXUqPXuVxeHn4yaaDbq6KU+94fvyaKVbWwsbha4ycS4fQ9oPTfjhQ9leIpNupwOe2hTQ1
	 icNYbzuNbXtAchI5MSCZPdtbDtDXOezKaJAyu5NzbG2aUSduBOJqu+oViiAEigHalR4JL
	 sEVmYh2xVLqr+reTErwewNibe4135E5/Ek++wiAy3RLoCkO8nHd9fn/NdYSnHpqkTdS2B
	 C1ETOAsxQ8N9Y/gWB5hxNFR9q2ZS871U47nsOlKBUydXjJXMWI0KBk6MgfmgzxxB5Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=HnnypLfp;
	arc=none smtp.remote-ip=88.99.92.76
Received: from mail1.rojer.cloud (mail1.rojer.cloud [88.99.92.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED06606A31F;
	Fri, 30 Oct 2026 14:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED06606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=HnnypLfp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793370151; bh=mNjiVU53+6TZtMOsCOynN0L38lvuNgertASbbdmbt1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnnypLfpoiJF2FtbJ3MCp/S4rC0B9F36NhfHEjd0RNnVhNv1fywaF4gbeQ247+rG7
	 GRrGP97u0nB0286y434ZtX2qDO2hq8+2PFlJcjqw2XmieaI31ocxlPIq/DJlK8UDpN
	 O4Ofz4/AqSfgYcFj8IlgJ0fav+Q5LWkMJFZvL4rkZtPMn8y2sU8nlZeMZtjYnucau1
	 QnBIZX6gRC8abDfQhJR7ndZLpIsIOu6gjmT4r/4NXGyTbBYLAfwPCelL+W8lvdv9jf
	 Uc/mJtI70hYyu/xJeG9rw4w8r1ItRzsyNrtkpjoOuD0CiAEXpGxdBKoR/jDSaoEVv4
	 qfeg9tEw/qvkw==
Received: from nbf.rojer.cloud (unknown [46.32.99.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 9BFFF21654;
	Fri, 30 Oct 2026 14:22:29 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawn.lin@rock-chips.com,
	llj@rock-chips.com,
	Deomid rojer Ryabkov <rojer@rojer.me>,
	Jensen Huang <jensenhuang@friendlyarm.com>
Subject: [PATCH v3 2/2] mmc: core: sdio: skip CMD11 if signalling is already 1.8V
Date: Fri, 30 Oct 2026 17:22:24 +0300
Message-ID: <20261030142224.3183407-3-rojer@rojer.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030142224.3183407-1-rojer@rojer.me>
References: <20261030142224.3183407-1-rojer@rojer.me>
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

The SWT6621S misreports S18A the same way; there, the failed switch
leaves the card unable to initialise at all (error -110) instead of
falling back to high speed.

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

This relies on the fixed 1.8V supply being described as vqmmc-supply.
vqmmc is optional: without it, the host can't tell that the bus is
hardwired to 1.8V. Setting 3.3V then "succeeds", the core believes the
bus is at 3.3V and CMD11 is still sent, so the patch doesn't help. Such
boards need to describe the supply (e.g. a fixed 1.8V regulator as
vqmmc-supply) to benefit from it.

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
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Longjian Lin <llj@rock-chips.com>
Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
---
 drivers/mmc/core/sdio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b247786782f..83c785ae677 100644
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

