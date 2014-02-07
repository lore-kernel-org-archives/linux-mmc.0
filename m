From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 8/8] mmc: dw_mmc: fix the checking whether card is
 present
Date: Fri, 07 Feb 2014 11:45:35 +0900
Message-ID: <52F448CF.20409@samsung.com>
References: <52EF7A5B.3030902@samsung.com>
 <002a01cf232e$c0d44bc0$427ce340$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51124 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaBGCpu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Feb 2014 21:45:50 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0L003QTUBWTLC0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Feb 2014 11:45:32 +0900 (KST)
In-reply-to: <002a01cf232e$c0d44bc0$427ce340$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>

On 02/06/2014 08:29 PM, Seungwon Jeon wrote:
> On Mon, February 03, 2014, Jaehoon Chung wrote:
>> Broken card detection is assumed "the card is present".
>> Non-removable card didn't call get_cd().
>> dw-mmc controller didn't check whether card is present or not.
>> Because DW_MMC_CARD_PRESENT flag is set into dw_mci_get_cd().
>> If cd-pin is used, then dw_mci_get_cd() is called.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index ac2907d..0d6ab8f 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -910,6 +910,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>  {
>>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>>  	struct dw_mci *host = slot->host;
>> +	struct dw_mci_board *brd = host->pdata;
>>
>>  	WARN_ON(slot->mrq);
>>
>> @@ -920,7 +921,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>  	 */
>>  	spin_lock_bh(&host->lock);
>>
>> -	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
>> +	if (!(brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) &&
>> +			!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
> 
> I think 'non-removable' property doesn't indicate DW_MCI_QUIRK_BROKEN_CARD_DETECTION.
> Actually DW_MCI_QUIRK_BROKEN_CARD_DETECTION is set with 'broken-cd' property as quirk.
> Still, DW_MMC_CARD_PRESENT flag won't be set  with 'non-removable' property.

Right, it's didn't indicate DW_MCI_QUIRK_BROKEN_CARD_DETECTION.
I think that the below approach is more reasonable.

> 
> The following part was removed from commit bf626e5(mmc: dw_mmc: use slot-gpio to handle cd pin).
> It would be better to restore that to resolved this problem. 
> 
> <Quoted>
> static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> @@ -2197,12 +2223,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  #endif /* CONFIG_MMC_DW_IDMAC */
>         }
> 
> -       if (dw_mci_get_cd(mmc))
> -               set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> -       else
> -               clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> -
> </Quoted>
It's good. I will update after testing.
> 
> Then, Needed to check 'non-removable' case in dw_mci_get_cd().
> I think MMC_CAP_NONREMOVABLE is useful.
Right. MMC_CAP_NONREMOVABLE is useful. When it's set, it needs not to check the card-status with polling system.
It's related with increasing a little performance.

Do you have any opinion for other patches?

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
> 
> 

