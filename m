Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABD8836
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843713; cv=none; b=ttRFyR4/PvOK3uWZcT6tLzMcgaeL+e95kYnd/VskArwC1anC5oha0DWCEV3ScP5jy8cmmoBJuUsPfMTtss7evex8BsiTc7RU/QUgyr7RI+rsT5OQZKP4wQp8L6u2EQI6CTU9HzX5jVBQzgDbheYCQMZ5PVSpykECT7AVSh9MP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843713; c=relaxed/simple;
	bh=dnA3k+2chUV60vz+TLilj627Vd2jECydqGfKXFRb0hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7I49yHBR9X3u9s+RVKpA+sNlvU5B8nHkJgETD3MxuRD9s0hWa3uiNHbrzVHzTlfvZawxND69lfrAoVudhTLiougsqCnA1se6K+azVD28aK4AORiEu2esHsX/+C+Ig0kXobzHR+8KlpyHWI6E+Sm/r5k/vmRQmwSUIEpqyKOPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=oNhzh451; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="oNhzh451"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1745843711; x=1777379711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnA3k+2chUV60vz+TLilj627Vd2jECydqGfKXFRb0hY=;
  b=oNhzh451BClyY77xx+64d0hE4vitLuEhYWE2an/iXazUQcqBsThtJgSX
   teul/FcC5VhK17+Z34GFkVoUug4cEBlzeFa2deBMWCx5/wa7FkMuV71CC
   Ov91sFD8HhCJJm2qcvhr//CNlMycb2xFOjLtjTYVJcsYMxc9J/xI2f7uw
   wITz+9moQzkpJTAMY4V34WaJ8Zd5+6OiC53dxUD7Gqz4Xa2ZH2IMtvCqC
   l3qzVQ/AL63ApHYvwRyDYRfkCdlbKFgGNwlWiZrPgEtRDNFNh2699JHev
   o0zk/giSUQCJpztCIt/m4Zu+TrjwwMP987pZGiDmPJsulWlG/3cpkX/eg
   w==;
X-CSE-ConnectionGUID: J+gKaz5hTi+nrINQUEd1ZA==
X-CSE-MsgGUID: QfXGDsuzQ2+ZSHBGKrQkFw==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="83568778"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 20:35:11 +0800
IronPort-SDR: 680f67dd_EmBZ8w0tv02oIeaXrWxhvaO3xaFtyK36MiSv0USC/gC7O8q
 Z8Mzg9hK3JMxcSJ4a3V67zgHV90n/XCSOQeNr5A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 04:34:53 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 05:35:10 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 3/4] mmc-utils: Introduce a generic print_usage function
Date: Mon, 28 Apr 2025 15:29:50 +0300
Message-Id: <20250428122951.317055-4-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428122951.317055-1-avri.altman@sandisk.com>
References: <20250428122951.317055-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a generic `print_usage` function to centralize the
handling of command usage messages. It reuses and prints the usage
information stored in the `help` field of the `struct Command`.

This refactoring simplifies command-specific usage handling by
centralizing it in a reusable function, reducing redundancy and
improving maintainability.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc.c      | 18 +++++++++++++++++-
 mmc_cmds.h |  4 ++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/mmc.c b/mmc.c
index 6e834ca..315fa70 100644
--- a/mmc.c
+++ b/mmc.c
@@ -26,7 +26,7 @@
 
 #include "mmc_cmds.h"
 
-typedef int (*CommandFunction)(int argc, char **argv);
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
 struct Command {
 	CommandFunction	func;	/* function which implements the command */
@@ -545,6 +545,22 @@ static int parse_args(int argc, char **argv,
 
 	return 1;
 }
+
+void print_usage(CommandFunction func)
+{
+	int num_commands = ARRAY_SIZE(commands);
+	int i;
+
+	for (i = 0; i < num_commands; i++) {
+		if (commands[i].func == func) {
+			print_help(&commands[i]);
+			return;
+		}
+	}
+
+	fprintf(stderr, "Error: Command not found for the given function pointer.\n");
+}
+
 int main(int ac, char **av )
 {
 	char *cmd = NULL, **args = NULL;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index d83fb57..ce35d3e 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -17,6 +17,10 @@
  * those modifications are Copyright (c) 2016 SanDisk Corp.
  */
 
+typedef int (*CommandFunction)(int argc, char **argv);
+
+void print_usage(CommandFunction func);
+
 /* mmc_cmds.c */
 int do_read_extcsd(int nargs, char **argv);
 int do_write_extcsd(int nargs, char **argv);
-- 
2.25.1

