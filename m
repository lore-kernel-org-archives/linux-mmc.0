From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: Re: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to the CMD
 error flag
Date: Thu, 10 Oct 2013 04:01:26 -0700
Message-ID: <CAGOxZ53PJTyXhcg20whXZYcRVVvy1+p0SA9xM_WFOAbYJ7riSQ@mail.gmail.com>
References: <32277109.227361381136426293.JavaMail.weblogic@epv6ml06>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:43757 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab3JJLCH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Oct 2013 07:02:07 -0400
Received: by mail-vb0-f44.google.com with SMTP id e13so1462913vbg.17
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 04:02:06 -0700 (PDT)
In-Reply-To: <32277109.227361381136426293.JavaMail.weblogic@epv6ml06>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, "cjb@laptop.org" <cjb@laptop.org>, "dianders@chromium.org" <dianders@chromium.org>

Hi Jaeohoon,

On Mon, Oct 7, 2013 at 2:00 AM, ALIM AKHTAR <alim.akhtar@samsung.com> wrote:
> Hi Jaeohoon,
> Thanks for quick review.
>>------- Original Message -------
>>Sender : Jaehoon Chung<jh80.chung@samsung.com> S4/Engineer/System S/W Lab./Samsung Electronics
>>Date : Oct 07, 2013 17:36 (GMT+09:00)
>>Title : Re: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to the CMD error flag
>
>>Hi, Alim.
>
>>On 10/07/2013 05:21 PM, ALIM AKHTAR wrote:
>>>
>>>
>>>> ------- Original Message -------
>>>> Sender : Jaehoon Chung S4/Engineer/System S/W Lab./Samsung Electronics
>>>> Date : Oct 07, 2013 13:34 (GMT+09:00)
>>>> Title : Re: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to the CMD error flag
>>>
>>>> On 10/07/2013 01:22 PM, ALIM AKHTAR wrote:
>>>>> Hi Jaehoon,
>>>>>
>>>>>> ------- Original Message -------
>>>>>> Sender : Jaehoon Chung S4/Engineer/System S/W Lab./Samsung Electronics
>>>>>> Date : Oct 06, 2013 17:28 (GMT+09:00)
>>>>> Title : Re: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to the CMD error flag
>>>>
>>>>> Hi Alim,
>>>>
>>>>> On 10/03/2013 06:18 PM, alim akhtar wrote:
>>>>>> From: Alim Akhtar
>>>>>>
>>>>>> Hardware locked error set when the dw_mmc controller cannot load a
>>>>>> command issued by software. When software sets the start_cmd bit in the
>>>>>> CMD register, the controller tries to load the command. If the command
>>>>>> buffer is already filled with a command, this error is raised. Currently
>>>>>> driver does not handle HLE interrupt, which results in a system hang.
>>>>> When SDMMC_INT_HLE is set into CMD_ERROR_FLAGS,.then could driver handle the HLE interrupt?
>>>> Yes, this will be handled as a part of DW_MCI_CMD_ERROR_FLAGS error handling.
>>>> Could some command or data be lost?
>>> No, Data and command will not be lost as they are not send out.
>>Maybe it needs to discuss how recovery the command/data, when HLE interrupt is occured.
>>I want to know, do you have the recovery method when HLE interrupt is occured?
>>
>>As you mentioned, this patch controlled the HLE error and can't send the any command/data.
>>Patch like this had already posted at mailing list.
> Can you point to the link?
>>But we also need to control after occurred the HLE.
> Well, dw_mmc controller document just say "The software then has to reload the command" to recover from HLE.
>>In SD-card's case, card can be inserted/removed. but in case of eMMC, can't it.
>>It should be maintained the hardware lock status.
> HLE is independent of emmc/sd slot and handling should be the same.
> Insert/removal is one way to simulate HLE, this is how I found this.
> Are you suggesting to check for INT_STATUE for emmc and handle it in case of HLE?

Let me know if you have any other comments/ suggestions on this.
Thanks!!

>>>Best Regards,
>>>Jaehoon Chung
>
>>>>>
>>>>>> Best Regards,
>>>>>> Jaehoon Chung
>>>>>>
>>>>>> HLE can be simulated by quickly inserting and removing sd card in card
>>>>>> slot (30 ~ 40 times in say 20 secs)
>>>>>>
>>>>>> Reviewed-by: Doug Anderson
>>>>>> Signed-off-by: Alim Akhtar
>>>>>> ---
>>>>>>   drivers/mmc/host/dw_mmc.c | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>>> index 0a6a512..24b4a52 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>> @@ -44,7 +44,7 @@
>>>>>>   SDMMC_INT_HTO | SDMMC_INT_SBE  | \
>>>>>>   SDMMC_INT_EBE)
>>>>>>   #define DW_MCI_CMD_ERROR_FLAGS (SDMMC_INT_RTO | SDMMC_INT_RCRC | \
>>>>>> - SDMMC_INT_RESP_ERR)
>>>>>> + SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
>>>>>>   #define DW_MCI_ERROR_FLAGS (DW_MCI_DATA_ERROR_FLAGS | \
>>>>>>   DW_MCI_CMD_ERROR_FLAGS  | SDMMC_INT_HLE)
>>>>>>   #define DW_MCI_SEND_STATUS 1

-- 
Regards,
Alim
