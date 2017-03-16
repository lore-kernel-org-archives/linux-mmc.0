From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/4] mmc: pwrseq: add op reset to struct mmc_pwrseq_ops
Date: Thu, 16 Mar 2017 07:49:17 +0100
Message-ID: <d029f887-4fd3-1319-fd01-a99ea9ede5c1@gmail.com>
References: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
 <c75c3e5c-c4e1-3f2f-267b-1c781052c55e@gmail.com>
 <CAPDyKFr6_Y3cSv5Q1WRSQBo7_bsyeVVQTYBQ01gykdMpVWNtXw@mail.gmail.com>
 <ac5f62eb-64c6-b66f-24cc-b6ae74a01697@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33521 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCPGtf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 02:49:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id g10so4596976wrg.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2017 23:49:34 -0700 (PDT)
In-Reply-To: <ac5f62eb-64c6-b66f-24cc-b6ae74a01697@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 15.03.2017 um 22:42 schrieb Heiner Kallweit:
> Am 15.03.2017 um 11:50 schrieb Ulf Hansson:
>> On 8 February 2017 at 22:48, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>> Add an operation reset to struct mmc_pwrseq_ops and related wrappers.
>>>
>>> Don't expose the pwrseq-internal reset function directly to kernel
>>> users but just to the mmc core.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/mmc/core/core.c   | 6 ++++++
>>>  drivers/mmc/core/pwrseq.c | 8 ++++++++
>>>  drivers/mmc/core/pwrseq.h | 3 +++
>>>  include/linux/mmc/core.h  | 1 +
>>>  4 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 926e0fde..5d5fe591 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1869,6 +1869,12 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>>>         mmc_power_up(host, ocr);
>>>  }
>>>
>>> +void mmc_hw_reset_pwrseq(struct mmc_host *host)
>>> +{
>>> +       mmc_pwrseq_reset(host);
>>> +}
>>> +EXPORT_SYMBOL(mmc_hw_reset_pwrseq);
>>> +
>>>  /*
>>>   * Cleanup when the last reference to the bus operator is dropped.
>>>   */
>>> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
>>> index 9386c477..e3ad30fa 100644
>>> --- a/drivers/mmc/core/pwrseq.c
>>> +++ b/drivers/mmc/core/pwrseq.c
>>> @@ -76,6 +76,14 @@ void mmc_pwrseq_power_off(struct mmc_host *host)
>>>                 pwrseq->ops->power_off(host);
>>>  }
>>>
>>> +void mmc_pwrseq_reset(struct mmc_host *host)
>>> +{
>>> +       struct mmc_pwrseq *pwrseq = host->pwrseq;
>>> +
>>> +       if (pwrseq && pwrseq->ops->reset)
>>> +               pwrseq->ops->reset(host);
>>> +}
>>> +
>>>  void mmc_pwrseq_free(struct mmc_host *host)
>>>  {
>>>         struct mmc_pwrseq *pwrseq = host->pwrseq;
>>> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
>>> index 39c911aa..819386f4 100644
>>> --- a/drivers/mmc/core/pwrseq.h
>>> +++ b/drivers/mmc/core/pwrseq.h
>>> @@ -18,6 +18,7 @@ struct mmc_pwrseq_ops {
>>>         void (*pre_power_on)(struct mmc_host *host);
>>>         void (*post_power_on)(struct mmc_host *host);
>>>         void (*power_off)(struct mmc_host *host);
>>> +       void (*reset)(struct mmc_host *host);
>>>  };
>>>
>>>  struct mmc_pwrseq {
>>> @@ -36,6 +37,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host);
>>>  void mmc_pwrseq_pre_power_on(struct mmc_host *host);
>>>  void mmc_pwrseq_post_power_on(struct mmc_host *host);
>>>  void mmc_pwrseq_power_off(struct mmc_host *host);
>>> +void mmc_pwrseq_reset(struct mmc_host *host);
>>>  void mmc_pwrseq_free(struct mmc_host *host);
>>>
>>>  #else
>>> @@ -49,6 +51,7 @@ static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
>>>  static inline void mmc_pwrseq_pre_power_on(struct mmc_host *host) {}
>>>  static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
>>>  static inline void mmc_pwrseq_power_off(struct mmc_host *host) {}
>>> +static inline void mmc_pwrseq_reset(struct mmc_host *host) {}
>>>  static inline void mmc_pwrseq_free(struct mmc_host *host) {}
>>>
>>>  #endif
>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>>> index a0c63ea2..8dbbd7a1 100644
>>> --- a/include/linux/mmc/core.h
>>> +++ b/include/linux/mmc/core.h
>>> @@ -166,6 +166,7 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>>>                 int retries);
>>>
>>>  int mmc_hw_reset(struct mmc_host *host);
>>> +void mmc_hw_reset_pwrseq(struct mmc_host *host);
>>
>> Don't you think we can make this transparent to mmc host drivers,
>> instead of them having to assign their host_ops->hw_reset() callback
>> to this new API? Because I guess that's the though!?
>>
>> In principle the mmc core already have all the information it needs,
>> as to understand when the eMMC pwrseq should be invoked. Or perhaps
>> the code may become a bit too messy for that?
>>
> The easiest way I could think of:
> If host->ops->hw_reset is NULL overwrite it with pwrseq->ops->reset
> in mmc_add_host. But host->ops is defined es being const, so the compiler
> won't allow us to do this. Of course we could do some casting but usually
> I try to avoid hacks like casting away const qualifiers.
> 
Other alternative:

typedef void (*hw_reset_t)(struct mmc_host *host);

hw_reset_t mmc_get_hw_reset(struct mmc_host *host)
{
       struct mmc_pwrseq *p = host->pwrseq;

       if (host->ops->hw_reset)
               return host->ops->hw_reset;
       else if (p && p->ops->reset)
               return p->ops->reset;
       else
               return NULL;
}

And then use what mmc_get_hw_reset returns instead of using
host->ops->hw_reset directly.

How do you like this one?

>>>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
>>>
>>>  #endif /* LINUX_MMC_CORE_H */
>>> --
>>> 2.11.0
>>>
>>>
>>
>> Kind regards
>> Uffe
>>
> 

