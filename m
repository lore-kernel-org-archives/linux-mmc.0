From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: usdhi6rol0: mark expected switch fall-throughs
Date: Thu, 21 Mar 2019 11:46:28 +0100
Message-ID: <CAPDyKFq7Qcp+WZazg2CiB_nBV7Bsmns2aD-Na_k72Kk9sf9X2g@mail.gmail.com>
References: <20190320200010.GA14527@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190320200010.GA14527@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 20 Mar 2019 at 21:02, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> In file included from drivers/mmc/host/usdhi6rol0.c:9:
> drivers/mmc/host/usdhi6rol0.c: In function =E2=80=98usdhi6_timeout_work=
=E2=80=99:
> ./include/linux/device.h:1483:2: warning: this statement may fall through=
 [-Wimplicit-fallthrough=3D]
>   _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1689:3: note: in expansion of macro =E2=80=
=98dev_err=E2=80=99
>    dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
>    ^~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1691:2: note: here
>   case USDHI6_WAIT_FOR_CMD:
>   ^~~~
> drivers/mmc/host/usdhi6rol0.c:1711:3: warning: this statement may fall th=
rough [-Wimplicit-fallthrough=3D]
>    usdhi6_sg_unmap(host, true);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1716:2: note: here
>   case USDHI6_WAIT_FOR_DATA_END:
>   ^~~~
> drivers/mmc/host/usdhi6rol0.c: In function =E2=80=98usdhi6_stop_cmd=E2=80=
=99:
> drivers/mmc/host/usdhi6rol0.c:1338:6: warning: this statement may fall th=
rough [-Wimplicit-fallthrough=3D]
>    if (mrq->stop->opcode =3D=3D MMC_STOP_TRANSMISSION) {
>       ^
> drivers/mmc/host/usdhi6rol0.c:1343:2: note: here
>   default:
>   ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mmc/host/usdhi6rol0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index cd8b1b9d4d8a..b9712ac96be5 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1339,7 +1339,7 @@ static int usdhi6_stop_cmd(struct usdhi6_host *host=
)
>                         host->wait =3D USDHI6_WAIT_FOR_STOP;
>                         return 0;
>                 }
> -               /* Unsupported STOP command */
> +               /* fall through - Unsupported STOP command */
>         default:
>                 dev_err(mmc_dev(host->mmc),
>                         "unsupported stop CMD%d for CMD%d\n",
> @@ -1688,6 +1688,7 @@ static void usdhi6_timeout_work(struct work_struct =
*work)
>         default:
>                 dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->w=
ait);
>                 /* mrq can be NULL in this actually impossible case */
> +               /* fall through */

Please make this one comment.

>         case USDHI6_WAIT_FOR_CMD:
>                 usdhi6_error_code(host);
>                 if (mrq)
> @@ -1713,6 +1714,7 @@ static void usdhi6_timeout_work(struct work_struct =
*work)
>                  * If USDHI6_WAIT_FOR_DATA_END times out, we have already=
 unmapped
>                  * the page
>                  */
> +               /* fall through */

Ditto.

>         case USDHI6_WAIT_FOR_DATA_END:
>                 usdhi6_error_code(host);
>                 data->error =3D -ETIMEDOUT;
> --
> 2.21.0
>

Kind regards
Uffe
