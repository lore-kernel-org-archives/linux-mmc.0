From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix DT binding documentation SDHCI left-over
Date: Mon, 28 Jan 2013 16:35:08 -0500
Message-ID: <87wqux6lf7.fsf@laptop.org>
References: <Pine.LNX.4.64.1301161719310.19928@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56458 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001Ab3A1Vfl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Jan 2013 16:35:41 -0500
In-Reply-To: <Pine.LNX.4.64.1301161719310.19928@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 16 Jan 2013 17:20:41 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi Guennadi,

On Wed, Jan 16 2013, Guennadi Liakhovetski wrote:
> The file Documentation/devicetree/bindings/mmc/mmc.txt is common for all
> MMC host drivers. Use a generic MMC host reference instead of an SDHCI
> left-over.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index a591c67..34f28ed 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -10,7 +10,7 @@ Required properties:
>  - bus-width: Number of data lines, can be <1>, <4>, or <8>
>  
>  Card detection:
> -If no property below is supplied, standard SDHCI card detect is used.
> +If no property below is supplied, host native card detect is used.
>  Only one of the properties in this section should be supplied:
>    - broken-cd: There is no card detection available; polling must be used.
>    - cd-gpios: Specify GPIOs for card detection, see gpio binding

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
