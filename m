From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: ushc: fix NULL-deref at probe
Date: Thu, 16 Mar 2017 15:46:25 +0100
Message-ID: <CAPDyKFpGQ-Kf39jc9cgWGeQb7PNActRXMOzYAX+szXfhb+fruw@mail.gmail.com>
References: <20170313124022.28401-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170313124022.28401-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, David Vrabel <david.vrabel@csr.com>
List-Id: linux-mmc@vger.kernel.org

On 13 March 2017 at 13:40, Johan Hovold <johan@kernel.org> wrote:
> Make sure to check the number of endpoints to avoid dereferencing a
> NULL-pointer should a malicious device lack endpoints.
>
> Fixes: 53f3a9e26ed5 ("mmc: USB SD Host Controller (USHC) driver")
> Cc: stable <stable@vger.kernel.org>     # 2.6.37
> Cc: David Vrabel <david.vrabel@csr.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/ushc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
> index d2c386f09d69..1d843357422e 100644
> --- a/drivers/mmc/host/ushc.c
> +++ b/drivers/mmc/host/ushc.c
> @@ -426,6 +426,9 @@ static int ushc_probe(struct usb_interface *intf, const struct usb_device_id *id
>         struct ushc_data *ushc;
>         int ret;
>
> +       if (intf->cur_altsetting->desc.bNumEndpoints < 1)
> +               return -ENODEV;
> +
>         mmc = mmc_alloc_host(sizeof(struct ushc_data), &intf->dev);
>         if (mmc == NULL)
>                 return -ENOMEM;
> --
> 2.12.0
>
