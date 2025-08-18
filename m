Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8731CA48;
	Mon, 18 Aug 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525795; cv=none; b=sD7qcmOl4gW/xl2Pd4XP1T9CayH1O2L0EpYwtjptVKHA/aMc8IVbB1hmx/fbm7cOCw5gLr3g2Uz2qGC1S1owIoIyP6jpGD4mol8yavOLMtlt5r7DGx67OkEj+vg4DOemTCKZ3Al2EIx0RmgM6LhjeW/B9EAO3oSVKhEgMKFrFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525795; c=relaxed/simple;
	bh=u/Mh6QMW/fxl5ex7MvG974k7mfVE7yTG8KRGiyJjEtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7OtU1jvpj7ZPqdWhK5LUF3TL9gS0y3V3PP1SnIRF+cGmyVJvw6pJh6ASr+wbLakmH9LagIflUhHtEl+HtTeFqGp6IT2UQ0KUAvj6aqPR5FpKSMSeF6SJpK/4OcCTlk3p5zwjOssAyYRpLkQ4TLGjAzGYYrLVXRNsOIBlYspX9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YYyUa0yS; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YYyUa0yS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32EE64397C;
	Mon, 18 Aug 2025 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755525789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zMyivun2ZhPaC0c15Jzxv6HXN5r+otqFCrTgy5NlLg=;
	b=YYyUa0ySBNxGJDxmURFn4kw+zGH7ZzGSx153oSj8Gv8vAjFia9zxYAkwe3aNmicTv1b748
	NRsmlGRDnlrEreZGnEbCWzdvp3cZGui1wecojqGMdjvivEpjzhhtaIZVqlMFIBlo0kzh15
	qTUio7Jll7pYIRs7rMib5nJGgnfImNHTNVxrMyI7/8O67e++gDWNTQvgdE1lGKZPFQH2DF
	7c1a3U/FzcQJKT/BB96c6btpceAC/ogC+u24Yy60tbb5HEN7RMA1C5Kzo60iWFg1dxOrib
	Sk6AsM0W9c7hSoyaUkGAv8rl7hmItI5tm4q/LeBA0rt2PKntOb7XHXRvhoBIzw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 18 Aug 2025 16:02:47 +0200
Subject: [PATCH v4 2/6] mmc: card: add mmc_card_blk_no_cmd23
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250818-mobileye-emmc-for-upstream-4-v4-2-34ecb3995e96@bootlin.com>
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

Add a helper to check for the missing CMD23 quirk, similar to other
quirk helpers. Also reorder the helpers to match the order of the quirk
bits defined in include/linux/mmc/card.h.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/card.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 9cbdd240c3a7d42ecbb45cbc52c5562e4664ee35..1200951bab08c2e18ce96becf56693e696b9f30b 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -245,14 +245,19 @@ static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
 }
 
+static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;
+}
+
 static inline int mmc_card_disable_cd(const struct mmc_card *c)
 {
 	return c->quirks & MMC_QUIRK_DISABLE_CD;
 }
 
-static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
+static inline int mmc_card_blk_no_cmd23(const struct mmc_card *c)
 {
-	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;
+	return c->quirks & MMC_QUIRK_BLK_NO_CMD23;
 }
 
 static inline int mmc_card_broken_byte_mode_512(const struct mmc_card *c)

-- 
2.50.1

