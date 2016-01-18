From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 5/5 RFC] DT: sdhci-iproc: add bcm2835 compatible
Date: Mon, 18 Jan 2016 13:47:53 -0800
Message-ID: <569D5D89.4040604@broadcom.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-6-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:10341 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbcARVsF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 16:48:05 -0500
In-Reply-To: <1453042744-16196-6-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

Looks good.

On 16-01-17 06:59 AM, Stefan Wahren wrote:
> Since sdhci-iproc can support bcm2835 we need to add the
> compatible string to the binding.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Scott Branden <sbranden@broadcom.com>

> ---
>   .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> index 72cc9cc..a9330a4 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> @@ -4,7 +4,10 @@ This file documents differences between the core properties described
>   by mmc.txt and the properties that represent the IPROC SDHCI controller.
>
>   Required properties:
> -- compatible : Should be "brcm,sdhci-iproc-cygnus".
> +- compatible : Should be one of the following
> +	       "brcm,bcm2835-sdhci"
> +	       "brcm,sdhci-iproc-cygnus"
> +
>   - clocks : The clock feeding the SDHCI controller.
>
>   Optional properties:
>

