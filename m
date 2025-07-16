Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EE23496F;
	Wed, 16 Jul 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680879; cv=none; b=ToZhObZUVfcrbF79MNZpPjamvSYxcCrq7niV8GfKyTtguylUyz6sCKqDxHB5Qgs4cu6C/tbzvg9r7mM/ZXSD+/MK88iAkBXr7DneXE0p9dWifDwTBh9tpz4UZtRnfUTyXJEdiCu06gtTWH5byurdOvGnrMdht9vVxzWQwBIVyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680879; c=relaxed/simple;
	bh=Ow9KW3YcVSr0/nPhBv9tKtnie2AY1M86cNe3h2YVq1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIQBpseoyunesXaJPqtQP2WS2nY0iK0QfUEO0dSKRAVw2mXW/k1zq5A7eEI4nT34GvNJzaKwPGG52Hkll2ON1FQd/F4cY11B519HjSSKsOk2ZlKlbKcUhSh56/DPAc/kATxK+f+6qWTjD/e4uYTODha3Gc8izLB0YsRlPuJ7CJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AM+mZd0a; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AM+mZd0a"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26A9544459;
	Wed, 16 Jul 2025 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752680870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLD1DeoM4SdeI+gMUKY34n91PgjQmdYcZNQgzI0w0C0=;
	b=AM+mZd0aeFQmPJRgEKM6bcmPJ9hKMGRsBMJDZR0VIUE/nWg33d8pTzSzL9b/JQjWe6+Qt/
	97mP7M7Pv+4iB79TQN30FvYCqZLyz/aluoSd52J5787agkBN0szBSLd+wuwyhcf0+Rz4Ho
	YvCx8QzoyLqlveBc5QLDcbpuy4ixUFYKye1Ynf69x8EDlS0LiLba34oqucOX4Xgt2l3FPR
	+nRNpU/pxsaiKxj5Mr8gL6Dr0IHqJGM6s3QzOKk7svUNzw2/CtDSsoX1qAG7xEKLgFon4t
	oYs/D1SPqOljt7szAO/vIE35FDAWvaI26ijIsyfOUim4SfOSrVAzHQGyWtoJgQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 16 Jul 2025 17:47:14 +0200
Subject: [PATCH v3 3/6] mmc: mmc_test: use mmc_card cmd23 helpers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-mobileye-emmc-for-upstream-4-v3-3-dc979d8edef0@bootlin.com>
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

Use mmc_card_can_cmd23 instead of using a local and partial
implementation, and check for the CMD23 quirk with
mmc_card_blk_no_cmd23.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/mmc_test.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 80e5d87a5e50bea772c06443bca8f48f042d6ad5..67d4a301895c905bf52776f970bfc7a8f86a65aa 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -180,20 +180,14 @@ static int mmc_test_set_blksize(struct mmc_test_card *test, unsigned size)
 	return mmc_set_blocklen(test->card, size);
 }
 
-static bool mmc_test_card_cmd23(struct mmc_card *card)
-{
-	return mmc_card_mmc(card) ||
-	       (mmc_card_sd(card) && card->scr.cmds & SD_SCR_CMD23_SUPPORT);
-}
-
 static void mmc_test_prepare_sbc(struct mmc_test_card *test,
 				 struct mmc_request *mrq, unsigned int blocks)
 {
 	struct mmc_card *card = test->card;
 
 	if (!mrq->sbc || !mmc_host_can_cmd23(card->host) ||
-	    !mmc_test_card_cmd23(card) || !mmc_op_multi(mrq->cmd->opcode) ||
-	    (card->quirks & MMC_QUIRK_BLK_NO_CMD23)) {
+	    !mmc_card_can_cmd23(card) || !mmc_op_multi(mrq->cmd->opcode) ||
+	    mmc_card_blk_no_cmd23(card)) {
 		mrq->sbc = NULL;
 		return;
 	}

-- 
2.50.1

