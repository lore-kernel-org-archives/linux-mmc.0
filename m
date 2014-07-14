From: Chris Ball <chris@printf.net>
Subject: Re: One bug of SDHCI driver
Date: Mon, 14 Jul 2014 14:26:36 +0100
Message-ID: <86zjgcjckz.fsf@void.printf.net>
References: <53B249A4.2040404@linux.intel.com>
	<53B57B23.4020607@linux.intel.com> <53B61403.7040602@samsung.com>
	<53B968EB.60401@linux.intel.com> <53BC164E.4040900@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36401 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbaGNN0x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jul 2014 09:26:53 -0400
In-Reply-To: <53BC164E.4040900@linux.intel.com> (Zhonghui Fu's message of
	"Wed, 09 Jul 2014 00:03:26 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org, tgih.jun@samsung.com, aaron.lu@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jackey.shen@amd.com, gregkh@linuxfoundation.org

Hi Zhonghui,

On Tue, Jul 08 2014, Fu, Zhonghui wrote:
> Why add "mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;" ?  How to fix this bug?
>
> Could you please give out some idea about this bug?

Jaehoon already gave you a patch to fix this bug.  Here it is again in
proper patch form.  Please can you test it and let us know whether it
fixes the crash?  Thanks.


From: Chris Ball <chris@printf.net>
Subject: [PATCH] mmc: core: sdio: Fix unconditional wake_up_process() on sdio thread

781e989cf59 ("mmc: sdhci: convert to new SDIO IRQ handling") and
bf3b5ec66bd ("mmc: sdio_irq: rework sdio irq handling") disabled
the use of our own custom threaded IRQ handler, but left in an
unconditional wake_up_process() on that handler at resume-time.

Reported-by: Fu, Zhonghui <zhonghui.fu@linux.intel.com>
[Patch suggested by Jaehoon Chung]
Signed-off-by: Chris Ball <chris@printf.net>
---
 drivers/mmc/core/sdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index e636d9e..2a128e2 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -992,7 +992,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		}
 	}
 
-	if (!err && host->sdio_irqs)
+	if (!err && host->sdio_irqs &&
+	    !(host->quirks & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 		wake_up_process(host->sdio_irq_thread);
 	mmc_release_host(host);
 
-- 
Chris Ball   <http://printf.net/>
