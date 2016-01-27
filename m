From: Haibo Chen <haibo.chen@nxp.com>
Subject: bug on sdhc suspend/resume
Date: Wed, 27 Jan 2016 10:47:09 +0000
Message-ID: <DB3PR04MB0553724531AE27D6F0B8E59A90D90@DB3PR04MB0553.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-am1on0068.outbound.protection.outlook.com ([157.56.112.68]:47376
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932136AbcA0KrM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 05:47:12 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, Aisheng Dong <aisheng.dong@nxp.com>

Hi Ulf,

Now I find an issue in our sdhci.c driver.

During system resume, when we input the key Ctrl+C, then we will meet the following error log:

CPU1 is up
PM: noirq resume of devices complete after 0.637 msecs
imx-sdma 30bd0000.sdma: loaded firmware 4.1
PM: early resume of devices complete after 0.774 msecs
dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
PM: Device 30b40000.usdhc failed to resume: error -4
dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
PM: Device 30b50000.usdhc failed to resume: error -4
dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
PM: Device 30b60000.usdhc failed to resume: error -4
fec 30be0000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: error -110 during resume (card was removed?)
mmc2: Timeout waiting for hardware interrupt.
mmc2: Timeout waiting for hardware interrupt.
mmc2: error -110 during resume (card was removed?)

I did an simple debug, and find in function sdhci_resume_host(), it change to call 
request_threaded_irq() rather than request_irq(). 
(Russell King add this change, commit 781e989cf593c71d26bdca74f5e77b3651fc060e)

And in request_threaded_irq-> __setup_irq-> kthread_create-> kthread_create_on_node,
The comment in the code shows that SIGKILLed will impact the function, and return -EINTR.

Why do we need to do free_irq() in sdhci_suspend_host? Is there any reason?
If unnecessary, I think we can remove the free irq in supend, and remove request thread irq in resume. 



Best Regards
Haibo Chen




