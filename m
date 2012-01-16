From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH RFC] mmc : omap_hsmmc : Save and restore the sysc across
 reset
Date: Mon, 16 Jan 2012 19:52:14 +0530
Message-ID: <4F143296.8090802@ti.com>
References: <1326713587-26463-1-git-send-email-shubhrajyoti@ti.com> <5E7C2FE2AE03DF4CA6AC500032BF8F77C1762A@008-AM1MPN1-072.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5E7C2FE2AE03DF4CA6AC500032BF8F77C1762A@008-AM1MPN1-072.mgdnok.nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext-denis.2.karpov@nokia.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday 16 January 2012 06:41 PM, ext-denis.2.karpov@nokia.com wrote:
> ext Shubhrajyoti D wrote on 2012-01-16:
>> The commit 11dd62:[omap_hsmmc: context save/restore support]
>>
>> does a reset and restores AUTOIDLE settings.
>> This patch saves the register does a reset and restores
>> the same configuration.
> ...
>>  	if (pdata->get_context_loss_count) {
>> @@ -700,6 +700,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host
>> *host)
>>  		&& time_before(jiffies, timeout))
>>  		;
>> +	sysc = OMAP_HSMMC_READ(host->base, SYSCONFIG);
>>  	/* Do software reset */
>>  	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, SOFTRESET);
>>  	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
>> @@ -707,8 +708,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host
>> *host)
>>  		&& time_before(jiffies, timeout))
>>  		;
>> -	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
>> -			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
>> +	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, sysc);
> The meaning of the code is to restore the register context after it was lost during transition into low power consumption state. SW reset is needed to bring all the registers in a consistent state before reconfiguring some of them. 
Agreed thanks.
> Saving and restoring the SYSCONFIG register across SW reset is not needed. 
>
> Also re-configuring AUTOIDLE feature is not necessary since SYSCONFIG reset value has is 1 already, according to TRM. I guess it was done to make things more explicit.
However in addition to autoidle there are other bits in the register
like the sidle mode , enable wakeup which will get not get overwritten now.

Do you agree?
> Denis
