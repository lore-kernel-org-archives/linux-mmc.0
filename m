From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/3] Document: dw_mmc-k3: add document of hi6220 mmc
Date: Tue, 12 May 2015 16:36:30 +0900
Message-ID: <5551AD7E.2050200@samsung.com>
References: <1430985401-12202-1-git-send-email-zhangfei.gao@linaro.org>
 <1430985401-12202-2-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:10671 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbbELHgg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 May 2015 03:36:36 -0400
In-reply-to: <1430985401-12202-2-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

Hi, Zhangfei.

On 05/07/2015 04:56 PM, Zhangfei Gao wrote:
> Add bindings for hi6220 mmc support
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> index 3b35449..df37058 100644
> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -13,6 +13,10 @@ Required Properties:
>  
>  * compatible: should be one of the following.
>    - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
> +  - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
> +
> +Optional Properties:
> +- hisilicon,peripheral-syscon: phandle of syscon used to control peripheral.
>  
I'm not sure..
but i think this patch could be added just the compatible and optional properties descriptions.
If SoC will be added, it need not to add every example, doesn't it?

how about removing the below example? This is just my opinion. :)
If there is a special reason that add example...let me know, plz.

Best Regards,
Jaehoon Chung

>  Example:
>  
> @@ -42,3 +46,27 @@ Example:
>  		cap-mmc-highspeed;
>  		cap-sd-highspeed;
>  	};
> +
> +	/* for Hi6220 */
> +
> +	dwmmc_1: dwmmc1@f723e000 {
> +		compatible = "hisilicon,hi6220-dw-mshc";
> +		num-slots = <0x1>;
> +		bus-width = <0x4>;
> +		disable-wp;
> +		cap-sd-highspeed;
> +		sd-uhs-sdr12;
> +		sd-uhs-sdr25;
> +		card-detect-delay = <200>;
> +		hisilicon,peripheral-syscon = <&ao_ctrl>;
> +		reg = <0x0 0xf723e000 0x0 0x1000>;
> +		interrupts = <0x0 0x49 0x4>;
> +		clocks = <&clock_sys HI6220_MMC1_CIUCLK>, <&clock_sys HI6220_MMC1_CLK>;
> +		clock-names = "ciu", "biu";
> +		cd-gpios = <&gpio1 0 1>;
> +		pinctrl-names = "default", "idle";
> +		pinctrl-0 = <&sd_pmx_func &sd_clk_cfg_func &sd_cfg_func>;
> +		pinctrl-1 = <&sd_pmx_idle &sd_clk_cfg_idle &sd_cfg_idle>;
> +		vqmmc-supply = <&ldo7>;
> +		vmmc-supply = <&ldo10>;
> +	};
> 

