From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 15 Sep 2016 13:29:14 +0530
Message-ID: <CANYu_0s=cyt52W2B5B=rUcx4O7Ms5kO2kBa2mw6JwWzCFTDw_A@mail.gmail.com>
References: <20160901142335.2396-1-pramod.gurav@linaro.org>
 <a0e314de-3590-399c-27c7-ddd6461dee42@intel.com> <496321c5-24e7-3ac5-b3dd-7b7d5dc75536@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:35135 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756452AbcIOH7P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2016 03:59:15 -0400
Received: by mail-yb0-f176.google.com with SMTP id d69so30139153ybf.2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Sep 2016 00:59:15 -0700 (PDT)
In-Reply-To: <496321c5-24e7-3ac5-b3dd-7b7d5dc75536@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On 9 September 2016 at 15:48, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> On 09/08/2016 11:02 AM, Adrian Hunter wrote:
>>
>> On 01/09/16 17:23, Pramod Gurav wrote:
>>>
>>> Provides runtime PM callbacks to enable and disable clock resources
>>> when idle. Also support system PM callbacks to be called during system
>>> suspend and resume.
>>>
>>> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
>>
>>
>> Can we get some Tested/Reviewed/Acked-by from people using this driver?
>>
>
> Hi Pramod,
> Thanks for the patch. Unfortunately, my db410c board fails to
> boot when i apply it.
>

Thanks Georgi for testing the patch. Its my wrong I did not update my
kernel and continued fixing comments on old kernel.
After spending some time I came to know that below change is causing the issue:

Author: Dong Aisheng <aisheng.dong@nxp.com>
Date:   Tue Jul 12 15:46:17 2016 +0800

    mmc: sdhci: add standard hw auto retuning support

    If HW supports SDHCI_TUNING_MODE_3 which is auto retuning, we won't
    retune during runtime suspend and resume, instead we use Re-tuning
    Request signaled via SDHCI_INT_RETUNE interrupt to do retuning and
    hw auto retuning during data transfer to guarantee the signal sample
    window correction.

    This can avoid a mass of repeatedly retuning during small file system
    data access and improve the performance.

Specially these lines that was added to suspend path:

+       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+               mmc_retune_needed(host->mmc);

During sdhci setup in msm driver, the host returns the values to set
sdhci auto tuning as supported.
Hence host->tuning_mode is set to SDHCI_TUNING_MODE_3 during setup.
But some how the auto tuning is not happening.
Just to verify my case, I removed the 'if' part in above code and got
the FS mounted.

Is there anything else needed in msm sdhci driver so that the auto
tuning is taken care of?

> [    1.778433] mmc0: new HS200 MMC card at address 0001
> [    1.783115] mmcblk0: mmc0:0001 DS2008 7.28 GiB
> [    1.783337] mmcblk0boot0: mmc0:0001 DS2008 partition 1 4.00 MiB
> [    1.787025] mmcblk0boot1: mmc0:0001 DS2008 partition 2 4.00 MiB
> [    1.792893] mmcblk0rpmb: mmc0:0001 DS2008 partition 3 4.00 MiB
> [    1.802603]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
> [    2.693631] blk_update_request: I/O error, dev mmcblk0, sector 462880
> [    2.710381] blk_update_request: I/O error, dev mmcblk0, sector 462880
> [    2.710443] Buffer I/O error on dev mmcblk0p10, logical block 0, async
> page read
> [    2.724827] blk_update_request: I/O error, dev mmcblk0, sector 462881
> [    2.724853] Buffer I/O error on dev mmcblk0p10, logical block 1, async
> page read
> ...
>
> More I/O errors are following and it is unable to mount the rootfs from
> the eMMC. When i retried booting, got also the following:
>
> [    2.877149] mmcblk0: error -110 sending status command, retrying
> [    2.879408] mmcblk0: error -110 sending status command, retrying
> [    2.884436] mmcblk0: error -110 sending status command, aborting
> [    2.896826] mmc0: cache flush error -110
>
> BR,
> Georgi
