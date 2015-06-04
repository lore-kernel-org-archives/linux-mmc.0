From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Thu, 4 Jun 2015 10:54:03 +0800
Message-ID: <1433386443.3304.2.camel@mhfsdcap03>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
 <20150519111558.GD6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20150519111558.GD6325-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-05-19 at 13:15 +0200, Sascha Hauer wrote:
> On Tue, May 19, 2015 at 02:36:46PM +0800, Chaotian Jing wrote:
> > Add Mediatek MMC driver code
> > Support eMMC/SD/SDIO
> > 
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/mmc/host/Kconfig  |    8 +
> >  drivers/mmc/host/Makefile |    1 +
> >  drivers/mmc/host/mtk-sd.c | 1422 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1431 insertions(+)
> >  create mode 100644 drivers/mmc/host/mtk-sd.c
> > 
> > +
> > +	host->src_clk = devm_clk_get(&pdev->dev, "source");
> > +	if (IS_ERR(host->src_clk)) {
> > +		ret = PTR_ERR(host->src_clk);
> > +		goto host_free;
> > +	}
> > +
> > +	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > +	if (IS_ERR(host->h_clk)) {
> > +		/* host->h_clk is optional, Only for MSDC0/3 at MT8173 */
> > +		dev_dbg(&pdev->dev,
> > +				"Invalied hclk from the device tree!\n");
> > +	}
> 
> s/Invalied/Invalid/
> 
> According to my reference manual the controller always needs a hclk. It
> seems on some controllers it is just not software controllable. If
> that's the case you should always provide a hclk to the driver and make
> this clock mandatory.
For MT8173, MSDC1, MSDC2's HCLK are in Infra, software cannot control
it. So just set the HCLK to clk_null ?

If it is, will set HCLK to clk_null at next revision, and the same
changes will make for MT8135.
> 
> Sascha
> 
