From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting support
Date: Mon, 6 Jul 2015 03:05:47 +0000
Message-ID: <BY1PR03MB138801E1ECE136F138F7D4A99A930@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
 <1433926244-29244-3-git-send-email-haibo.chen@freescale.com>
 <20150703111017.GA17553@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150703111017.GA17553@localhost>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: "Dong A.S." <Aisheng.Dong@freescale.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, July 03, 2015 7:10 PM
> To: Chen Haibo-B51421
> Cc: linux-mmc@vger.kernel.org; Dong Aisheng-B29396;
> ulf.hansson@linaro.org; chris@printf.net; shawn.guo@linaro.org; linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
> support
> 
> On Wed, Jun 10, 2015 at 04:50:40PM +0800, Haibo Chen wrote:
> > @@ -969,6 +976,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device
> *pdev,
> >
> >  	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
> >
> > +	of_property_read_u32(np, "tuning-step", &boarddata->tuning_step);
> > +
> 
> Where is the binding doc for this device tree property?
> 
> Shawn

I will add this in next version, Thanks for your review.


Haibo
