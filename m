From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH Resend 01/10] mmc: ushc: Fix incorrect parameter in sizeof
Date: Tue, 25 Feb 2014 11:06:49 +0100
Message-ID: <CAPDyKFp-s4eXcBDC3xU1CBziWBW=ZA_Tqmgfne5avu=AqcDZOw@mail.gmail.com>
References: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59623 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbaBYKO6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 05:14:58 -0500
Received: by mail-qc0-f174.google.com with SMTP id e16so3382008qcx.5
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2014 02:14:58 -0800 (PST)
In-Reply-To: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 25 February 2014 10:48, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> sizeof should be of the parent structure type.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

For the hole series:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Hi Ulf / Chris,
>
> This series which is a re-send has been pending since a very long time.
> Hope to have this merged atleast during this cycle.
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
