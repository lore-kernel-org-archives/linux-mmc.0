From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 0/4] mmc: dw_mmc: mmc_test related fixes
Date: Wed, 29 Jun 2011 09:27:40 +0100
Message-ID: <4E0AE1FC.3070201@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:61455 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713Ab1F2I1n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2011 04:27:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Will <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>l

More improvements and fixes for the Synopsys DesignWare MCI driver so
that it passes the mmc_test suite:

[PATCH 1/4] mmc: dw_mmc: fix stop when fallen back to PIO
	Fixes a hang after an error/timeout in PIO mode.
[PATCH 2/4] mmc: dw_mmc: remove unnecessary error messages
	Removes some dev_err's since an errno is sufficient.
[PATCH 3/4] mmc: dw_mmc: handle "no CRC status" error
	Fixes "Correct xfer_size at write" tests.
[PATCH 4/4] mmc: dw_mmc: reset FIFO after an error
	Fixes modified "Correct xfer_size at write" tests (3 blocks
	instead of 2).
 
 drivers/mmc/host/dw_mmc.c  |   41 +++++++++++++++++++++++++++++++----------
 include/linux/mmc/dw_mmc.h |    2 ++
 2 files changed, 33 insertions(+), 10 deletions(-)

