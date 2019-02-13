From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-xenon: Mark expected switch fall-through
Date: Wed, 13 Feb 2019 09:35:10 +0100
Message-ID: <CAPDyKFrP3GX16EXQTjCa1ThfF-jzWM-JdtvY6TOqo8LBCJ2bbw@mail.gmail.com>
References: <20190212152558.GA21933@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212152558.GA21933@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 12 Feb 2019 at 16:26, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> drivers/mmc/host/sdhci-xenon-phy.c: In function =E2=80=98xenon_emmc_phy_s=
low_mode=E2=80=99:
> drivers/mmc/host/sdhci-xenon-phy.c:527:47: warning: this statement may fa=
ll through [-Wimplicit-fallthrough=3D]
>    if ((priv->init_card_type =3D=3D MMC_TYPE_SDIO) ||
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>        params->slow_mode) {
>        ~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sdhci-xenon-phy.c:534:2: note: here
>   default:
>   ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next - and by cleaning up the somewhat noisy change log, thanks=
!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-=
xenon-phy.c
> index 5b5eb53a63d2..8d07ee1b8f08 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -530,7 +530,7 @@ static bool xenon_emmc_phy_slow_mode(struct sdhci_hos=
t *host,
>                         ret =3D true;
>                         break;
>                 }
> -               /* else: fall through */
> +               /* fall through */
>         default:
>                 reg &=3D ~XENON_TIMING_ADJUST_SLOW_MODE;
>                 ret =3D false;
> --
> 2.20.1
>
