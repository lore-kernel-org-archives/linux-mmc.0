From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Documentation: mmc: sdhci-of-arasan: add
 description of power domain
Date: Fri, 16 Sep 2016 10:25:35 -0500
Message-ID: <20160916152535.GA6020@rob-hp-laptop>
References: <20160908064905.18080-1-xzy.xu@rock-chips.com>
 <20160908064905.18080-2-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160908064905.18080-2-xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 08, 2016 at 02:49:04PM +0800, Ziyuan Xu wrote:
> Add power domain as a optional property for sdhci-of-arasan, which can
> be truned off in the so-called unused condition, such as suspend and

s/truned/turned/

> remove. Aim to lower power requirements.
> 
> Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> ---
> 
> Changes in v2:
> - fix a typo
> - add an example code for power-domain
> 
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

With that,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
