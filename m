From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 1/4] mmc: sdio: Keep card runtime resumed while adding
 function devices
Date: Mon, 24 Apr 2017 23:03:15 +0200
Message-ID: <CAPDyKFqkj_Tb6zA2e8RZ_pGsLErqvDdSYyC-mKfVanZimfkmFA@mail.gmail.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com> <1492769288-7474-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1492769288-7474-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

On 21 April 2017 at 12:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Drivers core will runtime suspend a device with no driver. That means the
> SDIO card will be runtime suspended as soon as it is added. It is then
> runtime resumed to add each function. That is entirely pointless, so add

I totally agree! You are touching the part of the PM code for SDIO
that is severely broken in my view.

The mmc core shouldn't mess with runtime PM for func device at all,
except setting up the parent-child relationship. Instead runtime PM
for the func device should be solely handled by the func driver.

> pm runtime get/put to keep the SDIO card runtime resumed until the function
> devices have been added.
>
> This also benefits the hibernation use-case whereby we want to avoid the
> SDIO reset that is done as part of runtime resume. In that case, the SDIO
> card state is preserved at boot time by avoiding loading any function
> drivers before restoring the hibernation image.

This seems like a different issue. I guess this is because the func
driver don't implement the PM callbacks, which makes the mmc core to
remove the sdio card at mmc_pm_notify().

The proper solution here is to make the sdio func driver to implement
the PM callbacks.

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/sdio.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index fae732c870a9..97bedde0610c 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1110,6 +1110,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>                 if (err)
>                         goto remove;
>
> +               pm_runtime_get_noresume(&card->dev);
> +
>                 /*
>                  * Enable runtime PM for this card
>                  */
> @@ -1129,7 +1131,7 @@ int mmc_attach_sdio(struct mmc_host *host)
>         for (i = 0; i < funcs; i++, card->sdio_funcs++) {
>                 err = sdio_init_func(host->card, i + 1);
>                 if (err)
> -                       goto remove;
> +                       goto remove_get;
>
>                 /*
>                  * Enable Runtime PM for this func (if supported)
> @@ -1156,6 +1158,10 @@ int mmc_attach_sdio(struct mmc_host *host)
>         }
>
>         mmc_claim_host(host);
> +
> +       if (host->caps & MMC_CAP_POWER_OFF_CARD)
> +               pm_runtime_put(&card->dev);
> +
>         return 0;
>
>
> @@ -1163,6 +1169,9 @@ int mmc_attach_sdio(struct mmc_host *host)
>         /* Remove without lock if the device has been added. */
>         mmc_sdio_remove(host);
>         mmc_claim_host(host);
> +remove_get:
> +       if (host->caps & MMC_CAP_POWER_OFF_CARD)
> +               pm_runtime_put(&card->dev);
>  remove:
>         /* And with lock if it hasn't been added. */
>         mmc_release_host(host);
> --
> 1.9.1
>

Overall this looks okay to me. Except for the changelog that is a bit
miss-leading.

Kind regards
Uffe
