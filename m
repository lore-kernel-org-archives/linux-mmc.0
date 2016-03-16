From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ARM: dts: r8a7793: Add MMCIF0
Date: Wed, 16 Mar 2016 20:20:46 +0300
Message-ID: <56E995EE.2010805@cogentembedded.com>
References: <1458148237-21902-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458148237-21902-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-mmc@vger.kernel.org

Hello.

On 03/16/2016 08:10 PM, Ulrich Hecht wrote:

> Same as on r8a7794.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>   arch/arm/boot/dts/r8a7793.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index 63f811d..33413e8 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -509,6 +509,18 @@
>   		reg = <0 0xe6060000 0 0x250>;
>   	};
>
> +	mmcif0: mmcif@ee200000 {
> +		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
> +		reg = <0 0xee200000 0 0x80>;
> +		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
> +		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
> +		       <&dmac1 0xd1>, <&dmac1 0xd2>;
> +		dma-names = "tx", "rx";

    4 DMA channels but only 2 channel names?

[...]

MBR, Sergei
