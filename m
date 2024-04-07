Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254E3D569
	for <linux-mmc@vger.kernel.org>; Sun,  7 Apr 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520309; cv=none; b=TSZsF3Qxrqk4k7HF9x7gZXsjAQIeF6bOugXEPJ8Sndba6HUEmjwItXIzBlOcqjHdkaOIHELo9mevaB/EPKVCgD0tQg8teqUoBlOlrSIGjTegTHGLlNh857dFsFnBO3I+otIUTZbZbZ/sRjQU4AC+9ZPQzRRHCzRGLo0Jaq7V1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520309; c=relaxed/simple;
	bh=BkPfyh+/R/SAT/Dw3qhoPfUOKrJzhfKfc9c377XZyUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vwj70+zykjVK0fxQujM/hz+dK2Z4F41ik6mYjX8Ad10mTHAV1bztqBu++FERaU/HXP0z/Hg4C9evil825hA4Ti/mxtinmhsducUs5XzRcCqjAdfFcn8JG/TAho8LKVKZfne1uXXlOads8H9f8Z6TGx/R8+ykgWzz6Xp2GaQVfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a41Kbowh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a41Kbowh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712520307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++mJnVutmsBGOslhKKCtNNUogGbPipdKZBdIb1Fk3GU=;
	b=a41KbowhYY9125BgfRhJMfyAOvRHtkPr1OPGyP+51GJSWg3ZuH+xIGAB1pvlhi09zunXHA
	BNHliYOiji4vPekVtU9KFyGJ6AiaJSLaT7MWypQcl8eLPtMbBwMmlHtHoZrHY87EfJYpR6
	mau1Ci/xPFGpX0UWWm8Nnlks1p8cz+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-KMMAlvNSN5KWR5Os3IfTQQ-1; Sun, 07 Apr 2024 16:05:04 -0400
X-MC-Unique: KMMAlvNSN5KWR5Os3IfTQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57BBC10113D3;
	Sun,  7 Apr 2024 20:05:04 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61783112132A;
	Sun,  7 Apr 2024 20:05:03 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 5/6] mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
Date: Sun,  7 Apr 2024 22:04:52 +0200
Message-ID: <20240407200453.40829-5-hdegoede@redhat.com>
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

On the Toshiba WT10-A the microSD slot always reports the card being
write-protected, just like on the Toshiba WT8-B.

Add a DMI quirk to work around this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 233af36d55a9..ff45114bf886 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -799,6 +799,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
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

