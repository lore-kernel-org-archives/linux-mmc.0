From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 0/2] mmc: host: s3cmci: add device tree support
Date: Fri, 24 Mar 2017 08:18:49 +0100
Message-ID: <CAPDyKFqMJHfBSdcQe9DNk430c3yXz+zqoS8C+b7yiv4P=D5dJw@mail.gmail.com>
References: <1489799633-29278-1-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489799633-29278-1-git-send-email-sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 18 March 2017 at 02:13, Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org> wrote:
> This series adds support for configuring Samsung's S3C24XX MMC/SD/SDIO
> controller via device tree.
>
> Tested on FriendlyARM mini2440, based on s3c2440 SoC.
>
> Changes since v4 (as suggested by Jaehoon Chung):
> - using just a flag as a data structure for the driver to check for
>   s3c2400 compatibility
>
> Changes since v3 (as suggested by Rob Herring):
> - describing properties that wasn't documented and removing unnecessary
>   comment in the device tree binding
>
> Changes since v2:
> - struct "s3cmci_drv_data" and flag "is2440" renamed
> - copying the whole driver data struct instead of only its member so
>   it will be easier to extend the information in the future
> - using mmc_of_parse() to read "cd-gpios" and "wp-gpios" properties
>   from device tree
>
> Changes since v1:
> - pinctrl description removed from DT binding
> - unit and label on DT binding renamed to mmc
>
> Sergio Prado (2):
>   dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
>   mmc: host: s3cmci: allow probing from device tree
>
>  .../devicetree/bindings/mmc/samsung,s3cmci.txt     |  42 ++++
>  drivers/mmc/host/s3cmci.c                          | 257 ++++++++++-----------
>  2 files changed, 168 insertions(+), 131 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
>
> --
> 1.9.1
>


Thanks, applied for next!

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
