From: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 4/6] arm64: dts: stratix10: remove 'num-slots' property
 for dwmmc
Date: Wed, 7 Mar 2018 08:37:46 -0600
Message-ID: <94cf9226-27f2-1550-e1c1-2f7dbb873bd1@kernel.org>
References: <20180223064138.18401-1-jh80.chung@samsung.com>
 <CGME20180223064140epcas2p3804fe3b7d63e4b7975d94a178e94dffb@epcas2p3.samsung.com>
 <20180223064138.18401-4-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223064138.18401-4-jh80.chung@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, manabian@gmail.com, will.deacon@arm.com, xuwei5@hisilicon.com
List-Id: linux-mmc@vger.kernel.org



On 02/23/2018 12:41 AM, Jaehoon Chung wrote:
> Since 'num-slots' had already deprecated, remove the property in
> device-tree file.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index a37c46112876..4e146b4e6487 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -88,7 +88,6 @@
>  
>  &mmc {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	broken-cd;
>  	bus-width = <4>;
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
