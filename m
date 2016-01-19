From: Rob Herring <robh@kernel.org>
Subject: Re: [LINUX PATCH 4/5] Documentation: mmc: Updated the binding doc
 for Arasan SDHCI.
Date: Tue, 19 Jan 2016 11:16:11 -0600
Message-ID: <20160119171611.GA2708@rob-hp-laptop>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-4-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51495 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297AbcASRQR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Jan 2016 12:16:17 -0500
Content-Disposition: inline
In-Reply-To: <1453213055-35563-4-git-send-email-lakshmis@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>, Emil Lenchak <emill@xilinx.com>, Tobias Klauser <tklauser@distanz.ch>, Sudeep Holla <Sudeep.Holla@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Haibo Chen <haibo.chen@freescale.com>, Marek Vasut <marex@denx.de>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org, Harini Katakam <harini>

On Tue, Jan 19, 2016 at 07:47:34PM +0530, P L Sai Krishna wrote:
> This patch adds broken-mmc-highspeed property to the binding
> doc for Arasan SDHCI.
> 
> Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 2088d9f..5884832 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -20,7 +20,8 @@ Required Properties:
>  Optional Properties:
>    - broken-tuning: Indicates tuning broken in Silicon 1.0 of
>  			  Zynq Ultrascale+ MPSoC.
> -
> +  - broken-mmc-highspeed: Indicates to force
> +				the controller to use in standard speed.

We already have the inverse of this with "cap-mmc-highspeed".

The only potential problem is it will need to be added to existing DTs 
if you start disabling high speed by default. Maybe that's not an issue 
for users of the Arasan driver.

Otherwise, you should determine this with a more specific compatible 
string.

Rob
