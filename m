From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sd: fix the maximum au_size for SD3.0
Date: Mon, 26 Aug 2013 10:25:38 +0900
Message-ID: <521AAE92.1060802@samsung.com>
References: <51E77061.2030308@samsung.com> <87sixysc0d.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:30049 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab3HZBZ3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Aug 2013 21:25:29 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MS4008S96LQJQ60@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Aug 2013 10:25:27 +0900 (KST)
In-reply-to: <87sixysc0d.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Philip Rakity <prakity@marvell.com>, Johan Rudholm <jrudholm@gmail.com>, Aaron Lu <aaron.lu@amd.com>

Hi Chris,

Thanks a lot.

Do you have any comment or plan for merging?

https://patchwork.kernel.org/patch/2837942/
https://patchwork.kernel.org/patch/2837943/
https://patchwork.kernel.org/patch/2837944/
https://patchwork.kernel.org/patch/2837945/

Best Regards,
Jaehoon Chung

On 08/25/2013 12:08 PM, Chris Ball wrote:
> Hi Jaehoon,
> 
> Pushed to mmc-next for 3.12 with the following minor change, let me
> know if you disagree:
> 
> On Thu, Jul 18 2013, Jaehoon Chung wrote:
>> Since SD Physical Layer specification V3.0, AU_SIZE is supported up to 0xf.
>> So If SD-card is supported v3.0, then max_au should be 0xf.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/core/sd.c |   10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 176d125..aa5013f 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -215,7 +215,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>>  static int mmc_read_ssr(struct mmc_card *card)
>>  {
>>  	unsigned int au, es, et, eo;
>> -	int err, i;
>> +	int err, i, max_au;
>>  	u32 *ssr;
>>  
>>  	if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
>> @@ -239,12 +239,18 @@ static int mmc_read_ssr(struct mmc_card *card)
>>  	for (i = 0; i < 16; i++)
>>  		ssr[i] = be32_to_cpu(ssr[i]);
>>  
>> +	/* The value of maximum au_size is supported 0xF since SD3.0 */
>> +	if (card->scr.sda_spec3)
>> +		max_au = 0xf;
>> +	else
>> +		max_au = 9;
>> +
> 
> /* SD3.0 increases max AU size to 64MB (0xF) from 4MB (0x9) */
> max_au = card->scr.sda_spec3 ? 0xF : 0x9;
> 
>>  	/*
>>  	 * UNSTUFF_BITS only works with four u32s so we have to offset the
>>  	 * bitfield positions accordingly.
>>  	 */
>>  	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
>> -	if (au > 0 && au <= 9) {
>> +	if (au > 0 && au <= max_au) {
>>  		card->ssr.au = 1 << (au + 4);
>>  		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
>>  		et = UNSTUFF_BITS(ssr, 402 - 384, 6);
> 
> Thanks,
> 
> - Chris.
> 

