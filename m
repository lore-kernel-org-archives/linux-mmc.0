From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v5 1/2] Documentation: bindings: add description
 of phy for sdhci-of-arasan
Date: Tue, 23 Feb 2016 14:29:12 -0600
Message-ID: <20160223202912.GA12557@rob-hp-laptop>
References: <1455848322-2210-1-git-send-email-shawn.lin@rock-chips.com>
 <1455848387-2251-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455848387-2251-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 19, 2016 at 10:19:47AM +0800, Shawn Lin wrote:
> This patch adds phys and phy-names for sdhci-of-arasan as required
> properties for arasan,sdhci-5.1, and details the example as well.
> 
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> ---
> 
> Changes in v2:
> - Keep phy as a mandatory requirement for arasan,sdhci-5.1
> 
>  .../devicetree/bindings/mmc/arasan,sdhci.txt         | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
