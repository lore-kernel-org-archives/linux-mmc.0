From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: remove sdhci-bcm2835
Date: Wed, 22 Jun 2016 17:22:58 +0200
Message-ID: <CAPDyKFoMzadox1k0xqprMfvoR6b+tHNpjtZb8pB1FZo6QmKqGg@mail.gmail.com>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37299 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbcFVPXB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 11:23:01 -0400
Received: by mail-wm0-f46.google.com with SMTP id a66so11087720wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2016 08:23:00 -0700 (PDT)
In-Reply-To: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 3 June 2016 at 21:47, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The sdhci-bcm2835 is no more needed since it has been replaced
> by sdhci-iproc.
>
> Stefan Wahren (2):
>   DT: bindings: remove bcm2835-sdhci
>   mmc: sdhci-bcm2835: remove driver
>
>  .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |   18 --
>  drivers/mmc/host/Kconfig                           |   11 --
>  drivers/mmc/host/Makefile                          |    1 -
>  drivers/mmc/host/sdhci-bcm2835.c                   |  204 --------------------
>  4 files changed, 234 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
>  delete mode 100644 drivers/mmc/host/sdhci-bcm2835.c
>
> --
> 1.7.9.5
>

Thanks, applied for next!

Kind regards
Uffe
