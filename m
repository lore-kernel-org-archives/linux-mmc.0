From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 3/9] mmc: cavium: Add MMC platform driver for Octeon SOCs
Date: Mon, 20 Mar 2017 16:19:41 +0100
Message-ID: <CAPDyKFrKOiyPiFKH7z7RaFYFuMM67oLmWOx25wT2x6m+BeSKeQ@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-4-jglauber@cavium.com>
 <CAPDyKFqTf7qGMb5b-ZEdYJUrF-kr-kzLO-mR_N5Xx06eohgtCQ@mail.gmail.com> <20170320144050.GA18823@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34688 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753377AbdCTPp3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 11:45:29 -0400
Received: by mail-vk0-f53.google.com with SMTP id z204so15271971vkd.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2017 08:43:56 -0700 (PDT)
In-Reply-To: <20170320144050.GA18823@hardcore>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On 20 March 2017 at 15:40, Jan Glauber <jan.glauber@caviumnetworks.com> wrote:
> On Fri, Mar 17, 2017 at 02:35:34PM +0100, Ulf Hansson wrote:
>> On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
>> > Add a platform driver for Octeon MIPS SOCs.
>> >
>> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
>> > Signed-off-by: David Daney <david.daney@cavium.com>
>> > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
>> > ---
>> >  drivers/mmc/host/Kconfig               |  10 ++
>> >  drivers/mmc/host/Makefile              |   2 +
>> >  drivers/mmc/host/cavium-pltfm-octeon.c | 183 +++++++++++++++++++++++++++++++++
>> >  3 files changed, 195 insertions(+)
>> >  create mode 100644 drivers/mmc/host/cavium-pltfm-octeon.c
>>
>> Please rename the file to cavium-octeon.c
>
> OK.
>
>> >
>> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> > index f08691a..68cc811 100644
>> > --- a/drivers/mmc/host/Kconfig
>> > +++ b/drivers/mmc/host/Kconfig
>> > @@ -622,6 +622,16 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
>> >         help
>> >           If you say yes here SD-Cards may work on the EZkit.
>> >
>> > +config MMC_CAVIUM_OCTEON
>> > +       tristate "Cavium OCTEON SD/MMC Card Interface support"
>> > +       depends on CAVIUM_OCTEON_SOC
>> > +       help
>> > +         This selects Cavium OCTEON SD/MMC card Interface.
>> > +         If you have an OCTEON board with a Multimedia Card slot,
>> > +         say Y or M here.
>> > +
>> > +         If unsure, say N.
>> > +
>>
>> Adding more new cavium variants becomes a bit messy in this approach.
>> May I suggest something similar we are using for SDHCI mmc driver.
>
> There will be no more new variants.
>
>> That is:
>>
>> For the core mmc cavium driver:
>> config MMC_CAVIUM (to build cavium-mmc.o)
>> I would also appreciate to rename that file to cavium.c
>> This also means you need to export the functions you provide from the
>> header cavium-mmc.h (rename to cavium.h)
>>
>> For the octeon variant:
>> config MMC_CAVIUM_OCTEON (to build cavium-octeon.o)
>> depends on MMC_CAVIUM && CAVIUM_OCTEON_SOC
>
> Why is this better? It creates a module out of the shared code that only
> has one single user, the ThunderX or the Octeon driver and they will
> never run both at the same time.
>
> Why not just link the shared code to the driver that uses it? Calling
> accross modules is also slower, although that doesn't matter here.

Okay, lets's keep it as is. We can always change it later on, if we
think it's needed.

Kind regards
Uffe
