Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B090340DA8;
	Mon, 18 Aug 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525794; cv=none; b=qxR6VO+7xOirZECCMZlxP5Bi4HSuqCtoVGJ8g7BpT6e3ehWM1fyLhKMWsGQjOp073vHGWcts6xZlAbPAOBLyFpEFF/HJcae9PqKt9Grr4eofkXrNw9y9QKdXSIJrh7H3c/eg0t3xhKpugzQQiQ1rgOIeIh7b4do7ROGqEQ0aloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525794; c=relaxed/simple;
	bh=RIZotKOz5Ep3lz0wNnNwyPOQQr0lY5YGcfA7KjZMSCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ODLOyNoofiaf839nQEHJCCtpef8h7p1VoY1YzalUjxrMQXIGIGa8wEk4afINsAFviWLLv/L7aL8uKPR6CNFEq7Hznh1QKlUNUTbYIUft0xCF/qwwAqEFBhkmedpGAwFpoLo+osLxUBzuuxXxcNUuObT+wvcw87UNPfzGnpia2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q5+Vf1tb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q5+Vf1tb"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F11443968;
	Mon, 18 Aug 2025 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755525788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FF+Y7GQlFFWDqelcq6YU/BMH84OMF9/QX3GwhYnuBYA=;
	b=Q5+Vf1tbhhQogyy290hbWlzGzWfE3Lb0NQaIXtfW2TMAcAmaIkiM/YcPCmxD6q3127roX7
	W1TLwqfQltHlZFNSi+ipGKc1cpbSKm4jL7tw1BLli6x6CkMPmRUJO0HdmShY1wqrJTUFJv
	2/3kazbHxbZLvkiFfVHLBKyrqFMH+oxg6P2I5th6PEo2E+4YHJnIISco1Mkd3Ix2cbeMVo
	1Bhv4B1VNZtR1BMfvCEAMD5JbwKwnfwemFCvF8hBK/RJZ33Ey3scjYGomikJZlSRdDjT0U
	vPnsRrcbtUX4MhdqMcwaJjYdiKj5rjITF6UAhlA8a2zd+xKuNrmDprYS3YgY3w==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH v4 0/6] mmc: introduce multi-block read gap tuning
Date: Mon, 18 Aug 2025 16:02:45 +0200
Message-Id: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIUyo2gC/43NQQ6CMBCF4auQWTumAhVx5T0MC2inMgllSItEQ
 ri7lRO4/N7ifxtECkwR7tkGgRaOLGNCecrA9O34ImSbDLnKtaouV/TS8UArIXlv0EnA9xTnQK3
 HEktFTuvcFJ2uISWmQI4/R/7ZJPccZwnr8bYUv/XP8FKgQmvqqrY3suTUoxOZBx7PRjw0+75/A
 cL1pe3KAAAA
X-Change-ID: 20250716-mobileye-emmc-for-upstream-4-40ef552c3b59
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepuegvnhhofphtucfoohhnihhnuceosggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeefgeelfedvtdfghffftdegieefieehhedthefhteehgfekkeffueejkeeukedvueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopegludelvddrudeikedruddtrddukeejngdpmhgrihhlfhhrohhmpegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehvlhgrughimhhirhdrkhhonhgurhgrthhivghvsehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtl
 hhinhdrtghomhdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepthgrfihfihhkrdgsrgihohhukhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmhgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhg
X-GND-Sasl: benoit.monin@bootlin.com

This patchset implements the multi-block read gap tuning for the SDHCI
cadence driver.

The first two patches introduce helpers to check for CMD23 support by
MMC card: mmc_card_can_cmd23 for support proper and mmc_card_blk_no_cmd23
for the NO_CMD23 quirk.

The next two patches use the new helpers in mmc/core/mmc_test.c and
mmc/core/block.c.

The next patch add mmc_read_tuning to read blocks from MMC as part of
the tuning. This function does not return the data read to the caller,
only the status of the read operation.

Finally the last patch uses mmc_read_tuning to implement the multi-block
read gap tuning in the cadence host driver, by doing a multi-block read
and increasing the gap delay until the read succeeds.

In the previous version of this series, mmc_read_tuning had a struct
mmc_card parameter and was making use of the helpers. This parameter has
been dropped so the last two patches are now independent of the rest of
the patchset.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Changes in v4:
- Dropped the card parameter of mmc_read_tuning.
- Updated the last patch following the review of Adrian.
- Link to v3: https://lore.kernel.org/r/20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com

Changes in v3:
- Move the changes related to CMD23 support by MMC card to separate
  patches at the beginning of the series.
- Change the mmc read function to be less appealing to reuse/abuse
  outside of tuning context.
- Link to v2: https://lore.kernel.org/linux-mmc/cover.1751898225.git.benoit.monin@bootlin.com/

Changes in v2:
- Split the code between the core and the driver by adding a generic
  function to read blocks from the MMC.
- Link to v1: https://lore.kernel.org/linux-mmc/2a43386ffef4012530ca2421ad81ad21c36c8a25.1750943549.git.benoit.monin@bootlin.com/

---
Benoît Monin (6):
      mmc: core: add mmc_card_can_cmd23
      mmc: card: add mmc_card_blk_no_cmd23
      mmc: mmc_test: use mmc_card cmd23 helpers
      mmc: block: use mmc_card cmd23 helpers
      mmc: core: add mmc_read_tuning
      mmc: sdhci-cadence: implement multi-block read gap tuning

 drivers/mmc/core/block.c         | 12 ++-----
 drivers/mmc/core/card.h          |  9 +++--
 drivers/mmc/core/core.c          |  9 +++++
 drivers/mmc/core/core.h          |  1 +
 drivers/mmc/core/mmc_ops.c       | 72 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_test.c      | 10 ++----
 drivers/mmc/host/sdhci-cadence.c | 63 ++++++++++++++++++++++++++++++++++-
 include/linux/mmc/host.h         |  1 +
 8 files changed, 157 insertions(+), 20 deletions(-)
---
base-commit: 8936497143de1da7958178d57db6011eceeb14a8
change-id: 20250716-mobileye-emmc-for-upstream-4-40ef552c3b59

Best regards,
-- 
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

