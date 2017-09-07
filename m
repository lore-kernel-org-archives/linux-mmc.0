From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: cavium: Fix use-after-free in of_platform_device_destroy
Date: Thu, 7 Sep 2017 14:21:17 +0200
Message-ID: <CAPDyKFri9EFwAk3n0Oxt-+pNQak9KT5V9mURevgEN_CEF0Gmfw@mail.gmail.com>
References: <20170907112417.21495-1-jglauber@cavium.com> <CAPDyKFos=uPbuy1oQREMpE6hyaYbVxhVKSQNWkrE3VyoxzoL8g@mail.gmail.com>
 <20170907121940.GA22336@hc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35916 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755053AbdIGMVS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Sep 2017 08:21:18 -0400
Received: by mail-io0-f175.google.com with SMTP id d16so3718985ioj.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 Sep 2017 05:21:18 -0700 (PDT)
In-Reply-To: <20170907121940.GA22336@hc>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 7 September 2017 at 14:19, Jan Glauber
<jan.glauber@caviumnetworks.com> wrote:
> Thanks Uffe. The fix would only be required for 4.13, as only with that the
> Cavium GPIO driver became available.

Okay, I drop the fixes tag then, because it points to a commit present
in 4.12 as well.

Make sense?

Kind regards
Uffe

>
> --Jan
>
> On Thu, Sep 07, 2017 at 02:07:01PM +0200, Ulf Hansson wrote:
>> On 7 September 2017 at 13:24, Jan Glauber <jglauber@cavium.com> wrote:
>> > KASAN reported the following:
>> >
>> > [   19.338655] ==================================================================
>> > [   19.345946] BUG: KASAN: use-after-free in of_platform_device_destroy+0x88/0x100
>> > [   19.345966] Read of size 8 at addr fffffe01aa6f1468 by task systemd-udevd/264
>> >
>> > [   19.345983] CPU: 1 PID: 264 Comm: systemd-udevd Not tainted 4.13.0-jang+ #737
>> > [   19.345989] Hardware name: Cavium ThunderX CN81XX board (DT)
>> > [   19.345995] Call trace:
>> > [   19.346013] [<fffffc800808b1b0>] dump_backtrace+0x0/0x368
>> > [   19.346026] [<fffffc800808b6bc>] show_stack+0x24/0x30
>> > [   19.346040] [<fffffc8008cbb944>] dump_stack+0xa4/0xc8
>> > [   19.346057] [<fffffc80082c2870>] print_address_description+0x68/0x258
>> > [   19.346070] [<fffffc80082c2d70>] kasan_report+0x238/0x2f8
>> > [   19.346082] [<fffffc80082c14a8>] __asan_load8+0x88/0xb8
>> > [   19.346098] [<fffffc8008aacee0>] of_platform_device_destroy+0x88/0x100
>> > [   19.346131] [<fffffc8000e02fa4>] thunder_mmc_probe+0x314/0x550 [thunderx_mmc]
>> > [   19.346147] [<fffffc800879d560>] pci_device_probe+0x158/0x1f8
>> > [   19.346162] [<fffffc800886e53c>] driver_probe_device+0x394/0x5f8
>> > [   19.346174] [<fffffc800886e8f4>] __driver_attach+0x154/0x158
>> > [   19.346185] [<fffffc800886b12c>] bus_for_each_dev+0xdc/0x140
>> > [   19.346196] [<fffffc800886d9f8>] driver_attach+0x38/0x48
>> > [   19.346207] [<fffffc800886d148>] bus_add_driver+0x290/0x3c8
>> > [   19.346219] [<fffffc800886fc5c>] driver_register+0xbc/0x1a0
>> > [   19.346232] [<fffffc800879b78c>] __pci_register_driver+0xc4/0xd8
>> > [   19.346260] [<fffffc8000e80024>] thunder_mmc_driver_init+0x24/0x10000 [thunderx_mmc]
>> > [   19.346273] [<fffffc8008083a80>] do_one_initcall+0x98/0x1c0
>> > [   19.346289] [<fffffc8008177b54>] do_init_module+0xe0/0x2cc
>> > [   19.346303] [<fffffc8008175cf0>] load_module+0x3238/0x35c0
>> > [   19.346318] [<fffffc8008176438>] SyS_finit_module+0x190/0x1a0
>> > [   19.346329] [<fffffc80080834a0>] __sys_trace_return+0x0/0x4
>> >
>> > This is caused by:
>> >
>> >   platform_device_register()
>> >    -> platform_device_unregister(to_platform_device(dev))
>> >         freeing struct device
>> >    -> of_node_clear_flag(dev->of_node, ...)
>> >         writing to the freed device
>> >
>> > The issue is solved by increasing the reference count before calling
>> > of_platform_device_destroy() so freeing the device is postponed after
>> > the call.
>> >
>> > Fixes: 8fb83b142823 ("mmc: cavium: Fix probing race with regulator")
>> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
>>
>> Thanks, applied for fixes and added a stable tag.
>>
>> Kind regards
>> Uffe
>>
>> > ---
>> >  drivers/mmc/host/cavium-thunderx.c | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
>> > index b9cc95998799..eee08d81b242 100644
>> > --- a/drivers/mmc/host/cavium-thunderx.c
>> > +++ b/drivers/mmc/host/cavium-thunderx.c
>> > @@ -7,6 +7,7 @@
>> >   *
>> >   * Copyright (C) 2016 Cavium Inc.
>> >   */
>> > +#include <linux/device.h>
>> >  #include <linux/dma-mapping.h>
>> >  #include <linux/interrupt.h>
>> >  #include <linux/mmc/mmc.h>
>> > @@ -149,8 +150,11 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>> >         for (i = 0; i < CAVIUM_MAX_MMC; i++) {
>> >                 if (host->slot[i])
>> >                         cvm_mmc_of_slot_remove(host->slot[i]);
>> > -               if (host->slot_pdev[i])
>> > +               if (host->slot_pdev[i]) {
>> > +                       get_device(&host->slot_pdev[i]->dev);
>> >                         of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
>> > +                       put_device(&host->slot_pdev[i]->dev);
>> > +               }
>> >         }
>> >         clk_disable_unprepare(host->clk);
>> >         return ret;
>> > --
>> > 2.9.0.rc0.21.g7777322
>> >
