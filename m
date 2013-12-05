From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv3 2/4] arm: dts: Add a system manager compatible property
Date: Thu, 5 Dec 2013 11:40:34 +0000
Message-ID: <20131205114034.GL29200@e106331-lin.cambridge.arm.com>
References: <1386197576-3825-1-git-send-email-dinguyen@altera.com>
 <1386197576-3825-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1386197576-3825-3-git-send-email-dinguyen@altera.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "dinguyen@altera.com" <dinguyen@altera.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mturquette@linaro.org" <mturquette@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, Pawel Moll <Pawel.Moll@arm.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "dinh.linux@gmail.com" <dinh.linux@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 04, 2013 at 10:52:54PM +0000, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The "altr,sysmgr-sdmmc-sdr" compatible property is used for the SOCFPGA
> clk-sysmgr driver. This property represents the register inside the
> system manager that controls the clock phase of the SD/MMC driver.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
> v3: Cannot use the syscon driver along with the clock because as of v3.13-rc1,
> the syscon driver is loaded after the clocks.
> v2: Add syscon
> ---
>  .../bindings/arm/altera/socfpga-system.txt         |   10 ++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   14 +++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
> index f4d04a0..7a6c7ed 100644
> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
> @@ -5,9 +5,19 @@ Required properties:
>  - reg : Should contain 1 register ranges(address and length)
>  - cpu1-start-addr : CPU1 start address in hex.
>  
> +Optional properties:
> +- compatible = "altr,sysmgr-sdmmc-sdr". This compatible property is used
> +to represent the clock phase settings for the SD/MMC IP.
> +

This makes no sense with the example below. This is _not_ an optional
property of the sysmgr node, this is a poor description of a child node.

>  Example:
>  	 sysmgr@ffd08000 {
>  		compatible = "altr,sys-mgr";
>  		reg = <0xffd08000 0x1000>;
>  		cpu1-start-addr = <0xffd080c4>;
> +
> +		sysmgr_sdr_mmc: sysmgr_sdr_mmc {
> +			#clock-cells = <0>;
> +			compatible = "altr,sysmgr-sdmmc-sdr";
> +			reg = <0x108 1>;

What's this reg?

Is # clock-cells required?

Neither were described in the binding.

Mark.
