From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Date: Thu, 13 Jun 2019 21:45:47 +0200
Message-ID: <20190613194547.GD6863@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7907793397334166513=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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


--===============7907793397334166513==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 07:20:14PM +0900, Yoshihiro Shimoda wrote:
> Since the commit 133d624b1cee ("dma: Introduce dma_max_mapping_size()")
> provides a helper function to get the max mapping size, we can use
> the function instead of the workaround code for swiotlb.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

I love it! I'd really like to see this code go away. Do I get this right
that this patch is kinda independent of the reset of the series? Anyway:

Acked-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>


--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0Cp+sACgkQFA3kzBSg
KbZH5w//YZbTziLismKCWT2Aa4Xx6jz9hYCViEHV3YlulecWNZMk1MMj5mAEVLDS
XQep1eGpqDNfxaXKoHdzinLJ1BQGEtwwqyKiWr2XC0PEZh4H7Ead43pYEg1xKgb6
9eC82CtEQemmnV9bW3DRi/H/zRE2oNmshA5oM8Nk70QDNSD/dW2XEWNTpCGwq/oQ
PiaDy2UMqneh6fpNADb/2motINaNseE4ChCTc27Hx/PGtnl4qvR34iZXSI0WhLaN
Ppt1uI9kC50YaMAgeO4mSK9B84N1FucI7rboutgkRWOfUlDaDf+yIMhnE92LLVs7
0yn0uXKtkDnnWRpI2jcMScLSpzk5ISbPfsmvImoRUwruKy/vfpsYylJYWtxTx6Rn
OyZccS9fKodljAJkn7aly1fezO2+m6+NlLY/mPxEcOMuHgXo948/za6b7Aa4bzEF
Rr/AiP4cXYdvUjy3OnYpnGMX+3zsStJSSEHl+Lh9cxhflCyj0o3BLoVFn7IUOC2K
3STPFIRsol+WtRH6NJSOCQ5u8PZd1nd8n4nm0/tv/tUp55Ao62uoStmkz7D0IzKQ
migGfFhLx+NEHejtIhFFUUXNAWk+Hqw3yfBsUtbnJXX+rZcxo+mXBUveBhs9GZ98
IWp9OB52Rb74TGprWNz4JxlKi/T82E9wl3IPD1jizTD915sW/uM=
=bAj7
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

--===============7907793397334166513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7907793397334166513==--
