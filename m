Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9032E266D;
	Mon,  7 Jul 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901898; cv=none; b=gj2vaNdJtwNNmgLncf4ivpJvSxcC+m1gM36wrddgsQF86VHVzlom2rnypHB/SXXu7pMSjaD8WzvXv9qWdxC3cGDBilgC2Z9p9Ae/0DyvOn2uL/rOSAvcPGr7z7wpi8NLsb60yHJSFXSjipQcB+f7ris7uJPRR4f11SRtJT1dq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901898; c=relaxed/simple;
	bh=NxfRsEXjom4ScRJ/zhIsda4QU9wioouFB6Bmwo+evJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6UkhuMPIHG962Sxig1je5O+VpVDBkkX4InjJ+/OkspDtWvPH5Z0WC7wVS4clALMzuz6kOPiOoUA/CSqY7ig3Vz5w7DkpqMI4E8//fYXAuwwBVWx2UHixMLRJkHBbpeZ0tpvUS5av/68zwC6jTK1uCfGEw50dgUDdoj+ecPuzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ono6DK67; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ono6DK67"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 244E04446F;
	Mon,  7 Jul 2025 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751901894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vasRCk+heDQuoeK+7MeJyn1gmxGcI290u/BrgCMWho8=;
	b=ono6DK67DVwZIz2qDQkMyiWT5r4IO2vHb8D/a70PpABHMtSwFpA+MAkHAD+kTS6S+xMKo6
	hWoABuyW/o4zFMf989HB8k+7N8v1eO99f0vEFk0nQEIASBhJEYLuVKzXQ8AgAM+2uiJiIp
	igxqzTvWhrmNl/BrlLE5WN71/Q5ICZx+zs1j/q0y+uTzjUVe3mT7JHswrn6pObfrGbdm6l
	3EDS8KA2nDJLHLNdCowbPami8zzZ1daiTi33B7q/pABeJsIZ13GdYgYPbmHHI8KaVpTZMK
	/gDRZ2Dw8QuxTTLLtJhJAp9ABr/WOLOTrvsvYoDBOTiWJfx99OXdbKZSL6EQcA==
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	"Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 4/4] mmc: block: use mmc_card_can_cmd23
Date: Mon,  7 Jul 2025 17:24:36 +0200
Message-ID: <fadea910693438b256841ba41e5e725172eb5198.1751898225.git.benoit.monin@bootlin.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751898225.git.benoit.monin@bootlin.com>
References: <cover.1751898225.git.benoit.monin@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdfffeeiieejkeevuefhvdeggeefudffueeuffehffehffevjedugfdtueegtddvnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopehfrhgrmhgvfihorhhkpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigq
 dhmmhgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhlrgguihhmihhrrdhkohhnughrrghtihgvvhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepthgrfihfihhkrdgsrgihohhukhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomh
X-GND-Sasl: benoit.monin@bootlin.com

Use the helper to test for CMD23 card support. Remove the check on the
NO_CMD23 quirk as it is already done in the helper.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/block.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9cc47bf94804b..f67f5ff97f896 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1768,8 +1768,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	 * these, while retaining features like reliable writes.
 	 */
 	if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
-	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
-	     do_data_tag)) {
+	    (do_rel_wr || do_data_tag)) {
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
