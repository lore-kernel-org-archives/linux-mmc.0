From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon support for DCFG node
Date: Tue, 8 Dec 2015 11:46:21 -0600
Message-ID: <1449596781.15946.126.camel@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	 <1448594417-22515-5-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0142.outbound.protection.outlook.com ([157.56.110.142]:16608
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750733AbbLHSCC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Dec 2015 13:02:02 -0500
In-Reply-To: <1448594417-22515-5-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com

On Fri, 2015-11-27 at 11:20 +0800, Yangbo Lu wrote:
> Add syscon support for DCFG node, so that the driver could use
> syscon regmap interface to access the device config module registers.
> And the CONFIG_MFD_SYSCON should be enabled for this.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- Added this patch
> ---
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> index 68c4ead..5f148b2 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> @@ -941,7 +941,9 @@
>  /include/ "qoriq-mpic4.3.dtsi"
>  
>  	guts: global-utilities@e0000 {
> -		compatible = "fsl,t4240-device-config", "fsl,qoriq-device
> -config-2.0";
> +		compatible = "fsl,t4240-device-config",
> +				"fsl,qoriq-device-config-2.0",
> +				"syscon";


I really don't like changing the device tree based on Linux internals.  It
also means that the workaround wouldn't work for users that don't upgrade
their device tree.  I definitely don't like one QorIQ chip having "syscon" on
the dcfg node but others not having it.

The guts driver should just maintain a list of compatibles to match.  Why do
we need to use syscon, rather than a guts driver that exports an fsl_get_svr()
function?

-Scott

