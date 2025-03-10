Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6C1C7013
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586168; cv=none; b=PZLs8NkCUAkGz61x8GyrswZEq6dFcSDRoUzp5zlVy5pUajLAAjciVBD0Do0VJJiYidpUjv7MC2sd0vFzEz+jn6aLr7r2JOxiCYdVSqud/ODOFpXr0JVUQnhyQDs8OOracufufWiwvxDri3b/7XYRab+tB6lFK4TTMoxlMMPwTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586168; c=relaxed/simple;
	bh=OjknDet2JooRE9NzX99Ydxu/vUoeElSzHiHtsj0GGDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+F3s77oWG1uAdWHl1pG1HK6S7wYMK3I5iXDLlhV3URAcYM4kIGBo5NXzmq0r3jJYBEM4/Iq1FLyVeWHLg/Aji+hoJMDALNBTFhdI8lw3xI4Z+AOJl+nPwju8zqBlLm6Aw3RDzUIGud1RyywV8wEDQDyaQv8B1JazP2887t+Tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=lv5Cm3US; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="lv5Cm3US"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1741586164; x=1773122164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjknDet2JooRE9NzX99Ydxu/vUoeElSzHiHtsj0GGDo=;
  b=lv5Cm3USMDwklBxDiLiFuEYRzOogqaE1wN3YPZW/by7hqudmqGG1TP6B
   vYvqIzs/We5SY3tHRpZxH8wpHZbp5NOnyQdfQC70U+K+xLrAZjjYhhTaA
   Dn5lqA4kfcgTKXhZpqjslXxFzqIji405qwJ6dxYy63jBAKYpR/09K2npk
   ELJiO1wjq8ScIi+XziWKyG34GGE9oOBkNtV+0aoGNA2yDyYBoy0VprlCr
   bBOQiiL7oZ5Xn+0KRSIuMlX70RymaHrM9oSnz8fZG2MajLZWdI+r1swd8
   V24iUPLfUj/kzSQq92khviO76Lq3M67aoEBcKWv4Wht6xYVqLTIhiDTVk
   A==;
X-CSE-ConnectionGUID: CNZ/gNc9QQyN3PJpV2xxIg==
X-CSE-MsgGUID: b+rPHQeLSlaWliT8UeyQMg==
X-IronPort-AV: E=Sophos;i="6.14,235,1736784000"; 
   d="scan'208";a="46164539"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 13:56:04 +0800
IronPort-SDR: 67ce7120_hda1t/rIauFacVIcQFpMKTd0lKk4h3AJBPEYB1SjjNC62mO
 4r94Wc7xrJaZ1r4Euv1I80yHR9Gydw/d1+6Lwuw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 21:57:05 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2025 22:56:04 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 3/7] mmc-utils: lsmmc: Pass program name to usage function
Date: Mon, 10 Mar 2025 07:52:27 +0200
Message-Id: <20250310055231.304728-4-avri.altman@sandisk.com>
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

This commit updates the usage function to accept the program name as an
argument, allowing the usage message to display the correct program name
dynamically. This change improves the clarity and accuracy of the usage
message. This enhancement ensures that the usage message accurately
reflects the name of the register: cid, csd or scr, being read.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 lsmmc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 468a533..ae30799 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -232,9 +232,9 @@ static struct ids_database mmc_database[] = {
 };
 
 /* Command line parsing functions */
-static void usage(void)
+static void usage(char *progname)
 {
-	printf("Usage: print mmc [-h] [-v] <device path ...>\n");
+	printf("Usage: %s [-h] [-v] <device path ...>\n", progname);
 	printf("\n");
 	printf("Options:\n");
 	printf("\t-h\tShow this help.\n");
@@ -248,7 +248,7 @@ static int parse_opts(int argc, char **argv, struct config *config)
 	while ((c = getopt(argc, argv, "hv")) != -1) {
 		switch (c) {
 		case 'h':
-			usage();
+			usage(argv[0]);
 			return -1;
 		case 'v':
 			config->verbose = true;
@@ -256,12 +256,12 @@ static int parse_opts(int argc, char **argv, struct config *config)
 		case '?':
 			fprintf(stderr,
 				"Unknown option '%c' encountered.\n\n", c);
-			usage();
+			usage(argv[0]);
 			return -1;
 		case ':':
 			fprintf(stderr,
 				"Argument for option '%c' missing.\n\n", c);
-			usage();
+			usage(argv[0]);
 			return -1;
 		default:
 			fprintf(stderr,
@@ -272,11 +272,12 @@ static int parse_opts(int argc, char **argv, struct config *config)
 
 	if (optind >= argc) {
 		fprintf(stderr, "Expected mmc directory arguments.\n\n");
-		usage();
+		usage(argv[0]);
 		return -1;
 	}
 
 	config->dir = strdup(argv[optind]);
+
 	return 0;
 }
 
-- 
2.25.1

