From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Add broken-cd devicetree property
Date: Sat, 6 Apr 2013 17:06:54 +0200
Message-ID: <201304061706.54320.marex@denx.de>
References: <1365255828-6416-1-git-send-email-aletes.xgr@gmail.com> <51602A0B.6020405@pengutronix.de> <CAAAP30Gmc+aR1AY2Grd_M5LyXUO9szMxoLLA62ROq7=Hzz3ZEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAAP30Gmc+aR1AY2Grd_M5LyXUO9szMxoLLA62ROq7=Hzz3ZEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, fabio.estevam@freescale.com, Otavio Salvador <otavio@ossystems.com.br>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Dear Alexandre Pereira da Silva,

> On Sat, Apr 6, 2013 at 10:58 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > According to the documentation broken card detect is something different
> > 
> > than non-removable:
> > >   - broken-cd: There is no card detection available; polling must be
> > >   used. - non-removable: non-removable slot (like eMMC); assume always
> > >   present.
> > 
> > But mxs-mmc set MMC_CAP_NEEDS_POLL unconditionally.
> 
> I will work on a better way to fix this.

NEEDS_POLL looks nice and seems to fit this case.

Best regards,
Marek Vasut
