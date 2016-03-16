From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] ARM: dts: r8a7793: Add SDHI controllers
Date: Wed, 16 Mar 2016 20:22:13 +0300
Message-ID: <56E99645.10504@cogentembedded.com>
References: <1458148297-22159-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1458148297-22159-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35748 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbcCPRWQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 13:22:16 -0400
Received: by mail-lb0-f173.google.com with SMTP id bc4so52513879lbc.2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 10:22:15 -0700 (PDT)
In-Reply-To: <1458148297-22159-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com

On 03/16/2016 08:11 PM, Ulrich Hecht wrote:

> Same as on r8a7791.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>   arch/arm/boot/dts/r8a7793.dtsi | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index b7f32d3..009ce38 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -509,6 +509,39 @@
>   		reg = <0 0xe6060000 0 0x250>;
>   	};
>
> +	sdhi0: sd@ee100000 {
> +		compatible = "renesas,sdhi-r8a7793";
> +		reg = <0 0xee100000 0 0x328>;
> +		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
> +		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
> +		       <&dmac1 0xcd>, <&dmac1 0xce>;
> +		dma-names = "tx", "rx";

    4 DMA channels but only 2 channel names?

[...]

MBR, Sergei

