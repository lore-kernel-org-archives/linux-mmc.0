Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C08176FA2;
	Fri,  1 Nov 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456094; cv=none; b=aC2KphvIez/b+W0e6isK9cGk6Z7ZdcATgS36487TZv3XbdXtXc0dL2ZrnMK+j+gvhP9hqEgZ5hP9Ye1KImd+lAdAc7DKvT52YicUgYPRnCZXfshfmCz6UK+qWzKO/eZpYnpsM1TZJicPATBQb57ip4RItsgxDlMvxKuq+rgPz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456094; c=relaxed/simple;
	bh=ZmjTPYPWQVUuwBtqZF1mpWHidFQ1gO6jSMVLiuRlQeg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxIUrAbuAvOnsxC6cnzDgs15ypJpGxVHV6UVSwdM/moIm1qG8x8lNs2rMyWH/arsxGWnqVxBs2NsEV82n2vLTtMf99DFBsphOINseXvJKAqjKwNe/Pf92BQdfiJc10EdIwJ4Jg7Q9IKJs63k9iZ8Bl0BN0659o0wdF4SGOJpr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T19DgyAX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T19DgyAX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730456092; x=1761992092;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ZmjTPYPWQVUuwBtqZF1mpWHidFQ1gO6jSMVLiuRlQeg=;
  b=T19DgyAXx6eLmalJTRrmxpEzT/TDLjmfFWihOyWWDhhueigSGivVfBBR
   aAcKswCO5XCdrSh/YXgFBMSOHGc+paSLGlrE1DM9Im6/rNoUhgDyBUAG6
   j0idqfoWjcTTv4GWiPE/bsFenZtM0OGWhNjNefrtNwiG6N51W5SCNWC0Z
   tz7BqmCF44KiqxMJpAzHOYXgpok04N99paizg9TA1nC35zH1XSddQLzW2
   xEcDEJwwivsyqz80TZeZbk3l+b4/BSYSy1Ejkgy0s73gTzY6YkzD8tvxu
   u8XeEbnzG5cvFlwGNDwgMPKR0LoCpoFSb2QkbcTXMFEbBjYzgYmDyZNvY
   A==;
X-CSE-ConnectionGUID: ukabWDtqSEWduozrTkBCBQ==
X-CSE-MsgGUID: ATc9IYLjR2qqZD7jnv4Rww==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41615782"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="41615782"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:14:50 -0700
X-CSE-ConnectionGUID: lLxddGjXTKqOmb9rE83F1g==
X-CSE-MsgGUID: +PzIKr/zS46Gi1VazdQK7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83737457"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 01 Nov 2024 03:14:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DD9CA44B; Fri, 01 Nov 2024 12:14:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] mmc: sdhci-acpi: Tidy up ACPI ID table
Date: Fri,  1 Nov 2024 12:11:35 +0200
Message-ID: <20241101101441.3518612-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy up ACPI ID table:
- sort entries alphabetically for better maintenance
- drop comma in the terminator entry

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 8e265b53d7ce..c931f506c1b0 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -682,33 +682,35 @@ struct sdhci_acpi_uid_slot {
 };
 
 static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
-	{ "80865ACA", NULL, &sdhci_acpi_slot_int_sd },
-	{ "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
-	{ "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
 	{ "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
 	{ "80860F14" , "2" , &sdhci_acpi_slot_int_sdio },
 	{ "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "80860F16" , NULL, &sdhci_acpi_slot_int_sd   },
+	{ "80865ACA", NULL, &sdhci_acpi_slot_int_sd },
+	{ "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
+	{ "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
+	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
+	{ "AMDI0041", NULL, &sdhci_acpi_slot_amd_emmc },
 	{ "INT33BB"  , "2" , &sdhci_acpi_slot_int_sdio },
 	{ "INT33BB"  , "3" , &sdhci_acpi_slot_int_sd },
 	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
-	{ "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "PNP0D40"  },
+	{ "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
 	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
-	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
-	{ "AMDI0041", NULL, &sdhci_acpi_slot_amd_emmc },
-	{ },
+	{ }
 };
 
 static const struct acpi_device_id sdhci_acpi_ids[] = {
+	{ "80860F14" },
+	{ "80860F16" },
 	{ "80865ACA" },
 	{ "80865ACC" },
 	{ "80865AD0" },
-	{ "80860F14" },
-	{ "80860F16" },
+	{ "AMDI0040" },
+	{ "AMDI0041" },
 	{ "INT33BB"  },
 	{ "INT33C6"  },
 	{ "INT3436"  },
@@ -716,9 +718,7 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 	{ "PNP0D40"  },
 	{ "QCOM8051" },
 	{ "QCOM8052" },
-	{ "AMDI0040" },
-	{ "AMDI0041" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac

