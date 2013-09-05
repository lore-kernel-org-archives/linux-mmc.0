From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 1/8] mmc: sdhci: add hooks for platform specific tuning
Date: Thu, 5 Sep 2013 22:53:29 +0800
Message-ID: <CAA+hA=R+79cDTDLnUBdndBMNzsBjbM+anjyiVN0UXx8V+KqW7A@mail.gmail.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
	<1378299257-2980-2-git-send-email-b29396@freescale.com>
	<20130905031401.GA775@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:50910 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3IEOxa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2013 10:53:30 -0400
Received: by mail-qc0-f175.google.com with SMTP id v2so986224qcr.6
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2013 07:53:29 -0700 (PDT)
In-Reply-To: <20130905031401.GA775@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, anton@enomsg.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 5, 2013 at 11:14 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Sep 04, 2013 at 08:54:10PM +0800, Dong Aisheng wrote:
>> The tuning of some platforms may not follow the standard host control
>> spec v3.0, e.g. Freescale uSDHC on i.MX6Q/DL.
>> Add a hook here to allow execute platform specific tuning instead of
>> standard host controller tuning.
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> ---
>>  drivers/mmc/host/sdhci.c |    8 ++++++++
>>  drivers/mmc/host/sdhci.h |    1 +
>>  2 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index dd2c083..2890cfd 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1875,6 +1875,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>               return 0;
>>       }
>>
>> +     if (host->ops->platform_execute_tuning) {
>> +             spin_unlock(&host->lock);
>> +             enable_irq(host->irq);
>
> Hmm, you want these two functions be called before
> platform_execute_tuning()?  That probably means you do not need to call
> spin_lock() and disable_irq() for platform_execute_tuning()?  In that

Platform_execute_tuning may send commands and can not execute with
lock all the time.
Since the lock is acquired in upper layer(sdhci_execute_tuning), so we
just release it at the same layer for more clear code.
In platform_execute_tuning, it may still need acquire lock according
to specific implemenation if it wants to access host.
However, not need to handle sdhci_runtime_pm_get/put things since it's
executed with
runtime_pm_get already.
I could add more description in commit message about this API definition.

> case, can we not just put this platform hook at the beginning of the
> function, something like below?
>
>         host = mmc_priv(mmc);
>
>         if (host->ops->platform_execute_tuning) {
>                 sdhci_runtime_pm_get(host);
>                 err = host->ops->platform_execute_tuning(host, opcode);
>                 sdhci_runtime_pm_put(host);
>         }
>
> I guess that's more clear to tell that platform_execute_tuning hook is
> there to replace sdhci_execute_tuning() completely.  Is it the case?
>

The sdhci_execute_tuning includes two parts: checking whehter need tuning
and the tuning execution process.
The first part is common for all other platforms.
So i just put the platform tuning under it, only replace later tuning
execution process.

Regards
Dong Aisheng

>
>> +             err = host->ops->platform_execute_tuning(host, opcode);
>> +             sdhci_runtime_pm_put(host);
>> +             return err;
>> +     }
>> +
>>       sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>>       /*
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index b037f18..976c14b 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -288,6 +288,7 @@ struct sdhci_ops {
>>       unsigned int    (*get_ro)(struct sdhci_host *host);
>>       void    (*platform_reset_enter)(struct sdhci_host *host, u8 mask);
>>       void    (*platform_reset_exit)(struct sdhci_host *host, u8 mask);
>> +     int     (*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
>>       int     (*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
>>       void    (*hw_reset)(struct sdhci_host *host);
>>       void    (*platform_suspend)(struct sdhci_host *host);
>> --
>> 1.7.1
>>
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
