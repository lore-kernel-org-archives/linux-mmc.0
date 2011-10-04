From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] mmc: core: Add eMMC4.5 feature
Date: Tue, 04 Oct 2011 21:05:31 +0900
Message-ID: <4E8AF68B.7000007@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38286 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab1JDMFm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2011 08:05:42 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LSJ00D36IXB9TX0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Oct 2011 21:05:41 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LSJ003R7IXH5W70@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Oct 2011 21:05:41 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, kyungmin.park@samsung.com, tgih.jun@samsung.com, Girish K S <girish.shivananjappa@linaro.org>

Hi Chris..

Please pull eMMC4.5 feature patch.
(git://git.infradead.org/users/kmpark/linux-2.6-samsung emmc4.5)
I hope to merge these features.(for linux-v3.2)

I didn't add the bkops patch. how about bkops?

Regards,
Jaehoon Chung

------
The following changes since commit c344e0c044b7634a93c5de18f6b009cea7a3870b:

  mmc: core: ext_csd.raw_* used in comparison but never set (2011-09-26
09:28:28 -0400)

are available in the git repository at:
  git://git.infradead.org/users/kmpark/linux-2.6-samsung emmc4.5

Girish K S (1):
      mmc: core: Add Power Off Notify Feature eMMC 4.5

Jaehoon Chung (1):
      mmc: core: support HPI send command

Kyungmin Park (2):
      mmc: core: mmc sanitize feature support for v4.5
      mmc: core: new discard feature support at mmc v4.5

Seungwon Jeon (2):
      mmc: core: Add default timeout value for CMD6.
      mmc: core: Add cache control for eMMC4.5 device

 drivers/mmc/card/block.c   |   27 +++++--
 drivers/mmc/card/queue.c   |    2 +-
 drivers/mmc/core/core.c    |  179
++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |   94 ++++++++++++++++++++++-
 drivers/mmc/core/mmc_ops.c |   31 ++++++++
 drivers/mmc/core/mmc_ops.h |    1 +
 drivers/mmc/host/sdhci.c   |   10 +++
 include/linux/mmc/card.h   |   30 ++++++++
 include/linux/mmc/core.h   |    6 ++
 include/linux/mmc/host.h   |    8 ++
 include/linux/mmc/mmc.h    |   15 ++++
 11 files changed, 390 insertions(+), 13 deletions(-)
