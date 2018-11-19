From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-cadence: include <linux/bits.h> instead of <linux/bitops.h>
Date: Mon, 19 Nov 2018 13:07:56 +0100
Message-ID: <CAPDyKFo_RckxWhp3+_NX5Mwd=VgWdszmj=7Di+VzTkvuwu0kFA@mail.gmail.com>
References: <1540897506-3075-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540897506-3075-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 30 October 2018 at 12:05, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The reason of including <linux/bitops.h> here is just for BIT() and
> GENMASK() macros.
>
> Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
> macros from <linux/bitops.h> to a new <linux/bits.h> file"),
> <linux/bits.h> is enough for such compile-time macros.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 7a343b8..e241287 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -14,7 +14,7 @@
>   */
>
>  #include <linux/bitfield.h>
> -#include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> --
> 2.7.4
>
