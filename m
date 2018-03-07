From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH v6] mmc: Export host capabilities to debugfs.
Date: Wed, 7 Mar 2018 06:40:44 +0000
Message-ID: <DM5PR04MB10857D9F0177C760047100D1FCD80@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1520401051-11135-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520401051-11135-1-git-send-email-harish_kandiga@mentor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Harish Jenny K N [mailto:harish_kandiga@mentor.com]
> Sent: Wednesday, March 07, 2018 7:38 AM
> To: ulf.hansson@linaro.org; linus.walleij@linaro.org;
> adrian.hunter@intel.com; shawn.lin@rock-chips.com; Avri Altman
> <Avri.Altman@wdc.com>; andriy.shevchenko@linux.intel.com
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> harish_kandiga@mentor.com; Vladimir_Zapolskiy@mentor.com
> Subject: [PATCH v6] mmc: Export host capabilities to debugfs.
>=20
> This patch exports the host capabilities to debugfs
>=20
> This idea of sharing host capabilities over debugfs came up from Abbas Ra=
za
> <Abbas_Raza@mentor.com> Earlier discussions:
> https://lkml.org/lkml/2018/3/5/357
> https://www.spinics.net/lists/linux-mmc/msg48219.html
>=20
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
>=20
>=20
> +static int mmc_caps_show(struct seq_file *s, void *unused) {
> +	struct mmc_host *host =3D s->private;
> +	u32 caps =3D host->caps;
> +
> +	seq_puts(s, "\nMMC Host capabilities are:\n");
> +	seq_puts(s,
> "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +	seq_printf(s, "Can the host do 4 bit transfers :\t%s\n",
> +		   ((caps & MMC_CAP_4_BIT_DATA) ? "Yes" : "No"));

Maybe use a more compact form, and just call a macro with the applicable (s=
tringified) bit?


Thanks,
Avri
