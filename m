From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: Change the enhanced area related sysfs output format
Date: Tue, 14 Jun 2016 14:41:00 +0200
Message-ID: <20160614124100.GA1608@katana>
References: <1465893186-6399-1-git-send-email-beatax.baranowska@intel.com>
 <20160614101242.GA1603@katana>
 <575FDE1B.2090206@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575FDE1B.2090206@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Beata Baranowska <beatax.baranowska@intel.com>, ulf.hansson@linaro.org, aisheng.dong@nxp.com, wsa+renesas@sang-engineering.com, gwendal@chromium.org, chaotian.jing@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, sebastianx.jarosz@intel.com, Chuanxiao Dong <chuanxiao.dong@intel.com>
List-Id: linux-mmc@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 01:36:11PM +0300, Adrian Hunter wrote:
> On 14/06/16 13:12, Wolfram Sang wrote:
> > On Tue, Jun 14, 2016 at 10:33:06AM +0200, Beata Baranowska wrote:
> >> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> >>
> >> When the enhanced area feature was not enabled, the related sysfs will=
=20
> >> have -EINVAL(-22) value, so change the sysfs output format to display=
=20
> >> the correct value.
> >>
> >> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> >=20
> > What about introducing attribute_group an use the is_visible callback
> > there, so they won't get displayed at all?
> >=20
>=20
> Except that it is an ABI:
>=20
> 	Documentation/ABI/testing/sysfs-devices-mmc

And broken ever since if this patch is needed... that being said, I
don't really have a strong opinion on my suggestion. I see the file is
out there for >5 years.


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXX/tcAAoJEBQN5MwUoCm2bgAQAKNl0V+RQGHtHW9kWR3aH+Wr
X0v4D/P/k2Y3f8N9861Ior/Xbf5nufGi0HzLNCaj9f8UIGCRkf8V58wZkJ9aOLy8
+UzoQqbu4kx/9FVak9EBKaxE8Q+cq26V3QU0ucK2zPeZtlMXoGsvPCJTFgIjxL1f
8UIhrHPmsQ86dLdbDVnW0+xWnhShQn5DMyfFV6XPPEZi5JBCjn3TN6SyPUE+p+wN
wWnMftu68lrIDRK6YoKgdZvQbDMAxBLY1vuHCFENh2hOu4Kc1Ze5Y/ZpMbFcBZ1y
CRdyDAtAUmOn950MedT0zH7PlBNuyDrhUUvrbWWLzNOE/QK+iA3hY5icBTttoS72
X148Gb7AQzvkIa8CC5cNI6s2pBlM9FNqodr9n9O4yGPTMy2qpTb4cWpH7N2csGv2
huz7DAfMD2z85biFvjX3cr1TZ9n8O5nC4pJStzeJxTIKIGPAvGwUZU2ICyuDHpoe
fSMNWNdTdYthY+HZtsQ87vujyTr+DSRTtfW1Ow3UVXGPUCSdoEq/ERaXlFjk/PVD
Im2tbhhtKUSsjuMDYILoVPDepylpakhjRZ5r1CwaROt9N/WoDO+zwi32iEGqS2LU
fwJMBB85HF8rjom1A0nG0DDBJ4NqpU5I38x9uXpkT0aZsBU4MHlea9PShUT99Ivx
7wSj99Pk9Z3M8HGl6vIZ
=SzUg
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
