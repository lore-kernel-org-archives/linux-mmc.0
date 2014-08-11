From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCHv10 5/5] ARM: dts: rockchip: unuse the slot-node and
 deprecate the supports-highspeed for dw-mmc
Date: Mon, 11 Aug 2014 16:38:31 +0200
Message-ID: <2216569.yZfKCR5Kzu@diego>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <1407397082-32495-6-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407397082-32495-6-git-send-email-jh80.chung@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, kgene.kim@samsung.com, tgih.jun@samsung.com, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dinguyen@altera.com
List-Id: linux-mmc@vger.kernel.org

Am Donnerstag, 7. August 2014, 16:38:02 schrieb Jaehoon Chung:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced with "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

I've added this one to my queue for 3.18


Heiko

> ---
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts |   15 ++++-----------
>  arch/arm/boot/dts/rk3188-radxarock.dts |    7 ++-----
>  2 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> b/arch/arm/boot/dts/rk3066a-bqcurie2.dts index 042f821d..665dd56 100644
> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> @@ -150,12 +150,8 @@
>  	num-slots = <1>;
>  	status = "okay";
>  	vmmc-supply = <&vcc_sd0>;
> -
> -	slot@0 {
> -		reg = <0>;
> -		bus-width = <4>;
> -		disable-wp;
> -	};
> +	bus-width = <4>;
> +	disable-wp;
>  };
> 
>  &mmc1 { /* wifi */
> @@ -166,11 +162,8 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
> 
> -	slot@0 {
> -		reg = <0>;
> -		bus-width = <4>;
> -		disable-wp;
> -	};
> +	bus-width = <4>;
> +	disable-wp;
>  };
> 
>  &uart0 {
> diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts
> b/arch/arm/boot/dts/rk3188-radxarock.dts index 171b610..ef72faf 100644
> --- a/arch/arm/boot/dts/rk3188-radxarock.dts
> +++ b/arch/arm/boot/dts/rk3188-radxarock.dts
> @@ -181,11 +181,8 @@
>  	status = "okay";
>  	vmmc-supply = <&vcc_sd0>;
> 
> -	slot@0 {
> -		reg = <0>;
> -		bus-width = <4>;
> -		disable-wp;
> -	};
> +	bus-width = <4>;
> +	disable-wp;
>  };
> 
>  &pinctrl {
