From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 3/4] mmc: mmci: Adapt to register write restrictions
Date: Tue, 3 Sep 2013 13:56:11 +0200
Message-ID: <CAPDyKFrDxGgd4Z_RDSSfSxB6VYq2dXSMS9cFYimqLSDfaTuSjQ@mail.gmail.com>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
	<1378200576-13413-4-git-send-email-ulf.hansson@linaro.org>
	<5225B0EF.7030006@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:64887 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733Ab3ICL4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 07:56:12 -0400
Received: by mail-ve0-f171.google.com with SMTP id pa12so4086399veb.30
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 04:56:12 -0700 (PDT)
In-Reply-To: <5225B0EF.7030006@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Johan Rudholm <jrudholm@gmail.com>

On 3 September 2013 11:50, Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
> On 09/03/2013 11:29 AM, Ulf Hansson wrote:
>> After a write to the MMCICLOCK register data cannot be written to th=
is
>> register for three feedback clock cycles. Writes to the MMCIPOWER
>> register must be separated by three MCLK cycles. Previously no issue=
s
>> has been observered, but using higher ARM clock frequencies on STE-
>> platforms has triggered this problem.
>>
>> The MMCICLOCK register is written to in .set_ios and for some data
>> transmissions for SDIO. We do not need a delay at the data transmiss=
ion
>> path, because sending and receiving data will require more than thre=
e
>> clock cycles. Then we use a simple logic to only delay in .set_ios a=
nd
>> thus we don't affect throughput performance.
>>
>> Signed-off-by: Johan Rudholm <jrudholm@gmail.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
>> ---
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> + two questions below.
>
>>  drivers/mmc/host/mmci.c |   16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index c550b3e..82afcd3 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -189,6 +189,21 @@ static int mmci_validate_data(struct mmci_host =
*host,
>>       return 0;
>>  }
>>
>> +static void mmci_reg_delay(struct mmci_host *host)
>> +{
>> +     /*
>> +      * According to the spec, at least three feedback clock cycles
>> +      * of max 52 MHz must pass between two writes to the MMCICLOCK=
 reg.
>> +      * Three MCLK clock cycles must pass between two MMCIPOWER reg=
 writes.
>> +      * Worst delay time during card init is at 100 kHz =3D> 30 us.
>> +      * Worst delay time when up and running is at 25 MHz =3D> 120 =
ns.
>> +      */
>> +     if (host->cclk < 20000000)
>
> Shouldn't it be 25000000 ?

You are right! Thanks for spotting this! I resend a new version.

>
> What about using macros ?
>
> #define MMC_CLOCK 25000000
> #define MMCINIT_DELAY 30
> #define MMCUP_DELAY 120

These values wont be used anywhere else but here. Additionally, mmci
is already having other hard-coded values around. Unless you feel it
is important too you, I would prefer keeping this as is.

Thanks for review Daniel!

Kind regards
Ulf Hansson

>
>> +             udelay(30);
>> +     else
>> +             ndelay(120);
>> +}
>> +
>>  /*
>>   * This must be called with host->lock held
>>   */
>> @@ -1264,6 +1279,7 @@ static void mmci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
>>
>>       mmci_set_clkreg(host, ios->clock);
>>       mmci_write_pwrreg(host, pwr);
>> +     mmci_reg_delay(host);
>>
>>       spin_unlock_irqrestore(&host->lock, flags);
>>
>>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
