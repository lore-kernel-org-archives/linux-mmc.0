From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: add 0x600 IP version
Date: Wed, 20 Aug 2014 09:29:35 +0200
Message-ID: <CAPDyKFopHQzYuCjC09i0QYJ92FhXskN7TtQOkYEd5_o4JMJKSw@mail.gmail.com>
References: <1402559265-18340-1-git-send-email-ludovic.desroches@atmel.com>
	<53F39F3A.1090704@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34335 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaHTH3g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Aug 2014 03:29:36 -0400
Received: by mail-qg0-f45.google.com with SMTP id f51so6924985qge.4
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2014 00:29:35 -0700 (PDT)
In-Reply-To: <53F39F3A.1090704@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 19 August 2014 21:02, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 12/06/2014 02:47, Ludovic Desroches :
>> From: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Chris, Ufl,
>
> It seems that this tiny patch got forgotten: Should we re-send it?
>
> Thanks, bye,

Sorry for delay.

I have applied it for next now. Thanks!

Kind regards
Uffe

>
>> ---
>>  drivers/mmc/host/atmel-mci.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>> index 1b4b064..9c4c191 100644
>> --- a/drivers/mmc/host/atmel-mci.c
>> +++ b/drivers/mmc/host/atmel-mci.c
>> @@ -2306,6 +2306,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
>>
>>       /* keep only major version number */
>>       switch (version & 0xf00) {
>> +     case 0x600:
>>       case 0x500:
>>               host->caps.has_odd_clk_div = 1;
>>       case 0x400:
>>
>
>
> --
> Nicolas Ferre
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
