From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/7] mmc: clarify DDR timing mode between SD-UHS and eMMC
Date: Mon, 20 Jan 2014 12:55:51 +0900
Message-ID: <001201cf1593$82b7c090$882741b0$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <001f01cf11fb$93d188c0$bb749a40$%jun@samsung.com>
 <CAPDyKFpzxoMJYhWWsnnJdHRbHd3+efTyz5PMtoqDtBa2O3pkeg@mail.gmail.com>
 <CAPDyKFoeHNmcVTtcR6cVvb3SY0LqjE2nyC+vPBOEVOshNcUswQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16312 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbaATDzx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2014 22:55:53 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZO005RRLL4XO70@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 20 Jan 2014 12:55:52 +0900 (KST)
In-reply-to: <CAPDyKFoeHNmcVTtcR6cVvb3SY0LqjE2nyC+vPBOEVOshNcUswQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'Chris Ball' <chris@printf.net>, 'linux-mmc' <linux-mmc@vger.kernel.org>

Hi Ulf,

On Sat, January 18, 2014, Ulf Hansson wrote:
> On 16 January 2014 11:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 15 January 2014 15:10, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> This change distinguishes DDR timing mode of current
> >> mixed usage to clarify device type.
> >>
> >> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> >> ---
> >>  drivers/mmc/core/debugfs.c |    3 +++
> >>  drivers/mmc/core/mmc.c     |    2 +-
> >>  include/linux/mmc/host.h   |    3 ++-
> >>  3 files changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> >> index 54829c0..509229b 100644
> >> --- a/drivers/mmc/core/debugfs.c
> >> +++ b/drivers/mmc/core/debugfs.c
> >> @@ -135,6 +135,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
> >>         case MMC_TIMING_UHS_DDR50:
> >>                 str = "sd uhs DDR50";
> >>                 break;
> >> +       case MMC_TIMING_MMC_DDR52:
> >> +               str = "mmc DDR52";
> 
> Just a minor thought. In the eMMC spec there are no such thing as
> DDR52 mode. Only DDR is mentioned, should we maybe change to
> "MMC_TIMING_MMC_DDR" to better reflect the spec?
In eMMC spec, DDR mode for high speed is up to 52MHz unlike SD.
Actually DDR52 is appeared in spec. And it helps to ensure the meaning.
Also, for distinguishing from HS200's DDR mode(HS400), it would be not bad to keep it.
It makes sense?

Thanks,
Seungwon Jeon

> 
> Kind regards
> Ulf Hansson
> 
> >> +               break;
> >>         case MMC_TIMING_MMC_HS200:
> >>                 str = "mmc high-speed SDR200";
> >>                 break;
> >> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> index 98e9eb0..6d91ff7 100644
> >> --- a/drivers/mmc/core/mmc.c
> >> +++ b/drivers/mmc/core/mmc.c
> >> @@ -1261,7 +1261,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >>                                         goto err;
> >>                         }
> >>                         mmc_card_set_ddr_mode(card);
> >> -                       mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
> >> +                       mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
> >>                         mmc_set_bus_width(card->host, bus_width);
> >>                 }
> >>         }
> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >> index 99f5709..87b1f4f 100644
> >> --- a/include/linux/mmc/host.h
> >> +++ b/include/linux/mmc/host.h
> >> @@ -58,7 +58,8 @@ struct mmc_ios {
> >>  #define MMC_TIMING_UHS_SDR50   5
> >>  #define MMC_TIMING_UHS_SDR104  6
> >>  #define MMC_TIMING_UHS_DDR50   7
> >> -#define MMC_TIMING_MMC_HS200   8
> >> +#define MMC_TIMING_MMC_DDR52   8
> >> +#define MMC_TIMING_MMC_HS200   9
> >>
> >>  #define MMC_SDR_MODE           0
> >>  #define MMC_1_2V_DDR_MODE      1
> >> --
> >> 1.7.0.4
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

