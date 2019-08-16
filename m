From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v9 3/5] block: sort headers on blk-setting.c
Date: Fri, 16 Aug 2019 21:50:26 +0200
Message-ID: <20190816195026.GC6886@kunai>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7967510337783848994=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--===============7967510337783848994==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 05:31:14PM +0900, Yoshihiro Shimoda wrote:
> This patch sorts the headers in alphabetic order to ease
> the maintenance for this part.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> ---

Jens, can we have your ack for this patch so Christoph can take this
series via his tree (also for patch 4/5)?

Thanks,

   Wolfram

>  block/blk-settings.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 2ae348c..45f2c52 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -2,16 +2,16 @@
>  /*
>   * Functions related to setting various queue properties from drivers
>   */
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
>  #include <linux/bio.h>
>  #include <linux/blkdev.h>
> -#include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
>  #include <linux/gcd.h>
> -#include <linux/lcm.h>
> -#include <linux/jiffies.h>
>  #include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/lcm.h>
> +#include <linux/memblock.h>     /* for max_pfn/max_low_pfn */
> +#include <linux/module.h>
> =20
>  #include "blk.h"
>  #include "blk-wbt.h"
> --=20
> 2.7.4
>=20

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1XCQEACgkQFA3kzBSg
KbYjog//dAZQC63XN6l3f9L1WM8IfdYypPCOsUgtWh4QAVYLdZ/jWXQPRpVwR/hF
WMR4XX7hbfiFzT5beBXQL2PdzpfjZBIGb7asS//S+9e1FZxSCOrTZKgu3REzg6xr
+YfC80n4iUw6rYLLz77WRSoFFkwB9n+IKQQt+aH6G3TqkF09y47VNQSPXfd7qysv
6QOmFR9Ks/zteUOZ7IpJHrCHr7BnLZxxP0WibZxkPteccbymLMWc5gL78ZCYj768
96wAiC2kYaimsXtwjRZjfSQnhLRGe4sG+DJREhpv79q73bss8Oj+3rvJziGfnbwN
6utP5aC039RbvIApECeK0pLOnLhXD/rkRQGHQroXVzarEXe/U4Kqhv2bUePym2DE
kg1n72w+DaEHCvF6YplmPQp+1xsIzFc+pk6z4Ck3gZkHv7tuNqCzD5Ljonp6C6fl
FJUKKIrV/vMmsrloglOxWWsV5cqSoc3rtuJK9OAH/p5tLpl5Rv1ZlBLBN6VIG0kM
wKYFmDHXeC6bh31D8a8XlEwbb124uvOWSaYw8OIO7hl/P8/BpDmmuyL90RsuqU2N
ThBk0luayqVqdag5MqZeNqkScfuIaMP4OIVROxa66JqEIH4+wB/kxnneRFGQVg0j
HimmywdZzFbi+FNZTxpjZ7SkN2xHELiGwxQsieJMgtMRJG+nwx8=
=SupF
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--

--===============7967510337783848994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7967510337783848994==--
