From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Fri, 22 Apr 2016 15:27:33 -0500
Message-ID: <20160422202733.GA11270@rob-hp-laptop>
References: <cover.1461246772.git.larper@axis.com>
 <a96281244b55d55e36b72a40cd061d7ffd70b88e.1461246772.git.larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33677 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbcDVU1i (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2016 16:27:38 -0400
Content-Disposition: inline
In-Reply-To: <a96281244b55d55e36b72a40cd061d7ffd70b88e.1461246772.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, g.liakhovetski@gmx.de, ulf.hansson@linaro.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

On Thu, Apr 21, 2016 at 03:55:42PM +0200, Lars Persson wrote:
> Add a pinctrl binding to specify different pin settings for high speed
> modes and UHS modes.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
> index 8babdaa..6d1b797 100644
> --- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
> +++ b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
> @@ -12,6 +12,12 @@ Optional properties:
>  
>  - vmmc-supply:	a phandle of a regulator, supplying Vcc to the card
>  - vqmmc-supply:	a phandle of a regulator, supplying VccQ to the card
> +- pinctrl-names: Can contain a "default" entry and a "state_uhs"

Don't use underscores. Just "uhs" should be sufficient, right?

> +                 entry. The state_uhs entry is used together with the default
> +                 entry when the board requires distinct settings for UHS speeds.
> +
> +- pinctrl-N: One property for each name listed in pinctrl-names, see
> +             ../pinctrl/pinctrl-bindings.txt.
>  
>  Additionally any standard mmc bindings from mmc.txt can be used.
>  
> -- 
> 2.1.4
> 
