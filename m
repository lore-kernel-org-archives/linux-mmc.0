From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 3/3] Documentation: mmc: Update Arasan SDHC documentation
 to support 4.9a version of Arasan SDHC controller.
Date: Mon, 4 May 2015 16:13:23 +0200
Message-ID: <eb09e430-53dd-47ac-8395-6b5becf62517@BN1AFFO11FD044.protection.gbl>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
 <1430746792-32574-4-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0076.outbound.protection.outlook.com ([207.46.100.76]:38560
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751934AbbEDONi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 May 2015 10:13:38 -0400
In-Reply-To: <1430746792-32574-4-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>, chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com

On 05/04/2015 03:39 PM, Suman Tripathi wrote:
> This patch updates Arasan SDHC documentation to support
> 4.9a version of Arasan SDHC controller.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 98ee2ab..6dd3d60 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> 
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> +                'arasan,sdhci-4.9a'
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> --
> 1.8.2.1
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
