From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 01/12] mmc: dt-bindings: Add reg/source_cg/latch-ck
 for Mediatek MMC bindings
Date: Mon, 23 Oct 2017 17:36:12 -0500
Message-ID: <20171023223612.uzl52ux26nuujkt3@rob-hp-laptop>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
 <1508118399-21828-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1508118399-21828-2-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 16, 2017 at 09:46:28AM +0800, Chaotian Jing wrote:
> Change the comptiable for support of multi-platform
> Make compatible explicit, as MMC host of mt8173 has difference with
> mt8135(mt8173 supports hs400 and hs400_tune),so that need separate
> mt8173/mt8135 compatible name.
> Add description for reg
> Add description for source_cg
> Add description for mediatek,latch-ck
> Note that source_cg and mediatek,latch-ck are optional for some projects,
> eg, MT2701 do not have source_cg, and MT2712 do not need
> mediatek,latch-ck
> 
> Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
