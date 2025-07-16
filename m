Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21B22F762;
	Wed, 16 Jul 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680881; cv=none; b=e6Hcw/sz/ldE7yiIKhBYF2ynf2o84FWak5DL39Rk5OUWqOiyr2zy224r5K15AyReqhboYefrSlyxIa6gQWgEDZaQJeoQQNQEKlJ9xYLOX9e7Y645t8TOBs3HwN0OfvkUTMpot3DKVI4CI9BGXnBBNSHN6sHQa+JpJfYh063egkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680881; c=relaxed/simple;
	bh=u/Mh6QMW/fxl5ex7MvG974k7mfVE7yTG8KRGiyJjEtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3NoghL83ns7ItNXYk1xGYFyzUY7fKjZqdptUVtlaACuYfw75mGdl3knA8b/2sfVrVeAlS0gJ1NhK3FexfojmoTGMXDAVb12f37Y7peqB4IkvkUX6ixSNBOlxP0BruozfoRtoBS7jgWoOAIgL85UpFMnUjvnfWd8ndpQTRlEFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xd0VeBTi; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xd0VeBTi"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6BED44408;
	Wed, 16 Jul 2025 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752680870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zMyivun2ZhPaC0c15Jzxv6HXN5r+otqFCrTgy5NlLg=;
	b=Xd0VeBTijV1ILQGL5QMy3QW/UdW84EfTQE45FD5X3xf2bf/5GT6QmzB8SGrqq3tezK8nnP
	z4Pm+zVEbO7SAJTbsO8K8MqADzDylk33H42p2nEtusDV+mXLdv2jr8PW0RsKdQr4kEHAJY
	OwWH7cbYIlMH+R2gL2/SYlORNJXZ3qCmB9i78KoRKUN9ymePn9/vpfzHMxr3gm4zEUe/Fj
	tVLf4vsd27ma0f3zzbhMRxhz3jpMrt7QTGT5GvFP5A+BMtw7OQyPmid6bioqSo0quOEPkz
	Qh+dyiHMZWyiTHAmnWu+NlQ+S0lZvL5g/uf4qdT0YC20oT9ey9Mnlkvl/N9w/w==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 16 Jul 2025 17:47:13 +0200
Subject: [PATCH v3 2/6] mmc: card: add mmc_card_blk_no_cmd23
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-mobileye-emmc-for-upstream-4-v3-2-dc979d8edef0@bootlin.com>
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
In-Reply-To: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudefgfdugfffgfeuhfeguedvuefhkeektdeludelvdelteelteejjeeiteetvedtnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopegludelvddrudeikedruddtrddukeejngdpmhgrihhlfhhrohhmpegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmhgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthgrfihfihhkrdgsrgihohhukhesmhhosghilhgvhigvr
 dgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhg
X-GND-Sasl: benoit.monin@bootlin.com

Add a helper to check for the missing CMD23 quirk, similar to other
quirk helpers. Also reorder the helpers to match the order of the quirk
bits defined in include/linux/mmc/card.h.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/card.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 9cbdd240c3a7d42ecbb45cbc52c5562e4664ee35..1200951bab08c2e18ce96becf56693e696b9f30b 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -245,14 +245,19 @@ static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
 }
 
+static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;
+}
+
 static inline int mmc_card_disable_cd(const struct mmc_card *c)
 {
 	return c->quirks & MMC_QUIRK_DISABLE_CD;
 }
 
-static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
+static inline int mmc_card_blk_no_cmd23(const struct mmc_card *c)
 {
-	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;
+	return c->quirks & MMC_QUIRK_BLK_NO_CMD23;
 }
 
 static inline int mmc_card_broken_byte_mode_512(const struct mmc_card *c)

-- 
2.50.1

