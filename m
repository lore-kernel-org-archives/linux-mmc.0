From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc-imx: fix mmc ddr mode regression issue
Date: Tue, 27 May 2014 16:27:07 +0200
Message-ID: <CAPDyKFokc5baGwCgm03Qw-EcY5-P7sE26ijs6G33CGwp5tVWqg@mail.gmail.com>
References: <1399618395-359-1-git-send-email-b29396@freescale.com>
	<CAPDyKFqp5Pq51hbXG04HEFhMHB7itkWmvD7cqLgBUFwytVv7Hw@mail.gmail.com>
	<CAOMZO5CKCYiMF3d-bC1NOVRV7our-0yxRq1b-F1FhDaVF2Cf=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:56295 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaE0O1I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 May 2014 10:27:08 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so13791946qcy.8
        for <linux-mmc@vger.kernel.org>; Tue, 27 May 2014 07:27:07 -0700 (PDT)
In-Reply-To: <CAOMZO5CKCYiMF3d-bC1NOVRV7our-0yxRq1b-F1FhDaVF2Cf=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 27 May 2014 16:05, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Ulf,
>
> On Fri, May 9, 2014 at 5:42 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 9 May 2014 08:53, Dong Aisheng <b29396@freescale.com> wrote:
>>> The regression is caused by the following commit ...
>>>
>>> commit 79f7ae7c45a6ccf04e2908337461dee615f6afb0
>>> Author: Seungwon Jeon <tgih.jun@samsung.com>
>>> Date:   Fri Mar 14 21:11:56 2014 +0900
>>>
>>> mmc: clarify DDR timing mode between SD-UHS and eMMC
>>>
>>> This change distinguishes DDR timing mode of current
>>> mixed usage to clarify device type.
>>>
>>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Chris Ball <chris@printf.net>
>>>
>>> ... and the line below.
>>>
>>> @@ -1264,7 +1264,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>> goto err;
>>>         }
>>>                 mmc_card_set_ddr_mode(card);
>>> -               mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
>>> +               mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
>>>                 mmc_set_bus_width(card->host, bus_width);
>>>         }
>>> }
>>>
>>> It's caused by the platform driver was still using MMC_TIMING_UHS_DDR50 for MMC DDR
>>> mode which needs update too.
>>>
>>> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
>>> Reported-by: Shawn Guo <shawn.guo@freescale.com>
>>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>>
>> Hi Dong,
>>
>> Thanks for the fix. I will include this in the next PR I send to Chris.
>
> It seems this one is still missing in linux-next.

The patch is applied to Chris' mmc tree. Currently, Stehpen can't
merge the latest version of Chris' tree since we have mange to break
it. :-)

I hope Chris will merge the following patch to his tree the next few
days, that will solve the problem.
[PATCH] mmc: sdhci-s3c: use mmc_of_parse and remove the card_tasklet

Kind regards
Ulf Hansson
