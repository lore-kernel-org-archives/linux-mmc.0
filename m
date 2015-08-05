From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
Date: Wed, 05 Aug 2015 17:27:21 +0900
Message-ID: <55C1C8E9.1060808@samsung.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-reply-to: <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: dianders@chromium.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>, Govindraj Raja <govindraj.raja@imgtec.com>, linux-samsung-so
List-Id: linux-mmc@vger.kernel.org

On 05.08.2015 17:17, Shawn Lin wrote:
> synopsys-dw-mshc supports three types of transfer mode. We add bindings
> and description for how to use them at runtime. Without idmac and edmac
> property, pio is the default transfer mode. Make sure that Idmac and emdac
> should not be used simultaneously.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 346c609..30369cb 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -75,6 +75,25 @@ Optional properties:
>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>    specified we'll defer probe until we can find this regulator.
>  
> +* supports-idmac: Enables support for internal DMAC block within the Synopsys
> +  Designware Mobile Storage IP block. If supports-idmac property is present, then
> +  we MUST NOT add supports-edmac property since we'd assume that dw-mshc IP is
> +  integrated with only one type of dma master.
> +
> +* supports-edmac: Enables support for external DMAC block outside the Synopsys
> +  Designware Mobile Storage IP block. If supports-edmac property is present, then
> +  we MUST NOT add supports-idmac property since we'd assume that dw-mshc IP is
> +  integrated with only one type of dma master.
> +
> +  (Without "supports-idmac" and "supports-edmac", use PIO as default transfer mode)

Aren't you breaking here backward compatibility with existing DTB?

Best regards,
Krzysztof

> +
> +* dmas: List of DMA specifiers with the controller specific format as described
> +  in the generic DMA client binding. This property should be combined with
> +  supports-edmac. Refer to dma.txt for details.
> +
> +* dma-names: DMA request names. Must be "rx-tx". And This property should be
> +  combined with supports-edmac. Refer to dma.txt for details.
> +
>  Aliases:
>  
>  - All the MSHC controller nodes should be represented in the aliases node using
> @@ -95,6 +114,8 @@ board specific portions as listed below.
>  		#size-cells = <0>;
>  	};
>  
> +[board specific internal DMA resources]
> +
>  	dwmmc0@12200000 {
>  		clock-frequency = <400000000>;
>  		clock-freq-min-max = <400000 200000000>;
> @@ -106,4 +127,24 @@ board specific portions as listed below.
>  		bus-width = <8>;
>  		cap-mmc-highspeed;
>  		cap-sd-highspeed;
> +		supports-idmac;
>  	};
> +
> +[board specific generic DMA request binding]
> +
> +	dwmmc0@12200000 {
> +		clock-frequency = <400000000>;
> +		clock-freq-min-max = <400000 200000000>;
> +		num-slots = <1>;
> +		broken-cd;
> +		fifo-depth = <0x80>;
> +		card-detect-delay = <200>;
> +		vmmc-supply = <&buck8>;
> +		bus-width = <8>;
> +		cap-mmc-highspeed;
> +		cap-sd-highspeed;
> +		supports-edmac;
> +		dmas = <&pdma 12>;
> +		dma-names = "rx-tx";
> +	};
> +
> 
