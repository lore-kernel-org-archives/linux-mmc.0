From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Date: Mon, 20 May 2019 10:52:01 +0200
Message-ID: <20190520085201.GA1021@kunai>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
 <20190519090642.GA2279@kunai>
 <36cae1d3-f11c-3c71-3f04-23fdc74f8866@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5293278781399190483=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <36cae1d3-f11c-3c71-3f04-23fdc74f8866-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Madhan Mohan R <madhanmohan.r-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Martin Hicks <mort-THxEKynEWHc@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chi-Hsien Lin <chi-hsien.lin-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Double Lo <double.lo-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Avri Altman <avri.altman-Sjgp3cTcYWE@public.gmane.org>, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Wright Feng <wright.feng-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Jiong Wu <lohengrin1024-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--===============5293278781399190483==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2019 at 10:46:19AM +0200, Arend Van Spriel wrote:
> On 5/19/2019 11:06 AM, Wolfram Sang wrote:
> >=20
> > > Let's add an API that the SDIO card drivers can call that will
> > > temporarily disable the auto-tuning functionality.  Then we can add a
> > > call to this in the Broadcom WiFi driver and any other driver that
> > > might have similar needs.
> >=20
> > Can't you fix the WiFi driver to return something else than -EILSEQ
> > before calling mmc_request_done() to skip the retuning?
>=20
> Not really. mmc_request_done() is for the host controller driver so the w=
ifi
> driver is not involved.

Uh, right. Brown paper bag, please...


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlziaq0ACgkQFA3kzBSg
KbaQVA//WXYFC+BIrlY0Pul+9dGBD8PAFC8f7fZUdwUGDjSC/CI1SfSMkOojpbLX
MQvDlzKvpYj/rS3+xcrNQjgRELPn9DdKWXUEU6CZkgo+xs/cbms1H9fg65UwkVk3
VARN5T2AgnFidWfXrxnD+LxRudQnj6LQqifhfUq6I0X+CfQ7AcDH80gC7FdPCwO5
RM2gC+NNczRd3zxKKWQNXLvuY+yHzx71kHc5+gd5GVRqzsLYwgYQWj1wd6hpUuqY
Ur+m6uUUoQo66teAA+FF+injciq6DJhwqZwa1pvkw7/hXorBArzBbHo3EAqch/hA
349urJNcPBhbN+FCBzjhN+3XpoJATd4DM69v157zYHd2I1QFOiDqBukksD3OBuSk
BRRfrSO2fcTVraEVTtTSgsl8e9eHvGP5hkpwl3GGq+1YvoC5/jOJAXwh17g4vQGD
/wIPqA7a2Edd3Ei3uVjdquqBmmGGDQXADgE+fS9U/gbq/632tXdJ8c25eFUBlN8N
KekuqSINDVvdEHnuy1yKTf7LU0q2hZjifSTU9in3ynzFZSe7ZghCrro/HBCeKBF3
lPCZ2Qf3GlexViNy5/FhvNXPoWQY1sYh0fWMYzOuKm2VEdznrpt5oTtasTapIzy6
9vf04EbfsMnAmHTPi8Hteo+jvczd+rYgFGg6hY/t8FiPtKgWwfs=
=zF+7
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


--===============5293278781399190483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============5293278781399190483==--
