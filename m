From: Chunhe Lan <b25806@freescale.com>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 21 Sep 2012 16:52:53 -0400
Message-ID: <505CD3A5.6080101@freescale.com>
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com> <201208101327.47789.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:40208
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932067Ab2IUIuV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Sep 2012 04:50:21 -0400
In-Reply-To: <201208101327.47789.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, cjb@laptop.org, Kumar Gala <galak@kernel.crashing.org>

On 08/10/2012 09:27 AM, Arnd Bergmann wrote:
> On Friday 10 August 2012, Chunhe Lan wrote:
>
>> +static inline void mmc_delay(unsigned int ms)
>> +{
>> +	if (ms < 1000 / HZ) {
>> +		cond_resched();
>> +		mdelay(ms);
>> +	} else {
>> +		msleep(ms);
>> +	}
>> +}
> I would actually question the point in this function to start with: The
> decision whether to call mdelay() or msleep() should only be based on
> whether you are allowed to sleep in the caller context. The idea of
>
>
> 	cond_resched();
> 	mdelay(ms);
>
> sets off alarm bells, and I would always replace that with msleep().
     I think that it does not replace with msleep().
     When the time of sleep is very short, program should not been scheduled
     in the context. Because it expends the more time.

     Thanks,
     Chunhe
>
> 	Arnd
>



