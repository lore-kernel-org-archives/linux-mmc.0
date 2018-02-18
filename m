From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH v1] mmc: core: Re-use DEFINE_SHOW_ATTRIBUTE() macro
Date: Sun, 18 Feb 2018 08:22:31 +0000
Message-ID: <DM5PR04MB1085CA70C39889351887D380FCC90@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <20180214154512.53739-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51351 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBRIWe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Feb 2018 03:22:34 -0500
In-Reply-To: <20180214154512.53739-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Andy Shevchenko
> Sent: Wednesday, February 14, 2018 5:45 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>; Linus Walleij
> <linus.walleij@linaro.org>; linux-mmc@vger.kernel.org
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Subject: [PATCH v1] mmc: core: Re-use DEFINE_SHOW_ATTRIBUTE() macro
>=20
> ...instead of open coding file operations followed by custom ->open()
> callbacks per each attribute.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Looks fine.
Cheers,
Avri

> ---
>  drivers/mmc/core/debugfs.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c inde=
x
> 0f4a7d7b2626..c51e0c044a3e 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -196,18 +196,7 @@ static int mmc_ios_show(struct seq_file *s, void
> *data)
>=20
>  	return 0;
>  }
> -
> -static int mmc_ios_open(struct inode *inode, struct file *file) -{
> -	return single_open(file, mmc_ios_show, inode->i_private);
> -}
> -
> -static const struct file_operations mmc_ios_fops =3D {
> -	.open		=3D mmc_ios_open,
> -	.read		=3D seq_read,
> -	.llseek		=3D seq_lseek,
> -	.release	=3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(mmc_ios);
>=20
>  static int mmc_clock_opt_get(void *data, u64 *val)  {
> --
> 2.15.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
