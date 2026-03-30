Received: from mail-m83211.xmail.ntesmail.com (mail-m83211.xmail.ntesmail.com [156.224.83.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41B4C81;
	Mon, 30 Mar 2026 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843461; cv=none; b=ccYRDXQanhmyCe4SfUS2aXwZWa4cPIQo0zEQd5jElnI0LGbtSbebQ2F1NhwrsT2tqnbRZgOHcrCQeTmX0PiO9F5muwjBGDxCHcQ0eG5+lq/1pX6EeOCRFZkbdd4QPLF9C/M5u0h+hylu2W1QluQJexRIxslEjSUw1Mt+QHtEiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843461; c=relaxed/simple;
	bh=l+jWKWf+97RksQf/Mq3dw1zwlqdbGi4+fW23666T5jE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l/nMO7/LBRCF+AwQXnn8H4DYnhSRhOgVXs+go2O7FndxSs0n4TfJw0v0d4jv8Gzhh3WPUi/a5hMkkZsstgpI91Tfi+BtGCVEQnKDdLKbALn/Whyochn/KRdwsxaO9ZXVNunbsEZXf4dfO41LWLpPHKRuG5SXOwoOF54NcK/R0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=c8QuYSrV; arc=none smtp.client-ip=156.224.83.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="c8QuYSrV"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38c2332aa;
	Mon, 30 Mar 2026 11:28:41 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/4] Extend MQRQ_XFER_SINGLE_BLOCK to Support Multi-Block Read Failures
Date: Mon, 30 Mar 2026 11:28:28 +0800
Message-Id: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d3cc957cf09cckunmd82a3513dfee19
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tPHlZJGBlPQkxDHU1OTR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=c8QuYSrVhfNJEXBxQNVVSM8r5sCixEjawnxUvLmnfAJlI3/xfmR0wX1xGNvFdqccgwJDo+yHxxPgUAZklM/TmED9ps2Lte5fF6BGt2KdvYWWJSo19fYkpxgiVDdfAdsT99I0iwnxlQ8OGwg3xPuI5vV+UMY54eoetvjXPq9+FT4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=543AEDv1jjXTZSF9qnokcObUsdlLBEkcKJVget/Oghc=;
	h=date:mime-version:subject:message-id:from;


Background and patchset description:
Currently, the MMC driver handles multi-block read/write failures through
two separate mechanisms:
1.  For read failures, the native retry mechanism is triggered internally
    within the MMC core.
2.  For write failures, the corresponding request is re-queued with the
    MQRQ_XFER_SINGLE_BLOCK flag for single-block recovery. This separation
    creates inconsistency in error handling.

To improve code uniformity and reliability, this patch series consolidates
both read and write failure paths into a unified recovery model by enabling
the use of MQRQ_XFER_SINGLE_BLOCK for handling multi-block read failures as
well. Patch 1-3 are small improvement while reading the code. Patch 4
implements the conversion of multi-block read failures to MQRQ_XFER_SINGLE_BLOCK
mode.

Testing Details:
1. Platforms: Tested on RK3576 with both CQE and non-CQE modes.
2. Methodology:
- Background dd test continuously reading from eMMC.
- Physically interrupting the eMMC data line during tests to simulate CRC errors.

Testing Result:
On CEQ mode, CRC error triggered on slot 4 (blkaddr 734208). It successfully
transitioned to single-block retries using tags 25, 27, 24, 25, 26, etc.
(see logs below):
mmc0: starting CQE transfer for tag 4 blkaddr 734208
mmc0: CQE transfer done tag 9
mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
mmc0: 524288 bytes transferred: 0
mmc0: starting CQE transfer for tag 5 blkaddr 735232
mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
mmc0: running CQE recovery
mmc0: starting CMD12 arg 00000000 flags 00000019
mmc0: req failed (CMD12): -110, retrying...
mmc0: req failed (CMD12): -110, retrying...
mmc0: req failed (CMD12): -110, retrying...
mmc0: req done (CMD12): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD13 arg 00010000 flags 00000195
mmc0: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmc0: starting CMD48 arg 00000001 flags 00000019
mmc0: req done (CMD48): 0: 00000900 00000000 00000000 00000000
mmc0: CQE transfer done tag 4
mmc0: 0 bytes transferred: -84
mmc0: CQE transfer done tag 5
mmc0: 0 bytes transferred: 0
mmc0: starting CQE transfer for tag 25 blkaddr 734208
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: starting CQE transfer for tag 26 blkaddr 735232
mmc0: CQE transfer done tag 25
mmc0: 512 bytes transferred: 0
mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
mmc0: starting CQE transfer for tag 27 blkaddr 734209
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: CQE transfer done tag 26
mmc0: 524288 bytes transferred: 0
mmc0: CQE transfer done tag 27
mmc0: 512 bytes transferred: 0
mmc0: starting CQE transfer for tag 24 blkaddr 734210
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: CQE transfer done tag 24
mmc0: 512 bytes transferred: 0
mmc0: starting CQE transfer for tag 25 blkaddr 734211
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: CQE transfer done tag 25
mmc0: 512 bytes transferred: 0
mmc0: starting CQE transfer for tag 26 blkaddr 734212
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: CQE transfer done tag 26
mmc0: 512 bytes transferred: 0

On non-CQE mode, a CRC error occurs during a multi-block read
operation (CMD18) targeting sector 0x0002d000. Subsequently,
mmc core initiates a single-block retry using CMD17, starting
from the same sector 0x0002d000(see logs below):
mmc0: starting CMD18 arg 0002d000 flags 000000b5
mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
mmc0: CMD12 arg 00000000 flags 00000095
mmc0: req done : 0: 00000000 00000000 00000000 00000000
mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc0: 0 bytes transferred: -84
mmc0: (CMD12): 0: 00000b00 00000000 00000000 00000000
mmc0: starting CMD13 arg 00010000 flags 00000195
mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
mmc0: <starting CMD23 arg 00000400 flags 00000015>
mmc0: starting CMD18 arg 0002d400 flags 000000b5
mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
mmc0: CMD12 arg 00000000 flags 00000095
mmc0: req done : 0: 00000000 00000000 00000000 00000000
mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc0: 524288 bytes transferred: 0
mmc0: (CMD12): 0: 00000000 00000000 00000000 00000000
mmc0: starting CMD17 arg 0002d000 flags 000000b5
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
mmc0: 512 bytes transferred: 0
mmc0: starting CMD17 arg 0002d001 flags 000000b5
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
mmc0: 512 bytes transferred: 0
mmc0: starting CMD17 arg 0002d002 flags 000000b5
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
mmc0: 512 bytes transferred: 0
mmc0: starting CMD17 arg 0002d003 flags 000000b5
mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
mmc0: 512 bytes transferred: 0



Shawn Lin (4):
  mmc: core: Replace the hard-coded shift value 9 with SECTOR_SHIFT
  mmc: block: Convert to use DEFINE_SIMPLE_DEV_PM_OPS()
  mmc: mmc_test: Replace hard-coded values with macros and consolidate
    test parameters
  mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both read and write
    recovery

 drivers/mmc/core/block.c    | 82 ++++----------------------------------------
 drivers/mmc/core/core.c     |  3 +-
 drivers/mmc/core/mmc_test.c | 83 ++++++++++++++++++++-------------------------
 3 files changed, 45 insertions(+), 123 deletions(-)

-- 
2.7.4

