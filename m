Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331781B4153
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586181; cv=none; b=u1hDF5G3rMg5HRxusldjDEM/5130S2uK1Hf7bKp2+TmB7zxxxh2ZZ8kNCjuC9MBQc/3U4ef6n0h00+954pWDWYt6a+NFvNLpq2jTumIudB7cMtHlzf54OMcrsdCoU1ZRyY4m+XdTBS6E8pqQGBszEhY6ZQvVbYYEvAVogN8W8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586181; c=relaxed/simple;
	bh=r/LCjAgW/TZLpcjNcZzguHFpUseBSheEcPe8zmaaL0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4g452RJ71DwaS5NjsKc+IQU90PcTWSxLpqVHDcrqWFleZw63a613w9qVa0IEz9ZgReceLmT9lsRvoMre0LnJODNx7JKxcBg7zJaGphalaH/87sUyixfddr7t0TTdyl36/r1lxJ1sOqsZA3jYF/qqhB2Y/UrTQ8xsQGnNf/8hzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=N0cPsqX6; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="N0cPsqX6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741586180; x=1773122180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/LCjAgW/TZLpcjNcZzguHFpUseBSheEcPe8zmaaL0A=;
  b=N0cPsqX6OjtKawSYCYN4A3Am+fA6TOD1rIn5xMopSkC+XK2x1Z+HVAvX
   YcmMv9J6jh7n8/v8D5c7seNNGwOOg6mpW+O/g8NJNT/mrc1UW6vJwZ9oZ
   3iApZl7hXyybs1IyA86kX11LaSp4aPZPbk5x8j9xqZaoe91bqu7Q7/KF8
   XibIUc/J1/MCwxofaooC2XRed1XnQgNUOBin635dJAXTthRO9I9cHWgrX
   TmIE/OvmOBx+K0sxaLe8wfNvyBHxhxqgNzsxuB/bPcQqe+wU9Bu+TBzQW
   JBcJv72Bggo5cKkD7mEpfS3HHNz/aybW4Xs7EA+Wd5k27bm+uBFjgjkom
   g==;
X-CSE-ConnectionGUID: i4/x67ZhSUW5+6h69WtUmA==
X-CSE-MsgGUID: 15+ARkx2TI6fZy0nL/yQkQ==
X-IronPort-AV: E=Sophos;i="6.14,235,1736784000"; 
   d="scan'208";a="45168267"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 13:56:20 +0800
IronPort-SDR: 67ce712f_Pj1SaiFv/CpsE1EWG44FxFmsLhhXMWScAw9jAJKe0YGOGDZ
 yCmDIcAoi0IXT335oPcWcYxrZTc3TZRR04Pfzfg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 21:57:19 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 22:56:19 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 5/7] mmc-utils: lsmmc: Refactor register processing
Date: Mon, 10 Mar 2025 07:52:29 +0200
Message-Id: <20250310055231.304728-6-avri.altman@sandisk.com>
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

This commit introduces a preliminary phase that allows nnc-utils accept
register values as arguments instead of reading them from their sysfs
paths. This change refactors the `process_dir` function and introduces a
new `process_reg` function to handle the register content directly.
This change sets the groundwork for future enhancements where register
values can be provided directly, improving flexibility and usability.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 lsmmc.c | 98 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 29 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index ae30799..726adf8 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -2084,38 +2084,12 @@ static void print_sd_scr(struct config *config, char *scr)
 	}
 }
 
-static int process_dir(struct config *config, enum REG_TYPE reg)
+static int process_reg(struct config *config, char *reg_content, enum REG_TYPE reg)
 {
-	char *type = NULL;
-	char *reg_content = NULL;
 	int ret = 0;
 
-	if (chdir(config->dir) < 0) {
-		fprintf(stderr,
-			"MMC/SD information directory '%s' does not exist.\n",
-			config->dir);
-		return -1;
-	}
-
-	type = read_file("type");
-	if (!type) {
-		fprintf(stderr,
-			"Could not read card interface type in directory '%s'.\n",
-			config->dir);
-		return -1;
-	}
-
-	if (strcmp(type, "MMC") && strcmp(type, "SD")) {
-		fprintf(stderr, "Unknown type: '%s'\n", type);
-		ret = -1;
-		goto err;
-	}
-
-	config->bus = strcmp(type, "MMC") ? SD : MMC;
-
 	switch (reg) {
 	case CID:
-		reg_content = read_file("cid");
 		if (!reg_content) {
 			fprintf(stderr,
 				"Could not read card identity in directory '%s'.\n",
@@ -2131,7 +2105,6 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 
 		break;
 	case CSD:
-		reg_content = read_file("csd");
 		if (!reg_content) {
 			fprintf(stderr,
 				"Could not read card specific data in "
@@ -2150,7 +2123,6 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 		if (config->bus != SD)
 			break;
 
-		reg_content = read_file("scr");
 		if (!reg_content) {
 			fprintf(stderr, "Could not read SD card "
 				"configuration in directory '%s'.\n",
@@ -2166,8 +2138,76 @@ static int process_dir(struct config *config, enum REG_TYPE reg)
 		goto err;
 	}
 
+err:
+
+	return ret;
+}
+
+static int process_reg_from_file(struct config *config, enum REG_TYPE reg)
+{
+	char *reg_content = NULL;
+	int ret = 0;
+
+	switch (reg) {
+	case CID:
+		reg_content = read_file("cid");
+		ret = process_reg(config, reg_content, CID);
+
+		break;
+	case CSD:
+		reg_content = read_file("csd");
+		ret = process_reg(config, reg_content, CSD);
+
+		break;
+	case SCR:
+		if (config->bus != SD)
+			break;
+
+		reg_content = read_file("scr");
+		ret = process_reg(config, reg_content, SCR);
+
+		break;
+	default:
+		goto err;
+	}
+
 err:
 	free(reg_content);
+
+	return ret;
+}
+
+static int process_dir(struct config *config, enum REG_TYPE reg)
+{
+	char *type = NULL;
+	int ret = 0;
+
+	if (chdir(config->dir) < 0) {
+		fprintf(stderr,
+			"MMC/SD information directory '%s' does not exist.\n",
+			config->dir);
+		return -1;
+	}
+
+	type = read_file("type");
+	if (!type) {
+		fprintf(stderr,
+			"Could not read card interface type in directory '%s'.\n",
+			config->dir);
+		return -1;
+	}
+
+	if (strcmp(type, "MMC") && strcmp(type, "SD")) {
+		fprintf(stderr, "Unknown type: '%s'\n", type);
+		ret = -1;
+		goto err;
+	}
+
+	config->bus = strcmp(type, "MMC") ? SD : MMC;
+
+	ret = process_reg_from_file(config, reg);
+
+err:
 	free(type);
 
 	return ret;
-- 
2.25.1

