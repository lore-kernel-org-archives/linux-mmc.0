From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdio: defer sdio irq handling when host suspended
Date: Fri, 21 Dec 2012 20:59:34 +0800
Message-ID: <CADz5_gKVxwa6OdFFeJdXYsx46OjWN8JgH9HPsxKtKUcxH8aoDw@mail.gmail.com>
References: <1355919130-28702-1-git-send-email-kliu5@marvell.com>
	<1355919130-28702-2-git-send-email-kliu5@marvell.com>
	<CAPDyKFomOU=ArpZ__uSqLz1OxbmEYOx12-dA8H7CgcRDiqXkPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:51904 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab2LUM7f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 07:59:35 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so1918222wib.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Dec 2012 04:59:34 -0800 (PST)
In-Reply-To: <CAPDyKFomOU=ArpZ__uSqLz1OxbmEYOx12-dA8H7CgcRDiqXkPA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@amd.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Al Cooper <acooper@gmail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>

2012/12/21 Ulf Hansson <ulf.hansson@linaro.org>:
> On 19 December 2012 13:12, Kevin Liu <kliu5@marvell.com> wrote:
>> If sdio host can wakeup system, its interrupt will _NOT_ be disabled
>> during suspending. So when card interrupt happens, the sdio irq thread
>> will be woken up.
>
> Is that really needed to handle the irq?
>
> I think you should instead wait on the system resume to be handled
> properly. In the mmc_sdio_resume, sdio_irq thread is woken up to find
> out if there is an irq to handle.
>
> ....
> if (!err && host->sdio_irqs)
>   wake_up_process(host->sdio_irq_thread);
> ....
>
> Would that not solve your issue?
>

With current code, if irq keeps on during suspend/resume, when
interrupt happen, sdio_irq_thread will be woken up and handle the
interrupt immediately while sdio host has suspended. It won't wait.

Just as you said, this patch just let sdio_irq_thread wait untill sdio
host resume back to handle the interrupt.

>> Claim the host  to avoid sdio irq thread handling the pending interrupt
>> while sdio host suspended. The pending interrupt will be handled after
>> the host released in resume when sdio host has been resumed.
>>
>> Signed-off-by: Jialing Fu <jlfu@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>  drivers/mmc/core/sdio.c |   20 ++++++++++++++++++--
>>  1 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index 2273ce6..81140b9 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -11,6 +11,7 @@
>>
>>  #include <linux/err.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/pm_wakeup.h>
>>
>>  #include <linux/mmc/host.h>
>>  #include <linux/mmc/card.h>
>> @@ -923,6 +924,17 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>>                 mmc_release_host(host);
>>         }
>>
>> +       /*
>> +       * If sdio host can wakeup system, its interrupt will _NOT_ be disabled
>> +       * during suspending. So the card interrupt may occur after host has
>> +       * suspended. Claim the host here to avoid sdio irq thread handling the
>> +       * pending interrupt while sdio host suspended. The pending interrupt
>> +       * will be handled after the host released in resume when sdio host has
>> +       * been resumed.
>> +       */
>> +       if (!err && device_may_wakeup(mmc_dev(host)))
>> +               mmc_claim_host(host);
>> +
>>         return err;
>>  }
>>
>> @@ -933,8 +945,12 @@ static int mmc_sdio_resume(struct mmc_host *host)
>>         BUG_ON(!host);
>>         BUG_ON(!host->card);
>>
>> -       /* Basic card reinitialization. */
>> -       mmc_claim_host(host);
>> +       /*
>> +       * Basic card reinitialization.
>> +       * if sdio host can wakeup system, the host has been claimed in suspend.
>> +       */
>> +       if (!device_may_wakeup(mmc_dev(host)))
>> +               mmc_claim_host(host);
>>
>>         /* No need to reinitialize powered-resumed nonremovable cards */
>>         if (mmc_card_is_removable(host) || !mmc_card_keep_power(host))
>> --
>> 1.7.0.4
>>
>
> Kind regards
> Ulf Hansson
