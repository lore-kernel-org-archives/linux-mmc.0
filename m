From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Fix calc_max_discard.
Date: Thu, 15 Dec 2016 10:14:17 +0200
Message-ID: <3c68bce2-8426-f1d6-03c3-9f285092091d@intel.com>
References: <1481656818-21141-1-git-send-email-gwendal@chromium.org>
 <8d4b89c1-678d-f85d-29b9-e2b8a5a3b40c@intel.com>
 <CAMHSBOUyZtSDy8VMwy8HTBUjNL7108mAJHKg-JpswFnhsjB8fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbcLOIUz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Dec 2016 03:20:55 -0500
In-Reply-To: <CAMHSBOUyZtSDy8VMwy8HTBUjNL7108mAJHKg-JpswFnhsjB8fQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>, hisanao.kinkawa@toshiba.co.jp, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 14/12/16 20:13, Gwendal Grignou wrote:
> On Tue, Dec 13, 2016 at 11:19 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 13/12/16 21:20, Gwendal Grignou wrote:
>>> Working with a SDHCI controller and a Toshiba 16GB THGBMFG7C2LBAIL.
>>> The Toshiba part has a large erase group size and a long erase timeout.
>>> It barely fits within the controller timeout, but mmc reports a
>>> 512B discard size to the block layer instead of the expected 4MB:
>>> /sys/block/mmcblk0/queue/discard_max_bytes = 512
>>>
>>> The host caps[0] is 0x...b2, so host->max_busy_timeout is set to
>>> 2684.35ms: (1 << 27 / ((0xb2 & 0x3f) * 1000).
>>>
>>> In Toshiba EXT_CSD, HC_ERASE_GRP_SIZE is set to 7 (2100ms erase timeout)
>>> HC_ERASE_GRP_SIZE is set to 8, (8192 512B sectors erase size).
>>>
>>> In mmc_do_calc_max_discard(), as a safety, for eMMC device, number of
>>> erase groups that could safely be erased with the host timeout (qty) was
>>> reduced by 1.
>>
>> It was not for safety - it was to allow for crossing an erase group boundary.
> Got it.
>>
>> But the current code is quite different now, so please have a look at that
>> because this code does not apply anymore.
> Indeed, looking at the block layer, it is paying attention not to
> cross  boundary, issuing an extra erase command when necessary.
> in blkdev_issue_discard(),  we use  bdev_discard_alignment to be sure
> erasing within a partition still start on a erase group boundary.
> It has been addressed with c6e66634 (block: split discard into aligned
> requests) and following changes.

I think you are misreading that patch.  It won't split a discard unless it
exceeds the maximum discard size.  So a discard of 2 sectors crossing an
erase group boundary is not split unless the max discard is 1.  The mmc core
now does a split since commit 642c28ab86f7 ("mmc: core: Optimize case for
exactly one erase-group budget")


