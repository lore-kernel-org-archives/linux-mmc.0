From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: fix logically and structurally dead code
Date: Fri, 20 Apr 2018 00:42:36 +0900
Message-ID: <CAK7LNATQSOtJs6xcYXyRqXdAL-x-CBLVmfAozEEZGnZpzURR8g@mail.gmail.com>
References: <20180419135316.GA14790@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419135316.GA14790@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi.


2018-04-19 22:53 GMT+09:00 Gustavo A. R. Silva <gustavo@embeddedor.com>:
> Currently, the code block inside the for loop will never execute
> more than once, because the function returns inmediately after
> the first iteration, hence the execution of the code at the second
> iteration is structurally dead and, code at line 281: return 0; is
> never reached.
>
> Based on the code comments, it seems that the actual intention is
> to execute the code inside the for loop twice instead of once.

Thanks for the report.

> So, fix this issue by removing the return statement inside the for
> loop and replace the "return 0" with "return ret".
>
> Addresses-Coverity-ID: 1468009 ("Logically dead code")
> Addresses-Coverity-ID: 1468002 ("Structurally dead code")
> Fixes: 213fae74318b ("mmc: sdhci-cadence: send tune request twice to
> work around errata")


Probably, this Fixes tag will dangle.

Ulf usually repeats git-rebase to build-up his pull-request.

The addressed commit was already rebased,
and its commit ID will change a few more times
since it is now -rc1.


A clean solution would be, to squash a fix-up into the original patch.
(This patch is not what I want, though.)

If you want to claim contribution in a separate patch,
please rewrite the code as I suggested,
and drop the Fixes tag.



> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index bc30d16..facbad8 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -275,10 +275,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>                                          !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
>                                          0, 1);
>
> -               return ret;
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
> --

No.
I want to confirm that the operation succeeds twice.

Your code hides any error in the first loop.



My intention is like follows:



 --- a/drivers/mmc/host/sdhci-cadence.c
 +++ b/drivers/mmc/host/sdhci-cadence.c
 @@ -275,10 +275,9 @@ static int sdhci_cdns_set_tune_val(struct
sdhci_host *host, unsigned int val)
                                          !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
                                          0, 1);
 -
 -               return ret;
 +               if (ret)
 +                       return ret;
         }

         return 0;
  }

  static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)



-- 
Best Regards
Masahiro Yamada
