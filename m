From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 33/35 linux-next] mmc: constify of_device_id array
Date: Mon, 23 Mar 2015 11:06:57 +0100
Message-ID: <CAPDyKFqJf-iYeMWEJL0v6SQngOWJBpNc03NU59seyOLuh61KoA@mail.gmail.com>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
	<1426535949-26107-1-git-send-email-fabf@skynet.be>
	<1426535949-26107-2-git-send-email-fabf@skynet.be>
	<CAPDyKFodW1zgrQ-sd5TPO_rCa_-tm95JkwCWiGX4BCUSFqPHdg@mail.gmail.com>
	<CAPDyKFoWoQhSat9vAfTGy_exdubcknySMPjoSXp5ox_YB+M6ZQ@mail.gmail.com>
	<1374583183.180918.1426968545752.open-xchange@webmail.nmp.proximus.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35324 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbCWKG6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2015 06:06:58 -0400
Received: by qcbkw5 with SMTP id kw5so140522548qcb.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2015 03:06:57 -0700 (PDT)
In-Reply-To: <1374583183.180918.1426968545752.open-xchange@webmail.nmp.proximus.be>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Tony Prisk <linux@prisktech.co.nz>

On 21 March 2015 at 21:09, Fabian Frederick <fabf@skynet.be> wrote:
>
>
>> On 20 March 2015 at 09:56 Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>
>> On 17 March 2015 at 10:49, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > On 16 March 2015 at 20:59, Fabian Frederick <fabf@skynet.be> wrote:
>> >> of_device_id is always used as const.
>> >> (See driver.of_match_table and open firmware functions)
>> >>
>> >> Signed-off-by: Fabian Frederick <fabf@skynet.be>
>> >
>> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> I realized that you might wanted me to pick this up and queue it
>> through my mmc tree? Just tell me if that's what you want.
>>
>> Kind regards
>> Uffe
>
> Hi Ulf,
>
>         Yes of course :) (it has not been added to linux-next yet).

Thanks! Applied.

Kind regards
Uffe

>
> Thanks,
> Fabian
>>
>> >
>> >> ---
>> >>  drivers/mmc/host/mmc_spi.c   | 2 +-
>> >>  drivers/mmc/host/wmt-sdmmc.c | 2 +-
>> >>  2 files changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
>> >> index e4a0754..ae19d83 100644
>> >> --- a/drivers/mmc/host/mmc_spi.c
>> >> +++ b/drivers/mmc/host/mmc_spi.c
>> >> @@ -1507,7 +1507,7 @@ static int mmc_spi_remove(struct spi_device *spi)
>> >>         return 0;
>> >>  }
>> >>
>> >> -static struct of_device_id mmc_spi_of_match_table[] = {
>> >> +static const struct of_device_id mmc_spi_of_match_table[] = {
>> >>         { .compatible = "mmc-spi-slot", },
>> >>         {},
>> >>  };
>> >> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
>> >> index dd2e1aa..5af0055 100644
>> >> --- a/drivers/mmc/host/wmt-sdmmc.c
>> >> +++ b/drivers/mmc/host/wmt-sdmmc.c
>> >> @@ -744,7 +744,7 @@ static struct wmt_mci_caps wm8505_caps = {
>> >>         .max_blk_size = 2048,
>> >>  };
>> >>
>> >> -static struct of_device_id wmt_mci_dt_ids[] = {
>> >> +static const struct of_device_id wmt_mci_dt_ids[] = {
>> >>         { .compatible = "wm,wm8505-sdhc", .data = &wm8505_caps },
>> >>         { /* Sentinel */ },
>> >>  };
>> >> --
>> >> 2.1.0
>> >>
