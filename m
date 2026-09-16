Received: from mail-m32111.qiye.163.com (mail-m32111.qiye.163.com [220.197.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8CE472F94;
	Wed, 16 Sep 2026 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547189; cv=none; b=h2E4VhsSRm4Mve/VGJ6d+Gz677oMaEop48jT2mHS0jp540l6GuCBXnEBBl0+D1jLttgp7AoMewyto6qgmck5hDvzywAYqITSga9Dgg7UEPdkec4oFJ8ln4LKgyTl3Sa5txGGlHpUQItdslm/eJ5XhsqJlJ8alWcIKnhIOTEIU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547189; c=relaxed/simple;
	bh=8UcVWqH4JzEIbe2deVZeFG+bWmIRytIfgZLkylLTCiI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ispoIxYX42j/glmcrbU82bE0GFJWcX4/QzZEJDLbiqo3GlVfLnnhIqNWO2SYiPufvuLYhDOf/Tkwpo8mK/2GzRWSHHgv5HRKmn0I/fwrDU2Z7SXiX53s51lVKMLTkMeNyGPme4betfysVDT7Tpdrt0mhIod8343AaMpZowdSc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=krCE+ky6; arc=none smtp.client-ip=220.197.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="krCE+ky6"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4defec625;
	Wed, 16 Sep 2026 11:50:00 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH] mmc: core: apply a per-command tuning timeout instead of the whole sequence budget
Date: Wed, 16 Sep 2026 11:49:49 +0800
Message-Id: <1789530589-8466-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0a855f1d703a4kunmb0660c138eca42
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGhpOSlZNSU1CQk0dTR
	hLSEpWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=krCE+ky6jDuaRT4zV8JKSVmQwdK70HRtD6rJm0324m2Bga0U5Aw6XNGE7Z3Uds4qKiMnrxOvudHxLX3YTT2bPzVj9Pg8k76TI3G1sYLdNdeLb8FEln36vmwgJ+xMlRvYgqIRin8LlbOKM3SGGzhNJwGVQ5JCYB24A0Zgb0Fo8UM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=q+GZ887ecAbnkZmX5SL3hXgBKmG0Ot+HHWEBl6OGZVw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

The tuning specs guarantee that a *sequence* of 40 tuning commands
completes within 150 ms, exclusive of any host overhead:

  eMMC, JESD84-B51B 6.6.5.1 "Sampling Tuning Sequence for HS200":

    "The Device is guaranteed to complete a sequence of 40 times CMD21
    executions within 150 ms. This is exclusive of any host overhead."

  SD Physical Layer Specification Version 4.00:

    "The card shall complete a sequence of 40 times CMD19 executions
    in no more than 150ms. The tuning process is normally shorter than
    40 executions of CMD19, and therefore should be shorter than
    150 ms."

mmc_send_tuning() however applied that 150 ms as the data timeout of
every single CMD19/CMD21, i.e. 40x the per-execution budget implied
by the specs (150 ms / 40 = 3.75 ms of device time, excluding host
overhead).

The data timeout only matters for tuning commands where the device
never returns the tuning block at all; a wrong sampling phase
normally fails fast with a CRC error instead.  Waiting 150 ms per
such test makes software phase scanning painfully slow.  With
dw_mmc-rockchip HS200 eMMC the TMOUT register saturates at ~112 ms
for the requested 150 ms, and dw_mmc's execute_tuning() scans every
phase of the tuning window, stalling that long on each phase that
misses the window.  Multi-second boot slowdowns have been reported[1].

Note that SDHCI hosts are unaffected: sdhci_send_tuning() does not
use mmc_send_tuning() (the hardware generates and checks the tuning
pattern itself) and bounds every tuning command to 50 ms in software
(sdhci.c).  The SDHCI variants which scan the tuning phases manually
through mmc_send_tuning() -- sdhci-msm, sdhci-omap, sdhci-tegra,
sdhci-cadence, sdhci-esdhc-imx, sdhci_am654, sdhci-of-k1,
sdhci-of-dwcmshc (CV180x), sdhci-of-bst and the AMD sdhci-pci
variant -- suffer from the same excessive per-command timeout and
benefit from this change as well.

Use 5 ms per tuning command.  For reference, the device serves the
tuning block straight out of its SD/MMC IP (no storage access is
involved), so even in the slowest reasonable setup -- a 64-byte
tuning block at 50 MHz over a 4-bit bus -- the block transfer alone
takes ~2.6 us, and a full tuning transaction only a few us of bus
time.  5 ms is ~1.3x the spec-implied per-execution device budget
(150 ms / 40 = 3.75 ms, excluding host overhead), 30x below the
150 ms ceiling, and the reporter verified that tuning keeps passing
with it on dw_mmc-rockchip HS200 eMMC.  Even in the worst case where
every tuning command times out, the whole tuning process stays
bounded within a few hundred milliseconds.

This also bounds the cost of runtime re-tuning, not just the tuning
performed at enumeration time.

[1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=221781
Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index a952cc8..abcdcf8 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -708,11 +708,33 @@ int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
 	data.flags = MMC_DATA_READ;
 
 	/*
-	 * According to the tuning specs, Tuning process
-	 * is normally shorter 40 executions of CMD19,
-	 * and timeout value should be shorter than 150 ms
+	 * JESD84-B51B 6.6.5.1, "Sampling Tuning Sequence for HS200":
+	 *
+	 *   "The Device is guaranteed to complete a sequence of 40 times
+	 *   CMD21 executions within 150 ms. This is exclusive of any
+	 *   host overhead."
+	 *
+	 * SD Physical Layer Specification Version 4.00:
+	 *
+	 *   "The card shall complete a sequence of 40 times CMD19
+	 *   executions in no more than 150ms. The tuning process is
+	 *   normally shorter than 40 executions of CMD19, and therefore
+	 *   should be shorter than 150 ms."
+	 *
+	 * Both specs bound a *sequence* of 40 tuning commands, i.e. at
+	 * most 150/40 ms (3.75 ms) of device time per command, excluding
+	 * host overhead.  And that is generous: the device serves the
+	 * tuning block straight from its SD/MMC IP, no storage access
+	 * involved, so the whole transaction is only a few us of bus
+	 * time even in the slowest reasonable setup (64 bytes at
+	 * 50 MHz, 4-bit takes ~2.6 us).  The timeout exists solely to
+	 * catch devices which never return the block at all.
+	 *
+	 * Use 5 ms per command: ~1.3x the spec-implied per-command
+	 * budget for host overhead and slower devices, still 30x below
+	 * the 150 ms bound.
 	 */
-	data.timeout_ns = 150 * NSEC_PER_MSEC;
+	data.timeout_ns = 5 * NSEC_PER_MSEC;
 
 	data.sg = &sg;
 	data.sg_len = 1;
-- 
2.7.4

