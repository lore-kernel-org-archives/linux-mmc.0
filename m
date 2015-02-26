From: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/4] Add support for IPROC SDHCI controller
Date: Thu, 26 Feb 2015 09:28:06 -0800
Message-ID: <54EF57A6.8070607@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com> <1423526791-29453-1-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423526791-29453-1-git-send-email-sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Corneliu Doban <cdoban-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazao <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

I have not heard any more feedback on this patchset.  Is it in your 
queue to review or merge into your tree?

Thanks,
  Scott

On 15-02-09 04:06 PM, Scott Branden wrote:
> This series of patchsets contains the IPROC SDHCI driver used
> in a series of Broadcom SoCs
> Quirks are also added to support this controller.
>
> Corneliu Doban (1):
>    mmc: sdhci: do not set AUTO_CMD12 for multi-block CMD53
>
> Scott Branden (3):
>    mmc: sdhci: add quirk for ACMD23 broken
>    mmc: sdhci-iproc: add IPROC SDHCI driver
>    mmc: sdhci-iproc: add device tree bindings
>
>   .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  23 ++
>   drivers/mmc/host/Kconfig                           |  14 ++
>   drivers/mmc/host/Makefile                          |   1 +
>   drivers/mmc/host/sdhci-iproc.c                     | 241 +++++++++++++++++++++
>   drivers/mmc/host/sdhci.c                           |   7 +-
>   include/linux/mmc/sdhci.h                          |   2 +
>   6 files changed, 286 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>   create mode 100644 drivers/mmc/host/sdhci-iproc.c
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
