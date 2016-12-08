From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Move files to core
Date: Thu, 8 Dec 2016 13:21:12 +0100
Message-ID: <CAPDyKFphV0SFLfnL19EfTLH2ZuGpHpP991xMhSq1O_J500BNTw@mail.gmail.com>
References: <1481195892-31779-1-git-send-email-ulf.hansson@linaro.org> <e0cab491-2902-1931-a14b-75ed7ac3e8af@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37479 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbcLHMVP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2016 07:21:15 -0500
Received: by mail-wm0-f42.google.com with SMTP id t79so22768808wmt.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Dec 2016 04:21:14 -0800 (PST)
In-Reply-To: <e0cab491-2902-1931-a14b-75ed7ac3e8af@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

On 8 December 2016 at 12:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 08/12/16 13:18, Ulf Hansson wrote:
>> Once upon a time it made sense to keep the mmc block device driver and its
>> related code, in a separate directory. Over time, more an more interfaces
>> and structures have been exported by the core layer to outsiders. This to
>> allow the mmc block device driver to do its job. In other words, the
>> relationship between the block code and the core code has become closer.
>>
>> Let's not continue this path, but instead let's join the two directories.
>> Simply by moving the block files into the core directory, lots of clean ups
>> can be made, but more importantly, this change should also enables us
>> remove unnecessary exported interfaces.
>
> Don't you still need to export things if they are separate modules?

Yes, right! Perhaps I was a bit too vague in my change-log.

I aim to slim down generic mmc headers in include/linux/mmc/* as to
achieve the goal of only providing interfaces/structures to outsiders
which they are allowed to use. Currently it's it too easy to abuse the
mmc interfaces.

BTW, regarding your eMMC CMDQ series, that can easily be re-based on
top of this change as git takes good care of files being renamed.

Kind regards
Uffe
