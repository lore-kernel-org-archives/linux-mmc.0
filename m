From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] drivers: mmc: Mark the function
 sdhci_disable_irq_wakeups() as static in sdhci.c
Date: Sat, 14 Dec 2013 13:00:24 -0800
Message-ID: <20131214210024.GV17601@leaf>
References: <20131214131631.GA8543@rashika>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131214131631.GA8543@rashika>
Sender: linux-kernel-owner@vger.kernel.org
To: Rashika Kheria <rashika.kheria@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Dec 14, 2013 at 06:46:31PM +0530, Rashika Kheria wrote:
> This patch marks the function sdhci_disable_irq_wakeups() as static i=
n
> host/sdhci.c because it is not used outside this file.
>=20
> Thus, it also eliminates the following warning in host/sdhci.c:
> drivers/mmc/host/sdhci.c:2553:6: warning: no previous prototype for =E2=
=80=98sdhci_disable_irq_wakeups=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>

This function has an EXPORT_SYMBOL_GPL, making it available for use
elsewhere in the kernel.  However, nothing in the kernel actually
*calls* this function, other than the one internal call in
sdhci_resume_host.  Thus, I'd suggest making this function static as yo=
u
have in this patch, and additionally deleting the EXPORT_SYMBOL_GPL for
it.

With that change:
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bd8a098..8de50e8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2550,7 +2550,7 @@ void sdhci_enable_irq_wakeups(struct sdhci_host=
 *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
> =20
> -void sdhci_disable_irq_wakeups(struct sdhci_host *host)
> +static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
>  {
>  	u8 val;
>  	u8 mask =3D SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
> --=20
> 1.7.9.5
>=20
