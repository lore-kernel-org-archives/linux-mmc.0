Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C9FC48BD1
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770426124C
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 14:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFKOvs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhFKOvr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2021 10:51:47 -0400
X-Greylist: delayed 1594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Jun 2021 07:49:49 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B417C061574
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jun 2021 07:49:49 -0700 (PDT)
Received: from dslb-188-096-148-249.188.096.pools.vodafone-ip.de ([188.96.148.249] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1lri3n-0003wT-9l; Fri, 11 Jun 2021 16:22:59 +0200
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.92)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1lri3m-0005Kt-QR; Fri, 11 Jun 2021 16:22:58 +0200
Date:   Fri, 11 Jun 2021 16:22:58 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Peng Fan <van.freenix@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Haibo Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, aisheng.dong@nxp.com
Subject: Re: [PATCH] mmc: sdhci: disable irq in sdhci host suspend ranther
 than free this irq
Message-ID: <20210611142251.GA20450@martin-debian-1.paytec.ch>
References: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com>
 <20160128102057.GJ10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0t3BWXV9ip-DKeTXFqGxmK=i=T1UuK6qiu4ZuUJ+i=w@mail.gmail.com>
 <alpine.DEB.2.11.1601281719350.3886@nanos>
 <alpine.DEB.2.11.1601281723140.3886@nanos>
 <20171227025401.GA28360@shlinux2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171227025401.GA28360@shlinux2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear all,

I have to resurrect this discussion once again. The issue is still present
in linux-next and can be reproduced easily on my imx25-based system.

Thus wrote Peng Fan (van.freenix@gmail.com):

> On Thu, Jan 28, 2016 at 05:27:46PM +0100, Thomas Gleixner wrote:
> >On Thu, 28 Jan 2016, Thomas Gleixner wrote:
> >> On Thu, 28 Jan 2016, Ulf Hansson wrote:
> >> > Therefore, the only way we currently can make sure to don't get the
> >> > IRQ is to free and later re-request it. Now, apparently that has
> >> > issues when using threaded IRQ handlers.

> >> What's the issue?

> >Ah, you mean that one:

> >> Currently sdhci driver free irq in host suspend, and call
> >> request_threaded_irq() in host resume. But during host resume,
> >> Ctrl+C can impact sdhci host resume, see the error log:

> >> [...]

My test setup uses rtc as a wakeup source. Additionally, I also define my
console uart as wakeup source

echo enabled > /sys/class/tty/ttymxc3/power/wakeup

and then run rtcwake in a loop

while true ; do rtcwake -s 2 -m mem ; done

Pressing Ctrl-C while the system is sleeping reproduces the problem quickly.

sdhci_resume_host fails because the kthread for the threaded irq can't be
created.

ps confirms that there's no [irq/25-mmc0] kernel thread any more and sdhci
starts printing register dumps periodically

[  101.603339] mmc0: Timeout waiting for hardware cmd interrupt.
[  101.609225] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  101.615725] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00001001
...
[  101.700086] mmc0: sdhci: Host ctl2: 0x00000000
[  101.704568] mmc0: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS DUMP =========
[  101.712179] mmc0: sdhci-esdhc-imx: cmd debug status:  0x0000
...
[  101.746827] mmc0: sdhci-esdhc-imx: async fifo debug status:  0x0000
[  101.753137] mmc0: sdhci: ============================================


I guest that we're taking this path from sdhci_resume_host

request_threaded_irq
   __setup_irq
      setup_irq_thread
         kthread_create
            kthread_create_on_node
               __kthread_create_on_node
                  wake_up_process(kthreadd_task);
                  if (unlikely(wait_for_completion_killable(&done))) {
                     if (xchg(&create->done, NULL))
                        return ERR_PTR(-EINTR);

I can confirm Peng's observation that current->pid in
__kthread_create_on_node is the pid of the rtcwake process.


This is an ftrace log of the error case, I used
trace-cmd start -e task -e mmc -e power -e signal -p function -l tty_flip_buffer_push -l sdhci_resume_host -l __kthread_create_on_node

         rtcwake-185     [000] .n..   321.166724: device_pm_callback_start: imx-uart 50008000.serial, parent: 50000000.spba, bus [resume]
         rtcwake-185     [000] dnh.   321.166823: tty_flip_buffer_push <-__imx_uart_rxint.constprop.0
         rtcwake-185     [000] .n..   321.166906: device_pm_callback_end: imx-uart 50008000.serial, err=0
...
         rtcwake-185     [000] .n..   321.167472: device_pm_callback_start: imx_rngc 53fb0000.rngb, parent: 53f00000.bus, bus [resume]
         rtcwake-185     [000] .n..   321.167486: device_pm_callback_end: imx_rngc 53fb0000.rngb, err=0
         rtcwake-185     [000] .n..   321.167502: device_pm_callback_start: sdhci-esdhc-imx 53fb4000.mmc, parent: 53f00000.bus, bus [resume]
         rtcwake-185     [000] .n..   321.167516: sdhci_resume_host <-sdhci_esdhc_resume
         rtcwake-185     [000] .n..   321.167584: __kthread_create_on_node <-kthread_create_on_node
         rtcwake-185     [000] .n..   321.167652: device_pm_callback_end: sdhci-esdhc-imx 53fb4000.mmc, err=-4
         rtcwake-185     [000] .n..   321.167922: device_pm_callback_start: imx-fb 53fbc000.lcdc, parent: 53f00000.bus, bus [resume]
         rtcwake-185     [000] .n..   321.167978: device_pm_callback_end: imx-fb 53fbc000.lcdc, err=0

If wakeup is successful, the irq's thread is created

         rtcwake-168     [000] .n..   320.566614: device_pm_callback_start: imx-uart 50008000.serial, parent: 50000000.spba, bus [resume]
         rtcwake-168     [000] dnh.   320.566718: tty_flip_buffer_push <-__imx_uart_rxint.constprop.0
         rtcwake-168     [000] .n..   320.566808: device_pm_callback_end: imx-uart 50008000.serial, err=0
...
         rtcwake-168     [000] .n..   320.567359: device_pm_callback_start: imx_rngc 53fb0000.rngb, parent: 53f00000.bus, bus [resume]
         rtcwake-168     [000] .n..   320.567372: device_pm_callback_end: imx_rngc 53fb0000.rngb, err=0
         rtcwake-168     [000] .n..   320.567386: device_pm_callback_start: sdhci-esdhc-imx 53fb4000.mmc, parent: 53f00000.bus, bus [resume]
         rtcwake-168     [000] .n..   320.567402: sdhci_resume_host <-sdhci_esdhc_resume
         rtcwake-168     [000] .n..   320.567460: __kthread_create_on_node <-kthread_create_on_node
        kthreadd-2       [000] ....   320.567922: task_newtask: pid=174 comm=kthreadd clone_flags=800700 oom_score_adj=0
    kworker/u2:3-173     [000] ....   320.568183: __kthread_create_on_node <-kthread_create_on_node
        kthreadd-2       [000] ....   320.568504: task_newtask: pid=175 comm=kthreadd clone_flags=800700 oom_score_adj=0
         rtcwake-168     [000] ....   320.568659: task_rename: pid=174 oldcomm=kthreadd newcomm=irq/25-mmc0 oom_score_adj=0
         rtcwake-168     [000] .n..   320.568824: device_pm_callback_end: sdhci-esdhc-imx 53fb4000.mmc, err=0

> >In request_threaded_irq-> __setup_irq-> kthread_create
> >->kthread_create_on_node, the comment shows that SIGKILLed will
> >impact the kthread create, and return -EINTR.

> >And how should that thread be SIGKILLed? Hitting Ctrl+C on the console does
> >not affect any kernel internal thread. Hitting Ctrl+C affects solely the
> >process which is running on that console.

> >And if it would, then that would be a completely different, serious bug which
> >needs to be fixed.

> >How was verified, that the thread was not created and that the creation failed
> >due to a SIGKILL?

See above, the irq thread is missing, it was running before the
suspend+wakeup. I hope that the ftrace output confirms my assumption about
the code path that was taken. I didn't find any other way we could return
-EINTR in sdhci_resume_host.

> My understanding is:
> The issue is during suspend resume, it is in rtwakeup.out process space,
> during resume, "get_current()->comm" shows "rtcwakeup.out", so if we
> send SIGKILL from userspace, a interrupt will occur, interrupt
> handler will directly return to kernel space to continue resuming.

> __setup_irq->kthread_create->wait_for_completion_killable, here
> wait_for_completion_killable see SIGKILL pending and return -EINTR,
> then sdhci resume process failure, because of sdhci interrupt thread
> not created.

> During suspend/resume, OOM Killer will be disabled and enalbed. When
> request_threaded_irq in sdhci resume, OOM Killer is still disabled.
> According to kthread_create comments for wait_for_completion_killable,
> using killable is to catch OOM sigkill. But during resume, OOM Killer
> is disabled, So how about the following patch to disable SIGKILL for
> a short while?

I tried this patch, it didn't fix the problem for me.

I could make the problem disappear if I moved sdhci_resume_host's
request_threaded_irq call into a worker. Instead of calling
request_threaded_irq, I'd schedule the work on system_unbound_wq. The new
thread for sdhci's irq is then requested by someone other than rtcwake.

Generally, it makes sense to me that kthreadd aborts a request for a new
thread if the requester is killed during the request. However, in the case
of sdhci resume, the thread should always be created, regardless of the
requester's state...

Of course, the workqueue hack is not an acceptable way to fix this. I'd
appreciate if anyone could point me in the right direction for a proper fix.

Thanks in advance for your help,

   Martin

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9290a3439d5..84c4c99b1acb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -19,6 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/scatterlist.h>
>  #include <linux/swiotlb.h>
> @@ -2895,9 +2896,11 @@ int sdhci_resume_host(struct sdhci_host *host)
>  	}

>  	if (!device_may_wakeup(mmc_dev(host->mmc))) {
> +		disallow_signal(SIGKILL);
>  		ret = request_threaded_irq(host->irq, sdhci_irq,
>  					   sdhci_thread_irq, IRQF_SHARED,
>  					   mmc_hostname(host->mmc), host);
> +		allow_signal(SIGKILL);
>  		if (ret)
>  			return ret;
>  	} else {

> Thanks,
> Peng.


> >Thanks,

> >	tglx

> -- 
