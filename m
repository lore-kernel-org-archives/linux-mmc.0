From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH v6 0/5] treewide: improve R-Car SDHI performance
Date: Thu, 13 Jun 2019 21:36:28 +0200
Message-ID: <20190613193628.GA6863@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7359102268517268240=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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


--===============7359102268517268240==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 07:20:10PM +0900, Yoshihiro Shimoda wrote:
> This patch series is based on iommu.git / next branch.
>=20
> Since SDHI host internal DMAC of the R-Car Gen3 cannot handle two or
> more segments, the performance rate (especially, eMMC HS400 reading)
> is not good. However, if IOMMU is enabled on the DMAC, since IOMMU will
> map multiple scatter gather buffers as one contignous iova, the DMAC can
> handle the iova as well and then the performance rate is possible to
> improve. In fact, I have measured the performance by using bonnie++,
> "Sequential Input - block" rate was improved on r8a7795.
>=20
> To achieve this, this patch series modifies IOMMU and Block subsystem
> at first. Since I'd like to get any feedback from each subsystem whether
> this way is acceptable for upstream, I submit it to treewide with RFC.
>=20
> Changes from v5:
>  - Almost all patches are new code.
>  - [4/5 for MMC] This is a refactor patch so that I don't add any
>    {Tested,Reviewed}-by tags.
>  - [5/5 for MMC] Modify MMC subsystem to use bigger segments instead of
>    the renesas_sdhi driver.
>  - [5/5 for MMC] Use BLK_MAX_SEGMENTS (128) instead of local value
>    SDHI_MAX_SEGS_IN_IOMMU (512). Even if we use BLK_MAX_SEGMENTS,
>    the performance is still good.

Thanks for your hard work, Shimoda-san!

I may not be the biggest DMA, IOMMU, and block layer expert, but I
really like how this simplifies the SDHI driver and enhances the MMC
core. So, I'll add my two cents to the patches although I can't really
comment on the main functionality.


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0CpbgACgkQFA3kzBSg
Kbb6fhAAsdfuCLxXS4xDUphPESkF+gt9xfaK1rX85NT4mPOnCRA7AMdH0rzSAboF
MFBO01ZS1+9P5SOaOuKArFD1rDkk9t41Hp+AEcsyGZMt47QlwvXakNaQeoGVLUuu
9kex9v8bpMgXjDS9B7CFcbWnLvEjEyysBYBVRMpppo1UwfIwKoQFZAzKJkodXGpE
i5HOkl+woaQVUDgNnnKEVbAmSmCJ7H8Nb4CvzRk14i5GK2UYUi9ql9B4Fro4tsgM
dqSlNzb9x/70ajG5EYGv5+E+pA8u3du9hNLzsm7PoFWCUIPa5n74aQC4CpMcjUao
FqPHfzcT3Mg8fk2K7u6riIaQAO7c/sYJ4quv547+cPTyPoAs290HqRZqH413C9wr
hQtNlC2g7j+6hgrkzyoesGKl0zpiPdW3TKQ17tDGoCipGKDwQGptKunqWFbDY90h
UJdgHWAo/kjy+pAGlutoy5bPdEbYYpxgHCgCrOaN0fzV7qKg7N1gfvRCNJSS0U9d
gNzLc4vE+d3a2jPq90LRNxpBoUgB/iuJBIEhZcTycIMjUBrWQ8ikClrFBMHkLEds
slSs6vzgUDcqOBSVQUVAif92fBeOUONnGbwOBx/r6x8LFIpG5h3gw0rRr9mF6Ppo
48Oi8LWLrkZ3ZSjfNyQMaUi4rPwEqULxuhqN7MZIAVUZk3f9L5s=
=tqtY
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============7359102268517268240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7359102268517268240==--
