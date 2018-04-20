From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-cadence: fix logically and structurally
 dead code
Date: Fri, 20 Apr 2018 09:10:13 +0200
Message-ID: <CAPDyKFq-BzzMjYrnDwrmKiKm_L=8dq-G_Mtx+pbpG0qqgHgerg@mail.gmail.com>
References: <20180419155958.GA18593@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419155958.GA18593@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 April 2018 at 17:59, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> Currently, the code block inside the for loop will never execute
> more than once, because the function returns inmediately after
> the first iteration, hence the execution of the code at the second
> iteration is structurally dead and, code at line 281: return 0; is
> never reached.
>
> Fix this by checking _ret_ before return.
>
> Addresses-Coverity-ID: 1468009 ("Logically dead code")
> Addresses-Coverity-ID: 1468002 ("Structurally dead code")
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, applied for next and by fixing the minor spelling mistake in
the changelog.

Kind regards
Uffe

> ---
> Changes in v2:
>  - Update changelog.
>  - Drop the 'Fixes' tag.
>  - Add check on ret instead of removing the "return ret;" line.
>  - Thanks to Masahiro Yamada for the feedback provided.
>
>  drivers/mmc/host/sdhci-cadence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index bc30d16..7a343b8 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -274,8 +274,8 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>                 ret = readl_poll_timeout(reg, tmp,
>                                          !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
>                                          0, 1);
> -
> -               return ret;
> +               if (ret)
> +                       return ret;
>         }
>
>         return 0;
> --
> 2.7.4
>
