Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103865;
	b=ZlmCq8pPE2U0lpF3kvCnWDj4t7479DX5+1Y6n1D9uUfxG4NwcR7ruqBOIEtRR6INQgiQ
	 GErQ501GnmhhWzSKNB46qNXbmktsJlhCEJH0HkY9K3QH+Xmd47kPHzpUGhO5MiOFZEgqY
	 WxueVu/Q0KrwiFaIRWGOd9393BO8hweq7y4Rux5cXXwwPyN9bLgwyny1IbNbK+SW4oHNh
	 rg0s+zhYNyjXurhhAuwo+liMKwOZ58MPIMeIPIKJec2/JvhovK7L7cw72zHgDdNthsT+r
	 +EQzaqMU5po6r9krUtwHLwvsiKCKjGoCPHZ1BeOL1ioFASPCe4rdxEDrg44EmcbNmhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103865;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LA/hZwRt2plS57FvevLCtFCbVIQ+omT+Gp+X0asiI28=;
	b=KC6OyDYFpbxGn641C25hho6riV7U4cypAjLIhg90LbH6vqAc7IBqiIqsKPqoTqdWNoTF
	 pgF4l3XKiC2jFt/kraTsTdtOKFSULs053NKO6Mf75r+O8CgU4X7tbSQsTvaU1iG6mFQEx
	 TH0d599aKZEv/1fYUTixBGVGwYl0oGtci/4vYq6aLllIPrl2fj29WWC8n34ED371sp330
	 kUvQdbSazhMQS75UuVhsv9/qoT77lWjRI2/4qi70F7jMuYkMY+8YnaAMA5gAz2ruMx3er
	 scY4iDMDPjhqqKquGnY6Qh/oXxEelQ/C/HiesS06a+KkVFIhfe7gHQiZ/gDQq+H4BgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=BFkT9Xds;
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA3606A32C;
	Tue, 27 Oct 2026 12:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05AA3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=BFkT9Xds
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793103862; bh=vjHrVzmjkeE8LPIKhW2tYsP4mzoqrIs1jcZFTmaBPZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFkT9XdsnACzp0WloTiTUsMRmfhDFG81JScAEY/khcSFzdL2ifKc0t69RdkAJLFOO
	 vU6DpeSuyHKTcsX6AbDeZT5R5DUb8nIKY2Pv4JTDGOTMMuPjeqh5Q2sO7CcQNhcyJT
	 7p6okqtfXaPMGPcp1O3H06E1nQ9NCawVjGUPuT/Sm31jKviH70AVkP4bBRYzrPJ3NK
	 S45ktjlQ8FD5zeBYeaj0thfIZSA5zAEskLTPFs9E0/jQTHPq4PUdEfQO05obNZCSRs
	 iRSTQibeoXNDx0XtWG00NIWuV+hOUotIyqu7ZSCaqbcxIpsuTe5VgKGHshytXNDTYb
	 38AKPda8Sg0yA==
Received: from nbf.lan (unknown [31.216.115.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 57B5C1271C3;
	Tue, 27 Oct 2026 12:24:21 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawn.lin@rock-chips.com,
	llj@rock-chips.com,
	Deomid rojer Ryabkov <rojer@rojer.me>,
	Jensen Huang <jensenhuang@friendlyarm.com>
Subject: [PATCH v2 2/2] mmc: core: sdio: skip CMD11 if signalling is already 1.8V
Date: Tue, 27 Oct 2026 14:24:17 +0200
Message-ID: <20261027122417.954133-3-rojer@rojer.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027122417.954133-1-rojer@rojer.me>
References: <20261027122417.954133-1-rojer@rojer.me>
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
index 6787fdf1c53..a986ee04ba2 100644
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

