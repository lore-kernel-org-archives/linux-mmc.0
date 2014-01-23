From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7] mmc: clarify DDR timing mode between SD-UHS and eMMC
Date: Thu, 23 Jan 2014 10:06:46 +0100
Message-ID: <CAPDyKFoNErg1hPM=P-RFLtOFd2CCGVd-1wae_iBKC1B22TuWHw@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<001f01cf11fb$93d188c0$bb749a40$%jun@samsung.com>
	<CAPDyKFpzxoMJYhWWsnnJdHRbHd3+efTyz5PMtoqDtBa2O3pkeg@mail.gmail.com>
	<CAPDyKFoeHNmcVTtcR6cVvb3SY0LqjE2nyC+vPBOEVOshNcUswQ@mail.gmail.com>
	<001201cf1593$82b7c090$882741b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:49746 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaAWJGr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 04:06:47 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so1897755qaq.29
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2014 01:06:46 -0800 (PST)
In-Reply-To: <001201cf1593$82b7c090$882741b0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 20 January 2014 04:55, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Ulf,
>
> On Sat, January 18, 2014, Ulf Hansson wrote:
>> On 16 January 2014 11:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > On 15 January 2014 15:10, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> >> This change distinguishes DDR timing mode of current
>> >> mixed usage to clarify device type.
>> >>
>> >> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> >
>> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >
>> >> ---
>> >>  drivers/mmc/core/debugfs.c |    3 +++
>> >>  drivers/mmc/core/mmc.c     |    2 +-
>> >>  include/linux/mmc/host.h   |    3 ++-
>> >>  3 files changed, 6 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> >> index 54829c0..509229b 100644
>> >> --- a/drivers/mmc/core/debugfs.c
>> >> +++ b/drivers/mmc/core/debugfs.c
>> >> @@ -135,6 +135,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>> >>         case MMC_TIMING_UHS_DDR50:
>> >>                 str = "sd uhs DDR50";
>> >>                 break;
>> >> +       case MMC_TIMING_MMC_DDR52:
>> >> +               str = "mmc DDR52";
>>
>> Just a minor thought. In the eMMC spec there are no such thing as
>> DDR52 mode. Only DDR is mentioned, should we maybe change to
>> "MMC_TIMING_MMC_DDR" to better reflect the spec?
> In eMMC spec, DDR mode for high speed is up to 52MHz unlike SD.
> Actually DDR52 is appeared in spec. And it helps to ensure the meaning.
> Also, for distinguishing from HS200's DDR mode(HS400), it would be not bad to keep it.
> It makes sense?
>

Diving a bit deeper into the eMMC spec 5.0.

DDR52 is mentioned, you are correct, but it is not listed as a bus
speed mode. Have a look at chapter 5.3.2 Bus Speed Modes, there you
find the more correct name. "High Speed DDR".

"High Speed" indicates the interface can run up to 52 MHz. So maybe
the most proper name for this would be "MMC_TIMING_MMC_HS_DDR"? Still
I have no strong opinion, so if you favor MMC_TIMING_MMC_DDR52, I am
fine with it.

Kind regards
Ulf Hansson

> Thanks,
> Seungwon Jeon
>
>>
>> Kind regards
>> Ulf Hansson
>>
>> >> +               break;
>> >>         case MMC_TIMING_MMC_HS200:
>> >>                 str = "mmc high-speed SDR200";
>> >>                 break;
>> >> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> >> index 98e9eb0..6d91ff7 100644
>> >> --- a/drivers/mmc/core/mmc.c
>> >> +++ b/drivers/mmc/core/mmc.c
>> >> @@ -1261,7 +1261,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >>                                         goto err;
>> >>                         }
>> >>                         mmc_card_set_ddr_mode(card);
>> >> -                       mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
>> >> +                       mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
>> >>                         mmc_set_bus_width(card->host, bus_width);
>> >>                 }
>> >>         }
>> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> >> index 99f5709..87b1f4f 100644
>> >> --- a/include/linux/mmc/host.h
>> >> +++ b/include/linux/mmc/host.h
>> >> @@ -58,7 +58,8 @@ struct mmc_ios {
>> >>  #define MMC_TIMING_UHS_SDR50   5
>> >>  #define MMC_TIMING_UHS_SDR104  6
>> >>  #define MMC_TIMING_UHS_DDR50   7
>> >> -#define MMC_TIMING_MMC_HS200   8
>> >> +#define MMC_TIMING_MMC_DDR52   8
>> >> +#define MMC_TIMING_MMC_HS200   9
>> >>
>> >>  #define MMC_SDR_MODE           0
>> >>  #define MMC_1_2V_DDR_MODE      1
>> >> --
>> >> 1.7.0.4
>> >>
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
