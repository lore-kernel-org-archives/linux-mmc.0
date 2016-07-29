From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/5] Documentation: mmc: synopsys-dw-mshc: add power
 domain description
Date: Fri, 29 Jul 2016 16:43:28 -0500
Message-ID: <20160729214328.GA20468@rob-hp-laptop>
References: <1469765703-30999-1-git-send-email-shawn.lin@rock-chips.com>
 <1469765703-30999-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35310 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbcG2Vna (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2016 17:43:30 -0400
Content-Disposition: inline
In-Reply-To: <1469765703-30999-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Feng Xiao <xf@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org

On Fri, Jul 29, 2016 at 12:14:59PM +0800, Shawn Lin wrote:
> This patch adds power domain as a optional property for dw_mmc.
> We should handle the power domain if available as it's in off
> state dut to the policy of power-saving after booting up. Otherwise
> dw_mmc can not be accessed.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
