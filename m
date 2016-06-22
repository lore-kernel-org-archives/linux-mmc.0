From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] mmc: bcm2835-sdhost: Add new driver for the internal
 SD controller.
Date: Wed, 22 Jun 2016 16:41:10 +0200
Message-ID: <CAPDyKFpak075H7aAH14-LLzKFtE6-n+x5u+k_dvT6Oi5=sgXeQ@mail.gmail.com>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38715 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbcFVOlX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 10:41:23 -0400
Received: by mail-wm0-f51.google.com with SMTP id r201so9310173wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2016 07:41:12 -0700 (PDT)
In-Reply-To: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Eric Anholt <eric@anholt.net>

On 22 June 2016 at 13:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the bcm2835-sdhost driver.  Patches 1+2 are unmodified from
> Eric, patches 3+4 are incremental fixes.  Left them separate for now,
> to make it easier to review, should probably squashed in for the final
> version.  Patch 5 adds it to the device tree, in disabled state.
>
> Actually enabling the thing depends on a bunch of changes in the gpio
> handling of the device tree.  Leaving that for another day ...

Why did you post this?

I think you should be adopting sdhci-iproc - in case there are issues
with its bcm2835 support, right!?

Kind regards
Uffe

>
> cheers,
>   Gerd
>
> Eric Anholt (2):
>   dt-bindings: Add binding for brcm,bcm2835-sdhost.
>   mmc: bcm2835-sdhost: Add new driver for the internal SD controller.
>
> Gerd Hoffmann (3):
>   mmc: bcm2835-sdhost: zap mmiowb() [fixup]
>   mmc: bcm2835-sdhost: reset tweaks. [fixup]
>   mmc: bcm2835-sdhost: add to devicetree
>
>  .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |    3 +
>  .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   24 +
>  arch/arm/boot/dts/bcm283x.dtsi                     |    8 +
>  drivers/mmc/host/Kconfig                           |    9 +
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/bcm2835-sdhost.c                  | 1652 ++++++++++++++++++++
>  6 files changed, 1697 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
>  create mode 100644 drivers/mmc/host/bcm2835-sdhost.c
>
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
