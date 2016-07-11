From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] Documentation: mmc: add description for new no-sd*
 and no-mmc
Date: Mon, 11 Jul 2016 08:57:35 -0500
Message-ID: <20160711135735.GA18339@rob-hp-laptop>
References: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
 <1467359130-11409-4-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35256 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933664AbcGKN5j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2016 09:57:39 -0400
Content-Disposition: inline
In-Reply-To: <1467359130-11409-4-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org

On Fri, Jul 01, 2016 at 03:45:30PM +0800, Shawn Lin wrote:
> This patch adds description for no-sd, no-sdio, no-mmc. We
> expect the specific boards adds these in DT to improve
> the initialization. For instance, for a soldered eMMC slot,
> we could skip sending SDIO and SD commands to probe its card
> types as it's always should be the type fo MMC card.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index ecc007a..b2046c6 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -49,6 +49,9 @@ Optional properties:
>  - mmc-hs400-enhanced-strobe: eMMC HS400 enhanced strobe mode is supported
>  - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
>    programmed with. Valid range: [0 .. 0xffff].
> +- no-sdio: skip sending sdio cmd during initialization
> +- no-sd: skip sending sd cmd during initialization
> +- no-mmc: skip sending mmc cmd during initialization

I still have issue with the description for these properties and the 
commit msg. They are fine if described as controller limitations as Ulf 
described. If folks want to (ab)use the properties for just skipping 
init, then that's their problem.

Rob
