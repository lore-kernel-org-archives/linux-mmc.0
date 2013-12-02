From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH v3 2/2] arm: dt: zynq: Add SDHCI nodes
Date: Mon, 02 Dec 2013 20:45:48 +0100
Message-ID: <529CE36C.4020707@monstr.eu>
References: <1386007357-11956-1-git-send-email-soren.brinkmann@xilinx.com> <1386007357-11956-2-git-send-email-soren.brinkmann@xilinx.com>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="epqDfHUX8lXpqe1s6MtQ46BBVauDxABRk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386007357-11956-2-git-send-email-soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--epqDfHUX8lXpqe1s6MtQ46BBVauDxABRk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/2013 07:02 PM, Soren Brinkmann wrote:
> Add nodes for the Arasan SDHCI controller to Zynq dts files.
>=20
> Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
> v2:
>  - update compatibilty string according to changes in 1/2 (append
>    '-8.9a' IP version string)
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts |  4 ++++
>  arch/arm/boot/dts/zynq-zc706.dts |  4 ++++
>  arch/arm/boot/dts/zynq-zed.dts   |  4 ++++
>  4 files changed, 32 insertions(+)

Chris: It is up to you if you want to take this through your tree
or just let me to take it through my tree. It is adding new nodes
to DTS file that's why it shouldn't be any problem to apply it
separately.

Anyway please let me know what you think.
If you want to add it to your tree here is my

Acked-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--epqDfHUX8lXpqe1s6MtQ46BBVauDxABRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKc42wACgkQykllyylKDCFTpwCgjssBjNL0GVC3mQjeakH3P9un
tqsAn3tn0//U7tycTsg8CIlQ8Ae8a2Jz
=mKP+
-----END PGP SIGNATURE-----

--epqDfHUX8lXpqe1s6MtQ46BBVauDxABRk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
