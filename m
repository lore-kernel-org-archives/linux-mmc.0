From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH v6 5/5] mmc: queue: Use bigger segments if IOMMU can
	merge the segments
Date: Thu, 13 Jun 2019 21:58:40 +0200
Message-ID: <20190613195839.GE6863@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5428652627234108751=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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
Cc: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--===============5428652627234108751==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	blk_queue_max_segments(mq->queue, host->max_segs);
> +	/* blk_queue_can_use_iommu_merging() should succeed if can_merge = 1 */
> +	if (host->can_merge &&
> +	    !blk_queue_can_use_iommu_merging(mq->queue, mmc_dev(host)))
> +		WARN_ON(1);
> +	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));

Maybe we could use WARN here to save the comment and move the info to
the printout?

-	blk_queue_max_segments(mq->queue, host->max_segs);
+	if (host->can_merge)
+		WARN(!blk_queue_can_use_iommu_merging(mq->queue, mmc_dev(host)),
+		     "merging was advertised but not possible\n");
+	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));


--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0Cqu8ACgkQFA3kzBSg
KbadfhAAq7Or22NlUZ69xSQh5IjO2ZwQHROwTG9rZwvQ6FkHsCRSuNihBVPuo4u/
uRaX75NEkDQYl8RjRKFluOKjLQH/TSjqSkQu3f82ZozJrgWJJ06FcWLzr7HSWfzO
Lox+7B6vk23pAjwnC5JDMNf2gBxAu5ZsZA2frkHTUYfZMS26zWxw5PKaB9INsuM7
IMzNO5J84ZMNpZitbBDb6p0MecEadseBi2SXnxFL+wTIksuLFHfZbaBRsf0sXF1/
Sy/GlZ1kQ6t8C+zjx525Y2c1rLaZSvRSQhXh0e+gaJ83U9rd+dgvyhd6xvz5Vn5k
Iqh2RS2U8iTQRUTUFXJwk/AOCYK3SkK6UdqWZESlQFLS6odUcLxub4Ux3hwve1xi
ql2C7s/EiVz7KB0HD6blLUoTvIgFnPcvL2UdxoHLGrhfU+k0tSGSh2NpIDTAuO+f
tBE8KQ3V4Mgjxm1ygYnnsdUYC7jMdxgcrz6xZHU2EwvOmyKvI8mwMDpJoIiK/xAn
BwZ7vU+IFG0QJ5X19QbRNGz4It86dWpaeQbWBvEX8kL+bg/2N2TJGtwHBaWCJgHQ
YBZjIeGm/0cM0psHWxuMyYjA2F4X2K7TQGBcBG8+CBD6hLvyV1Jgdrj8lzk1JKnk
V1tWov7zFB7ikEeybIsHBXXw6/jBx/cFz09yslcLeno79gh1Lx8=
=GBvH
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--

--===============5428652627234108751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5428652627234108751==--
