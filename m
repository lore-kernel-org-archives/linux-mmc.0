From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/2] mmc: arasan: Add driver for Arasan SDHCI
Date: Mon, 28 Oct 2013 22:16:49 +0100
Message-ID: <1587218.cW45zK0ty2@flatron>
References: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:59695 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3J1VQw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Oct 2013 17:16:52 -0400
In-Reply-To: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org

Hi Soren,

On Tuesday 15 of October 2013 12:08:04 Soren Brinkmann wrote:
> Add a driver for Arasan's SDHCI controller core.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  23 +++
>  MAINTAINERS                                        |   1 +
>  drivers/mmc/host/Kconfig                           |  12 ++
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 224
> +++++++++++++++++++++ 5 files changed, 261 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt create mode
> 100644 drivers/mmc/host/sdhci-of-arasan.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt new file mode
> 100644
> index 000000000000..20f0fc25e270
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -0,0 +1,23 @@
> +Device Tree Bindings for the Arasan SDCHI Controller
> +
> +  The bindings follow the mmc[1] and the clock bindings[2]. Only
> deviations are +  documented here.
> +
> +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required Properties:

According to the example below, the list of required properties lacks 
interrupt-related properties.

Except this minor issue, the binding is trivial and looks fine to me.

Best regards,
Tomasz

