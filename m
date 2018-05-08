From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] brcmfmac: Add support for bcm43364 wireless chipset
Date: Tue, 8 May 2018 09:58:34 +0200
Message-ID: <CAPDyKFr62-+EF_GRbUSa=VOQfYa3c3HHZCR_LsN67k1yVkNNFw@mail.gmail.com>
References: <1525416503-832-1-git-send-email-sean@lano.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1525416503-832-1-git-send-email-sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>, Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Franky Lin <franky.lin-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Hante Meuleman <hante.meuleman-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chi-Hsien Lin <chi-hsien.lin-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Wright Feng <wright.feng-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brcm80211-dev-list-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 4 May 2018 at 08:48, Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org> wrote:
> Add support for the BCM43364 chipset via an SDIO interface, as used in
> e.g. the Murata 1FX module.
>
> The BCM43364 uses the same firmware as the BCM43430 (which is already
> included), the only difference is the omission of Bluetooth.
>
> However, the SDIO_ID for the BCM43364 is 02D0:A9A4, giving it a MODALIAS
> of sdio:c00v02D0dA9A4, which doesn't get recognised and hence doesn't
> load the brcmfmac module. Adding the 'A9A4' ID in the appropriate place
> triggers the brcmfmac driver to load, and then correctly use the
> firmware file 'brcmfmac43430-sdio.bin'.
>
>
> Signed-off-by: Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>

Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Arend, I assume you want to pick this up? If not, just tell and I can do it.

Kind regards
Uffe

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
>  include/linux/mmc/sdio_ids.h                              | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index 0b68240..4648a3d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -963,6 +963,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
>         BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43340),
>         BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43341),
>         BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43362),
> +       BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43364),
>         BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339),
>         BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339),
>         BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430),
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index cdd66a5..0a7abe8 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -35,6 +35,7 @@
>  #define SDIO_DEVICE_ID_BROADCOM_4335_4339      0x4335
>  #define SDIO_DEVICE_ID_BROADCOM_4339           0x4339
>  #define SDIO_DEVICE_ID_BROADCOM_43362          0xa962
> +#define SDIO_DEVICE_ID_BROADCOM_43364          0xa9a4
>  #define SDIO_DEVICE_ID_BROADCOM_43430          0xa9a6
>  #define SDIO_DEVICE_ID_BROADCOM_4345           0x4345
>  #define SDIO_DEVICE_ID_BROADCOM_43455          0xa9bf
> --
> 2.7.4
>
