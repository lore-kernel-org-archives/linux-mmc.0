Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B846226CE6
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014813; cv=none; b=brlfr6kkLRqmqzBMN+Zd58hmr5dpdcOgCiX0LNr9E8tKWlj+rRJXk7BUeXlacJoh1IPGLUQAx6DpmORd3nAyMub0DtTxjVBfD7Cdq1hZpkPXEdqd3fQ4Z6t6uPZL9x8ej6stl+jwImdKerigCyiCzCBzfuaz4RP42iiZEItdUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014813; c=relaxed/simple;
	bh=EsyfZ4tmhjNz0FzKcwIZKsp2ON9zuXCsumdrtCOPEfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfEGmOfpSQ0HIo5oMKVpJyqTk1k69YLide+gNEHD4J0OoXk+K/LIlJfVJQjWsOVM6pjZQNFYKquUoOAVdCMTcE4Ro8yBtiHBhObzT2FdoC/VGtqg+oUHnRp5vi+3qkzQyVYs/0gnD8XZcNSN7HzKc8nDDLBhOLXylLpxKsHU5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=piHYlAb7; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="piHYlAb7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014812; x=1775550812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EsyfZ4tmhjNz0FzKcwIZKsp2ON9zuXCsumdrtCOPEfs=;
  b=piHYlAb7p3g1jjYDHZjVYquIwAuq0qTLFCKsq+5ZrVr2P7/blqMVW4yS
   gKUJ/Vow2wMrScftTc0Ev1JblALz2YY9UAXvZXE3TLCjKU12r95hRSpm0
   61Qs/VDrYByn/U52Sj0wgzRDtyzpBiaOXdxJcJgEHqPJFEgIFodD5OB8s
   RCQcOuOWjXSgP7/gm4zeTKdLS39tbc0Mnfmfttk82HlDdKPJsWZphAeHb
   LaHIGuBOlYXSMijqoYI8jT2jtLkCkQvl5D+Y8uH8V3Nb7eSg7/bJ7Wclx
   X2C2JCtW5ewsP08WMaWHNy6BLuSFta7OEw4mO/FXuuPvyOrKO0Mzf6Zwp
   w==;
X-CSE-ConnectionGUID: cm5G9MIIRU+9rS/cnS65oA==
X-CSE-MsgGUID: dD8oXzDxSNSm6rk+gnKiwQ==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="74116720"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:20 +0800
IronPort-SDR: 67f37fd0_S01SL0WcB0M+HPgHIkVAa4BWXhgwsi7w4eICyJ8a4IOqM8Y
 qy3Q/liwM93Ga4V0B0ZL2YRY9iHmibZTgqg+4vA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:33:37 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:19 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 02/10] mmc-utils: Reduce scope of nargs for RPMB commands
Date: Mon,  7 Apr 2025 11:28:25 +0300
Message-Id: <20250407082833.108616-3-avri.altman@sandisk.com>
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

This commit fixes the loose definition of the `nargs` member in the
`struct Command` for RPMB commands. The `nargs` member specifies the
number of arguments required for each command, and this change ensures
that the correct number of arguments is enforced for each RPMB command.

This reduction in the scope of the `nargs` variable helps to prevent
incorrect usage of the RPMB commands by ensuring that the correct number
of arguments is provided.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mmc.c b/mmc.c
index 077e901..b73dd24 100644
--- a/mmc.c
+++ b/mmc.c
@@ -157,7 +157,7 @@ static struct Command commands[] = {
 		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device.",
 	  NULL
 	},
-	{ do_rpmb_write_key, -1,
+	{ do_rpmb_write_key, 2,
 	  "rpmb write-key", "<rpmb device> <key file>\n"
 		  "Program authentication key which is 32 bytes length and stored\n"
 		  "in the specified file. Also you can specify '-' instead of\n"
@@ -168,12 +168,12 @@ static struct Command commands[] = {
 		  "    mmc rpmb write-key /dev/mmcblk0rpmb -",
 	  NULL
 	},
-	{ do_rpmb_read_counter, -1,
+	{ do_rpmb_read_counter, 1,
 	  "rpmb read-counter", "<rpmb device>\n"
 		  "Counter value for the <rpmb device> will be read to stdout.",
 	  NULL
 	},
-	{ do_rpmb_read_block, -1,
+	{ do_rpmb_read_block, -4,
 	  "rpmb read-block", "<rpmb device> <address> <blocks count> <output file> [key file]\n"
 		  "Blocks of 256 bytes will be read from <rpmb device> to output\n"
 		  "file or stdout if '-' is specified. If key is specified - read\n"
@@ -186,7 +186,7 @@ static struct Command commands[] = {
 		  "  $ mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 /tmp/block",
 	  NULL
 	},
-	{ do_rpmb_write_block, -1,
+	{ do_rpmb_write_block, 4,
 	  "rpmb write-block", "<rpmb device> <address> <256 byte data file> <key file>\n"
 		  "Block of 256 bytes will be written from data file to\n"
 		  "<rpmb device>. Also you can specify '-' instead of key\n"
-- 
2.25.1

