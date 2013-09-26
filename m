From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: ushc: Fix incorrect parameter in sizeof
Date: Thu, 26 Sep 2013 08:32:32 +0530
Message-ID: <CAK9yfHwbU83ZioTmHOGUjQj5ROpuqxxD_RF6+f8B5mgKtXAp2Q@mail.gmail.com>
References: <1378973653-12750-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35770 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab3IZDCd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Sep 2013 23:02:33 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so1213978obb.31
        for <linux-mmc@vger.kernel.org>; Wed, 25 Sep 2013 20:02:32 -0700 (PDT)
In-Reply-To: <1378973653-12750-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sachin Kamat <sachin.kamat@linaro.org>, David Vrabel <david.vrabel@csr.com>

Hi Chris,

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

Thanks for applying my other patches. Can you please check this one too?


-- 
With warm regards,
Sachin
