From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH Resend 1/7] mmc: ushc: Fix incorrect parameter in sizeof
Date: Wed, 27 Nov 2013 08:35:57 +0530
Message-ID: <CAK9yfHw=TpLz4DQqDHwZAmB38QJEcYU9-XeumjwA7+hn00Z7rA@mail.gmail.com>
References: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:33094 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab3K0DF6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Nov 2013 22:05:58 -0500
Received: by mail-oa0-f52.google.com with SMTP id h16so6886912oag.25
        for <linux-mmc@vger.kernel.org>; Tue, 26 Nov 2013 19:05:58 -0800 (PST)
In-Reply-To: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Sachin Kamat <sachin.kamat@linaro.org>

On 30 October 2013 17:13, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> sizeof should be of the parent structure type.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: David Vrabel <david.vrabel@csr.com>
> ---
> Chris,
> Resending the pending patches with appropriate acks.
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

Chris,
Can you please look into this series? Let me know if you want me to resend them.


-- 
With warm regards,
Sachin
