Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F9225A20
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014842; cv=none; b=Uxnb68xwmX5SDWEi24zngqLUyccEsTqhPEPmEdTVH+y+z9R/GHwz3VTQqVs1baKIhfMV/He3CoLxBPI4XlPxBua8uQ6eV5uS2Yrfvu0sfMTd6vhHx2QmPG/DeUthizGajD4r9YTtRonBs9zwoJyU2QDZ+70luEnWDTMFArGEwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014842; c=relaxed/simple;
	bh=cqn4jvG3cVHgoIMPxb7ME//tNbSCYE4xTotDfogc878=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbTlYW/TVppVqhrobFGWsVmfl5qY4GwEW3MIBNM7i63O1pbNn67uvVRwki7oaIe3FuGG97S87Y1Y3FQP09ZrO8l/ucbOUy6RZ23OfUl7HbL3zdZpq9RDNELBrjo1BgtGomSRIfvxzOIReuxHqh/Pvkt6NC6N3K7uUW9KqmtBNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=GnW3JmCL; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="GnW3JmCL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014840; x=1775550840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cqn4jvG3cVHgoIMPxb7ME//tNbSCYE4xTotDfogc878=;
  b=GnW3JmCLA8tcv8w3Sz/Yp536AX4LMFJuLP3o1ZXHQGPJXEpCkUW/ajS4
   tIs1W7jxP6k9xInElLxRKTDlc66EkDeGKoTD4n4oTROOGJQEEXayPMkJK
   l5ZfqXvoR4gnGjwZfCkvGZ7folTCOurThH8hqucxFKZ9Ym26/z4myHjne
   J7vQpnp3ftt/k78jwhmXu7QQ58vYgA/NF9WrDHo3zcLqmb88gDABX2yVS
   CICa0mEfKERW2tFTPprNjGOcSYH0jdgGdNkHTRXg4LemPT7n4gaXAhv60
   v660VLGQBhs3igIBNLdGPxTG5DqgexsWWus6Pp7sI5U1o2yCKLdg6toIF
   w==;
X-CSE-ConnectionGUID: IkRhB+9qRruL2CTZmTchfg==
X-CSE-MsgGUID: vY4ZB8QJR6W7VGz4MLnppQ==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="72021587"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:59 +0800
IronPort-SDR: 67f37ff8_6yHKQdvOH7D+0hCSL5qEhQ4Gs8v5ugJbtf4zgAnSilL6hSu
 SnE78a0lT0wB1gJhU72vV8CmUW0CxxaqwlezG+g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:34:17 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:58 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 08/10] mmc-utils: Enable/Disable write protect
Date: Mon,  7 Apr 2025 11:28:31 +0300
Message-Id: <20250407082833.108616-9-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407082833.108616-1-avri.altman@sandisk.com>
References: <20250407082833.108616-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@wdc.com>

In secure write protected mode, the updatability of USER_WP[171],
BOOT_WP[173], TMP_WRITE_PROTECT[12] and PERM_WRITE_PROTECT[13] are
controlled by SECURE_WP_MASK bit in the SECURE _WP_MODE_CONFIG of the
Authenticated Device Configuration Area.

Setting it, enables updating WP related EXT_CSD and CSD fields, and
clearing it vice versa.

Access to the Authenticated Device Configuration Area is regulated via
Authenticated Device Configuration Write Request.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.c      | 20 ++++++++++++++++++++
 mmc_cmds.c | 14 ++++++++++++++
 mmc_cmds.h |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/mmc.c b/mmc.c
index 0cffa5b..578b00c 100644
--- a/mmc.c
+++ b/mmc.c
@@ -220,6 +220,26 @@ static struct Command commands[] = {
 		  "    mmc rpmb secure-wp-mode-off /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
 	  NULL
 	},
+	{ do_rpmb_sec_wp_mode_set, 3,
+	  "rpmb secure-wp-disable", "<dev> <rpmb device> <key file>\n"
+		  "Enabling updating WP related EXT_CSD and CSD fields.\n"
+		  "Applicable only if secure wp mode is enabled.\n"
+		  "You can specify '-' instead of key\n"
+		  "Example:\n"
+		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
+		  "    mmc rpmb secure-wp-disable /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
+	  NULL
+	},
+	{ do_rpmb_sec_wp_mode_clear, 3,
+	  "rpmb secure-wp-enable", "<dev> <rpmb device> <key file>\n"
+		  "Disabling updating WP related EXT_CSD and CSD fields.\n"
+		  "Applicable only if secure wp mode is enabled.\n"
+		  "You can specify '-' instead of key\n"
+		  "Example:\n"
+		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
+		  "    mmc rpmb secure-wp-enable /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
+	  NULL
+	},
 	{ do_cache_en, -1,
 	  "cache enable", "<device>\n"
 		"Enable the eMMC cache feature on <device>.\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 07bd9ad..2ef4252 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2602,6 +2602,20 @@ int do_rpmb_sec_wp_disable(int nargs, char **argv)
 	return rpmb_auth_write(nargs, argv, 1, 0, usage);
 }
 
+int do_rpmb_sec_wp_mode_set(int nargs, char **argv)
+{
+	char *usage = "Usage: mmc rpmb secure-wp-disable </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
+
+	return rpmb_auth_write(nargs, argv, 2, 1, usage);
+}
+
+int do_rpmb_sec_wp_mode_clear(int nargs, char **argv)
+{
+	char *usage = "Usage: mmc rpmb secure-wp-enable </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
+
+	return rpmb_auth_write(nargs, argv, 2, 0, usage);
+}
+
 int do_rpmb_write_block(int nargs, char **argv)
 {
 	int ret, dev_fd, data_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 873d9b2..61fe337 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -41,6 +41,8 @@ int do_rpmb_read_block(int nargs, char **argv);
 int do_rpmb_write_block(int nargs, char **argv);
 int do_rpmb_sec_wp_enable(int nargs, char **argv);
 int do_rpmb_sec_wp_disable(int nargs, char **argv);
+int do_rpmb_sec_wp_mode_set(int nargs, char **argv);
+int do_rpmb_sec_wp_mode_clear(int nargs, char **argv);
 int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
-- 
2.25.1

