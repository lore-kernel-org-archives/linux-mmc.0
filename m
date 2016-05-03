From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] Documentation: mmc: add mmc-hs400-enhanced-strobe
Date: Tue, 3 May 2016 12:05:17 -0500
Message-ID: <20160503170517.GA31410@rob-hp-laptop>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
 <1461897960-28860-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461897960-28860-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 29, 2016 at 10:46:00AM +0800, Shawn Lin wrote:
> mmc-hs400-enhanced-strobe is used to claim that the
> host can support hs400 mode with enhanced strobe
> introduced by emmc 5.1 spec.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
