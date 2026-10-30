Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=88.99.92.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370151;
	b=KoD6VDHQqW2+AYTDhYE94PLGz1tsUmNzm2SY8sWbf30qLg8rtcHvf64khdTQHUuvq69w
	 Iow+jQgo+oaEGvYgCi4NvW0tUbqA+8utLfdqu2EGcYerRrbj5bQu0q1Elf0AQ6dn3B+UQ
	 n3X1WWhxqDBA3aVvBNhpPH+gL5ZwIxSZ4hB2Gs4HxRQ5ITWmsmwiAQFl2QfS3iqLjR8qh
	 IpqYUhzwvQR2Lci2K9KW4DDK+QhRIGr7b9qFWFFJk6I09Knwh4CgYgm9IkVx4/jf+zthI
	 2QItpklyv/A4vkxxjAHWZBqBH5mtoq3HqGq7L7Th/D0WYycoa+diiL4qq1vuCOvnQfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370151;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iHamBYF570s7QYz27K5fdn+AdXB9hP0el+hSp0RL1ok=;
	b=0TuR3YMillsTzI4w4qj+eWz4KafAvk6xrzQPsY4EYLkH48rHkgioBeh9paw1exPHd1tZ
	 AgTFlVif2pqhSamVB0mC0HTUdfsIKRtQU4rf2yx8VkMyuVLYSS7Vzwgo6JqWU2ikMVUD+
	 G08qCnEu3hn5bZiph14bG2PjMNfYzuUqY1kp7WzNiRi9jikGPgAa00er5LGX9eTaqKN9Y
	 pPNBVT89K4ficJokYlrRqiV81lrX/XU7yUGzA8hlF8QilUJJb/RoKQYdH4gq7uhNt2Pzg
	 j8qZFVxS4+l+96zQROcIxLvzsAu29ANZB9NPmbpNvS0hF6ThJJ2/zZRoLl2wc7y7qZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=RYLJ30lC;
	arc=none smtp.remote-ip=88.99.92.76
Received: from mail1.rojer.cloud (mail1.rojer.cloud [88.99.92.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6127606A31E;
	Fri, 30 Oct 2026 14:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6127606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=RYLJ30lC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793370149; bh=V6gdeezpQcqnCB7a+sqAEMr/DhkD33kxaMN7cFuHOcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYLJ30lCdfMuxXi1dke2YKkc53yweriN9D8/gegt+3itdpeT1O+1lo05cS/urV77t
	 b50u5XORMr/rki8GS8WgIxGoH8ZGh81vLqCLoLlHDv3umkLiOepYeTL8twIV6iX/di
	 aS4iaUe0vx7veysgEBWBTf+BJNM4SuURjhfAncRyv3rtNstmpHOyZtglZ3dQKPVOzA
	 5q42QIfANaxwBTPXVpVW5fGAyETO3KJPBkXsf1iaU7RjdDx4pGw19HEbScfXwJ4fzL
	 1m4s/uPjTa4jS8zS23sufqUi3+wXCOXoJeIMGq9cJZBQJGa3yIjxsGPgjf6nb9MjQ7
	 DFVeRTdMUqkOA==
Received: from nbf.rojer.cloud (unknown [46.32.99.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id DAC2821653;
	Fri, 30 Oct 2026 14:22:27 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawn.lin@rock-chips.com,
	llj@rock-chips.com,
	Deomid rojer Ryabkov <rojer@rojer.me>
Subject: [PATCH v3 1/2] mmc: core: sdio: retry without UHS if UHS init fails
Date: Fri, 30 Oct 2026 17:22:23 +0300
Message-ID: <20261030142224.3183407-2-rojer@rojer.me>
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
index 83085e76486..b247786782f 100644
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
+					  oldcard ? NULL : card);
+			retries = 0;
+			goto try_again;
+		}
 	} else {
 		/*
 		 * Switch to high-speed (if supported).
-- 
2.53.0

