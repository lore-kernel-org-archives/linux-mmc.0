From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Properly set
 corecfg_clockmultiplier on rk3399
Date: Thu, 1 Sep 2016 15:50:13 +0300
Message-ID: <c09e2195-bd67-97fc-6494-d71f4b5e0f97@intel.com>
References: <1472201475-7970-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49863 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932589AbcIAMys (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 08:54:48 -0400
In-Reply-To: <1472201475-7970-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, xzy.xu@rock-chips.com, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>

On 26/08/16 11:51, Shawn Lin wrote:
> corecfg_clockmultiplier indicates clock multiplier value of
> programmable clock generator which should be the same value
> of SDHCI_CAPABILITIES_1. The default value of the register,
> corecfg_clockmultiplier, is 0x10. But actually it is a mistake
> by designer as our intention was to set it to be zero which
> means we don't support programmable clock generator. So we have
> to make it to be zero on bootloader which seems work fine until
> now. But now we find an issue that when deploying genpd support
> for it, the remove callback will trigger the genpd to poweroff the
> power domain for sdhci-of-arasan which manage the controller, phy
> and corecfg_* stuff.
> 
> So when we do bind/unbind the driver, we have already reinit
> the controller and phy, but without doing that for corecfg_*.
> Regarding to only the corecfg_clockmultipler is wrong, let's
> fix it by explicitly marking it to be zero when probing. With
> this change, we could do bind/unbind successfully.
> 
> Reported-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
