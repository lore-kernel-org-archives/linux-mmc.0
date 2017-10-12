From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2 1/1] ANDROID: mmc: core: export emmc revision
Date: Thu, 12 Oct 2017 09:32:06 +0200
Message-ID: <CACRpkdYaq3YH+HSYh7ChSyBF8=pscYEU_URu8oZpgSik0MtT-Q@mail.gmail.com>
References: <20171011205152.173299-1-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:52816 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdJLHcH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2017 03:32:07 -0400
Received: by mail-it0-f53.google.com with SMTP id j140so5816232itj.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2017 00:32:07 -0700 (PDT)
In-Reply-To: <20171011205152.173299-1-jinqian@android.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jin Qian <jinqian@google.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Uri Yanai <uri.yanai@sandisk.com>, Chanho Min <chanho.min@lge.com>, Jungseung Lee <js07.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Oct 11, 2017 at 10:51 PM, Jin Qian <jinqian@android.com> wrote:

> From: Jin Qian <jinqian@google.com>
>
> Expose emmc revision as part of device attributes.
>
> Signed-off-by: Jin Qian <jinqian@android.com>

So have you tried and seen what happens with an MMC that
is not an eMMC, i.e. a good old MMC card from back in the days?

Does it display all zeroes or something?

I think it is by far a better idea that Android start to read out these
things using the ioctl() operation and cut this sysfs business.

Example, see:
https://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git/tree/mmc_cmds.c
there is int read_extcsd() immediately in the top of the file.
The ioctl()s are a much better way to do this.

The ioctl() will read the extcsd
on the fly from the card, and what you see in sysfs is just read
when the card is initialized and then kept static.

Since the extcsd is not static but can change at runtime, I think
what you want to to is ioctl()s.

If we start to support reading extcsd from sysfs, the implementation
cannot just use the static copy of ext_csd like this, it needs to
ask the card for it using MMC_DRV_OP_GET_EXT_CSD
see
commit 627c3ccfb46ada2583eac434127ad5d75e1ac33c
"mmc: debugfs: Move block debugfs into block module"

Yours,
Linus Walleij
