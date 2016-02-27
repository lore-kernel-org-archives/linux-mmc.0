From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/4] ARM: bcm2835: Include SDHOST in the device tree.
Date: Sat, 27 Feb 2016 21:17:00 +0300
Message-ID: <56D1E81C.9040003@cogentembedded.com>
References: <1456527942-3045-1-git-send-email-eric@anholt.net>
 <1456527942-3045-4-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33206 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692AbcB0SRG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Feb 2016 13:17:06 -0500
Received: by mail-lb0-f174.google.com with SMTP id ep2so29565856lbb.0
        for <linux-mmc@vger.kernel.org>; Sat, 27 Feb 2016 10:17:04 -0800 (PST)
In-Reply-To: <1456527942-3045-4-git-send-email-eric@anholt.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org

Hello.

On 02/27/2016 02:05 AM, Eric Anholt wrote:

> It's disabled by default, and will be enabled by a particular board's
> DT.  The DMA channels are also currently left out, because our DMA
> engine support doesn't yet include slave SG, and there doesn't appear
> to be a clean way to include "does slave SG" in the channel
> request/config process.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>   arch/arm/boot/dts/bcm283x.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 597a78f..7b2721b 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -366,6 +366,14 @@
>   			status = "disabled";
>   		};
>
> +		sdhost: sdhost@7e202000 {

    Please just sd@7e202000 to better comply with ePAPR.

[...]

MBR, Sergei

