From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/6] regulator: Fix pbias regulator enable
Date: Thu, 3 Sep 2015 09:39:50 +0200
Message-ID: <CAPDyKFrVR+vvmxm43hGimjqo4pcFa1pfDuNNENXU-tk_qXo2=w@mail.gmail.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33688 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbbICHjv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2015 03:39:51 -0400
Received: by wicmc4 with SMTP id mc4so10026930wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2015 00:39:50 -0700 (PDT)
In-Reply-To: <1441263042-12942-1-git-send-email-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

+Olof

On 3 September 2015 at 08:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> vsel_reg and enable_reg of the pbias regulator descriptor should actually
> have the offset from syscon.
>
> However after
> "ARM: dts: <platform>: add minimal l4 bus layout with control module
> support"
> vsel_reg and enable_reg started to have the absolute address because
> of address translation that happens due to pbias node made as the
> child node of syscon. This breaks the pbias regulator enable.
>
> This series adds the 'offset' to be populated in vsel_reg and enable_reg
> in the pbias driver itself.
>
> Changes from v1:
> *) Fixed Tony's review comments on adding a 'comment' for adding offset in
>    the driver and adding a warning for using platform_get_resource.
> *) Added Tony's Acked-by.
>
> Tested these patches against mmc -next in omap4 panda, omap3 beagle xm,
> dra72 and omap5 uevm
>
> Kishon Vijay Abraham I (6):
>   regulator: pbias: program pbias register offset in pbias driver
>   ARM: dts: dra7: use "ti,pbias-dra7" compatible string for pbias
>   ARM: dts: omap243x: use "ti,pbias-omap2" compatible string for pbias
>   ARM: dts: omap3: use "ti,pbias-omap3" compatible string for pbias
>   ARM: dts: omap4: use "ti,pbias-omap4" compatible string for pbias
>   ARM: dts: omap5: use "ti,pbias-omap5" compatible string for pbias
>
>  .../bindings/regulator/pbias-regulator.txt         |    7 ++-
>  arch/arm/boot/dts/dra7.dtsi                        |    2 +-
>  arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
>  arch/arm/boot/dts/omap3.dtsi                       |    2 +-
>  arch/arm/boot/dts/omap4.dtsi                       |    2 +-
>  arch/arm/boot/dts/omap5.dtsi                       |    2 +-
>  drivers/regulator/pbias-regulator.c                |   56 +++++++++++++++++---
>  7 files changed, 61 insertions(+), 12 deletions(-)
>
> --
> 1.7.9.5
>

I have recently queued another patchset [1] for the mmc omap driver
for 4.3 through my mmc tree for which Olof Johansson reported a
regression [2] for Panda ES with multi_v7_defconfig.

Kishon, could you please clarify if $subject patchset solves that
regression reported by Olof? Or perhaps Olof can run a test?

Finally, perhaps it's better if we queue this through my mmc tree
since we would then be able to avoid the regression - if I put
$subject patchset before [1], right? Then I need an ack from Mark for
the regulator patch.
Please tell me if you guys prefer another way.

Kind regards
Uffe

[1]
http://permalink.gmane.org/gmane.linux.kernel/2027789

[2]
http://www.spinics.net/lists/linux-mmc/msg33146.html
