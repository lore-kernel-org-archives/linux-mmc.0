From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] Documentation: synopsys-dw-mshc: add binding for
 resets
Date: Fri, 4 Mar 2016 22:28:11 -0600
Message-ID: <20160305042811.GR13525@rob-hp-laptop>
References: <1456968818-22140-1-git-send-email-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48190 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760744AbcCEE2Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Mar 2016 23:28:16 -0500
Content-Disposition: inline
In-Reply-To: <1456968818-22140-1-git-send-email-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Thu, Mar 03, 2016 at 09:33:37AM +0800, Guodong Xu wrote:
> Add resets property to synopsys-dw-mshc bindings. It is intended to
> represent the hardware reset signal present internally in some host
> controller IC designs.
> 
> See Documentation/devicetree/bindings/reset/reset.txt for details.
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 8636f5a..9b4896c 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -39,6 +39,10 @@ Required Properties:
>  
>  Optional properties:
>  
> +* resets: phandle + reset specifier pair, intended to represent hardware
> +  reset signal present internally in some host controller IC designs.
> +  See Documentation/devicetree/bindings/reset/reset.txt for details.
> +
>  * clocks: from common clock binding: handle to biu and ciu clocks for the
>    bus interface unit clock and the card interface unit clock.
>  
> @@ -48,7 +52,7 @@ Optional properties:
>    clock-frequency.  It is an error to omit both the ciu clock and the
>    clock-frequency.
>  
> -* clock-frequency: should be the frequency (in Hz) of the ciu clock.  If this
> +* clock-frequency: should be tke frequency (in Hz) of the ciu clock.  If this

You've added a typo here.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
