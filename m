From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: fix au_size according to sd spec3.0
Date: Wed, 22 Feb 2012 12:28:12 +0200
Message-ID: <4F44C33C.3060207@intel.com>
References: <1329473681-5071-1-git-send-email-hyeonsu.kim@samsung.com> <4F3E2FEC.6030808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33767 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab2BVK2H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Feb 2012 05:28:07 -0500
In-Reply-To: <4F3E2FEC.6030808@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: hyeonsu.kim@samsung.com, linux-mmc@vger.kernel.org, cjb@laptop.org, kyungmin.park@samsung.com

On 17/02/12 12:46, Jaehoon Chung wrote:
> Hi.
> On 02/17/2012 07:14 PM, hyeonsu.kim@samsung.com wrote:
> 
>> From: Hyeonsu Kim <hyeonsu.kim@samsung.com>
>>
>> This "if phrase" is illogical.
>> and SD Spec 3.0 supports au_size from 0 to 0xF.
>>
>> Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
>> ---
>>  drivers/mmc/core/sd.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index c63ad03..cf8bf0e 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -244,7 +244,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>>  	 * bitfield positions accordingly.
>>  	 */
>>  	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
>> -	if (au > 0 || au <= 9) {
>> +	if (au >= 0 && au < 16) {
> 
> I think "if (au > 0 && au <= 0xf)" is more readable and 
> need to check the sd-spec.
> Because in SD2.0, didn't define from 0xa to 0xf.
> 
>>  		card->ssr.au = 1 << (au + 4);
> 
> Is it right???
> card->ssr.au = 1 << (au + 4) is something wrong.
> If au is 1, card->ssr.au is 32KB. BUt in spec, defined 16KB.
> I think the wrong bit operation. this is more problem.

No it is 16KiB because "au" is in sectors.
