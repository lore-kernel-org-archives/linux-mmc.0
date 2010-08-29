From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 1/7] mmc: at91_mci: fix pointer errors
Date: Mon, 30 Aug 2010 09:39:44 +1200
Message-ID: <4C7AD3A0.40607@bluewatersys.com>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com> <20100827193303.GB23079@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.bluewatersys.com ([202.124.120.130]:11161 "EHLO
	hayes.bluewaternz.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753335Ab0H2Vjl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Aug 2010 17:39:41 -0400
In-Reply-To: <20100827193303.GB23079@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, avictor.za@gmail.com, wolfgang.mues@auerswald.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

On 08/28/2010 07:33 AM, Chris Ball wrote:
> Hi Andrew, Nicolas,
> 
> On Fri, Feb 26, 2010 at 07:39:29PM +0100, Nicolas Ferre wrote:
>> From: Wolfgang Muees <wolfgang.mues@auerswald.de>
>>
>> Fixes two pointer errors, one which leads to memory overwrites if used with
>> large chunks of data.
>>
>> Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/mmc/host/at91_mci.c |    8 +++++---
>>  1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
>> index 63924e0..6835104 100644
>> --- a/drivers/mmc/host/at91_mci.c
>> +++ b/drivers/mmc/host/at91_mci.c
>> @@ -227,11 +227,13 @@ static inline void at91_mci_sg_to_dma(struct at91mci_host *host, struct mmc_data
>>  			for (index = 0; index < (amount / 4); index++)
>>  				*dmabuf++ = swab32(sgbuffer[index]);
>>  		} else {
>> -			memcpy(dmabuf, sgbuffer, amount);
>> -			dmabuf += amount;
>> +			char *tmpv = (char *)dmabuf;
>> +			memcpy(tmpv, sgbuffer, amount);
>> +			tmpv += amount;
>> +			dmabuf = (unsigned *)tmpv;

I see this is already applied, but why all the type trickery here? Why
not just:

	memcpy(dmabuf, sgbuffer, amount);
	dmabuf += amount / sizeof(dmabuf);

>>  		}
>>  
>> -		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
>> +		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);

void * arithmetic is a gcc-ism. Isn't it better to cast to char *, since
the meaning will be a bit more clear.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
