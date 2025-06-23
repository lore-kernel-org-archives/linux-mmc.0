Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7622DA13
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668022; cv=none; b=U/AImPk6VANEnbuo5UBqiyWTcVp3AlpltfeE3TCibCnK9Nrqi4jqCjsFESllGAGfLys2zMck0KG4T47Df3t2IeAxRYiX+kzsZ48UYTknr5fAz5GnwwjRcayP3u8/+hkaG5F+LTtddjXY4MMY2asse9g5kJHgg5nP6mOWk5UMFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668022; c=relaxed/simple;
	bh=Y4RSlFHoY0sxb0qRz4vebRbfZyC2Q7UNqNP3uOA8mrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBbiRqjpV8el6gQ13o6foSWTBZMZUjRog6/GxHD8Y2wG0m2GsxyNqbvPOsxngleexpPBBbFgTSQGa7zbjqgK/YDRh6WaW5aFvGQw7DiGkKYMMA7TZX/zWnmYnQn4K9Q5SCKcaVEmAt9c46gRHn7QW7kAm/Oqgcyufb0MolfWAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=Ed3sUxIl; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="Ed3sUxIl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1750668020; x=1782204020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y4RSlFHoY0sxb0qRz4vebRbfZyC2Q7UNqNP3uOA8mrM=;
  b=Ed3sUxIlN2ju7DcIVsu/ZO35/fczQv7kMfKqtD635FbTFk1fmX6Ui/Mi
   diFXXw7EukrXFXqXIEPAe8cdHRLYJxEv1A3n8IsqwMU7LpXx+4iyNY1N3
   GVqzu5OLfUl11Esjr3Xyaj0Sg9QQLI+A/jcP0AhyFabGusZ97vojTCDip
   5YHjiyJQrtumdJWYs7TLmUnbE26FGkNoSmIgwsQmEAiTshRc77n+09hPX
   7hnnXVeD27KIyLFoJmKKZgQZMKjRM9aXVM/4cYJHnLE6LVS5qnncTSGke
   j17XiqX2c1Xy9v8i+ZEzkpH+jR6xWs4r2gbjagjFnuC91vywwV7nx3wrv
   g==;
X-CSE-ConnectionGUID: hblGVYl7R3i3kq0IhCCfyw==
X-CSE-MsgGUID: jlUYihA8Qia+OYcWJWmyiA==
X-IronPort-AV: E=Sophos;i="6.16,258,1744041600"; 
   d="scan'208";a="91094961"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2025 16:40:14 +0800
IronPort-SDR: 68590471_txk8z5YbQb+PK5XmbU1DwEBdlr3yhZvWnoCip8VlDvFmv2n
 P3u2yGdthMVDRPk7MCFtN6JbQYXhiaXWWhGEPQw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2025 00:38:25 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2025 01:40:13 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>,
	Simon Lindhorst <s.lindhorst@wut.de>
Subject: [PATCH] mmc-utils: Pass key_mac buffer to rpmb_get_key()
Date: Mon, 23 Jun 2025 11:33:00 +0300
Message-Id: <20250623083300.236198-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue where the key_mac buffer was not passed to
rpmb_get_key() in do_rpmb_write_key(), which could result in incorrect
key handling during RPMB key programming.

This is a resend of a patch originally submitted by Simon Lindhorst,
which was previously rejected due to formatting issues.

Fixes: 05051e40351c ("mmc-utils: Refactor RPMB key handling into a separate function")
Signed-off-by: Simon Lindhorst <s.lindhorst@wut.de>
Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index b2cc3d6..7994223 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2289,7 +2289,7 @@ int do_rpmb_write_key(int nargs, char **argv)
 		exit(1);
 	}
 
-	ret = rpmb_get_key(argv[2], &frame_in, NULL, false);
+	ret = rpmb_get_key(argv[2], &frame_in, frame_in.key_mac, false);
 	if (ret)
 		return ret;
 	/* Execute RPMB op */
-- 
2.25.1

