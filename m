From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2 1/1] ANDROID: mmc: core: export emmc revision
Date: Thu, 12 Oct 2017 09:49:16 +0200
Message-ID: <CACRpkdYCV0-55izOKDJVp450iKOuFqd8t8d25gO6CnmG4ZD4nA@mail.gmail.com>
References: <20171011205152.173299-1-jinqian@android.com> <CACRpkdYaq3YH+HSYh7ChSyBF8=pscYEU_URu8oZpgSik0MtT-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:54658 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdJLHtR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2017 03:49:17 -0400
Received: by mail-io0-f174.google.com with SMTP id h66so4530514ioh.11
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2017 00:49:17 -0700 (PDT)
In-Reply-To: <CACRpkdYaq3YH+HSYh7ChSyBF8=pscYEU_URu8oZpgSik0MtT-Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jin Qian <jinqian@android.com>, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jin Qian <jinqian@google.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Uri Yanai <uri.yanai@sandisk.com>, Chanho Min <chanho.min@lge.com>, Jungseung Lee <js07.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Oct 12, 2017 at 9:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> I think it is by far a better idea that Android start to read out these
> things using the ioctl() operation and cut this sysfs business.

But hey, too early in the morning. It's just the revision of the extcsd
that is being exposed. That's not too bad.

I shouldn't mail before I had my coffee.

I let Ulf and Chris look at this, paging Chris Ball.

Yours,
Linus Walleij
