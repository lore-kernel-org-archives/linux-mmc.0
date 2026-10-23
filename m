Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798103;
	b=07A6Q9f5HECi8vDeFUQ7Pom69tq/VNJ7ChVta0SN0M05dquyOgXtjh6+7t0yu2gSYNmX
	 Z6yo23rRgPM8krTE1Icv8d2MTsvobdVUPiMCUrbvTnQFxCMP9uVhEqmTc1zygLGiqRKJ+
	 4y26RUpdE88gIByGZZMnh7sF04XiUVuvT0WBaDNCvvmpVFhbLcQmzq9xCAMCJaICAoauA
	 aulTd5xieiRnVrIy8LinYb80VCFLJah4sxm2gqZixiaUwnIkoV1xXp3e3j5isEFGCsHG2
	 jjf65zXWZkUjQsxJAD0PMwVod3Xz2CePgx8xlLPEXwoPwVCq1S5jR1Bdu5ky4M+L42g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798103;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BgAJ236zTwCH4KkAQN7LY8OFEp+AjHkXbO7JCs68Z48=;
	b=ghDeO1xBkjZg5lPgIO4VJhrk1Uo8hL0P9swgEVTyYhWwGTHcnlOYx0B3ez/pFkOShln2
	 +bXfYo/Do632FhC3xJPXTyK0C7ijKj/FwM/8IlWUWRshpVhR7765nIE3e5W+qrnEsS2oO
	 DhMo10XYiMJ4XsC+It0ifXSoskwpdR3CtDnEUQ7QOWQRTW5I45kT0q3fNm826PrkU/E1m
	 CawKzMU5yA7dzW32uFW+92zdij4yX82lelnjZ9bDk24zJU7JUMwS2Rj18DxhpgrAdKrSD
	 VjL3o3vsiAz8eVs/4yI0k6hZRdmQqDfdjDIcg9UNWUk3GiaaJ9iOaATxgve3kdDXCjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=Ar2Zc8IC;
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F060606A31B;
	Fri, 23 Oct 2026 23:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F060606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=Ar2Zc8IC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1792798094; bh=rXOO2tjuW5MQt4a+ac1JCkqLSgpeQF5ItK6pa3Au9/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ar2Zc8ICPQlgLlI33JEVP8S2TfJIpjVfRu5cs1JTcA+hXr1xAY5OcVgXoK2sJE8PQ
	 4EUGiVqIN7kd43RLtHCU7OWXerH4L2f6DghaVw5A8HWAQzf1uEP4yBbHFypO/Lm9eE
	 lo4/JVeo1Zfwz68NNrgEQmz1CjR283z/Az6OdyYWjThK69QENn0KjHpC1EMdb8vbiX
	 2LMZoytKkmbjWbxIeCzJgmkePeo2N0ebM+OftyEN0nexCk1aCqn47NQHlBE0EQDCBx
	 Gbf7mulW1xAtcjJYwzzC2mWwJqcZznfUJOLBOqXNM4JA51zaeVrcHSE0rqUub2AJrL
	 0IcZWXBTOXKQQ==
Received: from nbf.lan (212-5-142-134.ip.btc-net.bg [212.5.142.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 972B71271E1;
	Fri, 23 Oct 2026 23:28:14 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	Deomid rojer Ryabkov <rojer@rojer.me>
Subject: [PATCH 1/2] mmc: core: sdio: retry without UHS if UHS init fails
Date: Sat, 24 Oct 2026 02:28:12 +0300
Message-ID: <20261023232813.2983368-2-rojer@rojer.me>
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

If mmc_sdio_init_uhs_card() fails, typically because tuning finds no
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
power-cycle the card and restart the init sequence without
R4_18V_PRESENT. Do the same when UHS init fails, so that the card comes
up in high-speed mode instead:

  mmc2: UHS init failed (-5), retrying without UHS
  mmc2: Skipping voltage switch
  mmc2: new high speed SDIO card at address 0001

The fallback is taken at most once, as the retry doesn't request UHS.

Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
---
 drivers/mmc/core/sdio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 83085e7648..6787fdf1c5 100644
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

