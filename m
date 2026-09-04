Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D746EF96
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526711; cv=none; b=OJZXXYCk644Bn9NfxmnxwvZim2b+hcRyOik8tMD7uJbyjuwoXRWHUGKaGcG0f84fkgXL5ZlsDeDkatvO8EUeQcrVuJvOhdckOY4Ojh4XBLZkZMm+wmunBUlY0iT2S597rVzRpUYvfYk1pDuMrTlqNaLtE5xlkHvqWbkMPlMAmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526711; c=relaxed/simple;
	bh=wT98D5+mopRN2py+hZZ3dYemXN5pyjH/YF/BeITo8UA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=U0lKhTFyUknIoohBsUpUHZbmpaDupZvbx3jqAE4R/tzYn+qt+6/XtwatA9e5Ev4cPIVZApz7dQsV62KmeSKn7z86KEcJe1J6SaC+fYpSmXT/+kW1CXA62eSSDI/c4Q+My/H75o08DZJALHph2eiZKRuXR+shfAb1HcT1554ThoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bZYXZj5k; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bZYXZj5k"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c938d29a;
	Fri, 4 Sep 2026 20:53:07 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH] mmc-utils: Close the device fd on the return paths
Date: Fri,  4 Sep 2026 20:53:02 +0800
Message-Id: <1788526382-45113-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa06c7adda803a4kunm71637831175410
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGU9NHVYfGktJShhKGR
	lDGRpWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bZYXZj5kbN1yhssXPFIMilDAp/OiuN/93VBr3qrfvpMui3qm/Pw4NNIvmZt4S2jJ3HPzI2zBX0DM14Cv/sUi0Dt8vKRR6R6FhTVhI948R/HkEKqDcuMKGqUSwuhAx5H0zcvBzDbzXJjoQ1NJ97DVxVxZnVTwbTD/xkAmApDsKuQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jJRNMUbZ0qKGKK238tCXn2ydq3fPol+4ZBOXBmpGs3M=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

do_read_extcsd(), do_write_extcsd(), do_writeprotect_user_set(),
do_create_gp_partition(), do_enh_area_set() and
do_write_reliability_set() open the device but never close it.

For a short lived command line tool the kernel reclaims the
descriptors when the process exits, so this is only visible to fd
tracking tools (strace open/close pairing, valgrind --track-fds=yes),
but it is flagged as a leak and would matter if the code is reused in
a long lived process.

Close the descriptor on the paths that return to the caller. The error
paths ending in exit(1) terminate the process and rely on the kernel
cleanup, consistent with the rest of the codebase.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---
 mmc_cmds.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 43dcdcc..0692505 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -550,6 +550,7 @@ int do_writeprotect_user_set(int nargs, char **argv)
 			exit(1);
 		}
 	}
+	close(fd);
 	return ret;
 
 usage:
@@ -1442,6 +1443,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	if (set_partitioning_setting_completed(dry_run, device, fd))
 		exit(1);
 
+	close(fd);
 	return 0;
 }
 
@@ -1589,6 +1591,7 @@ int do_enh_area_set(int nargs, char **argv)
 	if (set_partitioning_setting_completed(dry_run, device, fd))
 		exit(1);
 
+	close(fd);
 	return 0;
 }
 
@@ -1656,6 +1659,7 @@ int do_write_reliability_set(int nargs, char **argv)
 	if (set_partitioning_setting_completed(dry_run, device, fd))
 		exit(1);
 
+	close(fd);
 	return 0;
 }
 
@@ -2170,6 +2174,7 @@ int do_read_extcsd(int nargs, char **argv)
 		       "Please check sysfs node '/sys/devices/.../mmc_host/mmcX/mmcX:XXXX/cmdq_en'\n");
 	}
 out_free:
+	close(fd);
 	return ret;
 }
 
@@ -2202,6 +2207,7 @@ int do_write_extcsd(int nargs, char **argv)
 		exit(1);
 	}
 
+	close(fd);
 	return ret;
 }
 
-- 
2.25.1

