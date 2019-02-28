From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct the fix of ERR004536
Date: Thu, 28 Feb 2019 10:19:08 +0100
Message-ID: <CAPDyKFqWqBgCX3iB8U5S_DAER8G-gw+N9Ow-4mtvEb-nVfzAeQ@mail.gmail.com>
References: <20190228080859.32520-1-haibo.chen@nxp.com> <CAPDyKFp1_gp8BXQrHYpS09NQFR=SWB61O9-tqsSbq8+Mo3S8JA@mail.gmail.com>
 <VI1PR04MB50403160E8138D0E3790875890750@VI1PR04MB5040.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB50403160E8138D0E3790875890750@VI1PR04MB5040.eurprd04.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: BOUGH CHEN <haibo.chen@nxp.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, Aisheng Dong <aisheng.dong@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 28 Feb 2019 at 09:41, BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > Sent: 2019=E5=B9=B42=E6=9C=8828=E6=97=A5 16:25
> > To: BOUGH CHEN <haibo.chen@nxp.com>
> > Cc: adrian.hunter@intel.com; Aisheng Dong <aisheng.dong@nxp.com>;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > linux-mmc@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct the fix of ERR004536
> >
> > On Thu, 28 Feb 2019 at 09:01, BOUGH CHEN <haibo.chen@nxp.com> wrote:
> > >
> > > Commit 18094430d6b5 ("mmc: sdhci-esdhc-imx: add ADMA Length
> > Mismatch
> > > errata fix") involve the fix of ERR004536, but the fix is incorrect.
> > > Double confirm with IC, need to clear the bit 7 of register 0x6c
> > > rather than set this bit 7.
> > > Here is the definition of bit 7 of 0x6c:
> > >     0: enable the new IC fix for ERR004536
> > >     1: do not use the IC fix, keep the same as before
> > >
> > > Due to the reset value of this bit 7 is 0, ROM code and bootloader do
> > > not touch this bit 7, so here directly remove the operation of this
> > > bit 7, make sure the fix of ERR004536 can work.
> >
> > Well, rather than relying on the bootloader, let the kernel do the righ=
t thing.
> > That is, write a zero to the register bit rather than a one.
> >
> > Is the code doing that?
> >
>
> Yes, write a zero to the register bit is correct.
> Why I just remove the code rather than directly write 0 to this bit is be=
cause the register 0x6c should be invisible to software, and is not defined=
 in reference manual. It is a register only open for IC to test.
> If you prefer to write a zero to the register bit, I can do that.

I think that would be more safe, so yes, please.

[...]

Kind regards
Uffe
