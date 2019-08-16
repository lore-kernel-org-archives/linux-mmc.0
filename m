From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v9 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
Date: Fri, 16 Aug 2019 21:48:20 +0200
Message-ID: <20190816194820.GB6886@kunai>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5626338043742661986=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--===============5626338043742661986==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 05:31:13PM +0900, Yoshihiro Shimoda wrote:
> This patch adds a new dma_map_ops of get_merge_boundary() to
> expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Joerg, can we have your ack for this patch so Christoph can take this
series via his tree?

Thanks,

   Wolfram

> ---
>  drivers/iommu/dma-iommu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a7f9c3e..2992ce4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1085,6 +1085,16 @@ static int iommu_dma_get_sgtable(struct device *de=
v, struct sg_table *sgt,
>  	return ret;
>  }
> =20
> +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +{
> +	struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
> +
> +	if (domain->type !=3D IOMMU_DOMAIN_DMA)
> +		return 0;	/* can't merge */
> +
> +	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
> +}
> +
>  static const struct dma_map_ops iommu_dma_ops =3D {
>  	.alloc			=3D iommu_dma_alloc,
>  	.free			=3D iommu_dma_free,
> @@ -1100,6 +1110,7 @@ static const struct dma_map_ops iommu_dma_ops =3D {
>  	.sync_sg_for_device	=3D iommu_dma_sync_sg_for_device,
>  	.map_resource		=3D iommu_dma_map_resource,
>  	.unmap_resource		=3D iommu_dma_unmap_resource,
> +	.get_merge_boundary	=3D iommu_dma_get_merge_boundary,
>  };
> =20
>  /*
> --=20
> 2.7.4
>=20

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1XCIQACgkQFA3kzBSg
KbZ8OBAApd6wfSbUGk8bR2bHXmdMHPFIldoc2rP9hr9PM+q3qiQINrZttJrWtrDG
LFHddbWI0gio2yyl/e+9g5QRBF4rRzcLDhJxRSqn8KfAvxu4jU19HAN2rjboS7zl
R0MNVdj+uBCaxvDVXKfuRa+HUUGKtJCTB0Pp79iMJcVL/fq3emVy9cJIwp/K5Z5W
srwNpawQ2wPlC7IY293k+SJL9VCgGG3zMgsyQnQ5ZFZeybkBwsbltc9bw53HwA5G
MgHUt37Csrg+6V+5RlJx4LSY3J03x6N0h+CqSSohD24vNq3TRjoQQT6/yX+BgkDU
BtsT1CB/Ff1ehHSy4yHJc0+AGuLMx8dDhv2QKI+ZNWIbRkVcT5LYoygsdTAZ5w3n
uf59EWdIV2MvpK80WimH25kXMtlTWMmHbWmm3hjpmLFAypp3ZIFn4olIQ7l1Gi2k
jg8dAH4uA4Mu70cWApfnk/ujiSaBtvIfuTFqKcWRmML/liD8Wm+JhDoZzxw0dax5
RPu8KBIR0W/2DLZ8bKKaDzP3I5rzcBEbyrdVosgADXwPiX2ILq1et21iSz7+Z7G6
bidUnMWjOwlP1hhMOiZnzj2uZd9uhwpg87Iz7nY8PMrpJQbSQiJctt2FVfV+/xwq
DPFYl62HmlAiU8J9dEoRIHeo49sW5PO4uTBlMT+F2uLqfugrQns=
=70Bs
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

--===============5626338043742661986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5626338043742661986==--
