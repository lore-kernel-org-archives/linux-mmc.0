From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: vub300: Use common code in __download_offload_pseudocode()
Date: Mon, 30 Oct 2017 12:40:39 +0100
Message-ID: <CAPDyKFp6h_DAcDvDEMft_WApEakdPQiMw0v8t2fPVxS+H1KkOA@mail.gmail.com>
References: <7b418db1-ec35-4c85-5d06-45edde56822c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7b418db1-ec35-4c85-5d06-45edde56822c@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Tony Olech <tony.olech@elandigitalsystems.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 27 October 2017 at 21:31, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 27 Oct 2017 21:21:40 +0200
>
> Add a jump target so that a specific string copy operation is stored
> only once at the end of this function implementation.
> Replace two calls of the function "strncpy" by goto statements.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/vub300.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index c1a169843f99..c898a45a84c5 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -1244,12 +1244,8 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                                                 USB_RECIP_DEVICE, 0x0000, 0x0000,
>                                                 xfer_buffer, xfer_length, HZ);
>                         kfree(xfer_buffer);
> -                       if (retval < 0) {
> -                               strncpy(vub300->vub_name,
> -                                       "SDIO pseudocode download failed",
> -                                       sizeof(vub300->vub_name));
> -                               return;
> -                       }
> +                       if (retval < 0)
> +                               goto copy_error_message;
>                 } else {
>                         dev_err(&vub300->udev->dev,
>                                 "not enough memory for xfer buffer to send"
> @@ -1291,12 +1287,8 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                                                 USB_RECIP_DEVICE, 0x0000, 0x0000,
>                                                 xfer_buffer, xfer_length, HZ);
>                         kfree(xfer_buffer);
> -                       if (retval < 0) {
> -                               strncpy(vub300->vub_name,
> -                                       "SDIO pseudocode download failed",
> -                                       sizeof(vub300->vub_name));
> -                               return;
> -                       }
> +                       if (retval < 0)
> +                               goto copy_error_message;
>                 } else {
>                         dev_err(&vub300->udev->dev,
>                                 "not enough memory for xfer buffer to send"
> @@ -1349,6 +1341,12 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                         sizeof(vub300->vub_name));
>                 return;
>         }
> +
> +       return;
> +
> +copy_error_message:
> +       strncpy(vub300->vub_name, "SDIO pseudocode download failed",
> +               sizeof(vub300->vub_name));
>  }
>
>  /*
> --
> 2.14.3
>
