From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 04/15] mmc: support embedded data field in mmc_host
Date: Tue, 6 Jul 2010 18:49:24 +0300
Message-ID: <AANLkTilfjBIbylUDKlTGiEC_U6pJnkC6HoENOzK2eFFq@mail.gmail.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-5-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1278376666-3509-5-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, San Mehat <san@google.com>, Ohad Ben-Cohen <ohadb@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 6, 2010 at 3:37 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> From: Ohad Ben-Cohen <ohadb@ti.com>
>
> Add support to set/get mmc_host private embedded
> data.
>
> This is needed to allow software to dynamically
> create (and remove) SDIO functions which represents
> embedded SDIO devices.
>
> Typically, it will be used to set the context of
> a driver that is creating a new SDIO function
> (and would then expect to be able to get that context
> back upon creation of the new sdio func).
>
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> ---
> =A0drivers/mmc/core/Kconfig | =A0 =A08 ++++++++
> =A0include/linux/mmc/host.h | =A0 16 ++++++++++++++++
> =A02 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index bb22ffd..ab27eb3 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -16,3 +16,11 @@ config MMC_UNSAFE_RESUME
>
> =A0 =A0 =A0 =A0 =A0This option sets a default which can be overridden=
 by the
> =A0 =A0 =A0 =A0 =A0module parameter "removable=3D0" or "removable=3D1=
".
> +
> +config MMC_EMBEDDED_SDIO
> + =A0 =A0 =A0 boolean "MMC embedded SDIO device support"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say Y here, support will be added for embedd=
ed SDIO
> + =A0 =A0 =A0 =A0 devices (e.g. hardwired embedded WLAN SDIO devices)=
=2E
> + =A0 =A0 =A0 =A0 Such devices require software support for emulating
> + =A0 =A0 =A0 =A0 card detect events.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f65913c..9a48486 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -209,6 +209,10 @@ struct mmc_host {
> =A0 =A0 =A0 =A0struct led_trigger =A0 =A0 =A0*led; =A0 =A0 =A0 =A0 =A0=
 /* activity led */
> =A0#endif
>
> +#ifdef CONFIG_MMC_EMBEDDED_SDIO
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*embedded_d=
ata;
> +#endif
> +

Hm, do we really need a Kconfig option just for a single pointer? It
only saves sizeof(void *) bytes per host, but adds rather confusing
config option for users and some ifdef complexity.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
