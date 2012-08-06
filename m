From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Subject: [PATCH v3 0/5] mmc: Add access to RPMB partition
Date: Mon, 6 Aug 2012 17:12:26 +0200
Message-ID: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:46154 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932081Ab2HFPNO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 11:13:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy-ext@stericsson.com>

The goal of this patchserie is to offer access to MMC RPMB 
(Replay Protected Memory Block) partition.
The RPMB partition is used in general to store some secure data.
It is accessible through a trusted mechanism described in 
JEDEC standard JESD84-A441.

This patchserie proposes following modifications:
- detect RPMB capability and create RPMB block device if supported
- extend MMC sysfs to provide access to RPMB partition size and 
  reliable write sector count (information needed by user space to 
  acces RPMB partition)
- update IOCTL to support RPMB access. This includes automatic partition
  switch and sending of Set Block Count (CMD23) message.

RPMB partition becomes accessible using standard IOCTL interface.
Patches don't include trusted mechanism or any verification. 
It is user space or secure application responsability to provide the right 
command and the entire data frame as defined by JEDEC standard.
---
Changes in v2:
- Correction in patch 2: mmc: card: Do not scan RPMB partitions
  Remove GENHD_FL_EXT_DEVT flag

Changes in v3:
- Add acked-by and reviewed-by tags
---
Loic Pallardy (5):
  mmc: core: Expose access to RPMB partition
  mmc: card: Do not scan RPMB partitions
  mmc: core: Extend sysfs to ext_csd parameters for RPMB support
  mmc: core: Add mmc_set_blockcount feature
  mmc: card: Add RPMB support in IOCTL interface

 Documentation/mmc/mmc-dev-attrs.txt |  7 ++++
 drivers/mmc/card/block.c            | 66 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.c             | 14 ++++++++
 drivers/mmc/core/mmc.c              | 15 +++++++++
 include/linux/mmc/card.h            |  2 ++
 include/linux/mmc/core.h            |  2 ++
 include/linux/mmc/mmc.h             |  2 ++
 7 files changed, 108 insertions(+)

-- 
1.7.11.1

