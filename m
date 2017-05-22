From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip-dw-mshc: add optional
 rockchip,desired-num-phases
Date: Mon, 22 May 2017 15:06:16 -0500
Message-ID: <20170522200616.6xymymk25eei6qd2@rob-hp-laptop>
References: <1494916134-68043-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33151 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762017AbdEVUGT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 16:06:19 -0400
Content-Disposition: inline
In-Reply-To: <1494916134-68043-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org

On Tue, May 16, 2017 at 02:28:53PM +0800, Shawn Lin wrote:
> By default, dw_mmc-rockchip will execute tuning for each degree.
> So we won't miss every point of the good sample windows. However,
> probably the phases are linear inside the good sample window.
> Actually we don't need to do tuning for each degree so that we could
> save some time, for instance, probe the driver or resume from S3.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - rename to rockchip,desired-num-phases
> 
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
