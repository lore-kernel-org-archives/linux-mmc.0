From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Thu, 25 Aug 2016 11:56:55 +0100
Message-ID: <20160825105640.GA5439@remoulade>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755850AbcHYK5C (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 25 Aug 2016 06:57:02 -0400
Content-Disposition: inline
In-Reply-To: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, lars@metafoo.de

On Wed, Aug 24, 2016 at 06:23:03PM -0500, Zach Brown wrote:
> The sdhci controller on xilinx zynq devices will not function unless
> the cd bit is provided. http://www.xilinx.com/support/answers/61064.html
> In cases where it is impossible to provide the cd bit in hardware,
> setting the controller to test mode and then setting inserted to true
> will get the controller to function with out the cd bit.
> 
> The device property "fake-cd" will let the arasan driver know it needs
> to fake the cd bit for the controller inorder for the controller to

Nit: s/inorder/in order/

Comments on the actual patch below.

> function with a SD card that does not provide the CD bit.
> 
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 3404afa..3b9f406 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -21,6 +21,10 @@ Required Properties:
>    - interrupts: Interrupt specifier
>    - interrupt-parent: Phandle for the interrupt controller that services
>  		      interrupts for this device.
> +Optional Properties:
> +- fake-cd: On Zynq Devices the SDHCI Controller will not work without the cd
> +  bit. When this option is set the driver will put the controller in test mode
> +  and fake the cd bit so it will function.

As Lars noted, the DT should describe the HW, and the policy of how to deal
with that should be left to the kernel. So from a DT perspective the above is
not correct.

If I understand the linked documentation, this is slightly different to typical
uses of broken-cd in that in the absence of a card detect signal the HW will
not be able to access the SD card at all, even if requested to. Is that correct?

If so, perhaps a better option is to have the combination of broken-cd and the
compatible string for this IP block imply that the test mode workaround is
required. Obviously that requires a fixup to the usual broken-cd binding to
remove the implication that polling alone must be used.

Thanks,
Mark.
