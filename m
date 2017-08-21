From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: vub300: constify usb_device_id
Date: Mon, 21 Aug 2017 14:33:16 +0200
Message-ID: <CAPDyKFoF0xK+3Z4VvECLN8xTyAsdO7UZfMWZdr7b5nGoidf2HQ@mail.gmail.com>
References: <a92e1ae63bb48adf6b7983ba3a150f9579444cc0.1502300918.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:37268 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753680AbdHUMdR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 08:33:17 -0400
Received: by mail-qt0-f170.google.com with SMTP id 16so81629468qtz.4
        for <linux-mmc@vger.kernel.org>; Mon, 21 Aug 2017 05:33:16 -0700 (PDT)
In-Reply-To: <a92e1ae63bb48adf6b7983ba3a150f9579444cc0.1502300918.git.arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 9 August 2017 at 19:50, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> usb_device_id are not supposed to change at runtime. All functions
> working with usb_device_id provided by <linux/usb.h> work with
> const usb_device_id. So mark the non-const structs as const.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/vub300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index fbeea1a..6c99102 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -266,7 +266,7 @@ MODULE_PARM_DESC(firmware_rom_wait_states,
>  #define ELAN_VENDOR_ID         0x2201
>  #define VUB300_VENDOR_ID       0x0424
>  #define VUB300_PRODUCT_ID      0x012C
> -static struct usb_device_id vub300_table[] = {
> +static const struct usb_device_id vub300_table[] = {
>         {USB_DEVICE(ELAN_VENDOR_ID, VUB300_PRODUCT_ID)},
>         {USB_DEVICE(VUB300_VENDOR_ID, VUB300_PRODUCT_ID)},
>         {} /* Terminating entry */
> --
> 2.7.4
>
