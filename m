From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
Date: Tue, 13 Aug 2013 13:52:17 -0600
Message-ID: <520A8E71.4090508@wwwdotorg.org>
References: <1376322589-17606-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:49695 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757862Ab3HMTwW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Aug 2013 15:52:22 -0400
In-Reply-To: <1376322589-17606-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/12/2013 09:49 AM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> Add "syscon" to the "altr,sys-mgr" binding.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

I think it's reasonable to define one binding as being based on another
plus some additions, so, the binding,
Acked-by: Stephen Warren <swarren@nvidia.com>

> +Example:
> +	dwmmc0@ff704000 {
> +		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> +		altr,dw-mshc-sdr-timing = <0 3>;
> +	};

It'd be nice to provide a complete example though, rather than only
including the properties that this binding adds to the base binding.

> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi

>  		sysmgr@ffd08000 {
> -				compatible = "altr,sys-mgr";
> +				compatible = "altr,sys-mgr", "syscon";

That seems like an unrelated change?
