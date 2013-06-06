From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 12/13] mmc: add DT bindings for more MMC capability flags
Date: Wed, 5 Jun 2013 18:55:01 -0700
Message-ID: <CAOesGMh6VZHDrt6FvAXij-6Nz4m0C40hRPbzJbNK6Y4O7GxFBg@mail.gmail.com>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
	<1360941242-18153-13-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:59749 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103Ab3FFBzD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 21:55:03 -0400
Received: by mail-qc0-f173.google.com with SMTP id c11so1354307qcv.18
        for <linux-mmc@vger.kernel.org>; Wed, 05 Jun 2013 18:55:01 -0700 (PDT)
In-Reply-To: <1360941242-18153-13-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>

Hi,


On Fri, Feb 15, 2013 at 7:14 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Many MMC capability flags are platform-dependent and are traditionally set
> in platform data. With DT often each such capability requires a special
> binding. Add bindings for MMC_CAP_SD_HIGHSPEED, MMC_CAP_MMC_HIGHSPEED,
> MMC_CAP_POWER_OFF_CARD and MMC_CAP_SDIO_IRQ capabilities. Also add code to
> DT parser to look up "keep-power-in-suspend" and "enable-sdio-wakeup"
> bindings and set MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ respectively,
> if found.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

I just came across this patch after it was merged (with no review from
any device tree maintainer :()

> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt |    4 ++++
>  drivers/mmc/core/host.c                       |   13 +++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 24c8552..d9ab51f 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -25,6 +25,10 @@ Optional properties:
>  - max-frequency: maximum operating clock frequency
>  - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>    this system, even if the controller claims it is.
> +- cap-sd-highspeed: SD high-speed timing is supported
> +- cap-mmc-highspeed: MMC high-speed timing is supported
> +- cap-power-off-card: powering off the card is safe
> +- cap-sdio-irq: enable SDIO IRQ signalling on this interface

These are bad names for describing hardware properties. There is no
reason to carry over the "cap" prefix from the internal usage of the
hardware characteristics in the kernel.

Other drivers use, for example "supports-highspeed", which this
duplicates to some extent. More work should have been done to
commonalize them. Etc.


-Olof
