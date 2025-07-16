Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14D1E9B04;
	Wed, 16 Jul 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680879; cv=none; b=HOS0s28nTpXB0U5Hg5L00xrhyhQyVL/O4YMBtWS/QwMbWIIeI0lmIOjrih5GeF+fTBauOXPLcYqnmcHek/AQld1fh+CkhFPlGvfIShdxlzQTjonh2+6Wp+sm+DIlNveBdZ4R2XhY+tjJ+5+URBJrHBhxdh5lGSkPeRq2j0L7t2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680879; c=relaxed/simple;
	bh=3eOdQOt/3/myQ6BG4kub6yREnqK/aimJ2gjQEsE/ZS4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=obKN9EFw6cR4QY/pyfv9I+q+DsxDwTj858NpgAVxxdRquIY2FRqq9660CRbsLlCPKuXvmvER3QX8NNjG/uz48NYC6bg6+p0xyXLMiB2blUWpLWWX5QK+noA4Uxhx0t/QJkxHSBLpQKEq/x8fKIyc5iLGR3to8NgyLawAlF/fk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TAwOnSl9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TAwOnSl9"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9673E44430;
	Wed, 16 Jul 2025 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752680869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=seTcTLcAmQis+HdwGtCVVlFE0RHayr4SEQ28RMy+gCw=;
	b=TAwOnSl9bpZyu4jEUef2bUBSIFHHoqWZWtEDAxAswJzRBRW1mYNi/lMeZcIwz7G0X8FJ/J
	fBoPomJhMpZkuFgmEEpumb6sciWuWsaMkpACCy17Y3aIMA5XgZJ2HONE36k4Xg1UuKBxb/
	8+fARLPMwj4uQZ25TIQs32sJKHk1rowsnW7TCOjhEbpjTgV7QygSbMGOAbuFH2xhysfGii
	booNYU/GnDe6C01ENlzZfw2UFtOFAJnWP3z97coMCU2RkseAAjjaFQu/QWHJDld+hWG15Q
	HvU/BpvLBdMdW1XAlOx7gXMvHhqic/ScaX0JqL4YfA8UDpR/hnCwoAts3vvaiA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH v3 0/6] mmc: introduce multi-block read gap tuning
Date: Wed, 16 Jul 2025 17:47:11 +0200
Message-Id: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH/Jd2gC/x3MQQ6CMBAF0KuQWTtJKVQjVzEsoP7qJJaSKRAM4
 e42Lt/mHZShgkxddZBikyxpKmguFfn3ML3A8iwma6wzt/rKMY3ywReMGD2HpLzOeVEMkVtuDYJ
 z1jeju1MpZkWQ/d8/+vP8AXisVJZuAAAA
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdekudfftdefvdehjeehheegjefgvdetuedugefggedvffejffefueevgfduvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehpdhhvghloheplgduledvrdduieekrddutddrudekjegnpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrgiffhhik
 hdrsggrhihouhhksehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrgh
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
only the status of the read operation. It also takes an optional card
argument, not used when called from execute_tuning() but present in
execute_hs400_tuning() and prepare_sd_hs_tuning().

Finally the last patch uses mmc_read_tuning to implement the multi-block
read gap tuning in the cadence host driver, by doing a multi-block read
and increasing the gap delay until the read succeeds.

v2 -> v3:
Move the changes related to CMD23 support by MMC card to separate patches
at the beginning of the series.
Change the mmc read function to be less appealing to reuse/abuse
outside of tuning context.

Link to v2:
https://lore.kernel.org/linux-mmc/cover.1751898225.git.benoit.monin@bootlin.com/

v1 -> v2:
Split the code between the core and the driver by adding a generic 
function to read blocks from the MMC.

Link to v1:
https://lore.kernel.org/linux-mmc/2a43386ffef4012530ca2421ad81ad21c36c8a25.1750943549.git.benoit.monin@bootlin.com/

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Benoît Monin (6):
      mmc: core: add mmc_card_can_cmd23
      mmc: card: add mmc_card_blk_no_cmd23
      mmc: mmc_test: use mmc_card cmd23 helpers
      mmc: block: use mmc_card cmd23 helpers
      mmc: core: add mmc_read_tuning
      mmc: sdhci-cadence: implement multi-block read gap tuning

 drivers/mmc/core/block.c         | 12 ++----
 drivers/mmc/core/card.h          |  9 ++++-
 drivers/mmc/core/core.c          |  9 +++++
 drivers/mmc/core/core.h          |  1 +
 drivers/mmc/core/mmc_ops.c       | 79 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_test.c      | 10 +----
 drivers/mmc/host/sdhci-cadence.c | 69 ++++++++++++++++++++++++++++++++++-
 include/linux/mmc/host.h         |  2 +
 8 files changed, 171 insertions(+), 20 deletions(-)
---
base-commit: 4ad9e44c76b301e786eb4cdab890eac8c7eebd42
change-id: 20250716-mobileye-emmc-for-upstream-4-40ef552c3b59

Best regards,
-- 
Benoît Monin <benoit.monin@bootlin.com>

