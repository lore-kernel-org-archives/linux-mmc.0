From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCHv5 2/3] ARM: socfpga: dts: Add support for SD/MMC
Date: Tue, 27 Aug 2013 17:31:22 +0200
Message-ID: <20130827153122.GH24795@pengutronix.de>
References: <1377272686-13253-1-git-send-email-dinguyen@altera.com>
 <1377272686-13253-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53905 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab3H0Pbo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2013 11:31:44 -0400
Content-Disposition: inline
In-Reply-To: <1377272686-13253-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi!

On Fri, Aug 23, 2013 at 10:44:45AM -0500, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> 
> v5:
> - Add "altr,ciu-clk-offset" that represents the necessary offset
>   and shift values in the sysmgr phandle. This is used to set
>   the correct CIU clock values.
> 
> v4:
> - Add a complete binding example in documentations
> - Add a phandle entry for "altr,sysmgr" which links the system
>   manager to the SD/MMC IP block that controls the SDR timings.
> - Split up patches
>         1/3 - Add syscon binding to sys-mgr node
>         2/3 - DTS bindings and documentation for SD/MMC on SOCFPGA
>         3/3 - Driver changes to use the bindings
> 
> v3:
> - Explicitly reference synopsis-dw-mshc.txt for base bindings
> - Remove "dw-mshc-ciu-div" as driver can get clock information dts "ciu" entry
> - Fixed indentation issue
> 
> v2:
> - Remove bus-width and extra line in documentation
> - Merge bindings example into a single node in documentation
> ---

You should put your changelogs here and not above the ---
AFAIK nobody cares for the development history of a patch once it is applied.

>  .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   63 ++++++++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   11 ++++
>  arch/arm/boot/dts/socfpga_cyclone5.dts             |   14 +++++
>  arch/arm/boot/dts/socfpga_vt.dts                   |   14 +++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
