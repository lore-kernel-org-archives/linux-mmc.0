From: Franky Lin <frankyl@broadcom.com>
Subject: Re: [PATCH] mmc: sdhci: only invoke clock re-tuning for adtc type
 commands
Date: Wed, 26 Mar 2014 09:49:45 -0700
Message-ID: <53330529.9010804@broadcom.com>
References: <1389119511-26228-1-git-send-email-frankyl@broadcom.com>	<1389119859-28955-1-git-send-email-frankyl@broadcom.com> <CAPDyKFoGxa0Xp33o2OfUrFGbiHPvvLOg-ZE39DJLX2R2htKCHQ@mail.gmail.com> <53272818.5030706@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:31323 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbaCZQts (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Mar 2014 12:49:48 -0400
In-Reply-To: <53272818.5030706@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 03/17/2014 09:51 AM, Franky Lin wrote:
> Hi Ulf,
>
> On 03/17/2014 02:12 AM, Ulf Hansson wrote:
>> On 7 January 2014 19:37, Franky Lin <frankyl@broadcom.com> wrote:
>>> For high clock frequency modes, ie. SDR104 and possibly SDR50, the data
>>> window on the CMD and DAT lines needs to be tuned. Once tuned to a
>>> sample clock rate, a re-tuning might required because of drifted signal
>>> on different lines. This re-tuning is needed and only necessary for
>>> commands using the DAT lines, ie. adtc type commands. This patch is an
>>> optimization by adding the condition of the requested command being 
>>> adtc
>>> type in order to execute the re-tuning procedure.
>>>
>>> Signed-off-by: Franky Lin <frankyl@broadcom.com>
>>
>> Hi Franky,
>>
>> Sorry for the delay.
>>
>>> ---
>>>   drivers/mmc/host/sdhci.c |    3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index cc00bed..f301cd6 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1389,7 +1389,8 @@ static void sdhci_request(struct mmc_host 
>>> *mmc, struct mmc_request *mrq)
>>>                   * tuning procedure before sending command.
>>>                   */
>>>                  if ((host->flags & SDHCI_NEEDS_RETUNING) &&
>>> -                   !(present_state & (SDHCI_DOING_WRITE | 
>>> SDHCI_DOING_READ))) {
>>> +                   !(present_state & (SDHCI_DOING_WRITE | 
>>> SDHCI_DOING_READ)) &&
>>> +                   mmc_cmd_type(mrq->cmd) == MMC_CMD_ADTC) {
>>
>> I don't have the in-depth knowledge about the sdhci; Still, to me it
>> seems like checking for MMC_CMD_ADTC, is that not just the same a
>> checking if there are a READ/WRITE?
>
> non-adtc commands like CMD17/CMD24/CMD52 do not use the data lines. 
> Tuning is only necessary for adtc commands as CMD18/CMD25/CMD53 which 
> involve data lines.
>
>> Another note, we really should be working on moving the periodic
>> "re-tuning trigger" mechanism into the mmc core layer, so all host
>> driver's could benefit from this. Do you want to help out fixing this?
>
> I thought about this before but hesitated because of non-sdhci 
> drivers. I have seen some of them don't have standardized 
> implementation(well if they do they would have used sdhci anyway).
>
Ping?


