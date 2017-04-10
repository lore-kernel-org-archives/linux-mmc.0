From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/2] mmc: host: s3cmci: allow probing from device tree
Date: Mon, 10 Apr 2017 15:53:06 +0200
Message-ID: <CAPDyKFqLKj5pyZpaN3VmMGT+5W1Vg9u=UgPuv=+B6ejCBwTMdA@mail.gmail.com>
References: <1491004256-13969-1-git-send-email-sergio.prado@e-labworks.com> <1491004256-13969-3-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491004256-13969-3-git-send-email-sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 1 April 2017 at 01:50, Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org> wrote:
> Allows configuring Samsung S3C24XX MMC/SD/SDIO controller using a device
> tree.
>
> Signed-off-by: Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>

Thanks, applied for next - however, by amending the change with the
fix from Arnd. See more below.

[...]

> +
> +       if (pdata->wprotect_invert);

The above semicolon is removed to fix the expression.

> +               mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> +

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
