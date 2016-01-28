From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mmc: sdhci: disable irq in sdhci host suspend ranther
 than free this irq
Date: Thu, 28 Jan 2016 17:27:46 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601281723140.3886@nanos>
References: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com> <20160128102057.GJ10826@n2100.arm.linux.org.uk> <CAPDyKFr0t3BWXV9ip-DKeTXFqGxmK=i=T1UuK6qiu4ZuUJ+i=w@mail.gmail.com> <alpine.DEB.2.11.1601281719350.3886@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601281719350.3886@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Haibo Chen <haibo.chen@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 28 Jan 2016, Thomas Gleixner wrote:
> On Thu, 28 Jan 2016, Ulf Hansson wrote:
> > Therefore, the only way we currently can make sure to don't get the
> > IRQ is to free and later re-request it. Now, apparently that has
> > issues when using threaded IRQ handlers.
> 
> What's the issue?

Ah, you mean that one:

> Currently sdhci driver free irq in host suspend, and call
> request_threaded_irq() in host resume. But during host resume,
> Ctrl+C can impact sdhci host resume, see the error log:

> CPU1 is up
> PM: noirq resume of devices complete after 0.637 msecs imx-sdma 30bd0000.sdma: loaded firmware 4.1
> PM: early resume of devices complete after 0.774 msecs
> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
> PM: Device 30b40000.usdhc failed to resume: error -4
> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
> PM: Device 30b50000.usdhc failed to resume: error -4
> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
> PM: Device 30b60000.usdhc failed to resume: error -4 fec 30be0000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: error -110 during resume (card was removed?)
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: error -110 during resume (card was removed?)

In request_threaded_irq-> __setup_irq-> kthread_create
->kthread_create_on_node, the comment shows that SIGKILLed will
impact the kthread create, and return -EINTR.

And how should that thread be SIGKILLed? Hitting Ctrl+C on the console does
not affect any kernel internal thread. Hitting Ctrl+C affects solely the
process which is running on that console.

And if it would, then that would be a completely different, serious bug which
needs to be fixed.

How was verified, that the thread was not created and that the creation failed
due to a SIGKILL?

Thanks,

	tglx
