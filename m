From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [Query] mmc/sdhci: Suspend hangs if card is inserted at suspend.
Date: Tue, 15 Nov 2011 13:41:45 +0530
Message-ID: <4EC21EC1.2090607@codeaurora.org>
References: <4EBCC49E.5060008@st.com> <877h36hvki.fsf@laptop.org> <4EC1FCC1.6070609@st.com> <5D8008F58939784290FAB48F549751984E6510F91D@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:15684 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab1KOIL4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 03:11:56 -0500
In-Reply-To: <5D8008F58939784290FAB48F549751984E6510F91D@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, ulf.hansson@stericsson.com
Cc: Viresh Kumar <viresh.kumar@st.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>

Hi Ulf,

I see similar issue with your patch in 3.2 "mmc: core: Prevent too long 
response times for suspend".

                 if (mmc_try_claim_host(host)) {
<snip>
/* if CONFIG_MMC_UNSAFE_RESUME is not set, remove() callback would get 
blocked until mmcqd gets mmc_claim_host() causing deadlock here */
                                 if (host->bus_ops->remove)
                                         host->bus_ops->remove(host);
<snip>
                 } else {
                         err = -EBUSY;
                 }
         }

Proabably, we can do something like this:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5278ffb..0177d4a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2309,6 +2309,7 @@ int mmc_suspend_host(struct mmc_host *host)
                                  * We simply "remove" the card in this 
case.
                                  * It will be redetected on resume.
                                  */
+                               mmc_do_release_host(host);
                                 if (host->bus_ops->remove)
                                         host->bus_ops->remove(host);
                                 mmc_claim_host(host);
@@ -2317,8 +2318,9 @@ int mmc_suspend_host(struct mmc_host *host)
                                 mmc_release_host(host);
                                 host->pm_flags = 0;
                                 err = 0;
+                       } else {
+                               mmc_do_release_host(host);
                         }
-                       mmc_do_release_host(host);
                 } else {
                         err = -EBUSY;
                 }

Please let me know if you agree. I can post a patch for this.


Thanks
Sujit

On 11/15/2011 12:27 PM, Dong, Chuanxiao wrote:
> Hi Viresh,
> I also meet the hang issue when suspending a system with a mounted SD card. Actually it caused by a dead lock of mmc_claim_host. Maybe we faced the same issue.
> So may be the two mails in the attachment can help you.
>
> Thanks
> Chuanxiao
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org
>> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Viresh Kumar
>> Sent: Tuesday, November 15, 2011 1:47 PM
>> To: Chris Ball
>> Cc: linux-mmc@vger.kernel.org; Shiraz HASHIM; Armando VISCONTI
>> Subject: Re: [Query] mmc/sdhci: Suspend hangs if card is inserted at suspend.
>>
>> On 11/12/2011 8:54 AM, Chris Ball wrote:
>>> On Fri, Nov 11 2011, Viresh Kumar wrote:
>>>>> Controller specific suspend/resume are still not called, so i think it might
>>>>> be related to core code. I am using 2.6.37 kernel version.
>>>>>
>>>>> Any help on this?
>>> Please try to reproduce on 3.1 and let us know if it's present there.
>>
>> Hi Chris,
>>
>> Support for SPEAr13xx is not present on 3.1 and it will take some time to
>> move support there. I have a bit more info which might able you to guide us:
>>
>> file: drivers/mmc/card/queue.c
>>
>> static int mmc_queue_thread(void *d)
>> {
>> 	...
>> 	do {
>> 		req = blk_fetch_request(q);
>> 		...
>> 		if (!req) {
>> 			if (kthread_should_stop()) {
>> 				set_current_state(TASK_RUNNING);
>> 				break;
>> 			}
>> 			up(&mq->thread_sem);
>> 			schedule();
>> 			down(&mq->thread_sem);
>> 			continue;
>> 		}
>> 		set_current_state(TASK_RUNNING);
>> 		mq->issue_fn(mq, req);
>> 	} while (1);
>> 	...
>> }
>>
>> - In normal cases, i.e. when we are able to stop this thread,
>>    req is returned as NULL from blk_fetch_request()
>> - Suspend hang only occurs when the card is mounted.
>> - When suspend hangs, req is not returned as NULL and the card is
>>    already removed by kernel and so we never check kthread_should_stop().
>>    So it hangs.
>>
>> --
>> viresh
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Thanks & Regards,
Sujit Reddy Thumma

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
