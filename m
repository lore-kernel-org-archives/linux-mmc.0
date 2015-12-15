From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Optimize boot time by detecting cards
 simultaneously
Date: Wed, 16 Dec 2015 08:22:34 +0900
Message-ID: <5670A0BA.8090402@samsung.com>
References: <1448982916-21485-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFq3iuDkJgUGFV7Y4jLB37T=6Nkzf56bJ-a2RxHjy4fE=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36564 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965588AbbLOXWk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2015 18:22:40 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NZF00LF1A9QGQ60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 16 Dec 2015 08:22:38 +0900 (KST)
In-reply-to: <CAPDyKFq3iuDkJgUGFV7Y4jLB37T=6Nkzf56bJ-a2RxHjy4fE=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 12/15/2015 12:50 AM, Ulf Hansson wrote:
> On 1 December 2015 at 16:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The mmc workqueue is an ordered workqueue, allowing only one work to
>> execute per given time. As this workqueue is used for card detection, the
>> conseqeunce is that cards will be detected one by one waiting for each
>> other.
>>
>> Moreover, most of the time spent during card initialization is waiting for
>> the card's internal firmware to be ready. From a CPU perspective this
>> typically means waiting for a completion variable to be kicked via an
>> IRQ-handler or waiting for a sleep timer to finish.
>>
>> This behaviour of detecting/initializing cards is sub-optimal, especially
>> for SOCs having several controllers/cards.
>>
>> Let's convert to use the system_freezable_wq for the mmc detect works.
>> This enables several works to be executed simultaneously and thus also
>> cards to be detected like so.
>>
>> Tests on UX500, which holds two eMMC cards and an SD-card (actually also
>> an SDIO card, currently not detected), shows a significant improved
>> behaviour due to this change.
>>
>> Before this change, both the eMMC cards waited for the SD card to be
>> initialized as its detect work entered the workqueue first. In some cases,
>> depending on the characteristic of the SD-card, they got delayed 1-1.5 s.
>>
>> Additionally for the second eMMC, it needed to wait for the first eMMC to
>> be initialized which added another 120-190 ms.

how did you check this? I also want to test with similar environment. :)

>>
>> Converting to the system_freezable_wq, removed these delays and made both
>> the eMMC cards available far earlier in the boot sequence.
>>
>> Selecting the system_freezable_wq, in favour of for example the system_wq,
>> is because we need card detection mechanism to be disabled once userspace
>> are frozen during system PM. Currently the mmc core deal with this via PM
>> notifiers, but following patches may utilize the behaviour of the
>> system_freezable_wq, to simplify the use of the PM notifiers.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Even-though the lack of reviewers, I have decided to give this a try
> and pushed it for my next branch.
> 
> If it isn't clear by the above change-log:
> A side effect from this change is that mmc block partitions, may end
> up being given other indexes than they had before. Whether that may
> cause issues, depends on if the path to the rootfs have been
> hard-coded or not.

What does "mmc block partitions, may end up being given other indexes than they had before." mean?
Is it possible to increase the index for partition number?
If my understanding is right...mmcblk's partition index is not fixed.
Sometime eMMC should be mmcblk0pX or mmcblk1px..right? hmm...

I need to check more...with other boards and SoC.

Best Regards,
Jaehoon Chung

> 
> The recommended way to solve this is to use UUID/PARTUUID.
> 
> An important note, there has *never* been any guarantees that mmc
> block partitions get the same index at every boot, as that depends on
> the probe order of the mmc host devices and whether a removable card
> is inserted or not.
> For those platforms that don't take this into account, suffers from a
> fragile boot dependency and needs to be fixed.
> 
> I will check reports from the kernelci.org as my next branch is being
> tested from there. Of course I appreciate any other issues being
> reported!
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/core/core.c | 31 ++++++++-----------------------
>>  1 file changed, 8 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 910aa25..f95d41f 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -55,7 +55,6 @@
>>   */
>>  #define MMC_BKOPS_MAX_TIMEOUT  (4 * 60 * 1000) /* max time to wait in ms */
>>
>> -static struct workqueue_struct *workqueue;
>>  static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>>
>>  /*
>> @@ -66,21 +65,16 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>>  bool use_spi_crc = 1;
>>  module_param(use_spi_crc, bool, 0);
>>
>> -/*
>> - * Internal function. Schedule delayed work in the MMC work queue.
>> - */
>>  static int mmc_schedule_delayed_work(struct delayed_work *work,
>>                                      unsigned long delay)
>>  {
>> -       return queue_delayed_work(workqueue, work, delay);
>> -}
>> -
>> -/*
>> - * Internal function. Flush all scheduled work from the MMC work queue.
>> - */
>> -static void mmc_flush_scheduled_work(void)
>> -{
>> -       flush_workqueue(workqueue);
>> +       /*
>> +        * We use the system_freezable_wq, because of two reasons.
>> +        * First, it allows several works (not the same work item) to be
>> +        * executed simultaneously. Second, the queue becomes frozen when
>> +        * userspace becomes frozen during system PM.
>> +        */
>> +       return queue_delayed_work(system_freezable_wq, work, delay);
>>  }
>>
>>  #ifdef CONFIG_FAIL_MMC_REQUEST
>> @@ -2669,7 +2663,6 @@ void mmc_stop_host(struct mmc_host *host)
>>
>>         host->rescan_disable = 1;
>>         cancel_delayed_work_sync(&host->detect);
>> -       mmc_flush_scheduled_work();
>>
>>         /* clear pm flags now and let card drivers set them as needed */
>>         host->pm_flags = 0;
>> @@ -2852,13 +2845,9 @@ static int __init mmc_init(void)
>>  {
>>         int ret;
>>
>> -       workqueue = alloc_ordered_workqueue("kmmcd", 0);
>> -       if (!workqueue)
>> -               return -ENOMEM;
>> -
>>         ret = mmc_register_bus();
>>         if (ret)
>> -               goto destroy_workqueue;
>> +               return ret;
>>
>>         ret = mmc_register_host_class();
>>         if (ret)
>> @@ -2874,9 +2863,6 @@ unregister_host_class:
>>         mmc_unregister_host_class();
>>  unregister_bus:
>>         mmc_unregister_bus();
>> -destroy_workqueue:
>> -       destroy_workqueue(workqueue);
>> -
>>         return ret;
>>  }
>>
>> @@ -2885,7 +2871,6 @@ static void __exit mmc_exit(void)
>>         sdio_unregister_bus();
>>         mmc_unregister_host_class();
>>         mmc_unregister_bus();
>> -       destroy_workqueue(workqueue);
>>  }
>>
>>  subsys_initcall(mmc_init);
>> --
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

