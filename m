From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Mon, 4 May 2015 08:03:31 +0200
Message-ID: <19876f56-d3ce-4b70-9cb9-fcb43151d52d@BL2FFO11FD044.protection.gbl>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
 <1430456052-8888-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1430456052-8888-2-git-send-email-stripathi@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Tripathi <stripathi@apm.com>, chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com, jcm@redhat.com, linux-mmc@vger.kernel.org, patches@apm.com, ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 05/01/2015 06:54 AM, Suman Tripathi wrote:
> This patch adds the arasan sdhc nodes to reuse the of-arasan
> driver for APM X-Gene SoC.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  arch/arm64/boot/dts/apm-mustang.dts |  4 ++++
>  arch/arm64/boot/dts/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
> index 8eb6d94..d0e52a9 100644
> --- a/arch/arm64/boot/dts/apm-mustang.dts
> +++ b/arch/arm64/boot/dts/apm-mustang.dts
> @@ -44,3 +44,7 @@
>  &xgenet {
>  	status = "ok";
>  };
> +
> +&sdhc0 {
> +	status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> index 87d3205..d6c2216 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -144,6 +144,40 @@
>  				clock-output-names = "socplldiv2";
>  			};
> 
> +			ahbclk: ahbclk@1f2ac000 {
> +				compatible = "apm,xgene-device-clock";
> +				#clock-cells = <1>;
> +				clocks = <&socplldiv2 0>;
> +				reg = <0x0 0x1f2ac000 0x0 0x1000
> +					0x0 0x17000000 0x0 0x2000>;
> +				reg-names = "csr-reg", "div-reg";
> +				csr-offset = <0x0>;
> +				csr-mask = <0x1>;
> +				enable-offset = <0x8>;
> +				enable-mask = <0x1>;
> +				divider-offset = <0x164>;
> +				divider-width = <0x5>;
> +				divider-shift = <0x0>;
> +				clock-output-names = "ahbclk";
> +			};
> +
> +			sdioclk: sdioclk@1f2ac000 {
> +				compatible = "apm,xgene-device-clock";
> +				#clock-cells = <1>;
> +				clocks = <&socplldiv2 0>;
> +				reg = <0x0 0x1f2ac000 0x0 0x1000
> +					0x0 0x17000000 0x0 0x2000>;
> +				reg-names = "csr-reg", "div-reg";
> +				csr-offset = <0x0>;
> +				csr-mask = <0x2>;
> +				enable-offset = <0x8>;
> +				enable-mask = <0x2>;
> +				divider-offset = <0x178>;
> +				divider-width = <0x8>;
> +				divider-shift = <0x0>;
> +				clock-output-names = "sdioclk";
> +			};
> +
>  			qmlclk: qmlclk {
>  				compatible = "apm,xgene-device-clock";
>  				#clock-cells = <1>;
> @@ -503,6 +537,16 @@
>  			interrupts = <0x0 0x4f 0x4>;
>  		};
> 
> +		sdhc0: sdhc@1c000000 {
> +			device_type = "sdhc";
> +			compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";

I would just add 4.9a here because you want to use that quirks. We can
add some quirks to 8.9a version if any new problem arises.

Thanks,
Michal
