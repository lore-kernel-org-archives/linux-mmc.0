From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Documentation: dw-mshc: deprecate num-slots
Date: Mon, 24 Jul 2017 13:01:48 -0500
Message-ID: <20170724180148.3lkyjkyj7vgcjgwd@rob-hp-laptop>
References: <1500366698-117167-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1500366698-117167-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 18, 2017 at 04:31:38PM +0800, Shawn Lin wrote:
> dwmmc host driver already deprecate it in the driver
> but didn't modify the documentation to reflect the fact.
> This patch deprecates it and clean up num-slots from the
> examples of all variant host drivers.
> 
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt |  1 -
>  Documentation/devicetree/bindings/mmc/img-dw-mshc.txt    |  1 -
>  Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt     |  2 --
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt         | 16 +++++++---------
>  Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt     |  1 -
>  5 files changed, 7 insertions(+), 14 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
