Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C472E2664;
	Mon,  7 Jul 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901897; cv=none; b=RW+4mCZhqAdR0mpT6NRRjADgPcp35Cgumuh98pxcyqJn/JyhJRjfZK6IPBs9aeSbe2TKnBqKmFr3tyfZd4iAA0AhXlUuZT6kpJSEO0dL+URlpJY9px2gS/H/DQ6Sdbnv0YFO+I1dun9hnrT5C94ufdINC1+fuoaNl1dkdMko3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901897; c=relaxed/simple;
	bh=gIQsxmwoSHoTmKUAUr8Mq90worR0CkHb2rdYBEvdFgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjWE4bCtWcGFX9FlRagPvADu2vMNz0qEtkijCywEcPVxA77Zwyyv3xIhk7FOZY4rwbrMNU+kJKrWm05fhS0RQkD6szw1XptJNTf8QfHEJp8GnlD7hdfRWlMO27+Mu9xhP9YXcrwH8G2p7V63UiA5Jt8yl7MQRDj7OWHCqd+4G1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EY1uX1RJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EY1uX1RJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF54042FF4;
	Mon,  7 Jul 2025 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751901894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ouoUClIh/gkR2NWqCpyq8tEKwC8nAl5LCDvLuhVBOEI=;
	b=EY1uX1RJBJnEmI+zRwYa7tTMkYEnY37nnKQJ0s+3laLzeZN2paar7st+A4Tnu9q+lDdZQt
	xAW65/+Oc+o2ZUHLudaUDrRjh0Q7zUCdyHRE28O1PEcOqbrkzhgAexmScsOOdV7Cz66P5N
	J2zCTD2wV2Rl5lldKnb7u4X5IYUdFNuCH+v+rtwjaK0vXVAmNloWeKcrznpjtDGnewcDo9
	0IE3XXg7LghzjXJEMZJOgHagPnMV0oOAwdSUlp2S6ZZpOixUKE9JvBez9s8XeJsVhvNY/L
	lP/OJ5ex6cKlcHJfdAI26An48JIW5TA1VE8WUmoD+aYDy0oLOelPe/9+Ocekkg==
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
Subject: [PATCH v2 3/4] mmc: mmc_test: use mmc_card_can_cmd23
Date: Mon,  7 Jul 2025 17:24:35 +0200
Message-ID: <a22054a674e895625ba84e64175e0892217a12e2.1751898225.git.benoit.monin@bootlin.com>
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

Use the helper instead of using a local implementation.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/mmc_test.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 80e5d87a5e50b..58413af22517b 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -180,20 +180,13 @@ static int mmc_test_set_blksize(struct mmc_test_card *test, unsigned size)
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
+	    !mmc_card_can_cmd23(card) || !mmc_op_multi(mrq->cmd->opcode)) {
 		mrq->sbc = NULL;
 		return;
 	}
