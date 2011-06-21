From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] cb710: fix #ifdef HAVE_EFFICIENT_UNALIGNED_ACCESS
Date: Tue, 21 Jun 2011 12:17:25 +0200
Message-ID: <20110621101725.GA670@rere.qmqm.pl>
References: <BANLkTikMc1WfJMJ2NeBr1E62dGjCj1Cd_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTikMc1WfJMJ2NeBr1E62dGjCj1Cd_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james@albanarts.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 21, 2011 at 10:55:34AM +0100, James Hogan wrote:
> HAVE_EFFICIENT_UNALIGNED_ACCESS is a config option, therefore it need=
s
> the CONFIG_ before it when used by the preprocessor.
>=20
> Signed-off-by: James Hogan <james@albanarts.com>
> ---
>  drivers/misc/cb710/sgbuf2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/misc/cb710/sgbuf2.c b/drivers/misc/cb710/sgbuf2.=
c
> index d019746..2a40d0e 100644
> --- a/drivers/misc/cb710/sgbuf2.c
> +++ b/drivers/misc/cb710/sgbuf2.c
> @@ -47,7 +47,7 @@ static uint32_t sg_dwiter_read_buffer(struct
> sg_mapping_iter *miter)
>=20
>  static inline bool needs_unaligned_copy(const void *ptr)
>  {
> -#ifdef HAVE_EFFICIENT_UNALIGNED_ACCESS
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	return false;
>  #else
>  	return ((ptr - NULL) & 3) !=3D 0;

Acked-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>

[Cc: linux-mmc]
