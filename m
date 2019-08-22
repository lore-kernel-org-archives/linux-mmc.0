From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v9 3/5] block: sort headers on blk-setting.c
Date: Thu, 22 Aug 2019 11:35:56 +0200
Message-ID: <20190822093556.ludte2vtp77fiaax@katana>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190816195026.GC6886@kunai>
	<6ed6c62d-d773-71ec-382b-acd850e3dff1@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4156837875677353964=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6ed6c62d-d773-71ec-382b-acd850e3dff1-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--===============4156837875677353964==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kgj75bivo7t7ncfe"
Content-Disposition: inline


--kgj75bivo7t7ncfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

thanks for the feedback.

> Please just drop this patch.

OK, we will do. And patch 4/5? Is it OK or do you need some more time to
think about it?

Regards,

   Wolfram


--kgj75bivo7t7ncfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1eYfcACgkQFA3kzBSg
KbaLww/+Ke0gLqx1XCJqev3VRm9mm9T+lYoT5L7RlOSw7vRIZSGbZ5TtRLZvKmsY
Kec20o8ozIAuXKsYsOZ3TC2sMh+ntcnP+Gaadoj0pSB3APqT/KdCae9q31zL5DV5
JoJUfQs9OKhNT1kiQgSa3lkZdOsFheB0k1e8l0lnZJOga68dRFcOA57Vx0vFm5UC
dobMpbGoF/aLRfF7rPOdGGy1kZ+8L1+TVLrK97YTlHFrrSlAT2l4HBHAn0gCUOxD
7naLN2w4PQ1fLHVfEAZQHp5wg1XTYjyBIHj3hafLdvxXFtJZmlZDKQ+cTMFD9Ht1
EKW18HKFyUhzrdBgmOlizxqybL5lOpJhFXXE9KZsFVgpbKW6+WtPpzmRk02UagF0
N5zPf7TqQLWzUzxDT9zR4baTy074i+Oazzv5ur9GTCk48JFLdtTNhW4BXCj55ksZ
lkYmbKBNxfI6V8rZn9zhJNJAXAi9Vq6mHJnTLfIHIvcTT2uWJ67Mg8kbB5I9NJ4K
APmuIvXoss/cgXllOwkUZO7A6Z4HCbAS4H5M5seSqJ3DBf4wN0DR6ihOlktho0vz
LTsI5Kqi65RZbtJFfLWmHp2HhHEJbt8zZqvrTivv9uv23lS3tfKLzHReTSW5yJIa
d40nFCayfsQPfE2+FqK49Nvw4KBcH7q0TtUhwsb4is/iHnV/Nvc=
=QW4f
-----END PGP SIGNATURE-----

--kgj75bivo7t7ncfe--

--===============4156837875677353964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4156837875677353964==--
