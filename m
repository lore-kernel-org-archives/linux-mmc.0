Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1AA22ACEF;
	Wed, 16 Jul 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680879; cv=none; b=ubRoEKV0+Q0mMiYJyYQGa7gM2xcCJNhun6fEIB6oFPPHXLgMRCKePPD08BCcJAmDjRq9iEh4hg4cOvKXTJRMnQz9dgodgfI/IenfjJDaXVhjcudZfDG5pCTXM1GTt9nsXTtdViSAoo5vkMU1sNeQRbbEo4XEiEIwjqa2cvdOwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680879; c=relaxed/simple;
	bh=Upf/68ziVHah6Rlks/oNHiBue0nYeJly5A97BtbIxys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQnXRSVib/E5BOcqAY+PwkVsl+Had/tXQrbbSctrV1sgZAlr4CoFtZ5MdBWSXnr9XXo+LnlgRv86vINsRb5C9HVsN2grt3Rbiva0bCflJk4rQQZWpuTYrz7qpTGWaMH5xX81QQlhBw73C7D8ZAzEN6CYZcb2Ult7qvoXnSmfSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UbAW5QN0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UbAW5QN0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 407D943B07;
	Wed, 16 Jul 2025 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752680869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2K3ECqs8b7BXS3Z8XIsoknOfTvpoi8O6hgk61rndGZg=;
	b=UbAW5QN0INvxHc7csNuPq5SWWSctRRna/vGRLSWgp6w+VfRnsv7zXM0WooOn2X9qWameGu
	DclDVXVuUEirCcThVRH/crMcXkK9LL757UvIKZIZcaU0cEYzoi03Dt6NEWZuotUylEtGJL
	2vX4sewyQdGBux+lM/+Q8Yty2b/H6ud2gEJYsGWEeW8vQLGRfaAV/C06S6mBZfFL2Tru7m
	iG6XJBynf/afio6DVe/70Oc/qE1LVTRGiB5TUfRG2UasDVMVE3Ix9/TckMu+edZvGgrbBY
	A23JdV95JD+o4xFESRbC7P8f4AWwSZq1IdTCfKZ6shSOu2N8SE3WT1y7qScHZg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 16 Jul 2025 17:47:12 +0200
Subject: [PATCH v3 1/6] mmc: core: add mmc_card_can_cmd23
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-mobileye-emmc-for-upstream-4-v3-1-dc979d8edef0@bootlin.com>
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

Add a dedicated helper to check for CMD23 support for MMC card, similar
to mmc_host_can_cmd23 for the host, as it is easy to get the check
wrong.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/core.c | 9 +++++++++
 drivers/mmc/core/core.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 874c6fe92855e3535ec0ebc0254146f4b96bccc3..88fd231fee1d150b22baebddb7ad47472c24fb32 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1875,6 +1875,15 @@ bool mmc_card_can_secure_erase_trim(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_card_can_secure_erase_trim);
 
+bool mmc_card_can_cmd23(struct mmc_card *card)
+{
+	return ((mmc_card_mmc(card) &&
+		 card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
+		(mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
+		 card->scr.cmds & SD_SCR_CMD23_SUPPORT));
+}
+EXPORT_SYMBOL(mmc_card_can_cmd23);
+
 int mmc_erase_group_aligned(struct mmc_card *card, sector_t from,
 			    unsigned int nr)
 {
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 622085cd766f91334d5b9362cd7b96245af8884d..73f5d3d8c77d5da53795fe09beb384f134d6a886 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -123,6 +123,7 @@ bool mmc_card_can_trim(struct mmc_card *card);
 bool mmc_card_can_discard(struct mmc_card *card);
 bool mmc_card_can_sanitize(struct mmc_card *card);
 bool mmc_card_can_secure_erase_trim(struct mmc_card *card);
+bool mmc_card_can_cmd23(struct mmc_card *card);
 int mmc_erase_group_aligned(struct mmc_card *card, sector_t from, unsigned int nr);
 unsigned int mmc_calc_max_discard(struct mmc_card *card);
 

-- 
2.50.1

