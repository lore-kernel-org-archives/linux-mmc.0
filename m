From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 3/5 RFC] ARM: bcm283x: specify sdhci quirks in dtsi file
Date: Mon, 18 Jan 2016 13:40:32 -0800
Message-ID: <569D5BD0.6020804@broadcom.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-4-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:23125 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbcARVko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 16:40:44 -0500
In-Reply-To: <1453042744-16196-4-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

looks good

On 16-01-17 06:59 AM, Stefan Wahren wrote:
> This patch defines the known quirks for BCM283x in the dtsi file:
> * SDHCI_QUIRK_BROKEN_CARD_DETECTION
> * SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12
>
> So we don't need to define them in the driver.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Scott Branden <sbranden@broadcom.com>

> ---
>   arch/arm/boot/dts/bcm283x.dtsi |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 971e741..75451cd 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -164,6 +164,8 @@
>   			reg = <0x7e300000 0x100>;
>   			interrupts = <2 30>;
>   			clocks = <&clocks BCM2835_CLOCK_EMMC>;
> +			broken-cd;
> +			sdhci,auto-cmd12;
>   			status = "disabled";
>   		};
>
>

