From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH v2] Fix HS setting in mmc_hs400_to_hs200()
Date: Sat, 23 Feb 2019 14:42:46 +0800
Message-ID: <1550904166.16070.33.camel@mhfsdcap03>
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Avri Altman <avri.altman@wdc.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Hongjie Fang <hongjiefang@asrmicro.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

this is just a ping, do you have any comments of this series of
patches ?

Thx!

On Fri, 2019-02-15 at 13:59 +0800, Chaotian Jing wrote:
> Change vs v1:
>   do not retry CMD6 in __mmc_switch()
>   do not move the reduce clock operation after switch HS
> 
> Chaotian Jing (2):
>   mmc: core: do not retry CMD6 in __mmc_switch()
>   mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
> 
>  drivers/mmc/core/mmc.c     | 21 +++++++++++++++++++--
>  drivers/mmc/core/mmc_ops.c |  2 +-
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
