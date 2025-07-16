Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304F264605;
	Wed, 16 Jul 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680880; cv=none; b=TOygktlZU/CZHa/NBTrzRedIn2HmgGXC3MxGEC25sKxdlG3KMS1T2I0FoHnDXESCEyh7AE/aKQFIHKrwjEqSH8i+RFe3JXsCjRBI06RNb/hN7JlpWI/ECLjQMJ4vAo3UcvrFWMNYO9Ikqnf9kXkLcUn8YJI4dT1v7JyP+1a3isM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680880; c=relaxed/simple;
	bh=9lyUisWWwoQfSLcEFTWqqvap3ZZX/RoFNkOOQ++A9/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6erzDtdDEDaZ3j6iD7WC2XrfAInadAOGd0FolL1/GhHhhy3R6IeYLjZaJixXRIHWQ8ouM5UIT3eyEVwTRLC34JvtdMtaruLRCl+rNm0uxZzaVOtTgt0QAGdmCCuLgGr5m2loOCYBQCa5lmOD6QYzcKzgvKqpaOp2h48i4abIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mQMsvFXB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mQMsvFXB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90F1944460;
	Wed, 16 Jul 2025 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752680870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/B0tKSvtjHK+bMw61b+HxOpCHuU5fV5QHVywH58Gsxk=;
	b=mQMsvFXB/YBORkOeClB304ggf1tLU/tA9kf0B/7YWXr9q385FsKSsQSBWgxt0MHREMrVCN
	i9EuFeGRxwO7RX3gSZ5VcsaEUrGtkXVCecDAk//JM8T6iHTZDZLGf53LGYEeWjdBrRMss5
	6AdmAVsE4BrpinDs2b1i7Vb887IkTLDieO0gHe0eT7+RT5+6cD5FBzgcxGsvyaLzGF/Z+9
	oBsqAooPjkKK3oFyaaXaEdneSPtx7pinpI+RygwUISGcQzACWY0rMYa1FkzJMQ4ZrWvijI
	TfhdehgH9Tn5uMe2dnxQ7Og5A+e59BZFJ43VIs2w3KvnBi/zN5ZcHP0Oe5B82A==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 16 Jul 2025 17:47:15 +0200
Subject: [PATCH v3 4/6] mmc: block: use mmc_card cmd23 helpers
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-mobileye-emmc-for-upstream-4-v3-4-dc979d8edef0@bootlin.com>
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

Use the dedicated helpers for CMD23 card support.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/block.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9cc47bf94804b64a9cc60c7a5d95a0082d546ea9..8fd9891462054da8c00bdbb93e3414614441644d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1768,8 +1768,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	 * these, while retaining features like reliable writes.
 	 */
 	if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
-	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
-	     do_data_tag)) {
+	    (do_rel_wr || !mmc_card_blk_no_cmd23(card) || do_data_tag)) {
 		brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
 		brq->sbc.arg = brq->data.blocks |
 			(do_rel_wr ? (1 << 31) : 0) |
@@ -2618,13 +2617,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 */
 	md->read_only = mmc_blk_readonly(card);
 
-	if (mmc_host_can_cmd23(card->host)) {
-		if ((mmc_card_mmc(card) &&
-		     card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
-		    (mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
-		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
-			md->flags |= MMC_BLK_CMD23;
-	}
+	if (mmc_host_can_cmd23(card->host) && mmc_card_can_cmd23(card))
+		md->flags |= MMC_BLK_CMD23;
 
 	if (md->flags & MMC_BLK_CMD23 &&
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||

-- 
2.50.1

