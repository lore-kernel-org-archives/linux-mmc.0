From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable (clock-gating)
Date: Tue, 28 Sep 2010 14:29:39 +0900
Message-ID: <4CA17D43.1030004@samsung.com>
References: <4C91BD5A.1040804@samsung.com>
 <20100917134031.GA11462@console-pimps.org>
 <AANLkTi=HWUy7Fm7mKPGWT4m0kzKJhEUE8C=Yw2NN1Z5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14418 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab0I1F3X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 01:29:23 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L9F003C2Z8X7510@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Sep 2010 14:29:21 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L9F00CWQZ8X7Q@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Sep 2010 14:29:21 +0900 (KST)
In-reply-to: <AANLkTi=HWUy7Fm7mKPGWT4m0kzKJhEUE8C=Yw2NN1Z5J@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Matt Fleming <matt@console-pimps.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>

Jae hoon Chung wrote:
> 2010/9/17 Matt Fleming <matt@console-pimps.org>:
>> On Thu, Sep 16, 2010 at 03:46:50PM +0900, Jaehoon Chung wrote:
>>> Hi all,
>>>   This is a RFC patch that support clock-gating for saving power consumption.
>>>   I found mmc_host_enable/mmc_host_disable function in core.c
>>>   (using MMC_CAP_DSIABLE. i think that use when host enable/disable)
>>>   So, i used that functions and implemented some functions in sdhci-s3c.c & sdhci.c
>>>
>>> i want any feedback. how do you think about this patch?
>>> Plz let me know...
>>>
>>> Thank you all
>>>
>>>  Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>  Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>
>>> ---
>>>  drivers/mmc/host/sdhci-s3c.c |   36 ++++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci.c     |   30 ++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci.h     |    4 ++++
>>>  3 files changed, 70 insertions(+), 0 deletions(-)
>> [...]
>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 401527d..fa2e55d 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1245,7 +1245,37 @@ out:
>>>       spin_unlock_irqrestore(&host->lock, flags);
>>>  }
>>>
>>> +static int sdhci_enable_clk(struct mmc_host *mmc)
>>> +{
>>> +     struct sdhci_host *host = mmc_priv(mmc);
>>> +     int ret = 0;
>>> +
>>> +     if (host->old_clock != 0 && host->clock == 0) {
>>> +             if (host->ops->enable)
>>> +                     ret = host->ops->enable(host);
>>> +             sdhci_set_clock(host, host->old_clock);
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int sdhci_disable_clk(struct mmc_host *mmc, int lazy)
>>> +{
>>> +     struct sdhci_host *host = mmc_priv(mmc);
>>> +     int ret = 0;
>>> +
>>> +     if (host->clock != 0) {
>>> +             host->old_clock = host->clock;
>>> +             sdhci_set_clock(host, 0);
>>> +             if (host->ops->disable)
>>> +                     ret = host->ops->disable(host, lazy);
>>> +     }
>>> +     return ret;
>>> +}
>>> +
>>>  static const struct mmc_host_ops sdhci_ops = {
>>> +     .enable         = sdhci_enable_clk,
>>> +     .disable        = sdhci_disable_clk,
>>>       .request        = sdhci_request,
>>>       .set_ios        = sdhci_set_ios,
>>>       .get_ro         = sdhci_get_ro,
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index d316bc7..0c6f143 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -278,6 +278,8 @@ struct sdhci_host {
>>>       unsigned int            timeout_clk;    /* Timeout freq (KHz) */
>>>
>>>       unsigned int            clock;          /* Current clock (MHz) */
>>> +     unsigned int            old_clock;      /* Old clock (MHz) */
>>> +     unsigned int            clk_cnt;        /* Clock user count */
>>>       u8                      pwr;            /* Current voltage */
>>>
>>>       struct mmc_request      *mrq;           /* Current request */
>>> @@ -323,6 +325,8 @@ struct sdhci_ops {
>>>       unsigned int    (*get_max_clock)(struct sdhci_host *host);
>>>       unsigned int    (*get_min_clock)(struct sdhci_host *host);
>>>       unsigned int    (*get_timeout_clock)(struct sdhci_host *host);
>>> +     int             (*enable)(struct sdhci_host *host);
>>> +     int             (*disable)(struct sdhci_host *host, int lazy);
>>>  };
>>>
>>>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> I could have misunderstood something, but do you really need this new
>> 'old_clock' member? Is the previous clock value not stored in
>> host->ios.clock?
> 
> Thanks Matt for your comment.
> if host->ios.clock set zero, i think that need previous value (for
> example 52MHz..)
> So i add 'old_clock' member...i will test, after removed 'old_clock'
> 
> anyother doubt? and problem?
> Thanks
> 
Hi Chris.
I want to know how do you think about this patch.
If you have any doubt in this patch, let me know plz.

Thanks
Jaehoon Chung
