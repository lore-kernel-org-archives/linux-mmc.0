From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH  v2 4/4] mmc: sdhci-s3c: remove the duplicated calling sequence
Date: Thu, 29 Aug 2013 21:37:57 -0400
Message-ID: <87wqn4vtze.fsf@octavius.laptop.org>
References: <51FBBD7E.2090700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52904 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089Ab3H3BiC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2013 21:38:02 -0400
In-Reply-To: <51FBBD7E.2090700@samsung.com> (Jaehoon Chung's message of "Fri,
	02 Aug 2013 23:09:02 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>

Hi,

On Fri, Aug 02 2013, Jaehoon Chung wrote:
> Didn't need to call the sdhci_s3c_notify_change in setup_card_detect_=
gpio().
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changelog v2:
> 	- Added acked/tested by Heiko (on s3c2416)
>
>  drivers/mmc/host/sdhci-s3c.c |   26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index f974778..c4ea802 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -409,20 +409,18 @@ static void sdhci_s3c_setup_card_detect_gpio(st=
ruct sdhci_s3c *sc)
>  	if (devm_gpio_request(dev, pdata->ext_cd_gpio, "SDHCI EXT CD") =3D=3D=
 0) {
>  		sc->ext_cd_gpio =3D pdata->ext_cd_gpio;
>  		sc->ext_cd_irq =3D gpio_to_irq(pdata->ext_cd_gpio);
> -		if (sc->ext_cd_irq &&
> -		    request_threaded_irq(sc->ext_cd_irq, NULL,
> -					 sdhci_s3c_gpio_card_detect_thread,
> -					 IRQF_TRIGGER_RISING |
> -					 IRQF_TRIGGER_FALLING |
> -					 IRQF_ONESHOT,
> -					 dev_name(dev), sc) =3D=3D 0) {
> -			int status =3D gpio_get_value(sc->ext_cd_gpio);
> -			if (pdata->ext_cd_gpio_invert)
> -				status =3D !status;
> -			sdhci_s3c_notify_change(sc->pdev, status);
> -		} else {
> -			dev_warn(dev, "cannot request irq for card detect\n");
> -			sc->ext_cd_irq =3D 0;
> +		if (sc->ext_cd_irq) {
> +			ret =3D request_threaded_irq(sc->ext_cd_irq, NULL,
> +					sdhci_s3c_gpio_card_detect_thread,
> +					IRQF_TRIGGER_RISING |
> +					IRQF_TRIGGER_FALLING |
> +					IRQF_ONESHOT,
> +					dev_name(dev), sc);
> +			if (ret) {
> +				dev_warn(dev,
> +					"cannot request irq for card detect\n");
> +				sc->ext_cd_irq =3D 0;
> +			}
>  		}
>  	} else {
>  		dev_err(dev, "cannot request gpio for card detect\n");

Jaehoon, this is really bad.  Heiko's ACK was conditional on fixing
the error below:

/home/cjb/git/mmc/drivers/mmc/host/sdhci-s3c.c: In function =E2=80=98sd=
hci_s3c_setup_card_detect_gpio=E2=80=99:
/home/cjb/git/mmc/drivers/mmc/host/sdhci-s3c.c:422:4: error: =E2=80=98r=
et=E2=80=99 undeclared (first use in this function)

But you reposted the same patch with his ACK and no fix.

I don't mind the part where you probably didn't read his email
carefully -- I'm much more concerned that you've now submitted a
patch to me twice that you've apparently never compiled yourself.
I need you to compile and test all of the patches you send me.

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
