From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] ARM: dts: imx51-babbage: fix esdhc cd/wp properties
Date: Wed, 22 Aug 2012 10:02:48 -0400
Message-ID: <87pq6j3tyv.fsf@octavius.laptop.org>
References: <1345643887-30606-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51354 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab2HVOCw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Aug 2012 10:02:52 -0400
In-Reply-To: <1345643887-30606-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Wed, 22 Aug 2012 21:58:07 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

(removing stable@ from e-mail)

On Wed, Aug 22 2012, Shawn Guo wrote:
> The binding doc and dts use properties "fsl,{cd,wp}-internal" while
> esdhc driver uses "fsl,{cd,wp}-controller".  Fix binding doc and dts
> to get them match driver code.
>
> Reported-by: Chris Ball <cjb@laptop.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: <stable@vger.kernel.org>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    8 ++++----
>  arch/arm/boot/dts/imx51-babbage.dts                |    4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Want to take this through your own tree, to avoid .dts conflicts later?
If so:

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
