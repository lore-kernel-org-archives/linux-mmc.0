Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D651802CF
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776617; cv=none; b=KHFLhsw6KrFakMtx6v09rrITeu6eI8raJJ0r3ESI5pOc9qFofvLFVHoAh4njlWxnBe1JTV1LSIjx4G3B/JXEMsJ6Y6queRcyBgmZUVKVAYmtZsIri3vS3j+pd9eIBtVEYSg+y6DopsFtGkk+ku4vsbV1+tXYfyUmA/IWyzyTdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776617; c=relaxed/simple;
	bh=TmPMzy2QrKbaAv7DsDatyIH9559HKewe/ccvDgjokko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgIKs9UGHH+wdivsEI6e6N9RYnnl091L3LFCyaNuNE5CX2AQ68kW4m2p+6k5eajdkmHvOGvHjhIgiHfxPvuNrLhBND0LoZcDX0CSnGof9AC4P1xZm2p6ZXIAn9SVwGj65lepnVzQxYh1A6vderdXDwhJhanjB/4gFr17+SlmyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hq3to3iU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hq3to3iU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712776615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GS63d3wUNACBhBMB1wMLf9jnd6fxCOGCI4o4/hkcZk=;
	b=Hq3to3iU/+vRdMOAyd0+CAZYdx8D/Cj9hybu9w/9PeKguF4i0l8r1gklImY3PaRK0nzn3Q
	Ut9oE3USDr48iyIqtWZPwOkM7qZoB+hsQpbp5XI1P80FwB/KYPoB5YiijNLK8TgvjCCNZo
	i5wVFIZCvK/1Zuinapu4wd47L/xf7v0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-O5HO4J39OLGwaCTjip0aPg-1; Wed, 10 Apr 2024 15:16:51 -0400
X-MC-Unique: O5HO4J39OLGwaCTjip0aPg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4A531044577;
	Wed, 10 Apr 2024 19:16:50 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.79])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EDC3A44434C;
	Wed, 10 Apr 2024 19:16:49 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 5/6] mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
Date: Wed, 10 Apr 2024 21:16:38 +0200
Message-ID: <20240410191639.526324-6-hdegoede@redhat.com>
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

On the Toshiba WT10-A the microSD slot always reports the card being
write-protected, just like on the Toshiba WT8-B.

Add a DMI quirk to work around this.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index c0d77f589deb..f7d4808413cb 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -779,6 +779,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
 		},
 		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
 	},
+	{
+		/*
+		 * The Toshiba WT10-A's microSD slot always reports the card being
+		 * write-protected.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TOSHIBA WT10-A"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.44.0

