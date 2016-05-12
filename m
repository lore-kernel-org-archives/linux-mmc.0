From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3] mmc: dw_mmc: rockchip: Set the drive phase properly
Date: Fri, 13 May 2016 00:52:51 +0200
Message-ID: <2865073.LogD6IIKLp@phil>
References: <1463077910-25914-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34368 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcELWxI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 May 2016 18:53:08 -0400
In-Reply-To: <1463077910-25914-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: jh80.chung@samsung.com, Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org, briannorris@chromium.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Am Donnerstag, 12. Mai 2016, 11:31:50 schrieb Douglas Anderson:

[...]

> In commit 7a03fe6f48f3 ("clk: rockchip: reset init state before mmc card
> initialization") we actually started setting this explicitly in the
> kernel, but that commit wasn't quite right and also wasn't quite
> enough.  See <https://patchwork.kernel.org/patch/9085311/> for some
> details.
> 
> Let's explicitly set this phase in dw_mmc.

[...]

> Fixes: 7a03fe6f48f3 ("clk: rockchip: reset init state before mmc card
> initialization") Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

I've tested this patch together with the two clock patches linked above on a 
rk3288-firefly and a rk3288-veyron-jerry. On the firefly tuning still does not 
work (probably really some regulator issue) and on veyron tuning still works 
as expected, so

Tested-by: Heiko Stuebner <heiko@sntech.de>

Doug's explanations both in the commit message and the code look sane to me, 
but I don't feel confident enough in my understanding of the matter to 
transform that into a Reviewed-by tag.


Heiko
