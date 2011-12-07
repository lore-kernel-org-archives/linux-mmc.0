From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/14] mmc: mmci: Improved PM support, cleanup and bugfixes
Date: Wed, 7 Dec 2011 13:06:47 +0100
Message-ID: <CACRpkdZkqv+LW5nj4X9-sw+1kMWKbjQmZX_mECLx0Oq5o91JvQ@mail.gmail.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60516 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab1LGMGs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2011 07:06:48 -0500
Received: by iakc1 with SMTP id c1so843414iak.19
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2011 04:06:47 -0800 (PST)
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

Hi Ulf,

On Mon, Dec 5, 2011 at 6:35 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> Patch 1 -> 4:
> Minor changes for bugs and some performance optimizations.
> Previously sent to the mailing list.
> Patch 5 -> 7:
> Minor changes affecting how to handle a levelshifter.
> Previously sent to the mailing list.
> Patch 8:
> Bugfix for dma. Previously sent to the mailing list, ongoing discussion.
> Patch 9 -> 14:
> Improvement of PM support.

I applied all 14 patches on top of current v3.2-rc4
and regression-tested the whole shebang on RealView PB1176
and U300.

- Mounted /dev/mmcblk0p1
- Copy a kernel-sized uImage file from the card to ramdisk
- Copy the file back to the card from ramdisk
- Unmount
- Mount
- Compare the two files with diff (identical)
- Delete copy
- Unmount
- dd if=/dev/mmcblk0 of=/dev/null

(If any of you wants any more specific tests, tell me.)

Both platforms still work like a charm with these patches.
PB1176 is as slow on MMC as it always has been but dd:ed
the entire card without errors.

I have the branch here:
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmci

Ulf you can add my Tested-by: Linus Walleij <linus.walleij@linaro.org>
for these patches.

Russell if you want a pull request for a subset of the patches I can
arrange that, just tell me.

Yours,
Linus Walleij
