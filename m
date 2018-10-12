From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v2 1/4] dt: bindings: Add SD tap value properties
 details for 'xlnx,zynqmp-8.9a'
Date: Fri, 12 Oct 2018 11:29:56 -0500
Message-ID: <20181012162956.GA7339@bogus>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
 <1537435845-6682-2-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537435845-6682-2-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <manish.narani@xilinx.com>
Cc: ulf.hansson@linaro.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, amit.kucheria@linaro.org, sudeep.holla@arm.com, leoyang.li@nxp.com, jollys@xilinx.com, rajanv@xilinx.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 20, 2018 at 03:00:42PM +0530, Manish Narani wrote:
> Add documentation for MIO bank required property and Tap Delays optional
> properties in devicetree bindings.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 72769e0..6cc95fa 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -27,6 +27,7 @@ Required Properties for "arasan,sdhci-5.1":
>  
>  Required Properties for "xlnx,zynqmp-8.9a":
>    - xlnx,device_id: SD controller device ID. Must be either <0> or <1>.
> +  - xlnx,mio-bank: The value will be 0/1/2 depending on MIO bank selection.
>  
>  Optional Properties:
>    - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
> @@ -44,6 +45,24 @@ Optional Properties:
>    - xlnx,int-clock-stable-broken: when present, the controller always reports
>      that the internal clock is stable even when it is not.
>  
> +Optional Properties for "xlnx,zynqmp-8.9a":
> + - xlnx,itap-delay-sd-hsd: Input Tap Delay for SD HS.
> + - xlnx,itap-delay-sdr25: Input Tap Delay for SDR25.
> + - xlnx,itap-delay-sdr50: Input Tap Delay for SDR50.
> + - xlnx,itap-delay-sdr104: Input Tap Delay for SDR104.
> + - xlnx,itap-delay-sd-ddr50: Input Tap Delay for SD DDR50.
> + - xlnx,itap-delay-mmc-hsd: Input Tap Delay for MMC HS.
> + - xlnx,itap-delay-mmc-ddr52: Input Tap Delay for MMC DDR52.
> + - xlnx,itap-delay-mmc-hs200: Input Tap Delay for MMC HS200.
> + - xlnx,otap-delay-sd-hsd: Output Tap Delay for SD HS.
> + - xlnx,otap-delay-sdr25: Output Tap Delay for SDR25.
> + - xlnx,otap-delay-sdr50: Output Tap Delay for SDR50.
> + - xlnx,otap-delay-sdr104: Output Tap Delay for SDR104.
> + - xlnx,otap-delay-sd-ddr50: Output Tap Delay for DDR50.
> + - xlnx,otap-delay-mmc-hsd: Output Tap Delay for MMC HS.
> + - xlnx,otap-delay-mmc-ddr52: Output Tap Delay for MMC DDR52.
> + - xlnx,otap-delay-mmc-hs200: Output Tap Delay for MMC HS200.

type, values, units for all of these?

Perhaps combine to pairs of values for input and output delays?

> +
>  Example:
>  	sdhci@e0100000 {
>  		compatible = "arasan,sdhci-8.9a";
> -- 
> 2.1.1
> 
