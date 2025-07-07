Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353218D65C;
	Mon,  7 Jul 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901896; cv=none; b=ppvATHe+CE6spuI9RwlLofu5HFdMqRDK7DqwXBKVp+zXn9g21CYuPk7r6WQoyLNCLr1ZBU9IivwUPbQZT+JKbDiSC+4up+dcuaj39/ZZOZi3VcNLTxadENfAE3y/ufSz3JzLJYQV+US0UJBob2SPun+X/XBEuVxuEKGBbSDD7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901896; c=relaxed/simple;
	bh=HDJuUsTdRx4FRdl3hzU7RUngWSLdrRf0zrs+Cx2N+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O7Ng6rSp99/loIxbtEgzUzlKBp3kVsAqpRGYCbWxO+5H0b0ih3XHwz+cPQkgHQgqQ4KqGyD87Mja9eq0T1eRDbhhSNMI82yUBVNfYZ1zkReHb1w0M7P6QvqDxLqjlmiM9IwGngRkA6FFdvuJcs5Vdw0g0Qunu829OA09lRt4F6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LrYJOgF2; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LrYJOgF2"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C69F43B21;
	Mon,  7 Jul 2025 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751901892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aqB9+6rqapT4VBuzNnKX6VIbAtAmBQKcp+EL4OWFilI=;
	b=LrYJOgF24pGARNIAD8FIn/U0mOkNmbq6tM/HEN4k/HVLOxfbxIed9LlAmQjz/YcZdEeXjV
	9gmBnZGeX8UfCQ1h5mKfVQZiUcr8Kf1nBDj5UyaDxSVP0wN4ZoA3CNCWutTR9SIuYYDO21
	yLgQlMYpGz19L44YJJQ4UQOuAF6FYzfd2pk5Ym7SsfnDnf6basOEWV1P3h429Np5WXY+jA
	1YkUW9/wI2/fcYiYrNmhqAg6qSzYuzLviY3bIiuxDBOR3TWEwLXrc5AjbfEZEa5M93nsFm
	7fH8K9avf/upzWK1RtlMy9hlyFHF3kt/FiqKNJTEjCtXWPCgeeGPGrAC6Hh8wg==
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
Subject: [PATCH v2 0/4] mmc: introduce multi-block read gap tuning
Date: Mon,  7 Jul 2025 17:24:32 +0200
Message-ID: <cover.1751898225.git.benoit.monin@bootlin.com>
X-Mailer: git-send-email 2.50.0
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeegffeutedvvdduvefgkeehueefueeuvdeigffgteegheefuddtfeegvdefteeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehpdhhvghlohepfhhrrghmvgifohhrkhdpmhgrihhlfhhrohhmpegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnr
 dgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlhgrughimhhirhdrkhhonhgurhgrthhivghvsehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehtrgiffhhikhdrsggrhihouhhksehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: benoit.monin@bootlin.com

This patchset implements the multi-block read gap tuning for the SDHCI 
cadence driver. To do so, a generic function (mmc_read_blocks) to read 
blocks from the MMC is added to mmc_ops in the first patch.

The second patch is the implementation proper in the driver which try 
to do a multi-block read and increase the gap delay until it succeeds.
The read gap is done by the controller when its internal fifo is full
when reading multiple blocks. That is why we cannot use mmc_get_ext_csd
to do the tuning since it only read one block.

The implementation of the mmc_read_blocks also brings a helper to check 
for CMD23 support by MMC card, similar to mmc_host_can_cmd23 for host,
so the last two patches uses it instead of local implementation in
mmc_test.c and block.c.

v1 -> v2:
Split the code between the core and the driver by adding a generic 
function to read blocks from the MMC.

Link to v1:
https://lore.kernel.org/linux-mmc/2a43386ffef4012530ca2421ad81ad21c36c8a25.1750943549.git.benoit.monin@bootlin.com/

Benoît Monin (4):
  mmc: core: add mmc_read_blocks to mmc_ops
  mmc: sdhci-cadence: implement multi-block read gap tuning
  mmc: mmc_test: use mmc_card_can_cmd23
  mmc: block: use mmc_card_can_cmd23

 drivers/mmc/core/block.c         | 12 ++----
 drivers/mmc/core/card.h          | 10 +++++
 drivers/mmc/core/mmc_ops.c       | 69 ++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_test.c      |  9 +---
 drivers/mmc/host/sdhci-cadence.c | 72 +++++++++++++++++++++++++++++++-
 include/linux/mmc/host.h         |  3 ++
 6 files changed, 157 insertions(+), 18 deletions(-)

