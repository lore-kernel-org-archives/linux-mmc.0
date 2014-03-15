From: Franky Lin <frankyl@broadcom.com>
Subject: Re: [PATCH] mmc: sdhci: only invoke clock re-tuning for adtc type
 commands
Date: Sat, 15 Mar 2014 12:16:29 -0700
Message-ID: <5324A70D.6080501@broadcom.com>
References: <1389119511-26228-1-git-send-email-frankyl@broadcom.com> <1389119859-28955-1-git-send-email-frankyl@broadcom.com> <530BA436.4030207@broadcom.com> <531A23E1.8060400@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:25382 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974AbaCOTQf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Mar 2014 15:16:35 -0400
In-Reply-To: <531A23E1.8060400@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

Hi Chris and Ulf,

On 03/07/2014 11:54 AM, Franky Lin wrote:
> On 02/24/2014 11:57 AM, Franky Lin wrote:
>> Hi Chris,
>>
>> On 01/07/2014 10:37 AM, Franky Lin wrote:
>>> For high clock frequency modes, ie. SDR104 and possibly SDR50, the data
>>> window on the CMD and DAT lines needs to be tuned. Once tuned to a
>>> sample clock rate, a re-tuning might required because of drifted signal
>>> on different lines. This re-tuning is needed and only necessary for
>>> commands using the DAT lines, ie. adtc type commands. This patch is an
>>> optimization by adding the condition of the requested command being adtc
>>> type in order to execute the re-tuning procedure.
>>>
>>> Signed-off-by: Franky Lin <frankyl@broadcom.com>
>>> ---
>>
>> Is this still in your queue? Any remarks on it?
>>
>> Thanks,
>> Franky
>>
>
> Ping?

Need to try my luck again. :) Could you please share your thought about 
this patch?

Thanks,
Franky

>
>>>   drivers/mmc/host/sdhci.c |    3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index cc00bed..f301cd6 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1389,7 +1389,8 @@ static void sdhci_request(struct mmc_host *mmc,
>>> struct mmc_request *mrq)
>>>            * tuning procedure before sending command.
>>>            */
>>>           if ((host->flags & SDHCI_NEEDS_RETUNING) &&
>>> -            !(present_state & (SDHCI_DOING_WRITE |
>>> SDHCI_DOING_READ))) {
>>> +            !(present_state & (SDHCI_DOING_WRITE |
>>> SDHCI_DOING_READ)) &&
>>> +            mmc_cmd_type(mrq->cmd) == MMC_CMD_ADTC) {
>>>               if (mmc->card) {
>>>                   /* eMMC uses cmd21 but sd and sdio use cmd19 */
>>>                   tuning_opcode =
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

