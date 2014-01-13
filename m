From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH Resend 1/7] mmc: ushc: Fix incorrect parameter in sizeof
Date: Mon, 13 Jan 2014 09:01:57 +0530
Message-ID: <CAK9yfHwuv2pmvoNJqmfRikuUg+k4QdbwMN_gPZxyqT+1zUGniA@mail.gmail.com>
References: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:57619 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaAMDb6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Jan 2014 22:31:58 -0500
Received: by mail-oa0-f44.google.com with SMTP id h16so7477035oag.3
        for <linux-mmc@vger.kernel.org>; Sun, 12 Jan 2014 19:31:58 -0800 (PST)
In-Reply-To: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Sachin Kamat <sachin.kamat@linaro.org>

On 19 December 2013 14:13, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> sizeof should be of the parent structure type.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: David Vrabel <david.vrabel@csr.com>
> ---
>  drivers/mmc/host/ushc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
> index c0105a2e269a..d2c386f09d69 100644
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


Gentle ping on this series, Chris.

-- 
With warm regards,
Sachin
