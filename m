From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] mmc: use snprintf not sprintf
Date: Fri, 27 Aug 2010 20:59:04 +0100
Message-ID: <20100827195904.GO23079@void.printf.net>
References: <20100617145807.15099.65843.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46731 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab0H0T7G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:59:06 -0400
Content-Disposition: inline
In-Reply-To: <20100617145807.15099.65843.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: pierre@ossman.eu, linux-mmc@vger.kernel.org, akpm@linux-foundation.org

Hi Alan,

This wasn't merged, because it went to Pierre rather than Andrew.
Andrew, could you take it?

From: JiebingLi <jiebing.li@intel.com>
Date: Thu, 17 Jun 2010 15:58:46 +0100

This patch fixes an issue found by klockwork. Just paranoia.

Signed-off-by: JiebingLi <jiebing.li@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/block.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index cb9fbc8..9793f4c 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -535,7 +535,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	 * messages to tell when the card is present.
 	 */
 
-	sprintf(md->disk->disk_name, "mmcblk%d", devidx);
+	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
+		"mmcblk%d", devidx);
 
 	blk_queue_logical_block_size(md->queue.queue, 512);
 

--
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
