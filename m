From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 2/5] mmc: mediatek: Add Mediatek MMC driver
Date: Fri, 17 Apr 2015 11:12:13 +0200
Message-ID: <20150417091213.GM4946@pengutronix.de>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFoUg1snXeOwCiKPF_daxAAfcWE0nUbRAj23Z=k9z5FCyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoUg1snXeOwCiKPF_daxAAfcWE0nUbRAj23Z=k9z5FCyA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, bin.zhang@mediatek.com, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infrade>
List-Id: linux-mmc@vger.kernel.org

Ulf,

On Tue, Mar 31, 2015 at 02:23:06PM +0200, Ulf Hansson wrote:
> On 17 March 2015 at 04:13, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > +
> > +       msdc_set_buswidth(host, ios->bus_width);
> > +
> > +       /* Suspend/Resume will do power off/on */
> > +       switch (ios->power_mode) {
> > +       case MMC_POWER_UP:
> > +               msdc_init_hw(host);
> > +               if (!IS_ERR(mmc->supply.vmmc)) {
> > +                       ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> > +                                       ios->vdd);
> > +                       if (ret) {
> > +                               dev_err(host->dev, "Failed to set vmmc power!\n");
> > +                               return;
> > +                       }
> > +               }
> > +               break;
> > +       case MMC_POWER_ON:
> > +               if (!IS_ERR(mmc->supply.vqmmc)) {
> > +                       ret = regulator_enable(mmc->supply.vqmmc);
> 
> The calls to regulator_enable|disable() for the vqmmc will not be
> balanced properly here. You need a local cache variable like
> "is_enabled" to keep track of this.

Shouldn't the MMC core provide balanced hooks for this? What about
MMC_POWER_UP, can this be used for enabling regulators?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
