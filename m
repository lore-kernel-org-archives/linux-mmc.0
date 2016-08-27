From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH RFC 0/3] mmc: mxs-mmc: Implement DDR support
Date: Sat, 27 Aug 2016 21:15:22 +0200 (CEST)
Message-ID: <1082892691.24336.3dd5cc50-579f-4f46-b1de-7868392729ec.open-xchange@email.1und1.de>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470488140-10104-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Otavio Salvador <otavio-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>, Holger Schurig <holgerschurig-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

> Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> hat am 6. August 2016 um 14:55
> geschrieben:
> 
> 
> Based on these discussions: [1], [2] this patch series implements
> DDR support for the MXS MMC host driver. This feature has never been
> ported from the vendor kernel.
> 
> It has been tested on a i.MX28 board with eMMC which is currently
> not in mainline (Duckbill 2).
> 
> * without DDR support
> dd if=/dev/zero of=test bs=8k count=10000
> 81920000 bytes (82 MB) copied, 14.3321 s, 5.7 MB/s
> 
> * with DDR support:
> dd if=/dev/zero of=test bs=8k count=10000
> 81920000 bytes (82 MB) copied, 13.4781 s, 6.1 MB/s
> 
> [1] - http://www.spinics.net/lists/linux-mmc/msg32285.html
> [2] - http://www.spinics.net/lists/linux-mmc/msg34418.html

do you want to add some comments about this series?

Regards
Stefan

> 
> Stefan Wahren (3):
>   DT: bindings: mmc: Add property for 3.3V only support
>   mmc: core: add new cap for 3.3V only DDR MMCs
>   mmc: mxs-mmc: Implement DDR support
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt |    7 +++++--
>  drivers/mmc/core/host.c                       |    2 ++
>  drivers/mmc/core/mmc.c                        |    6 ++++++
>  drivers/mmc/host/mxs-mmc.c                    |   22 ++++++++++++++++++++++
>  include/linux/mmc/host.h                      |    1 +
>  5 files changed, 36 insertions(+), 2 deletions(-)
> 
> -- 
> 1.7.9.5
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
