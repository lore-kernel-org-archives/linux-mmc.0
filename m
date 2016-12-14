From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] mmc: core: Fix calc_max_discard.
Date: Wed, 14 Dec 2016 10:13:04 -0800
Message-ID: <CAMHSBOUyZtSDy8VMwy8HTBUjNL7108mAJHKg-JpswFnhsjB8fQ@mail.gmail.com>
References: <1481656818-21141-1-git-send-email-gwendal@chromium.org> <8d4b89c1-678d-f85d-29b9-e2b8a5a3b40c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33775 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753631AbcLNSN1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2016 13:13:27 -0500
Received: by mail-vk0-f54.google.com with SMTP id 137so40551488vkl.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2016 10:13:27 -0800 (PST)
In-Reply-To: <8d4b89c1-678d-f85d-29b9-e2b8a5a3b40c@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, Doug Anderson <dianders@chromium.org>, hisanao.kinkawa@toshiba.co.jp, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Dec 13, 2016 at 11:19 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 13/12/16 21:20, Gwendal Grignou wrote:
>> Working with a SDHCI controller and a Toshiba 16GB THGBMFG7C2LBAIL.
>> The Toshiba part has a large erase group size and a long erase timeout.
>> It barely fits within the controller timeout, but mmc reports a
>> 512B discard size to the block layer instead of the expected 4MB:
>> /sys/block/mmcblk0/queue/discard_max_bytes = 512
>>
>> The host caps[0] is 0x...b2, so host->max_busy_timeout is set to
>> 2684.35ms: (1 << 27 / ((0xb2 & 0x3f) * 1000).
>>
>> In Toshiba EXT_CSD, HC_ERASE_GRP_SIZE is set to 7 (2100ms erase timeout)
>> HC_ERASE_GRP_SIZE is set to 8, (8192 512B sectors erase size).
>>
>> In mmc_do_calc_max_discard(), as a safety, for eMMC device, number of
>> erase groups that could safely be erased with the host timeout (qty) was
>> reduced by 1.
>
> It was not for safety - it was to allow for crossing an erase group boundary.
Got it.
>
> But the current code is quite different now, so please have a look at that
> because this code does not apply anymore.
Indeed, looking at the block layer, it is paying attention not to
cross  boundary, issuing an extra erase command when necessary.
in blkdev_issue_discard(),  we use  bdev_discard_alignment to be sure
erasing within a partition still start on a erase group boundary.
It has been addressed with c6e66634 (block: split discard into aligned
requests) and following changes.

>
