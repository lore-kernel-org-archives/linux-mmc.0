From: "Shaobo" <shaobo@cs.utah.edu>
Subject: RE: Potentially invalid memory accesses in file drivers/mmc/core/block.c
Date: Thu, 3 Aug 2017 12:54:45 -0600
Message-ID: <000501d30c89$f964ebf0$ec2ec3d0$@cs.utah.edu>
References: <003501d30289$89f86990$9de93cb0$@Domain> <CACRpkdZmenuHSes+o9NtuzYBtobrs7g6-X3=NG2ar1Zot2wFXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:35766 "EHLO
        mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdHCSys (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 14:54:48 -0400
In-Reply-To: <CACRpkdZmenuHSes+o9NtuzYBtobrs7g6-X3=NG2ar1Zot2wFXw@mail.gmail.com>
Content-Language: zh-cn
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Linus Walleij' <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Adrian Hunter' <adrian.hunter@intel.com>, 'Shawn Lin' <shawn.lin@rock-chips.com>, 'Jens Axboe' <axboe@fb.com>, 'Geert Uytterhoeven' <geert@linux-m68k.org>

Hi Linus,

Thanks for your reply. While I appreciate your suggestions, I'm a little confused because honestly I don't know if I was pointing out a real issue since the bug occurs under certain conditions. And my knowledge to decide if these conditions are feasible is very limited. That's the exact reason that the last email is for. If you could kindly confirm the issue in the last email, then I can probably come up with a reasonable fix.

Thanks again for your time and suggestions. Please let me know your thoughts.

Best,
Shaobo
-----Original Message-----
From: Linus Walleij [mailto:linus.walleij@linaro.org] 
Sent: 2017年8月3日 1:46
To: Shaobo <shaobo@cs.utah.edu>
Cc: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter <adrian.hunter@intel.com>; Shawn Lin <shawn.lin@rock-chips.com>; Jens Axboe <axboe@fb.com>; Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Potentially invalid memory accesses in file drivers/mmc/core/block.c

On Sat, Jul 22, 2017 at 3:37 AM, Shaobo <shaobo@cs.utah.edu> wrote:

> My name is Shaobo He and I am a graduate student at University of 
> Utah. I am using a static analysis tool to search for null pointer 
> dereferences and came across a couple of potentially invalid memory 
> accesses in the file
> drivers/mmc/core/block.c: in function `force_ro_store`, function 
> `mmc_blk_get` can return a NULL pointer. However, there are a couple 
> of conditions that can make the error path infeasible. I was wondering 
> if you could confirm this. Especially if the condition 
> `dev_to_disk(dev)->private_data && 
> dev_to_disk(dev)->private_data->usage != 0` serves as a reasonable precondition of function `force_ro_store`.
>
> Please let me know if it makes sense. I am looking forward to your reply.

I can solidly confirm that the kernel is full och NULL pointer violations.
But pointing out the problems is rarely helpful as that pushes the work of fixing them to others.

When you find specific cases, send patches to fix the issue to the respective subsystem maintainer(s). It is the best way to illustrate the problem you see and at the same time propose a solution.

You have reached the right list.

Yours,
Linus Walleij

