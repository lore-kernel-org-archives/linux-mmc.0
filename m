From: James Hogan <james.hogan@imgtec.com>
Subject: Re: mmc: dw_mmc: miscaculated the fifo-depth with wrong bit operation
Date: Wed, 11 Jan 2012 09:28:21 +0000
Message-ID: <4F0D5635.50201@imgtec.com>
References: <4F0A3DA4.8010909@samsung.com> <4F0AB63B.4030202@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:1628 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756590Ab2AKJ2Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jan 2012 04:28:25 -0500
In-Reply-To: <4F0AB63B.4030202@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>

On 09/01/12 09:41, James Hogan wrote:
> On 01/09/2012 01:06 AM, Jaehoon Chung wrote:
>> In FIFOTH register, can find "bit[27:16] = FIFO_DEPTH - 1".
>> Finally, FIFO_DEPTH = bit[27:16] + 1.
>>
>> Now, Used the 0x7ff. but 0xfff is right.
> 
> Nice catch. The patch itself looks okay, but I don't think the commit
> message is very understandable, maybe something like this would be better?:
> 
> In FIFOTH register, the RX_WMark field (bits[27:16]) defaults to
> FIFO_DEPTH - 1. When reading it, bits[26:16] were being used, so fix it
> to use the mask 0xfff instead of 0x7ff.
> 
> Cheers
> James

Are you happy having your signed-off-by against this identical patch with
a modified message Jaehoon?

From: Jaehoon Chung <jh80.chung@samsung.com>

In FIFOTH register, the RX_WMark field (bits[27:16]) defaults to
FIFO_DEPTH - 1. When reading it, bits[26:16] were being used, so fix it
to use the mask 0xfff instead of 0x7ff.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cc54808..6ea6185 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2075,7 +2075,7 @@ static int dw_mci_probe(struct platform_device *pdev)
 		 * should put it in the platform data.
 		 */
 		fifo_size = mci_readl(host, FIFOTH);
-		fifo_size = 1 + ((fifo_size >> 16) & 0x7ff);
+		fifo_size = 1 + ((fifo_size >> 16) & 0xfff);
 	} else {
 		fifo_size = host->pdata->fifo_depth;
 	}
-- 
1.7.2.3


