From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 31/54] MAINTAINERS: Add file patterns for mmc device tree bindings
Date: Fri, 3 Jun 2016 10:33:42 +0200
Message-ID: <CAPDyKFrhEm1djhfUnTnFfbFz-VoyAEm+rkV31CbND+CtoMs=dg@mail.gmail.com>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org> <1463907991-7916-32-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463907991-7916-32-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 May 2016 at 11:06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Thanks, applied for next!

Kind regards
Uffe

> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1e413b2c61a9746..f296a5763fef0431 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7739,6 +7739,7 @@ M:        Ulf Hansson <ulf.hansson@linaro.org>
>  L:     linux-mmc@vger.kernel.org
>  T:     git git://git.linaro.org/people/ulf.hansson/mmc.git
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/mmc/
>  F:     drivers/mmc/
>  F:     include/linux/mmc/
>  F:     include/uapi/linux/mmc/
> --
> 1.9.1
>
