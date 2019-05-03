From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: usdhi6rol0: mark expected switch fall-throughs
Date: Fri, 3 May 2019 15:29:10 +0200
Message-ID: <CAPDyKFr0KrUCuBpYyypKiUsin98XaYOVUx8MuDEpxvm6knxrzw@mail.gmail.com>
References: <20190501203621.GA11352@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501203621.GA11352@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 1 May 2019 at 22:36, Gustavo A. R. Silva <gustavo@embeddedor.com> w=
rote:
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
>   CC [M]  drivers/isdn/hisax/hisax_isac.o
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

Applied for next, thanks!

I took the liberty to clean up the comments, avoiding to break 80
chars per line.

Kind regards
Uffe


> ---
> Changes in v2:
>  - Turn multiple line comments into single line comments.
>  - Fix additional fall-through warning.
>
>  drivers/mmc/host/usdhi6rol0.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index cd8b1b9d4d8a..f0cc5e0dbf79 100644
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
> @@ -1687,7 +1687,7 @@ static void usdhi6_timeout_work(struct work_struct =
*work)
>         switch (host->wait) {
>         default:
>                 dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->w=
ait);
> -               /* mrq can be NULL in this actually impossible case */
> +               /* fall through - mrq can be NULL in this actually imposs=
ible case */
>         case USDHI6_WAIT_FOR_CMD:
>                 usdhi6_error_code(host);
>                 if (mrq)
> @@ -1709,10 +1709,7 @@ static void usdhi6_timeout_work(struct work_struct=
 *work)
>                         host->offset, data->blocks, data->blksz, data->sg=
_len,
>                         sg_dma_len(sg), sg->offset);
>                 usdhi6_sg_unmap(host, true);
> -               /*
> -                * If USDHI6_WAIT_FOR_DATA_END times out, we have already=
 unmapped
> -                * the page
> -                */
> +               /* fall through - If USDHI6_WAIT_FOR_DATA_END times out, =
we have already unmapped the page */
>         case USDHI6_WAIT_FOR_DATA_END:
>                 usdhi6_error_code(host);
>                 data->error =3D -ETIMEDOUT;
> --
> 2.21.0
>
