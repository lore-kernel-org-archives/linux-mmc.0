From: chaotian.jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 2/5] mmc: mediatek: Add Mediatek MMC driver
Date: Sun, 19 Apr 2015 11:22:41 +0800
Message-ID: <1429413761.16027.2.camel@mhfsdcap03>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
 <20150417134547.GN4946@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20150417134547.GN4946-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

Dear Sascha,


On Fri, 2015-04-17 at 15:45 +0200, Sascha Hauer wrote:
> Hi Chaotian,
> 
> On Tue, Mar 17, 2015 at 11:13:52AM +0800, Chaotian Jing wrote:
> > Add Mediatek MMC driver code
> > 
> 
> [...]
> 
> > +	host->dev = &pdev->dev;
> > +	host->mmc = mmc;
> > +	/* Set host parameters to mmc */
> > +	mmc->ops = &mt_msdc_ops;
> > +	mmc->f_min = 260000;
> > +	mmc->ocr_avail = MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33;
> > +
> > +	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> > +	/* MMC core transfer sizes tunable parameters */
> > +	mmc->max_segs = MAX_BD_NUM;
> > +	mmc->max_seg_size = 64 * 1024;
> 
> Earlier versions of this driver had 64 * 1024 - 512 here. Using 64k
> breaks SD card support here. Reading the partition table still works
> fine, but the next transfers fail with messages like:
> 
> mtk-msdc 11240000.mmc: msdc_request_timeout: aborting cmd/data/mrq
> mtk-msdc 11240000.mmc: msdc_request_timeout: aborting mrq=ffffffc06e586860 cmd=18
> mtk-msdc 11240000.mmc: msdc_request_timeout: abort data: cmd18; 136 blocks
> mmcblk1: error -110 transferring data, sector 338488, nr 136, cmd response 0x900, card status 0xb00
> mtk-msdc 11240000.mmc: set mclk to 0 mmc1: tried to reset card
> 
> Can you confirm this?
> 
Yes, it will be fixed at next revision.
Thx!
> Sascha
> 
