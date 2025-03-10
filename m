Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE91B4153
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586158; cv=none; b=a8+NwNWz1ZJLRZzlVWRISsNnsCcN6XCvrEOlW9MztULTFWMvOKB65p/uvOB88ZUoQroYqVcUXr4B2AQdd3dWY/tUwZHhQUlBadwzXq1Rta/cSKiAB8bxRmGt2mDHoGIIkGcR0kVZPh8ua6apBcHN3yrjalAJn/vhGiobJbFU+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586158; c=relaxed/simple;
	bh=tbYTUff95T/hojr46ultYWRwbKU6UTWGo+9SSH7oHto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SvmPjkHrEy7cyqoPB5hUFzCKQp8+Vi4tzJW0VqixaLNLBYT0f45eqi5lMVVRlPVIz4ZNLW4VTf4NQAi5rvd93HVMNVMNCTjtsIF9nu01fezm9zHWALMzhgBox45eZAvpw/3quYYAJoqmhTmPju6rfP0DOk/QnHGV1KcJ5xQsxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=SdHzCCLK; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="SdHzCCLK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741586157; x=1773122157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tbYTUff95T/hojr46ultYWRwbKU6UTWGo+9SSH7oHto=;
  b=SdHzCCLKFGHxYCgDgJ0XxUqQR2Q5qpe8PNnVkV6tXl8LOwcxm7qAgXcH
   oRBS//DZxW/+WqLn4HLY+7m2mTDepGYucI3R/Mv4u8oyFPG1ILxrEUROr
   3PGE+DXeUvd/JG6c5XWpJbONnVYLKauc7IuH7DSKCbBLnAS77uenepwkE
   p+U/TZdq/B+hOa0PbxTH1OBiUK3Cdn6rqGTmJGLvlrPGNRIfhy1kQSJrV
   bAfDTmAfm2Vo790/VG9mvxlTxSdyBd/uobYANBInUwiBabqwC/Gq6yjMZ
   WzLLDsBDxSi1a1BtqHRpExSNMHBmQXtAe2leFQdYUvx59/i2mHWmDIvZV
   w==;
X-CSE-ConnectionGUID: EvayTR7rTdS4yR2mEyVMDA==
X-CSE-MsgGUID: 6cj55fqYRweEvbeWXGKX2Q==
X-IronPort-AV: E=Sophos;i="6.14,235,1736784000"; 
   d="scan'208";a="46164460"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 13:55:56 +0800
IronPort-SDR: 67ce7119_TxXuOwWeSkVJyKhQiEwhF/Ja6QxanHfX3I+nyOy0MF51NmM
 4qDkv+U+apvfIiQ66SQoZx8pmrePnx6T37W5P2A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 21:56:57 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 22:55:56 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 1/7] mmc-utils: lsmmc: Break early in scr read
Date: Mon, 10 Mar 2025 07:52:25 +0200
Message-Id: <20250310055231.304728-2-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310055231.304728-1-avri.altman@sandisk.com>
References: <20250310055231.304728-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit refactors the SCR case in the process_dir function to use
the bus type check instead of comparing the type string directly. This
change simplifies the logic and makes it consistent with other parts of
the code that use the bus type.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 lsmmc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 7e0ea23..bc0e264 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -2146,15 +2146,16 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 
 		break;
 	case SCR:
-		if (!strcmp(type, "SD")) {
-			reg_content = read_file("scr");
-			if (!reg_content) {
-				fprintf(stderr, "Could not read SD card "
-					"configuration in directory '%s'.\n",
-					config->dir);
-				ret = -1;
-				goto err;
-			}
+		if (config->bus != SD)
+			break;
+
+		reg_content = read_file("scr");
+		if (!reg_content) {
+			fprintf(stderr, "Could not read SD card "
+				"configuration in directory '%s'.\n",
+				config->dir);
+			ret = -1;
+			goto err;
 		}
 
 		print_sd_scr(config, reg_content);
-- 
2.25.1

