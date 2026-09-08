Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com [117.135.214.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492270808
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827791; cv=none; b=h1i/EXiMv02HhqCR2Ny+FC/2614foAlGIbRNS7ep1OIEHE5ydPPoHHc5E+b+goeQHmEaBWiKZCWyFwFkN+zwTbIId6j0Lnil0XBBtK36m7Y9qMl6hIu1WuDJ5Ik46QbE4CCja0/X7Ai8C4DHuu9FtLDqjcCagh/ejalH1GYl0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827791; c=relaxed/simple;
	bh=y5mqH4nMfzr/FkZ0LK7Kia40pXjMpebFFf4uJocS5Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lf3RNkMs86/l/spuX1krVncFUlaxBjrB6nl0mvNmZybifJmJKNDbtpsj8OSbITGMogJ+L1FUqfPP0EWNhGZTM74zeUQu3ZuGnr979fTBBfENwKh5anJV/SFcaTCpsb+HbpGdXvRPGrSkE2QvVeEgKmvGxifVccVjQHE0HzcDbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Q/FI+Bim; arc=none smtp.client-ip=117.135.214.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q/FI+Bim"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ce1549e3;
	Tue, 8 Sep 2026 08:21:06 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v3 1/2] mmc-utils: Factor out extcsd revision to string helper
Date: Tue,  8 Sep 2026 08:20:59 +0800
Message-Id: <1788826860-153971-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1788826860-153971-1-git-send-email-shawn.lin@rock-chips.com>
References: <1788826860-153971-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa07e63d4ec03a4kunm951c4038385a0b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGkpKSVZKTR9DThoYGh
	1KTR1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Q/FI+BimLWrdyXsnVK9IkOthVjdurGce37gPOMKyBXK1SakdKIsOOxC/Bvmqhphnqx9qlMki2CWjyesrm1NPc4JWb3rUdhZvne3HvRO2ZM6j1jTPAd2uyzHwrAotwTK7M8y4Dp+m6q3jXbPWsSQUzqm+jID/AUufYohgUPNogMU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=2Xc9+MTwV6wbvHSjmPWtpmv+hJvVCFz4FpHVOIr4pcY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

The extended CSD revision to MMC version string mapping is open coded
in do_read_extcsd(). Factor it out into a helper, so that it can be
shared with upcoming commands.

No functional change.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc_cmds.c | 58 +++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index c4ee5d7..c70c337 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -982,6 +982,31 @@ out_free:
 	return ret;
 }
 
+static const char *extcsd_rev_to_string(__u8 rev)
+{
+	switch (rev) {
+	case 9:
+	case 8:
+		return "5.1";
+	case 7:
+		return "5.0";
+	case 6:
+		return "4.5";
+	case 5:
+		return "4.41";
+	case 3:
+		return "4.3";
+	case 2:
+		return "4.2";
+	case 1:
+		return "4.1";
+	case 0:
+		return "4.0";
+	default:
+		return NULL;
+	}
+}
+
 static unsigned int get_sector_count(__u8 *ext_csd)
 {
 	return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) |
@@ -1527,35 +1552,10 @@ int do_read_extcsd(int nargs, char **argv)
 
 	ext_csd_rev = ext_csd[EXT_CSD_REV];
 
-	switch (ext_csd_rev) {
-	case 9:
-	case 8:
-		str = "5.1";
-		break;
-	case 7:
-		str = "5.0";
-		break;
-	case 6:
-		str = "4.5";
-		break;
-	case 5:
-		str = "4.41";
-		break;
-	case 3:
-		str = "4.3";
-		break;
-	case 2:
-		str = "4.2";
-		break;
-	case 1:
-		str = "4.1";
-		break;
-	case 0:
-		str = "4.0";
-		break;
-	default:
-		goto out_free;
-	}
+	str = extcsd_rev_to_string(ext_csd_rev);
+	if (!str)
+		goto out_free; /* Unknown revision */
+
 	printf("=============================================\n");
 	printf("  Extended CSD rev 1.%d (MMC %s)\n", ext_csd_rev, str);
 	printf("=============================================\n\n");
-- 
2.25.1

