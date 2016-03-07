From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] Documentation: synopsys-dw-mshc: add binding for resets
Date: Mon, 07 Mar 2016 09:53:50 +0900
Message-ID: <56DCD11E.5000901@samsung.com>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47304 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbcCGAxx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2016 19:53:53 -0500
In-reply-to: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi Goudong,

On 03/06/2016 05:47 PM, Guodong Xu wrote:
> Add resets property to synopsys-dw-mshc bindings. It is intended to
> represent the hardware reset signal present internally in some host
> controller IC designs.
> 
> See Documentation/devicetree/bindings/reset/reset.txt for details.
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 8636f5a..4e00e85 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -39,6 +39,10 @@ Required Properties:
>  
>  Optional properties:
>  
> +* resets: phandle + reset specifier pair, intended to represent hardware
> +  reset signal present internally in some host controller IC designs.
> +  See Documentation/devicetree/bindings/reset/reset.txt for details.

Is this reset property for common dwmmc IP controller?

Best Regards,
Jaehoon Chung

> +
>  * clocks: from common clock binding: handle to biu and ciu clocks for the
>    bus interface unit clock and the card interface unit clock.
>  
> 

