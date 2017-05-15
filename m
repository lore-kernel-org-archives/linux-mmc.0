From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: vub3000: add missing USB-descriptor endianness conversions
Date: Mon, 15 May 2017 12:51:38 +0200
Message-ID: <CAPDyKFp-ehvqFtd+Q=+B=j2_ke1qE8ahXv6ejm+RcQ0ARNBcdA@mail.gmail.com>
References: <20170512100335.1637-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170512100335.1637-1-johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Olech <tony.olech-ze5PQcJzaeOs0fm86SgGizGjJy/sRE9J@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12 May 2017 at 12:03, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Add the missing endianness conversions when printing the USB
> device-descriptor idVendor and idProduct fields during probe.
>
> Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/vub300.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index c061e7c704be..fbeea1a491a6 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2107,7 +2107,8 @@ static int vub300_probe(struct usb_interface *interface,
>         usb_string(udev, udev->descriptor.iSerialNumber, serial_number,
>                    sizeof(serial_number));
>         dev_info(&udev->dev, "probing VID:PID(%04X:%04X) %s %s %s\n",
> -                udev->descriptor.idVendor, udev->descriptor.idProduct,
> +                le16_to_cpu(udev->descriptor.idVendor),
> +                le16_to_cpu(udev->descriptor.idProduct),
>                  manufacturer, product, serial_number);
>         command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
>         if (!command_out_urb) {
> --
> 2.13.0
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
