From: Peng Fan <van.freenix@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: disable irq in sdhci host suspend ranther
 than free this irq
Date: Wed, 27 Dec 2017 10:54:01 +0800
Message-ID: <20171227025401.GA28360@shlinux2>
References: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com>
 <20160128102057.GJ10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0t3BWXV9ip-DKeTXFqGxmK=i=T1UuK6qiu4ZuUJ+i=w@mail.gmail.com>
 <alpine.DEB.2.11.1601281719350.3886@nanos>
 <alpine.DEB.2.11.1601281723140.3886@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45177 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdL0DKs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Dec 2017 22:10:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1601281723140.3886@nanos>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Haibo Chen <haibo.chen@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, aisheng.dong@nxp.com

Hi All,

Sorry for bring back this old topic again.

On Thu, Jan 28, 2016 at 05:27:46PM +0100, Thomas Gleixner wrote:
>On Thu, 28 Jan 2016, Thomas Gleixner wrote:
>> On Thu, 28 Jan 2016, Ulf Hansson wrote:
>> > Therefore, the only way we currently can make sure to don't get the
>> > IRQ is to free and later re-request it. Now, apparently that has
>> > issues when using threaded IRQ handlers.
>> 
>> What's the issue?
>
>Ah, you mean that one:
>
>> Currently sdhci driver free irq in host suspend, and call
>> request_threaded_irq() in host resume. But during host resume,
>> Ctrl+C can impact sdhci host resume, see the error log:
>
>> CPU1 is up
>> PM: noirq resume of devices complete after 0.637 msecs imx-sdma 30bd0000.sdma: loaded firmware 4.1
>> PM: early resume of devices complete after 0.774 msecs
>> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
>> PM: Device 30b40000.usdhc failed to resume: error -4
>> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
>> PM: Device 30b50000.usdhc failed to resume: error -4
>> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
>> PM: Device 30b60000.usdhc failed to resume: error -4 fec 30be0000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
>> mmc0: Timeout waiting for hardware interrupt.
>> mmc0: Timeout waiting for hardware interrupt.
>> mmc0: Timeout waiting for hardware interrupt.
>> mmc0: Timeout waiting for hardware interrupt.
>> mmc0: Timeout waiting for hardware interrupt.
>> mmc0: Timeout waiting for hardware interrupt.
>> mmc0: error -110 during resume (card was removed?)
>> mmc2: Timeout waiting for hardware interrupt.
>> mmc2: Timeout waiting for hardware interrupt.
>> mmc2: error -110 during resume (card was removed?)
>
>In request_threaded_irq-> __setup_irq-> kthread_create
>->kthread_create_on_node, the comment shows that SIGKILLed will
>impact the kthread create, and return -EINTR.
>
>And how should that thread be SIGKILLed? Hitting Ctrl+C on the console does
>not affect any kernel internal thread. Hitting Ctrl+C affects solely the
>process which is running on that console.
>
>And if it would, then that would be a completely different, serious bug which
>needs to be fixed.
>
>How was verified, that the thread was not created and that the creation failed
>due to a SIGKILL?

This is the testcase.
"/unit_tests/SRTC/rtcwakeup.out -d rtc0 -m mem -s 2;"
it acts "echo mem > /sys/power/state", then rtc interrupt will wakeup the system.

My understanding is:
The issue is during suspend resume, it is in rtwakeup.out process space,
during resume, "get_current()->comm" shows "rtcwakeup.out", so if we
send SIGKILL from userspace, a interrupt will occur, interrupt
handler will directly return to kernel space to continue resuming.

__setup_irq->kthread_create->wait_for_completion_killable, here
wait_for_completion_killable see SIGKILL pending and return -EINTR,
then sdhci resume process failure, because of sdhci interrupt thread
not created.

During suspend/resume, OOM Killer will be disabled and enalbed. When
request_threaded_irq in sdhci resume, OOM Killer is still disabled.
According to kthread_create comments for wait_for_completion_killable,
using killable is to catch OOM sigkill. But during resume, OOM Killer
is disabled, So how about the following patch to disable SIGKILL for
a short while?

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3439d5..84c4c99b1acb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/swiotlb.h>
@@ -2895,9 +2896,11 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
+		disallow_signal(SIGKILL);
 		ret = request_threaded_irq(host->irq, sdhci_irq,
 					   sdhci_thread_irq, IRQF_SHARED,
 					   mmc_hostname(host->mmc), host);
+		allow_signal(SIGKILL);
 		if (ret)
 			return ret;
 	} else {

Thanks,
Peng.

>
>Thanks,
>
>	tglx

-- 
