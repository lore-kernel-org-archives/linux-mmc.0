From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: bug on sdhc suspend/resume
Date: Wed, 27 Jan 2016 12:10:43 +0100
Message-ID: <CAPDyKFopUDUH3=sKQMHwWE98OWXRbW2bA5VB4_0Bt1sVjj-W5A@mail.gmail.com>
References: <DB3PR04MB0553724531AE27D6F0B8E59A90D90@DB3PR04MB0553.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33211 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbcA0LKo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 06:10:44 -0500
Received: by mail-yk0-f174.google.com with SMTP id k129so5618907yke.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 03:10:44 -0800 (PST)
In-Reply-To: <DB3PR04MB0553724531AE27D6F0B8E59A90D90@DB3PR04MB0553.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, Aisheng Dong <aisheng.dong@nxp.com>

On 27 January 2016 at 11:47, Haibo Chen <haibo.chen@nxp.com> wrote:
> Hi Ulf,
>
> Now I find an issue in our sdhci.c driver.
>
> During system resume, when we input the key Ctrl+C, then we will meet the following error log:
>
> CPU1 is up
> PM: noirq resume of devices complete after 0.637 msecs
> imx-sdma 30bd0000.sdma: loaded firmware 4.1
> PM: early resume of devices complete after 0.774 msecs
> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
> PM: Device 30b40000.usdhc failed to resume: error -4
> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
> PM: Device 30b50000.usdhc failed to resume: error -4
> dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
> PM: Device 30b60000.usdhc failed to resume: error -4
> fec 30be0000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
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
>
> I did an simple debug, and find in function sdhci_resume_host(), it change to call
> request_threaded_irq() rather than request_irq().
> (Russell King add this change, commit 781e989cf593c71d26bdca74f5e77b3651fc060e)
>
> And in request_threaded_irq-> __setup_irq-> kthread_create-> kthread_create_on_node,
> The comment in the code shows that SIGKILLed will impact the function, and return -EINTR.

Seems like there is an issue in genirq as I would expected this to work.

>
> Why do we need to do free_irq() in sdhci_suspend_host? Is there any reason?

At this point, not really.

> If unnecessary, I think we can remove the free irq in supend, and remove request thread irq in resume.

Well, we could actually replace them with disable|enable_irq(), as
that will prevent IRQs from being propagated to the sdhci driver which
is exactly what we want.

Do you want to send a patch fixing this? Pleas make sure it holds a fixes tag.

Kind regards
Uffe
