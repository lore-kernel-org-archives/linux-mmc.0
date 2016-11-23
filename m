From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] DWMMC controller for next
Date: Wed, 23 Nov 2016 12:47:30 +0100
Message-ID: <CAPDyKFokGM+-6hjGpgJRJOVwANX43gEww4p17LCxvD=e0Qbj=g@mail.gmail.com>
References: <63a0b568-cd9e-d038-b7eb-08b7868f96f2@samsung.com> <CAPDyKFo+W12sV-U8r44ySerWHi2tAwEEnGNMd97iUN8NLV4duA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37806 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935255AbcKWLrc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 06:47:32 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so20005443wmt.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2016 03:47:32 -0800 (PST)
In-Reply-To: <CAPDyKFo+W12sV-U8r44ySerWHi2tAwEEnGNMd97iUN8NLV4duA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 22 November 2016 at 17:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 22 November 2016 at 10:59, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Dear Ulf,
>>
>> Could you pull these patches on your next branch?
>> If there is a problem, let me know, plz.
>>
>> The following changes since commit e2081b37d910c5e6c6925d9b4d0a7a6283f84ec5:
>>
>>   Merge branch 'fixes' into next (2016-11-21 11:09:18 +0100)
>>
>> are available in the git repository at:
>>
>>   https://github.com/jh80chung/dw-mmc.git for-ulf
>>
>> for you to fetch changes up to e25fd245b557482a8e0f7ab87841085f30706f3a:
>>
>>   Documentation: synopsys-dw-mshc: remove the unused properties (2016-11-22 10:34:05 +0900)
>>
>> ----------------------------------------------------------------
>> Colin Ian King (1):
>>       mmc: dw_mmc: fix spelling mistake in dev_dbg message
>>
>> Jaehoon Chung (9):
>>       mmc: dw_mmc: display the real register value on debugfs
>>       mmc: dw_mmc: fix the debug message for checking card's present
>>       mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
>>       mmc: dw_mmc: use the hold register when send stop command
>>       mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
>>       mmc: dw_mmc: use the cookie's enum values for post/pre_req()
>>       mmc: dw_mmc: remove the unnecessary mmc_data structure
>>       mmc: dw_mmc: The "clock-freq-min-max" property was deprecated
>>       Documentation: synopsys-dw-mshc: remove the unused properties
>>
>>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  8 ++------
>>  drivers/mmc/host/dw_mmc.c                                  | 92 ++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
>>  include/linux/mmc/dw_mmc.h                                 |  6 ++++++
>>  3 files changed, 52 insertions(+), 54 deletions(-)
>>
>> Best Regards,
>> Jaehoon Chung
>
> Dear Jaehoon, thanks for the pull request. I have add queued it all up
> for my next branch!
>
>
> Kind regards
> Uffe

Jaehoon,

It seems like some of these patches breaks Exynos 5250-arndale. Can
you please have a look and see what you think?
https://kernelci.org/boot/all/job/ulfh/kernel/v4.9-rc5-78-g52eb5d4531e4/

Kind regards
Uffe
