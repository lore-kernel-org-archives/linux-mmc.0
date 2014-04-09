From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] mmc: card.h: Use NULL instead of 0 for END_FIXUP
Date: Wed, 09 Apr 2014 12:25:50 +0100
Message-ID: <53452E3E.7020000@codethink.co.uk>
References: <1396662168-6501-1-git-send-email-festevam@gmail.com> <CAPDyKFrGhX1R6HsVF_r=MTGXg_06xEe1WL3YCaywhKWq19TLFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45771 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932796AbaDILZ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Apr 2014 07:25:57 -0400
In-Reply-To: <CAPDyKFrGhX1R6HsVF_r=MTGXg_06xEe1WL3YCaywhKWq19TLFQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <festevam@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 09/04/14 10:33, Ulf Hansson wrote:
> On 5 April 2014 03:42, Fabio Estevam <festevam@gmail.com> wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Fix the following sparse warnings:
>>
>> drivers/mmc/card/block.c:2421:9: warning: Using plain integer as NULL pointer
>>
>> drivers/mmc/core/quirks.c:69:9: warning: Using plain integer as NULL pointer
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
>> ---
>>   include/linux/mmc/card.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index b730272..aa7e57f 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -353,7 +353,7 @@ struct mmc_fixup {
>>   #define CID_OEMID_ANY ((unsigned short) -1)
>>   #define CID_NAME_ANY (NULL)
>>
>> -#define END_FIXUP { 0 }
>> +#define END_FIXUP { NULL }

It would also be possible to use { } here.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
