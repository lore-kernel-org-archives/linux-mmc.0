From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
Date: Mon, 16 Jul 2018 12:11:29 +0200
Message-ID: <CAPDyKFpi87UaKLScADOT_gkXkXpLR6r2J71G78zVn0hkc3ng5g@mail.gmail.com>
References: <20180712195937.GA36007@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712195937.GA36007@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 July 2018 at 21:59, Kees Cook <keescook@chromium.org> wrote:
> Looks like the adjusted syntax wasn't fully build tested. This fixes
> failures with powerpc builds:
>
> drivers/mmc/host/mxcmmc.c: In function =E2=80=98mxcmci_swap_buffers=E2=80=
=99:
> drivers/mmc/host/mxcmmc.c:296:51: error: expected =E2=80=98)=E2=80=99 bef=
ore =E2=80=98;=E2=80=99 token
>    void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
>                                                    ^
> drivers/mmc/host/mxcmmc.c:299:1: error: expected =E2=80=98,=E2=80=99 or =
=E2=80=98;=E2=80=99 before =E2=80=98}=E2=80=99 token
>  }
>  ^
>
> Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mxcmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 75f781c11e89..de4e6e5bf304 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -293,9 +293,10 @@ static void mxcmci_swap_buffers(struct mmc_data *dat=
a)
>         int i;
>
>         for_each_sg(data->sg, sg, data->sg_len, i) {
> -               void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
> +               void *buf =3D kmap_atomic(sg_page(sg) + sg->offset);
>                 buffer_swap32(buf, sg->length);
>                 kunmap_atomic(buf);
> +       }
>  }
>  #else
>  static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security
