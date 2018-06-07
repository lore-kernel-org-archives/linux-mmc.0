From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties details
Date: Thu, 7 Jun 2018 13:47:43 +0100
Message-ID: <20180607124743.fqo7f7nxonn2k3b5@lakrids.cambridge.arm.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
 <1528373500-24663-2-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528373500-24663-2-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <manish.narani@xilinx.com>
Cc: robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, mdf@kernel.org, stefan.krsmanovic@aggios.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, adrian.hunter@intel.com, michal.simek@xilinx.com, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 07, 2018 at 05:41:39PM +0530, Manish Narani wrote:
> This patch adds details of SD tap value properties in device tree.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 60481bf..0e08877 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -15,6 +15,8 @@ Required Properties:
>      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP Arasan SDHCI 8.9a PHY
> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> @@ -26,6 +28,30 @@ Required Properties for "arasan,sdhci-5.1":
>    - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
>    - phy-names:  MUST be "phy_arasan".
> 
> +Required Properties for "xlnx,zynqmp-8.9a":
> +  - xlnx,mio_bank: The value will be 0/1/2 depending on MIO bank selection.

For all of these properties, please s/_/-/, folowing the usual property
name conventions.

It's not clear to me why you need this property. The code in patch 3
only seems to use this to determine which properties to read, choosing
between <prop>_b0 or <prop>_b2. I don't see why you dont have the base
<prop> alone...

Is this a HW detail, or configuration that you prefer?

> +  - xlnx,device_id: Unique Id of the device, value will be 0/1.

What's this used for?

> +  - xlnx,itap_delay_sd_hsd: Input Tap Delay for SD HS.

What unit at hese delays in?

Please follow the conventions in
Documentation/devicetree/bindings/property-units.txt.

> +  - xlnx,itap_delay_sdr25: Input Tap Delay for SDR25.
> +  - xlnx,itap_delay_sdr50: Input Tap Delay for SDR50.
> +  - xlnx,itap_delay_sdr104_b0: Input Tap Delay for SDR104.
> +  - xlnx,itap_delay_sdr104_b2: Input Tap Delay for SDR104.

As above, Given you have to specify the bank, I don't see why you need
multiple properties.

Thanks,
Mark.

> +  - xlnx,itap_delay_sd_ddr50: Input Tap Delay for SD DDR50.
> +  - xlnx,itap_delay_mmc_hsd: Input Tap Delay for MMC HS.
> +  - xlnx,itap_delay_mmc_ddr50: Input Tap Delay for MMC DDR50.
> +  - xlnx,itap_delay_mmc_hs200_b0: Input Tap Delay for MMC HS200.
> +  - xlnx,itap_delay_mmc_hs200_b2: Input Tap Delay for MMC HS200.
> +  - xlnx,otap_delay_sd_hsd: Output Tap Delay for SD HS.
> +  - xlnx,otap_delay_sdr25: Output Tap Delay for SDR25.
> +  - xlnx,otap_delay_sdr50: Output Tap Delay for SDR50.
> +  - xlnx,otap_delay_sdr104_b0: Output Tap Delay for SDR104.
> +  - xlnx,otap_delay_sdr104_b2: Output Tap Delay for SDR104.
> +  - xlnx,otap_delay_sd_ddr50: Output Tap Delay for DDR50.
> +  - xlnx,otap_delay_mmc_hsd: Output Tap Delay for MMC HS.
> +  - xlnx,otap_delay_mmc_ddr50: Output Tap Delay for MMC DDR50.
> +  - xlnx,otap_delay_mmc_hs200_b0: Output Tap Delay for MMC HS200.
> +  - xlnx,otap_delay_mmc_hs200_b2: Output Tap Delay for MMC HS200.
> +
>  Optional Properties:
>    - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
>      used to access core corecfg registers.  Offsets of registers in this
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
