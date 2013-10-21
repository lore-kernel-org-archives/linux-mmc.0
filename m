From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: ushc: Fix incorrect parameter in sizeof
Date: Mon, 21 Oct 2013 08:38:43 +0530
Message-ID: <CAK9yfHyrAeD-+a1DsjBKgHONDBAWdpGphLbu4m5vJhA0oa+CyQ@mail.gmail.com>
References: <1378973653-12750-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61141 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3JUDIn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Oct 2013 23:08:43 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so6060731pdj.6
        for <linux-mmc@vger.kernel.org>; Sun, 20 Oct 2013 20:08:43 -0700 (PDT)
In-Reply-To: <1378973653-12750-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sachin Kamat <sachin.kamat@linaro.org>

On 12 September 2013 13:44, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> sizeof should be of the parent structure type.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: David Vrabel <david.vrabel@csr.com>
> ---
> Compile tested.
> ---
>  drivers/mmc/host/ushc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
> index c0105a2..d2c386f 100644
> --- a/drivers/mmc/host/ushc.c
> +++ b/drivers/mmc/host/ushc.c
> @@ -504,7 +504,7 @@ static int ushc_probe(struct usb_interface *intf, const struct usb_device_id *id
>                 ret = -ENOMEM;
>                 goto err;
>         }
> -       ushc->csw = kzalloc(sizeof(struct ushc_cbw), GFP_KERNEL);
> +       ushc->csw = kzalloc(sizeof(struct ushc_csw), GFP_KERNEL);
>         if (ushc->csw == NULL) {
>                 ret = -ENOMEM;
>                 goto err;
> --
> 1.7.9.5
>

Gentle ping ...

-- 
With warm regards,
Sachin
