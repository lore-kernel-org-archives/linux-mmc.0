From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 13/13] Documentation: synopsys-dw-mshc: remove the unused
 properties
Date: Thu, 10 Nov 2016 12:47:17 -0600
Message-ID: <20161110184717.vgkp2flyi26dmbfo@rob-hp-laptop>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103062135.10697-14-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161103062135.10697-14-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 03, 2016 at 03:21:35PM +0900, Jaehoon Chung wrote:
> "support-highspeed" was the obsoleted property.
> And "broken-cd" is not synopsys specific property.
> It can be referred to mmc.txt binding Documentation.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
