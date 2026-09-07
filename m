Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com [45.254.49.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32B4CCDF3
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743275; cv=none; b=Iww3qP7cZjuowoH521TFan8gkJtVrtf+TuMOiZQgVi6U4avXUc194Njm6iszLO95qz3wGFce3i+xpT8pI0II/7pkujCb9TZhdQG8rqg9PnosOeN5Nbl3dAAaYgAtid9+dOY7gmjrlEQem1i5MX74+VgJyDpFp7oZbI5zN6/pFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743275; c=relaxed/simple;
	bh=P4RViOmj6mXui85/+WZ849P/qLdUKsMgukq+mBLx4yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ucY3qq7kXHJPPRPuy+Ko5eHE2ZZrs3SsyXeGMiEgDxeCYbXLnI5z0dsTgZELz4TvNFEVlY7y6fsAbKG9Wchf1fOh2o69FTXoSXWltzzte6zHmtG4/yLlju+lK3df94V/Nr0Vnj06Fv9IPQpa+xBcd1mJCq4Us4fp++9zE+w+Uzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IcUY5XGC; arc=none smtp.client-ip=45.254.49.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IcUY5XGC"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cb8dbf98;
	Mon, 7 Sep 2026 09:02:33 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v2 1/2] mmc-utils: Factor out extcsd revision to string helper
Date: Mon,  7 Sep 2026 09:02:23 +0800
Message-Id: <1788742944-94637-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1788742944-94637-1-git-send-email-shawn.lin@rock-chips.com>
References: <1788742944-94637-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa07963683b03a4kunm8383fd3f2ced10
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQk5PGVYeGk9DSkNJTk
	IfSkNWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IcUY5XGCsN1O7ZNtuexBEgGftKCoCE/+XVJzElaN1G8s9LnwNJ7yWHTqdeTjWKSBCOX6MMvcNZzb8R9U3vzGGKLJWug9iwahdwJjxBj+9DDfzOFAiOOIld4N7DSXFAaPgIGLRAZGnlUTgh0m/Buz2etMUYzTkXJ+0J25ZrqrwDI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ESsPXceobLqVIM289J/70JHu2+f9yuGt9NWFc2dHH8E=;
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

