Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103863;
	b=NBnuXUG/aFaJoP5On+uoZXcV+txCdINqBXeaqGB416EfR7+RTBPL1ZPA0f/QZdew/EDe
	 PG3AkOdtxB/N5/Q6n0UFH8MZk1ImRuTXE9Kj1S1wx01wYX5a7aZrHnlP5wZH7r3u79KjL
	 TDaCdXYIeYSgmh/NDyw0RPSucHupn+nBRI5FqQlH9Of5GLpArq6gHJzaomIe7v8omkdeR
	 lC50kZs2LfTLXmJGuUwnew5/Espzjh79FaWCbfFEjXLuWxossGtSNnwhR+6fpo0E8nbhi
	 NfT1QxJmx5TuwlPZ8UoT39vjHvmZN6dFLBQ/v1F4A3NeyBp7F0hdBt7y/jb7++QRuWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103863;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PTcUmOOyL/sDjI+Yim9rzbhFiBv2TQdk/UVNtMpPG38=;
	b=4xDK+XVw48DECncpuo4MDmvtX7mdZ5wRcnDWqnc97zzi5f59tTajkXyOuiCjQvbFMcxA
	 lrsRMtWA2FVMVt1Ftlk4jFr+LzLe5k7mp+ZW6jGf7GFH3iT65031+TxQoKPW7I1VoZEIv
	 U3A0yfbptcnNoYySBd5LnKKJ4ervjqTlV+cPzAfpodE6/QXoAvpWgCVXfcyXkgNx7HgG3
	 L0vtXItW52e2/7MnfZYRQqMMY8w1MMUcbWSqUUoH4TT9ULWOhpZbZfEtbQX++eQS2+b6q
	 /U+w3leqjr3eu9TKpWJScRLcrWJaVsw6s3ypd2ZJXIz3vJMx3Ccc67jSzTFyptRw3JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=lvwR5yu5;
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A99606A31E;
	Tue, 27 Oct 2026 12:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A99606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=lvwR5yu5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793103861; bh=0t9oJeZ+qvC6ntnFFDqmMrX48VxDf5pDUidCWUuWYuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvwR5yu56LrypLCygfy9SKiAcDpdHcVC4POsxMkbYdWDaDPCE0faTblrqS1gcBqQf
	 R5JWWl57MElYXacsg3Rh/FB9eDce6DZDyFIqESVIQFcy9vkCt97G1qTxtPFH7s/vPd
	 sOOfLd8UpXBwn80qpSp4iDHetlxQKjV9VsVlleF2lIpXW2UsyGic3DaymnlLr/n/Kp
	 ICMy14ic0FDHLKJdln3EvDn9NsA4+Rb7jJvs+fwfI1NfiWTgWaI0c2fgqs80tl6WwW
	 LJf+Ks/rCLNo90lr5XimUVPtZFW4JHj3km6obE/poGodYf8K4hNt1sG94sVup100ga
	 VjpdqUiLxmE/Q==
Received: from nbf.lan (unknown [31.216.115.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 2D556120499;
	Tue, 27 Oct 2026 12:24:20 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawn.lin@rock-chips.com,
	llj@rock-chips.com,
	Deomid rojer Ryabkov <rojer@rojer.me>
Subject: [PATCH v2 1/2] mmc: core: sdio: retry without UHS if UHS init fails
Date: Tue, 27 Oct 2026 14:24:16 +0200
Message-ID: <20261027122417.954133-2-rojer@rojer.me>
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

If mmc_sdio_init_uhs_card() fails, e.g. because tuning finds no
working sample phase, card initialisation fails and the card is not
usable at all, even though it would work fine in high-speed mode.

This happens for example on the FriendlyElec NanoPi R2S Plus when the
SDIO pins of the RTL8822CS Wi-Fi module are left at their default 4 mA
drive strength:

  dwmmc_rockchip ff5f0000.mmc: All phases bad!
  mmc2: tuning execution failed: -5
  mmc2: error -5 whilst initialising SDIO card
  [... repeated for every init frequency ...]
  mmc2: Failed to initialize a non-removable card

There is already a fallback for a failure to read the CCCR in UHS mode:
reset the card and restart the init sequence without R4_18V_PRESENT.
Do the same when UHS init fails, so that the card comes up in
high-speed mode instead:

  mmc2: UHS init failed (-5), retrying without UHS
  mmc2: Skipping voltage switch
  mmc2: new high speed SDIO card at address 0001

The fallback is taken at most once, as the retry doesn't request UHS.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
---
 drivers/mmc/core/sdio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 83085e76486..6787fdf1c53 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -867,8 +867,14 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/* Only if card supports 1.8v and UHS signaling */
 	if ((ocr & R4_18V_PRESENT) && card->sw_caps.sd3_bus_mode) {
 		err = mmc_sdio_init_uhs_card(card);
-		if (err)
-			goto remove;
+		if (err) {
+			pr_warn("%s: UHS init failed (%d), retrying without UHS\n",
+				mmc_hostname(host), err);
+			mmc_sdio_pre_init(host, ocr_card,
+					  card != oldcard ? card : NULL);
+			retries = 0;
+			goto try_again;
+		}
 	} else {
 		/*
 		 * Switch to high-speed (if supported).
-- 
2.53.0

