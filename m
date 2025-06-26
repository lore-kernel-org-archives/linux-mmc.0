Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9B2EACE2;
	Thu, 26 Jun 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949064; cv=none; b=b8d3xP+0y2b+P+mP8wmVzpt2APICScL43b5MnpbLT75p4pPUWQ2qZjwQ8TXm+OtEo/qmXaunXn41TriNcByDck5YsJmKeJV6o2aPlZmzW9+vNQ9oeFCl9naa9PhLsqRJv/NWaHhnTk5fp46gl1gr8OMssFeIDLfg/E1GSrlk1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949064; c=relaxed/simple;
	bh=R0EAGFvGQvjHkEc/P20pc/uZXUZetD/oYeIUeMMSOss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KNRezaWF3l5f9mSyCqVmC047z6z6C87rTvoDNWNXSFUZ2HL4MjMKSHfbJDjZYi+uMzKfhjLzNnGvpOYW6Px2QmZGzb+3FYPQlqFmBYPlUQqfzwN2lX9TUdLlUZiTImG9CvMEH3WRJVcuFiYyEGzCGREcH6LfGHnd7iPBk52wx7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e+8fKDOM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e+8fKDOM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEB98432FA;
	Thu, 26 Jun 2025 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750949054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NLIpxdvEyX0BS9Lol0bxELVMpm1LUgYGVcDm9ZkDjDM=;
	b=e+8fKDOMIU9DOssH04m+lhj1+DuBBNM0/7li5I/omYYlWWCXBldOftrvPuoylTWdrEgP4U
	lDUBBuM8miRLtMBQOUGf12emXTYAyQTXf4zeNNdGFg5ANVV5Zu5bGONKNuU7NAE2mZoYSz
	qOhZktgpmjP4q2je0XdoM2ivyULmfbtRr9E9vu90i2vKw21Yb9/7ojIKgU47vos44GJeTZ
	UV8T5rlqlMy9X1Bju6vLjTYYmvAWuDP9iWCKxUTPZDGZbZdnT282BO0S5OzfF/ToSvQwWj
	yUCzUkoOsQxtPxYm8iKKuhpgiSjCOuGQu+juhJiYYYpCw4o+kJALQQJmsE0h2w==
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	"Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/2] mmc: sdhci-cadence: warning fix and read block gap tuning
Date: Thu, 26 Jun 2025 16:43:30 +0200
Message-ID: <cover.1750943549.git.benoit.monin@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeeuhefhveehuefgteejheffieefhfejffdvteejueefgeegvdfhteehtdeuhfdvnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopehfrhgrmhgvfihorhhkpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmt
 gesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlhgrughimhhirhdrkhhonhgurhgrthhivghvsehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehtrgiffhhikhdrsggrhihouhhksehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: benoit.monin@bootlin.com

Two patches for the SDHCI cadence driver:

The first one fixes a misuse of of_property_read_bool to detect the 
presence of properties in the device tree.

The second one implements the read block gap coefficient tuning for 
HS200 mode. It should work on all cadence sd4hc controllers but has 
only be tested, and proven to be useful, on mobileye boards. If needs 
be, it could be limited to mobileye,eyeq-sd4hc compatible devices.

Benoît Monin (1):
  mmc: sdhci-cadence: use of_property_present

Vladimir Kondratiev (1):
  mmc: sdhci-cadence: tune multi-block read gap

 drivers/mmc/host/sdhci-cadence.c | 144 ++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 2 deletions(-)

