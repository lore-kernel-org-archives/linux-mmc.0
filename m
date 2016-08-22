From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: vub300: don't print error when allocating urb fails
Date: Mon, 22 Aug 2016 15:39:41 +0200
Message-ID: <CAPDyKFptBkb74Xepfps5TL6kkkkzDkKOkySMihOxzxd4yT_2-A@mail.gmail.com>
References: <1470949433-24707-1-git-send-email-wsa-dev@sang-engineering.com> <1470949433-24707-2-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34598 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755461AbcHVNjn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2016 09:39:43 -0400
Received: by mail-wm0-f42.google.com with SMTP id q128so21376138wma.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2016 06:39:43 -0700 (PDT)
In-Reply-To: <1470949433-24707-2-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Linux USB List <linux-usb@vger.kernel.org>, Tony Olech <tony.olech@elandigitalsystems.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 11 August 2016 at 23:03, Wolfram Sang <wsa-dev@sang-engineering.com> wrote:
> kmalloc will print enough information in case of failure.
>
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/vub300.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 1e819f98b94f52..bb3e0d1dd35501 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2116,13 +2116,11 @@ static int vub300_probe(struct usb_interface *interface,
>         command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
>         if (!command_out_urb) {
>                 retval = -ENOMEM;
> -               dev_err(&udev->dev, "not enough memory for command_out_urb\n");
>                 goto error0;
>         }
>         command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
>         if (!command_res_urb) {
>                 retval = -ENOMEM;
> -               dev_err(&udev->dev, "not enough memory for command_res_urb\n");
>                 goto error1;
>         }
>         /* this also allocates memory for our VUB300 mmc host device */
> --
> 2.8.1
>
