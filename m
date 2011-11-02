From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Fix build for hsmmc
Date: Wed, 2 Nov 2011 19:57:08 +0100
Message-ID: <CABoOg6wtN-t-DRKCWukauMQZ=FRDUcVRxVAVaaYco+sWAqT3Ug@mail.gmail.com>
References: <20111102170619.GJ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111102170619.GJ31337@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hello Tony, hello
Chris,https://mail.google.com/mail/?shva=3D1#label/linux-omap/133653efb=
30ae047

isn't this already fixed?

http://marc.info/?l=3Dlinux-omap&m=3D131991921316862&w=3D2

[PATCH] omap_hsmmc: fix missing parenthesis in pr_info

Thomas

On Wed, Nov 2, 2011 at 6:06 PM, Tony Lindgren <tony@atomide.com> wrote:
> Commit a3c76eb9d4a1e68a69dd880cf0bcb8a52418b993 (mmc: replace
> printk with appropriate display macro) does not compile:
>
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_protect_card':
> drivers/mmc/host/omap_hsmmc.c:1273: error: 'pr_info' undeclared (firs=
t use in this function)
> drivers/mmc/host/omap_hsmmc.c:1273: error: (Each undeclared identifie=
r is reported only once
> drivers/mmc/host/omap_hsmmc.c:1273: error: for each function it appea=
rs in.)
> drivers/mmc/host/omap_hsmmc.c:1273: error: expected ';' before string=
 constant
> drivers/mmc/host/omap_hsmmc.c:1275: error: expected statement before =
')' token
> distcc[15197] ERROR: compile drivers/mmc/host/omap_hsmmc.c on localho=
st failed
>
> Cc: Girish K S <girish.shivananjappa@linaro.org>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap=
_hsmmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->protect_card) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info"%s: cover is op=
en, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: cover is o=
pen, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "card is now inaccessible\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host->mmc));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->protect_card =3D=
 1;
>
