Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F823D971
	for <linux-mmc@vger.kernel.org>; Sun,  7 Apr 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520306; cv=none; b=KJVi7IDWF+OFxfuVZvFYgXw34TYhGwIM9QiMP0xRLMnXZ9f4wjTITBfos9r6txMogrAtK7oNUYDz4OmFLir7++ECoctEMS1bXT1lmNr/QO42X1UtV2X6/MwxTfSeXwl6ScPAdpJBe0DT3JLIdiM7TPCy5Pq3oXBzS8sayRUL9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520306; c=relaxed/simple;
	bh=upMUJveLAYrZFBF6DFvlvMPvK8XcF4uLJEsPWzW6Muw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKEqBpTIUMjSaa+Ufg9lS0Cimq+vQQWksjfvjs7sO9NmishyhzxtHV90Xk3XFsSh4Gljw4MB1yz2pPlvAk/cDfMjjCJPdBrvigr4kk5LT/jMNT1Ux77VqhkoxUWRLXP4IjfPKamZIPyukA+JAMexQuC1aSmCvI6kf42f9yX0RVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+n7tuoR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+n7tuoR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712520303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMoicdiKA9eMl9AI9QS4kybM1TdnA1yFigYV4EpBH24=;
	b=D+n7tuoRB1jcR+IQiXe3CQ/N/FO2VM9wUsNrb0v5u2y2AICQ00bHGS5EB5tBQSkBtZa6Ro
	vbn4uJudaZhiYTL2XElVUikMaFsO8CaAxJEknMFbrP8i0GYZB6LmGcXnsX280uWhmVLbvo
	Ckb+I7COfX2P3Mh5bj0vnCuf2woZ1xE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-yPTskxDYP6SxpNrbZ7uZYw-1; Sun, 07 Apr 2024 16:05:01 -0400
X-MC-Unique: yPTskxDYP6SxpNrbZ7uZYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A34948DEF7C;
	Sun,  7 Apr 2024 20:05:00 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 90A7D112132A;
	Sun,  7 Apr 2024 20:04:59 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 2/6] mmc: sdhci-acpi: Sort DMI quirks alphabetically
Date: Sun,  7 Apr 2024 22:04:49 +0200
Message-ID: <20240407200453.40829-2-hdegoede@redhat.com>
In-Reply-To: <20240407200453.40829-1-hdegoede@redhat.com>
References: <20240407200453.40829-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Sort the DMI quirks alphabetically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index acf5fc3ad7e4..d2003d3be6ba 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -719,7 +719,20 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
+/* Please keep this list sorted alphabetically */
 static const struct dmi_system_id sdhci_acpi_quirks[] = {
+	{
+		/*
+		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
+		 * reports the card being write-protected even though microSD
+		 * cards do not have a write-protect switch at all.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{
 		/*
 		 * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
@@ -734,18 +747,6 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
 		},
 		.driver_data = (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
 	},
-	{
-		/*
-		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
-		 * reports the card being write-protected even though microSD
-		 * cards do not have a write-protect switch at all.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
-		},
-		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
-	},
 	{
 		/*
 		 * The Toshiba WT8-B's microSD slot always reports the card being
-- 
2.44.0

