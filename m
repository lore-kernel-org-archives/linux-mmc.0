From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling() into
 a library function
Date: Thu, 19 Jun 2014 10:02:16 -0700
Message-ID: <CAOesGMh_8JSMzZQXVncBGmiTN6B--udY11kX=xmD5_TWRsUiSg@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
	<E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
	<20140616104615.GA10701@n2100.arm.linux.org.uk>
	<CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg@mail.gmail.com>
	<20140619122830.GP32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:52385 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933062AbaFSRCR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jun 2014 13:02:17 -0400
Received: by mail-ve0-f174.google.com with SMTP id jx11so2593173veb.33
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2014 10:02:17 -0700 (PDT)
In-Reply-To: <20140619122830.GP32514@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Barry Song <baohua@kernel.org>, spear-devel <spear-devel@list.st.com>, Stephen Warren <swarren@wwwdotorg.org>, Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>, Thierry Reding <thierry.reding@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Ben Dooks <ben-linux@fluff.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 19, 2014 at 5:28 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 16, 2014 at 02:17:30PM +0200, Ulf Hansson wrote:
>> Anyway, we did get some folks to test the patches and was thus fairly
>> confident that we could merge them. Chris asked me to try to collect
>> them in a PR for him, so I did. Sorry if I managed to screw some
>> things up, there were several conflicts and actual regressions, which
>> I tried to take care of.
>>
>> The mmc people were also very helping in sending patches to fixup
>> related regressions, immediately after we merged your patchset. Thus
>> together I think we managed to pull it off.
>
> I tend to look through slightly less rose-tinted glasses.
>
> The fact is... there's loads of ARM platforms which now fail in Olof's
> build/boot testing, and they all seem to have a very similar pattern:
>
> hummingboard:
> [    1.149688] sdhci: Secure Digital Host Controller Interface driver
> [    1.155901] sdhci: Copyright(c) Pierre Ossman
> ...
> [    1.253630] Waiting for root device /dev/mmcblk0p2...
> [   60.325469] imx-sdma 20ec000.sdma: firmware not found
> ~$off
> # PYBOOT: Exception: timeout
>
> jetson:
> [    2.261355] Waiting for root device /dev/mmcblk0p1...
>
> wandboard:
> [    1.186870] sdhci: Secure Digital Host Controller Interface driver
> [    1.193075] sdhci: Copyright(c) Pierre Ossman
> ...
> [    1.291064] Waiting for root device /dev/mmcblk0p2...
>
> Whether these are caused by the patch set or not is anyone's guess,
> because we (a) don't know what's causing these failures, and (b)
> my patch series was never tested on anything but iMX6.
>
> I'm pretty certain that the hummingboard failure is not related to
> my series as that's one of the platforms I did test my series on.
>
> There's more failures which look like possibly something in core MMC is
> rather screwed, as OMAP5 (which doesn't use SDHCI) is also failing at
> a similar point.
>
> What these failures /do/ mean is that when I'm pushing my ARM for-next
> branch out, Olof's builder picks it up and runs a build across it, and
> the report returns a whole load of failures.  A whole load of failures
> means that those platforms haven't tested my changes, which means the
> quality of testing is much lower than it should be.
>
> With 26 passing and 15 failing, that's over 1/3 of platforms failing,
> which means 1/3 aren't getting tested.
>
> This level of failure has been going on for quite a while now, and (afaik)
> it remains uninvestigated and undiagnosed.  (This is one of the complaints
> I have about Olof's build/boot test system, much of the information about
> the build and boot is hidden away and unpublished, which makes it almost
> impossible for third parties to diagnose any problem there.  I've given up
> looking at most of Olof's build/boot mails because of this - it's just
> not interesting to see the same abbreviated boot failure logs which give
> no useful information time and time again.)

Most of this is because I want to avoid sending huuuge emails out with
the failures. I'll add a push of the full log to arm-soc.lixom.net and
include a link to it in the emails, similar to how I do the build
logs. I'll let you know when I've made that change.


-Olof
