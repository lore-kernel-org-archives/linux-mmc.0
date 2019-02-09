From: Fabio Estevam <festevam@gmail.com>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock is disabled
Date: Sat, 9 Feb 2019 15:15:20 -0200
Message-ID: <CAOMZO5DrtgQzjY7_9SCM_NKbKPxQyHBQNN+pmUPrqtFkARPdUg@mail.gmail.com>
References: <20190207225211.GA17552@latitude> <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
 <20190209162449.GB2061@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190209162449.GB2061@latitude>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-clk <linux-clk@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@intel.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Michael Turquette <mturquette@baylibre.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Feb 9, 2019 at 2:25 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> On Thu, Feb 07, 2019 at 10:50:28PM -0200, Fabio Estevam wrote:
> > On Thu, Feb 7, 2019 at 8:52 PM Jonathan Neusch=C3=A4fer
> [...]
> > > I tried to compare the CCM's clocks between i.MX50 and i.MX53, but
> > > unfortunately, the i.MX50 reference manual doesn't have the table cal=
led
> > > "Output clocks from CCM".
> >
> > Please check Table 5-10. CCM_CCGR3 Gated Clock Mapping to Target
> > Module from the MX50 Referene Manual.
>
> Ok, the tables show:
>
> For i.MX50:
> [1:0] 0 ipg_clk_root    eSDHCv2_1

and it also shows that ahb_clk_root is controlled by these same bits.

That's why I added the ahb entry in my suggestion.

> [3:2] 1 esdhc1_clk_root eSDHCv2_1
>
> For i.MX53:
> 1=E2=80=930 CG0 esdhc1_ipg_hclk: affects ipg_clk and hclk inputs of ESDEH=
C-1 (esdhc1_clk_enable)
> 3=E2=80=932 CG1 esdhc1_perclk:   affects ipg_clk_perclk   input  of ESDEH=
C-1 (esdhc1_serial_clk_enable)
>
> Table 18-3 (Output clocks from CCM) in the iMX53RM shows that
> ESDHCv2-1's ipg_clk_perclk is esdhc1_clk_root, so the clock structure
> does seem to be the same here, between i.MX50 and i.MX53=E2=80=A6

That's correct. The esdhc clocks seem to differ.
