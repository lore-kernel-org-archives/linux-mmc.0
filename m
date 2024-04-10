Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75313180A92
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776616; cv=none; b=Afso4LJQIEqqBRnN8tAj1Ds1uEzoBj4CktmaFa7q0CqzdE/W7fS95zByeuNNLmZTSeux/vPqrblk5ku4QuVM9W+Vp/f6b2RL4p5Feh9GKtu936CCYUAEzGlHB9xvaJfzzvsiKnfsb4ChjU1qzq2uKdFjkk160yU93+YHu6Sc8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776616; c=relaxed/simple;
	bh=hny3GcJw+cOyC6bi3JxwpIxmCwZ+53tgY8yhvtqrX0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM1L+xSYOqHahO5juBU3BL9B8ZUbFixHnsYlmtm5e+9uHT+2XgEBMK8PjYRY6I9iBeziUou6aCu7CoA9NIOkaHqDJPuy5L9yv49pI3W0sqSJ28RUZccC8KvHvT0C+Mie95PxLsYEiFZAgeadHfB6VDZmspJy6iuiY2yH2HPvw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6pQFfCs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6pQFfCs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712776613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz3RoyVxm3ohgGMY00h1dvUybE8QFAe+1sOh2Nw6T04=;
	b=T6pQFfCs5cm2PIg5fzvbXWVcCV8IXQ/5tSCK03sdQ8a73zaREEyo88uRN8EOGXaZOYMV+g
	lB2MtPZndiSlODtKWgBUQV5evqp45gsg8N+9VnO/AyVKTVowSyU4egSYusBr2ZEU3LprsC
	iYY5rOSsREGZOTlFjsZU+S/voxvtvQk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-Xll1i70NPECketf9WmcCGQ-1; Wed,
 10 Apr 2024 15:16:50 -0400
X-MC-Unique: Xll1i70NPECketf9WmcCGQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD65C29ABA0D;
	Wed, 10 Apr 2024 19:16:49 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.79])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C3B2B44434D;
	Wed, 10 Apr 2024 19:16:48 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 4/6] mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
Date: Wed, 10 Apr 2024 21:16:37 +0200
Message-ID: <20240410191639.526324-5-hdegoede@redhat.com>
In-Reply-To: <20240410191639.526324-1-hdegoede@redhat.com>
References: <20240410191639.526324-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The Lenovo Yoga Tablet 2 Pro 1380 sdcard slot has an active high cd pin
and a broken wp pin which always reports the card being write-protected.

Add a DMI quirk to address both issues.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index d2003d3be6ba..c0d77f589deb 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -80,6 +80,7 @@ struct sdhci_acpi_host {
 enum {
 	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			= BIT(0),
 	DMI_QUIRK_SD_NO_WRITE_PROTECT				= BIT(1),
+	DMI_QUIRK_SD_CD_ACTIVE_HIGH				= BIT(2),
 };
 
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
@@ -747,6 +748,26 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
 		},
 		.driver_data = (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
 	},
+	{
+		/*
+		 * Lenovo Yoga Tablet 2 Pro 1380F/L (13" Android version) this
+		 * has broken WP reporting and an inverted CD signal.
+		 * Note this has more or less the same BIOS as the Lenovo Yoga
+		 * Tablet 2 830F/L or 1050F/L (8" and 10" Android), but unlike
+		 * the 830 / 1050 models which share the same mainboard this
+		 * model has a different mainboard and the inverted CD and
+		 * broken WP are unique to this board.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VALLEYVIEW C0 PLATFORM"),
+			DMI_MATCH(DMI_BOARD_NAME, "BYT-T FFD8"),
+			/* Full match so as to NOT match the 830/1050 BIOS */
+			DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21.X64.0005.R00.1504101516"),
+		},
+		.driver_data = (void *)(DMI_QUIRK_SD_NO_WRITE_PROTECT |
+					DMI_QUIRK_SD_CD_ACTIVE_HIGH),
+	},
 	{
 		/*
 		 * The Toshiba WT8-B's microSD slot always reports the card being
@@ -867,6 +888,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
 		bool v = sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
 
+		if (quirks & DMI_QUIRK_SD_CD_ACTIVE_HIGH)
+			host->mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
 		err = mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0);
 		if (err) {
 			if (err == -EPROBE_DEFER)
-- 
2.44.0

