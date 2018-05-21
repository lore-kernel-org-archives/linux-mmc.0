From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: propagate correct returned value in mmc_rpmb_ioctl
Date: Mon, 21 May 2018 13:36:34 +0200
Message-ID: <CAPDyKFr2Bf_Ngtwp5pPU8Q956Ok4Ut8HLDsNxFvk-iU445Huvw@mail.gmail.com>
References: <20180516192022.23541-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516192022.23541-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 May 2018 at 21:20, Mathieu Malaterre <malat@debian.org> wrote:
> In commit 97548575bef3 ("mmc: block: Convert RPMB to a character device")=
 a
> new function `mmc_rpmb_ioctl` was added. The final return is simply
> returning a value of `0` instead of propagating the correct return code.
>
> Discovered during a compilation with W=3D1, silence the following gcc war=
ning
>
>   drivers/mmc/core/block.c:2470:6: warning: variable =E2=80=98ret=E2=80=
=99 set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Thanks, applied for fixes and by adding a stable tag!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 9e923cd1d80e..38a7586b00cc 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2485,7 +2485,7 @@ static long mmc_rpmb_ioctl(struct file *filp, unsig=
ned int cmd,
>                 break;
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  #ifdef CONFIG_COMPAT
> --
> 2.11.0
>
