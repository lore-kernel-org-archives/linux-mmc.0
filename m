From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL v2] Add eMMC4.5 feature for v3.2
Date: Mon, 17 Oct 2011 10:22:21 +0900
Message-ID: <4E9B834D.2000600@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57898 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155Ab1JQBW6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Oct 2011 21:22:58 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LT6002FRRU8LM90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 17 Oct 2011 10:22:57 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LT6005TIRU8HE10@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 17 Oct 2011 10:22:56 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Chris.
This request pull is added eMMC4.5 feature for linux-3.2.

*v2
- based on latest mmc-next.
- removed the power notify patch (this patch need more discussion in mailing.)

The following changes since commit 8943b39afaa6d9774ed03fffb9afd6257fa2b428:

  mmc: fix compile error when CONFIG_BLOCK is not enabled (2011-10-12 14:38:16 -0400)

are available in the git repository at:
  git://git.infradead.org/users/kmpark/linux-2.6-samsung emmc4.5

Jaehoon Chung (1):
      mmc: core: support HPI send command

Kyungmin Park (2):
      mmc: core: mmc sanitize feature support for v4.5
      mmc: core: new discard feature support at mmc v4.5

Seungwon Jeon (1):
      mmc: core: Add cache control for eMMC4.5 device

 drivers/mmc/card/block.c   |   27 ++++++---
 drivers/mmc/card/queue.c   |    2 +-
 drivers/mmc/core/core.c    |  143 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |   59 ++++++++++++++++++
 drivers/mmc/core/mmc_ops.c |   31 ++++++++++
 drivers/mmc/core/mmc_ops.h |    1 +
 include/linux/mmc/card.h   |    9 +++
 include/linux/mmc/core.h   |    6 ++
 include/linux/mmc/host.h   |    3 +
 include/linux/mmc/mmc.h    |    8 +++
 10 files changed, 280 insertions(+), 9 deletions(-)
