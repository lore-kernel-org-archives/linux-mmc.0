From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: SDIO single irq optimization - Spurious interrupt notification to
 function driver
Date: Fri, 30 Mar 2012 10:27:12 +0530
Message-ID: <4F753D28.6020300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21932 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2C3E5R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Mar 2012 00:57:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, nicolas.pitre@linaro.org, per.forlin@linaro.org

Hi,

While I was debugging an issue where the sdio function driver panics 
upon receiving a spurious interrupt notification which is similar to the 
one found on libertas sdio 
http://permalink.gmane.org/gmane.linux.kernel.mmc/8338

I can confirm that my hardware not buggy and is not generating any 
interrupts during initialization and CCCR_INTx is all zero's.

After some analysis, I found that there is a notification of interrupt 
to function handler by sdio_irq_thread() even though there is no 
interrupt. The sequence is as follows.

sdio_claim_host();

sdio_claim_irq():
	...
	sdio_card_irq_get() -> kthread_run(sdio_irq_thread) -> 
wake_up_sdio_irq_thread
	sdio_single_irq_set() -> card->sdio_single_irq = func = sdio_func[i];
	...

sdio_release_host();

Since we woke up sdio_irq_thread(), while this thread get a chance to run:
...
__mmc_claim_host()
process_sdio_pending_irqs() -> since sdio_single_irq is non NULL the 
func->handler is directly called without checking pending interrupt bit 
CCCR_INTx.
mmc_release_host()
...

Irrespective of the function driver state, sdio driver should not call 
func->handler() if it is not real interrupt. I knew that function 
handler should be able to handle these interrupts gracefully. But it is 
just not the right thing for sdio driver to generate spurious interrupts.

I see this notification issue during mmc_sdio_resume() also explained by 
Nicolas:
http://permalink.gmane.org/gmane.linux.kernel.mmc/10871

This leads me to think of reverting commit 06e8935feb "optimized SDIO 
IRQ handling for single irq" instead of hacking every function driver to 
handle spurious interrupt notification gracefully.

Let me know your thoughts on this or suggest any alternate way instead 
of reverting it.

-- 
Thanks & Regards,
Sujit Reddy Thumma
