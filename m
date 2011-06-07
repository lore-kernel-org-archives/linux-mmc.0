From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v2 1/2] sdio: add quirk to handle pending IRQ in case of
 none CCCR_INTx bits
Date: Tue, 7 Jun 2011 08:49:48 +0200
Message-ID: <BANLkTi=Dmntzb=4BBptwqZ5WfBMQYbaTGA@mail.gmail.com>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
	<1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
	<4DE6B0E8.9050306@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41124 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1FGGtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 02:49:49 -0400
Received: by qyk7 with SMTP id 7so1172858qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2011 23:49:48 -0700 (PDT)
In-Reply-To: <4DE6B0E8.9050306@boundarydevices.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Per Forlin <per.forlin@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>

On 1 June 2011 23:36, Troy Kisky <troy.kisky@boundarydevices.com> wrote=
:
> On 6/1/2011 1:48 AM, Per Forlin wrote:
>> From: Per Forlin <per.forlin@linaro.org>
>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 7b4fd7b..852021c 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -175,6 +175,7 @@ struct mmc_card {
>> =A0#define MMC_QUIRK_DISABLE_CD (1<<5) =A0 =A0 =A0 =A0 =A0/* disconn=
ect CD/DAT[3] resistor */
>> =A0#define MMC_QUIRK_INAND_CMD38 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0=
 =A0/* iNAND devices have broken CMD38 */
>> =A0#define MMC_QUIRK_BLK_NO_CMD23 =A0 =A0 =A0 (1<<7) =A0 =A0 =A0 =A0=
 =A0/* Avoid CMD23 for regular multiblock */
>> +#define MMC_QUIRK_SDIO_IRQ_CCCR_INTX_0 (1<<7) =A0 =A0 =A0 =A0/* SDI=
O card has IRQ even if CCCR_INTx is 0 */
>
> Using the same value as MMC_QUIRK_BLK_NO_CMD23 looks odd...
>
Thanks for your observation.
Typo, it should be (1 << 8)
I'll update the patch but I don't plan post a new version yet. The
root cause issue in the libertas is resolved. If the fix turns out to
be needed later on I resend it.

Thanks,
Per
