From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RESEND PATCH v2 0/1] mmc: dw_mmc: Fix UHS tuning on some brand of
 cards.
Date: Wed, 27 Apr 2016 17:35:10 +0900
Message-ID: <572079BE.9000006@samsung.com>
References: <1461657838-25484-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53424 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbcD0IfN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2016 04:35:13 -0400
In-reply-to: <1461657838-25484-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/26/2016 05:03 PM, Enric Balletbo i Serra wrote:
> Hi,
> 
> I introduced the cover letter to give some background about this.
> 
> I have been investigating a problem related to at least one specific sdcard when
> UHS-I is set. The card is not detected due the tuning phase reports a
> failure. Since the problem is only reproduced with a single model of a single
> brand of card, it is probably a card firmware issue, but the card works fine
> on my laptop.

I think you have analyzed many case..of course..it was successful to switch voltage, right?
Maybe this patch too old..so can you remember which specific sdcard is produced?

> 
> The first attempt to fix this was a patch sent by Doug Anderson [1], but Alim
> Akhtar found that this produced randomly a hung task on Peach-pi. I can confirm
> that it's easy to reproduce the hung task, either, with cold boots or suspend to
> ram tests.

Yep..I have already tested and checked for this.

> 
> I tried to fix both problems (the original issue and the one introduced by the
> patch) in different ways, but I ended thinking that this second proposal is the
> most simple that solves both issues. So let's try to fix this by handling the
> response CRC error slightly differently when tuning command is happening.
> 
> I tested the patch on both platforms, on exynos and on rockhip. I did lots of
> tests and at the moment the patch seems to fix the rockchip issue and don't
> hung on exynos. I'll continue testing meanwhile we discuss about it.
> 
> I think the patch, at least, needs the Doug's approval (as he dig into the issue
> before) and the Tested-by Alim. So will be good if you have a slot of time to
> look a bit into this.
> 
> Thanks in advance.
>  Enric
> 
> [1] https://lkml.org/lkml/2015/5/18/495
> 
> Changelog since v1:
> - Fix the issue found by Alim with exynos letting the data transfer
>   take place only when MMC_SEND_TUNING_BLOCK is issued.
> 
> Doug Anderson (1):
>   mmc: dw_mmc: Wait for data transfer after response errors.
> 
>  drivers/mmc/host/dw_mmc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

