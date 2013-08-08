From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv2] ARM: socfpga: dts: Add support for SD/MMC
Date: Thu, 08 Aug 2013 14:14:18 -0600
Message-ID: <5203FC1A.3090903@wwwdotorg.org>
References: <1375735392-6836-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1375735392-6836-1-git-send-email-dinguyen@altera.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dinguyen@altera.com
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, dinh.linux@gmail.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 08/05/2013 02:43 PM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> Add "syscon" to the "altr,sys-mgr" binding.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> new file mode 100644
> index 0000000..dc14922
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> @@ -0,0 +1,48 @@
> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> +  Storage Host Controller
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> +	  specific extensions.
> +
> +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> +  value is fixed at 3, which means parent_clock/4.

This feels like something that should be represented using the common
clock API; a driver should query the rate of its input clock, and then
calculate the MMC block's internal divider based on that (perhaps also
call clk_set_rate() on the input clock?).

> +Example:
> +	dwmmc0@ff704000 {
> +		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> +		reg = <0xff704000 0x1000>;
> +		interrupts = <0 139 4>;

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		num-slots = <1>;
> +		supports-highspeed;
> +		fifo-depth = <0x400>;

Those properties aren't defined in this document anywhere. I guess this
binding is meant to "inherit" from that described in
"synopsis-dw-mshc.txt"? If so, that should be stated explicitly.

A similar comment applies to the clocks properties in the *.dtsi changes.

> +		altr,dw-mshc-ciu-div = <3>;
> +      		altr,dw-mshc-sdr-timing = <0 3>;

Indentation issue.
