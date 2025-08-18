Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AD340DAE;
	Mon, 18 Aug 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525795; cv=none; b=f22nWSluYflkq3DlGq35bcr4oy14B0V9WnZJMU8uxAf/BzTtCHNmGXR4NQfjOCZj1Km+LYIC/PDytQPXEEVt3nRotyXIyhH6jyZ9DgIIQfbM/fEUXtca9KWhZ5ztOC86SYj16Qnr3Ye3pjvhDLzGGDAtx8Az6hPXVK7w5Dfx3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525795; c=relaxed/simple;
	bh=Upf/68ziVHah6Rlks/oNHiBue0nYeJly5A97BtbIxys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVBaNeGwWTuf4+FvmTxz6lY44lYsjiqfE5TbqUsyf2d/ZaEbpYuXkO0wammdujZ8tW+7cEHYeOV/WpDakROZMtV6L2Fd5G1w31RAqKipotNVxO0/HShmxuEAoVwI4eaHT9Z1ZTRiL++75dlwGQ5g5iVthebDfdX7LZvfo28XlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q4DwIlLQ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q4DwIlLQ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3CB843974;
	Mon, 18 Aug 2025 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755525789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2K3ECqs8b7BXS3Z8XIsoknOfTvpoi8O6hgk61rndGZg=;
	b=Q4DwIlLQUdGNk9+8OgINidpKR2icZhPwJbKkER7jBmO4XGHmSe72dp6D+g9GZRwlQnuzrS
	vdxP5VBBhQnwszE2XbFNZLo1ZSwXlip8gYkelz/RjBeSAyejWRPNjRrHbYPli9n8wZC/wo
	QdCoXsAMjX8zB/PDvshh7Oy5oBzdiSoWaAdifetHq2SaTM5RIKB7cGzilOQdhQaXQapyk4
	aySUUIbyps2NwpMSBF72pumZro4B2VIfjNtSrApj3lkKqa7e54sNav3T9cMYR4OQ/1U1Jp
	N6K0U3MUv2Zz1/4uxcJ66U4y6AKtdN2rESeUkntTCleKqmlC8lczIOa9/iUGqQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 18 Aug 2025 16:02:46 +0200
Subject: [PATCH v4 1/6] mmc: core: add mmc_card_can_cmd23
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250818-mobileye-emmc-for-upstream-4-v4-1-34ecb3995e96@bootlin.com>
References: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
In-Reply-To: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepuegvnhhofphtucfoohhnihhnuceosggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedufefgudfgfffguefhgeeuvdeuhfekkedtleduledvleetleetjeejieetteevtdenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehpdhhvghloheplgduledvrdduieekrddutddrudekjegnpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepvhhlrgguihhmihhrrdhkohhnughrrghtihgvvhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesi
 hhnthgvlhdrtghomhdprhgtphhtthhopehtrgiffhhikhdrsggrhihouhhksehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrgh
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

