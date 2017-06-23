From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
Date: Fri, 23 Jun 2017 13:52:45 -0500
Message-ID: <20170623185245.e4frut72cf6jhzb4@rob-hp-laptop>
References: <20170616124544.15046-1-kishon@ti.com>
 <20170616124544.15046-13-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170616124544.15046-13-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 16, 2017 at 06:15:40PM +0530, Kishon Vijay Abraham I wrote:
> The data manual of J6/J6 Eco recommends to set different IODELAY values
> depending on the mode in which the MMC/SD is enumerated in order to
> ensure IO timings are met.
> 
> Add support to set the IODELAY values depending on the various MMC
> modes using the pinctrl APIs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   5 +

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/mmc/host/omap_hsmmc.c                      | 152 ++++++++++++++++++++-
>  2 files changed, 154 insertions(+), 3 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
