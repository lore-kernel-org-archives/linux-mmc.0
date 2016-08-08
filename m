From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 0/6] Add support of inverting power control and some
 minor cleanup
Date: Mon, 08 Aug 2016 19:24:31 +0900
Message-ID: <ee997311-3964-8623-a431-c9a5add7f991@samsung.com>
References: <CGME20160807013720epcas1p235628058a90efa6f0062b03a4b2e4284@epcas1p2.samsung.com>
 <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On 08/07/2016 10:33 AM, Shawn Lin wrote:
> By default, dw_mmc outputs high level voltage to indicate powering
> up the card and outputs low level vcltage to indicate powering
> off the card. But that is not always correct. The power io should
> be able to control different kind of hw components to supply or
> cutoff power to the card. We have boards that need this patchset
> to make the power control correct. Meanwhile let's expose it to
> DT for board-specific usage.

I have a question for this patch-set. Does DWMMC IP support to invert ON/OFF at Power Enable register?
Hmm..Well, if use the DW_MMC_CARD_PWR_INVERT, it should also be the similar behavior with Quirks.

Other flags are related with dwmmc IP. But this flag (DW_MMC_CARD_PWR_INVERT) is not related with IP side.
I understood why you needs to add this flag..Is rockchip designed to invert the power controlling?

But it's not general case. We can discuss about this.

Best Regards,
Jaehoon Chung

> 
> 
> Changes in v2:
> - fix copy-paste err and typo
> 
> Shawn Lin (6):
>   dt-bindings: rockchip-dw-mshc: add description of
>     rockchip,power-invert
>   mmc: dw_mmc: cleanup power setting of set_ios callback
>   mmc: dw_mmc: split out dw_mci_set_power
>   mmc: dw_mmc: split out dw_mci_set_power_reg
>   mmc: dw_mmc: support inverted power control
>   mmc: dw_mmc-rockchip: add parsing of power control from DT
> 
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   6 +
>  drivers/mmc/host/dw_mmc-rockchip.c                 |   8 ++
>  drivers/mmc/host/dw_mmc.c                          | 134 ++++++++++++---------
>  drivers/mmc/host/dw_mmc.h                          |   1 +
>  4 files changed, 90 insertions(+), 59 deletions(-)
> 
