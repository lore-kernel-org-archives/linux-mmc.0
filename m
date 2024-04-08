Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51425146592
	for <linux-mmc@vger.kernel.org>; Mon,  8 Apr 2024 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605983; cv=none; b=Tc8CaE7KstaXfWZkDr6CcanfD8B+3oMr3VJRBPTehIaZsQoxv5Hmb/bXESEIZjIJ8nB4gCCrMKRJsZtT5qy/PLIjJ5d8Upf/atwXDW3vhnu7GuW/zU5/bYaVziLKo21An4A1NMY7wLeUJfIhdYRosAdTdDz8CyvZHtMcJ6HqefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605983; c=relaxed/simple;
	bh=OacNPQzbXIa/mn9dQGxo+36265tL/N+nmoM03VRBvs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huFJFkwcD46tJsRo0nFxjIem07hSH0Q7He+p1LQmxO7KcYSrs2wDnAi8pu4bW/B9xQyQDWIWsVBNtt2svDsMUThCu2puG3rvKkJYOnzxUrvSF3QZETYV62YMxrFJhhNHCCmYsHC+jHwUB6awkcp//WjQREWF3EPIB2FIh3l1EZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bd9sbUSF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd9sbUSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712605981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+wvgzyYeENvi/VB7umYj+Lj+cu42xiFl7Q21VPLb9s=;
	b=Bd9sbUSF9jh2KvPzubL3HAoIxf9rrPULawPg92XIz6DJvPOYwYOpftmWrDerbKHruEW7DG
	ak8++B441jKe6ytfLHsIjqnjZSXiazueka6kR5gi2+tYTSLS1C1+TmVa5pvUrBtwbcGYNF
	wzIcktVIYpxjSyab94k05uiknA5eW/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-ykfFIG2vPVyAfQjtjY6seA-1; Mon, 08 Apr 2024 15:52:55 -0400
X-MC-Unique: ykfFIG2vPVyAfQjtjY6seA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6721E80D67F;
	Mon,  8 Apr 2024 19:52:55 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E1321C06666;
	Mon,  8 Apr 2024 19:52:54 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 5/6] mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
Date: Mon,  8 Apr 2024 21:52:43 +0200
Message-ID: <20240408195244.248280-6-hdegoede@redhat.com>
In-Reply-To: <20240408195244.248280-1-hdegoede@redhat.com>
References: <20240408195244.248280-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On the Toshiba WT10-A the microSD slot always reports the card being
write-protected, just like on the Toshiba WT8-B.

Add a DMI quirk to work around this.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
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

