From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (mmc-next) 3/3] mmc: fix a warning when compile the
 sdhci d.d.
Date: Mon, 27 Sep 2010 14:57:47 +0200
Message-ID: <4CA094CB.1060209@st.com>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-3-git-send-email-peppe.cavallaro@st.com>
 <20100927105413.GE2664@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:55396 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752639Ab0I0M6Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Sep 2010 08:58:16 -0400
In-Reply-To: <20100927105413.GE2664@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Wolfram,

On 09/27/2010 12:54 PM, Wolfram Sang wrote:
> On Thu, Sep 23, 2010 at 11:14:26AM +0200, Giuseppe CAVALLARO wrote:
>> This patch fixes a warning when compile the sdhci:
>>   pwr may be used uninitialized in sdhci_set_power
>> Also removes some include files that live in sdhci.h
>> header file.
>>
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> 
> Okay for the set_power-part (what compiler are you using? Newer one

I tried with both 4.2.4 and 4.4.4 without any problems.

> should detect that BUG never returns). The include-removal could be in a
> seperate patch, not sure if it is worth, though.

It can include in a separate patch.
It makes sense if apply the previous patch to split the header file
because we remove duplicated include files.

Regards,
Peppe

> 
>> ---
>>  drivers/mmc/host/sdhci.c |   11 ++---------
>>  1 files changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 5928b0a..058dacd 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -18,13 +18,8 @@
>>  #include <linux/io.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/slab.h>
>> -#include <linux/scatterlist.h>
>>  #include <linux/regulator/consumer.h>
>>  
>> -#include <linux/leds.h>
>> -
>> -#include <linux/mmc/host.h>
>> -
>>  #include "sdhci.h"
>>  
>>  #define DRIVER_NAME "sdhci"
>> @@ -1050,11 +1045,9 @@ out:
>>  
>>  static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
>>  {
>> -	u8 pwr;
>> +	u8 pwr = 0;
>>  
>> -	if (power == (unsigned short)-1)
>> -		pwr = 0;
>> -	else {
>> +	if (power != (unsigned short)-1) {
>>  		switch (1 << power) {
>>  		case MMC_VDD_165_195:
>>  			pwr = SDHCI_POWER_180;
>> -- 
>> 1.5.5.6
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
