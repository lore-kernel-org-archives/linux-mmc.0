From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Potentially invalid memory accesses in file drivers/mmc/core/block.c
Date: Thu, 3 Aug 2017 09:46:18 +0200
Message-ID: <CACRpkdZmenuHSes+o9NtuzYBtobrs7g6-X3=NG2ar1Zot2wFXw@mail.gmail.com>
References: <003501d30289$89f86990$9de93cb0$@Domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:38455 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdHCHqU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 03:46:20 -0400
Received: by mail-io0-f176.google.com with SMTP id g71so3831784ioe.5
        for <linux-mmc@vger.kernel.org>; Thu, 03 Aug 2017 00:46:20 -0700 (PDT)
In-Reply-To: <003501d30289$89f86990$9de93cb0$@Domain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shaobo <shaobo@cs.utah.edu>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jens Axboe <axboe@fb.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, Jul 22, 2017 at 3:37 AM, Shaobo <shaobo@cs.utah.edu> wrote:

> My name is Shaobo He and I am a graduate student at University of Utah. I am
> using a static analysis tool to search for null pointer dereferences and
> came across a couple of potentially invalid memory accesses in the file
> drivers/mmc/core/block.c: in function `force_ro_store`, function
> `mmc_blk_get` can return a NULL pointer. However, there are a couple of
> conditions that can make the error path infeasible. I was wondering if you
> could confirm this. Especially if the condition
> `dev_to_disk(dev)->private_data && dev_to_disk(dev)->private_data->usage !=
> 0` serves as a reasonable precondition of function `force_ro_store`.
>
> Please let me know if it makes sense. I am looking forward to your reply.

I can solidly confirm that the kernel is full och NULL pointer violations.
But pointing out the problems is rarely helpful as that pushes the work of
fixing them to others.

When you find specific cases, send patches to fix the issue to the respective
subsystem maintainer(s). It is the best way to illustrate the problem you see
and at the same time propose a solution.

You have reached the right list.

Yours,
Linus Walleij
