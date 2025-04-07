Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F923A6
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014811; cv=none; b=RLMGivOIOShKw3Ew0vQhrrCPMLYzNLXMkJjtb4JcrJPL2GIoxilUdJfxY5LVHBRdEFXw+TpRnemznrTjXO1QSYarYKBaRgJfXRJw9oQXizh9TMMNc8Yi9sw6eeanmKUPlnmCcJcLQwq7sDx7M+NeMKMwE0Xy3wGcjQ9zYe/ibJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014811; c=relaxed/simple;
	bh=EyEKPI//75bKxvR1UXdzWDPYKNRGXiLSbtKWsayQLKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAAB2khZeIPSmIBswTwcwlbPd5mTk8pW4N4mmTyRizzyAealgu1TGUKT2Dm8aKucDnAzfqRrTiHQVGfGyXu/3duy5BJsvmlMGIYZebGGP9u4I6qa5q7nAqM0GjjOsRA5S0Sx3pTOtP53+rqholnKUo4OtbdpeggcRCEYxs1g5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=qBQo2p2s; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="qBQo2p2s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014810; x=1775550810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EyEKPI//75bKxvR1UXdzWDPYKNRGXiLSbtKWsayQLKc=;
  b=qBQo2p2saDtXIgT/ahudjmRTHrILprfLCRvw1qsk9bnI0qySbc1evVjT
   StAQednrFcPV2TJe9T3LBXfIKF84bx14vGq9yOZ9PT3eYpHcxUWDChjRl
   YmJ3GpJs5Hf3C9wEcJyW9aC260SVrd/rXQPGwq4taXhldfW7fTx/PC/CD
   KI+Ir+u6jXjP5qyXehEMNrJwowelzAl6y0xxnwT37FCAJ519iW+Lt+qLS
   mKyn91r98sMfqpaAtKSyykCk0ES1hhcZRsuG6JzTj68W7Fpn+w/QmKtU5
   3XrVzGx7Tb07ywI7YQgqZ4tunm+5SSjno+Z4/picRqEPbTnNdNIhvLC5W
   Q==;
X-CSE-ConnectionGUID: 0oBhC8bdSke8wLT4/cv63Q==
X-CSE-MsgGUID: u4FQsGSZSSe4u0U9fPHDLA==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="74116708"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:11 +0800
IronPort-SDR: 67f37fc8_4HhFilp2yKBmidDpwyi/LgzXRNXBF/shcxIh1EdYRZnMNfH
 5nrKT4hyv6U7ZoW3KuAW4SRZHWKiLh5RJp0tbRw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:33:28 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:10 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 01/10] mmc-utils: Initialize RPMB frame_out structures to zero
Date: Mon,  7 Apr 2025 11:28:24 +0300
Message-Id: <20250407082833.108616-2-avri.altman@sandisk.com>
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

This patch ensures that the `frame_out` structures are properly
initialized to zero. It would helps prevent potential issues with
uninitialized memory and ensures that all fields are set to a known
state before use.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index dbe18ab..125816d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2224,7 +2224,7 @@ int do_rpmb_write_key(int nargs, char **argv)
 	int ret, dev_fd, key_fd;
 	struct rpmb_frame frame_in = {
 		.req_resp = htobe16(MMC_RPMB_WRITE_KEY)
-	}, frame_out;
+	}, frame_out = {};
 
 	if (nargs != 3) {
 		fprintf(stderr, "Usage: mmc rpmb write-key </path/to/mmcblkXrpmb> </path/to/key>\n");
@@ -2285,7 +2285,7 @@ static int rpmb_read_counter(int dev_fd, unsigned int *cnt)
 	int ret;
 	struct rpmb_frame frame_in = {
 		.req_resp = htobe16(MMC_RPMB_READ_CNT)
-	}, frame_out;
+	}, frame_out = {};
 
 	/* Execute RPMB op */
 	ret = do_rpmb_op(dev_fd, &frame_in, &frame_out, 1);
@@ -2499,7 +2499,7 @@ int do_rpmb_write_block(int nargs, char **argv)
 	struct rpmb_frame frame_in = {
 		.req_resp    = htobe16(MMC_RPMB_WRITE),
 		.block_count = htobe16(1)
-	}, frame_out;
+	}, frame_out = {};
 
 	if (nargs != 5) {
 		fprintf(stderr, "Usage: mmc rpmb write-block </path/to/mmcblkXrpmb> <address> </path/to/input_file> </path/to/key>\n");
-- 
2.25.1

