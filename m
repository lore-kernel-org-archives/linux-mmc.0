Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015B45FFB1
	for <linux-mmc@vger.kernel.org>; Mon, 21 Sep 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981478; cv=none; b=GfhYWuDQxTAlPHOyyHuYT8IvS5K33qHwp7DHlQvtFQjGBVi/AxSihdaM7q1VV2sYitDF0Lg7CsAceTkij6C60jz5kQmcXNdUBw+it1VMSgMb7KITFHJ1MXB8hBuPFRDtaifJnnRWYk7oXYFYraw7Vjtbaij7rPGLvD7SpxEZG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981478; c=relaxed/simple;
	bh=ep6c1TgkccXtFLmMwq1oS+x2Z4lk8WNkDOTBK1/h7/A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kz455QmgQVUyOLnlzcwEqTuQTI1Ot6ZxNxx4HRV8KGVplPIi5/IF97kEkvDRZ4D1IiRXdTDWvR+yTcz2zDSG3fHRHcXeMtH70IArU+eg0rcUNRREj0cT7BbjUF+b/tk35csQA1v33I+UY9b4rT0HRiZe74Ab3WQ4rgdYBU/oOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R3bbAiKW; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R3bbAiKW"
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ep6c1TgkccXtFLmMwq1oS+x2Z4lk8WNkDOTBK1/h7/A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789981474; v=1; x=1790586274;
 b=R3bbAiKW9SLmDhWT6JK3U1BlsP1jwbTn+hbMoU4RG/72cDWLvLvMAV3zIwtw/V95Du7qrKcn
 d7wWYOB/4YXrhyXMQUCZoxNyczYHWz9DaRPLa5+2Oy7ohrbxqhLJdxZOA5zwfK8LXmjrJm542jh
 j/TpVNE3IqyONg7tl/+fKMoM=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e8df5a5b37cd59a;
	Mon, 21 Sep 2026 09:04:34 +0000
X-Mizu-Trace-ID: 2e8df5a5b37cd59a
X-Migadu-Flow: FLOW_OUT
Message-ID: <35e76280-d956-4b85-a549-860e9de3e6a2@linux.dev>
Date: Mon, 21 Sep 2026 17:04:26 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, Ulf Hansson <ulfh@kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?6ZmI5paH6LaFIChXZW5jaGFvIENoZW4p?= <Wenchao.Chen@unisoc.com>,
 =?UTF-8?B?5byg5aaC5rOJIChSYWluIFpoYW5nKQ==?= <Rain.Zhang@unisoc.com>,
 =?UTF-8?B?5ZSQ5pyI5p6XIChZdWVsaW4gVGFuZyk=?= <yuelin.tang@unisoc.com>,
 "cixi.geng@linux.dev" <cixi.geng@linux.dev>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH v2] mmc: core: Optimize polling delay in
 __mmc_poll_for_busy()
To: =?UTF-8?B?5p2O5pmT5rSBIChYaWFvamllIExpLzEzMjMzKQ==?=
 <xiaojie.li2@unisoc.com>
References: <308e39324361468db136bb14a22f422b@zeshmbx09.spreadtrum.com>
 <1d135368-6b2c-443c-a946-45f0be2040fb@linux.dev>
 <837f123fb1aa4d8d90708c8e4f5cfb42@zeshmbx09.spreadtrum.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <837f123fb1aa4d8d90708c8e4f5cfb42@zeshmbx09.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/09/21 Mon 16:31, 李晓洁 (Xiaojie Li/13233) wrote:
>> I think the CMD1-specific branch can be avoided altogether. The reason CMD1's tail latency is high is that __mmc_poll_for_busy() limits udelay to a maximum of 32768 and, more importantly, the sleep upper bound is udelay * 2.
> 
>> Would it be possible to parameterize the maximum delay instead? E.g.
> 
>   >  int __mmc_poll_for_busy(host, period_us, udelay_max_us, timeout_ms, cb, cb_data)
> 
> Hi shawn,
> The __mmc_poll_for_busy function is invoked, either directly or indirectly, in numerous locations throughout the codebase.
> That's why I used if (busy_cb == __mmc_send_op_cond_cb) to check for the special CMD1 handling.
> As mentioned in my previous email, passing it directly as a function parameter would require modifying quite a few places.
> The call sites identified so far are listed below:

On the "quite a few places" concern: it is smaller than it looks. Of
the call sites you listed, 9 go through the mmc_poll_for_busy() wrapper
(__mmc_switch, mmc_send_hpi_cmd, mmc_blk_fix_state, sd_flush_cache,
sd_enable_cache, sd_poweroff_notify, mmc_cqe_recovery, mmc_do_erase),
so they do not change at all - the wrapper keeps passing the current
default. Only the ~6 direct callers of __mmc_poll_for_busy() need a
one-line mechanical change (mmc_ops.c CMD1 and the wrapper itself,
block.c x2, sd.c, mmc.c).

Also note that the hardcoded 32768 is itself a policy choice that only
suits the long-running commands (CMD6, erase, ...). The OP_COND style
polling wants a different maximum - CMD1 as you measured, and ACMD41
in sd_ops.c starts at 10ms and has the same tail-latency issue - so
making it an explicit parameter is exactly the point. The core helper
should not know which caller it is serving, which is what the
busy_cb pointer comparison effectively does.

> （1）mmc_ops.c
> （1.1）	238 err = __mmc_poll_for_busy(host, MMC_OP_COND_PERIOD_US, in mmc_send_op_cond()
> （1.2）555 return __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_busy_cb, &cb_data); in mmc_poll_for_busy()
> （1.3）641 err = mmc_poll_for_busy(card, timeout_ms, retry_crc_err, MMC_BUSY_CMD6); in __mmc_switch()
> （1.4）889 return mmc_poll_for_busy(card, busy_timeout_ms, false, MMC_BUSY_HPI); in mmc_send_hpi_cmd()
> （2）block.c	
> （2.1）649 err = __mmc_poll_for_busy(card->host, 0, busy_timeout_ms, in __mmc_blk_ioctl_cmd()
> （2.2）err = __mmc_poll_for_busy(card->host, 0, MMC_BLK_TIMEOUT_MS, in mmc_blk_card_busy()
> （2.3）1746 err = mmc_poll_for_busy(card, timeout, false, MMC_BUSY_IO); in mmc_blk_fix_state()
> （3）sd.c
> （3.1）1711 err = __mmc_poll_for_busy(card->host, 0, SD_POWEROFF_NOTIFY_TIMEOUT_MS, in sd_poweroff_notify()
> （3.2）1358 err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false, in sd_flush_cache()
> （3.3）1404 err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false, in sd_enable_cache()
> （3.4）1704 err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false, in sd_poweroff_notify()
> （4）mmc.c	
> （4.1）2011 err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host); in mmc_sleep()
> （5）core.c	
> （5.1）556 mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, MMC_BUSY_IO); in mmc_cqe_recovery()
> （5.2）1701 err = mmc_poll_for_busy(card, busy_timeout, false, MMC_BUSY_ERASE); in mmc_do_erase()
> 
> 
>> and limit both the backoff step and the sleep upper bound to
>> udelay_max_us:
> 
>>    unsigned int sleep_max = min(udelay * 2, udelay_max_us);
>>     usleep_range(min(udelay, udelay_max_us), sleep_max);
> 
> I'm not entirely sure about your suggested changes here. Could you provide more detailed modifications?

1) extend the prototype in mmc_ops.h:

int __mmc_poll_for_busy(struct mmc_host *host, unsigned int period_us,
                         unsigned int udelay_max_us, unsigned int 
timeout_ms,
                         int (*busy_cb)(void *cb_data, bool *busy),
                         void *cb_data);

2) in __mmc_poll_for_busy(), only the throttling changes:

-       unsigned int udelay = period_us ? period_us : 32, udelay_max = 
32768;
+       unsigned int udelay = period_us ? period_us : 32;
...
                 /* Throttle the polling rate to avoid hogging the CPU. */
                 if (busy) {
-                       usleep_range(udelay, udelay * 2);
-                       if (udelay < udelay_max)
-                               udelay *= 2;
+                       unsigned int sleep_max = min(udelay * 2, 
udelay_max_us);
+
+                       usleep_range(min(udelay, udelay_max_us), sleep_max);
+                       if (udelay < udelay_max_us)
+                               udelay *= 2;
                 }

3) add the new value next to the existing ones in mmc_ops.c:

#define MMC_OP_COND_MAX_DELAY_US        (8 * 1000) /* 8ms, justify with 
data */

4) in mmc_send_op_cond():

         err = __mmc_poll_for_busy(host, MMC_OP_COND_PERIOD_US,
+                                 MMC_OP_COND_MAX_DELAY_US,
                                   MMC_OP_COND_TIMEOUT_MS,
                                   &__mmc_send_op_cond_cb, &cb_data);

5) every other caller passes the current default, e.g. the wrapper in
mmc_ops.c:

-       return __mmc_poll_for_busy(host, 0, timeout_ms, &__mmc_busy_cb, 
&cb_data);
+       return __mmc_poll_for_busy(host, 0, 32768, timeout_ms,
+                                  &__mmc_busy_cb, &cb_data);

and the same one-line change for the direct callers in block.c
(__mmc_blk_ioctl_cmd(), mmc_blk_card_busy()), sd.c
(sd_poweroff_notify()) and mmc.c (mmc_sleep()). With period_us = 4ms and
udelay_max_us = 8ms, the sleeps become 4-8ms, then 8ms, 8ms, ... so the
tail bound is 8ms instead of today's 32-64ms, and no caller behaviour
changes except CMD1.


> 
>> Then mmc_send_op_cond() passes its own maximum delay (8ms), while all other callers keep passing 32768 so their behaviour is unchanged. That is two lines of code, no busy_cb pointer comparison, and the tail bound
>> (8ms) is actually tighter than the linear +2ms schedule (10ms).
> 
>> Could you try to see if the linear step is still needed once the sleep upper bound is limited to the maximum delay?
> 
> Do you mean that I should verify this by changing the original:
> usleep_range(udelay, udelay * 2);
> if (udelay < udelay_max)
> udelay *= 2;
> to:
> usleep_range(min(udelay, udelay_max_us), sleep_max);?

no, the backoff step stays doubling. What Imeant is: first try this
bounded version for CMD1 (8ms maximum) and compare it against your
linear +2ms schedule on the same slow cards. If the boot-time results
are the same, the linear step is unnecessary and the change stays simple
and generic.


> 
> Best regards,
> Xiaojie.Li
> -----邮件原件-----
> 发件人: Shawn Lin <shawn.lin@linux.dev>
> 发送时间: 2026年9月21日 15:53
> 收件人: 李晓洁 (Xiaojie Li/13233) <xiaojie.li2@unisoc.com>
> 抄送: shawn.lin@linux.dev; Ulf Hansson <ulfh@kernel.org>; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; 陈文超 (Wenchao Chen) <Wenchao.Chen@unisoc.com>; 张如泉 (Rain Zhang) <Rain.Zhang@unisoc.com>; 唐月林 (Yuelin Tang) <yuelin.tang@unisoc.com>; cixi.geng@linux.dev; Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> 主题: Re: [PATCH v2] mmc: core: Optimize polling delay in __mmc_poll_for_busy()
> 
> 
> 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> On 2026/09/20 Sun 13:40, 李晓洁 (Xiaojie Li/13233) wrote:
>>> No, that's the whole point. We don't want open coded polling loops,
>>> it's just a nightmare to maintain. Please try to extend the existing
>>> __mmc_poll_for_busy() instead.
>>
>> Hi Uffe,
>>
>> Following your suggestion to extend __mmc_poll_for_busy() instead of using open-coded polling loops, here is the proposed optimization.
>>
>> In our actual testing, we found that setting udelay_max = 8000 (8ms) is more time-efficient than udelay_max = 10000 (10ms).
>> For CMD1 (SEND_OP_COND), the polling intervals are 4ms, 6ms, and 8ms, capped at a maximum of 8ms.
>> Attached are the recorded per-boot phase latencies for udelay_max=8000 (8ms) and udelay_max=10000 (10ms), with timestamps in seconds.
>> Please let me know if you cannot open the attachment, and I will resend it.
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> 
> I think the CMD1-specific branch can be avoided altogether. The reason CMD1's tail latency is high is that __mmc_poll_for_busy() limits udelay to a maximum of 32768 and, more importantly, the sleep upper bound is udelay * 2.
> 
> Would it be possible to parameterize the maximum delay instead? E.g.
> 
>     int __mmc_poll_for_busy(host, period_us, udelay_max_us, timeout_ms, cb, cb_data)
> 
> and limit both the backoff step and the sleep upper bound to
> udelay_max_us:
> 
>     unsigned int sleep_max = min(udelay * 2, udelay_max_us);
>     usleep_range(min(udelay, udelay_max_us), sleep_max);
> 
> Then mmc_send_op_cond() passes its own maximum delay (8ms), while all other callers keep passing 32768 so their behaviour is unchanged. That is two lines of code, no busy_cb pointer comparison, and the tail bound
> (8ms) is actually tighter than the linear +2ms schedule (10ms).
> 
> Could you try to see if the linear step is still needed once the sleep upper bound is limited to the maximum delay?
> 
> 
>> index a952cc8..9c4762c 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -539,9 +539,23 @@
>>
>>                /* Throttle the polling rate to avoid hogging the CPU. */
>>                if (busy) {
>> -                     usleep_range(udelay, udelay * 2);
>> -                     if (udelay < udelay_max)
>> -                             udelay *= 2;
>> +                     /*
>> +                      * Special delay handling is required for mmc_send_op_cond;
>> +                      * otherwise, for slower memory particles, the time required to
>> +                      * wait for the status change will increase.
>> +                      */
>> +                     if (busy_cb == __mmc_send_op_cond_cb) {
>> +                             udelay_max = 8000;
>> +                             usleep_range(udelay, udelay + 2000);
>> +                             if (udelay < udelay_max)
>> +                                     udelay += 2000;
>> +                             else
>> +                                     udelay = udelay_max;
>> +                     } else {
>> +                             usleep_range(udelay, udelay * 2);
>> +                             if (udelay < udelay_max)
>> +                                     udelay *= 2;
>> +                     }
>>                }
>>        } while (busy);
>>
>>
>> Best regards,
>> Xiaojie.Li
>>
>> -----邮件原件-----
>> 发件人: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
>> 发送时间: 2026年9月11日 23:47
>> 收件人: 李晓洁 (Xiaojie Li/13233) <xiaojie.li2@unisoc.com>
>> 抄送: Ulf Hansson <ulfh@kernel.org>; linux-mmc@vger.kernel.org;
>> linux-kernel@vger.kernel.org; 陈文超 (Wenchao Chen)
>> <Wenchao.Chen@unisoc.com>; 张如泉 (Rain Zhang) <Rain.Zhang@unisoc.com>;
>> 唐月林 (Yuelin Tang) <yuelin.tang@unisoc.com>; cixi.geng@linux.dev
>> 主题: Re: [PATCH] mmc: core: Modify the CMD1 transmission interval
>>
>>
>> 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>>
>> On Fri, Sep 11, 2026 at 4:45 AM 李晓洁 (Xiaojie Li/13233) <xiaojie.li2@unisoc.com> wrote:
>>>
>>> Hi Uffe:
>>>           Thank you for your reply.
>>>           However, I noticed that __mmc_poll_for_busy() and mmc_poll_for_busy() are invoked either directly or indirectly by many other functions within the MMC driver.
>>> Modifying them directly could potentially introduce unintended side effects.
>>>
>>>           Would it be acceptable to implement a dedicated function specifically for CMD1? We could create a CMD1-specific variant based on the existing __mmc_poll_for_busy().
>>> This approach would significantly minimize the potential impact on the rest of the codebase.
>>
>> No, that's the whole point. We don't want open coded polling loops,
>> it's just a nightmare to maintain. Please try to extend the existing
>> __mmc_poll_for_busy() instead.
>>
>> And next time, please don't top post.
>>
>> [...]
>>
>> Kind regards
>> Uffe
> 

