From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 2/2] arm: dt: zynq: Add SDHCI nodes
Date: Mon, 06 Jan 2014 12:18:27 +0100
Message-ID: <52CA9103.6060803@monstr.eu>
References: <1386007357-11956-1-git-send-email-soren.brinkmann@xilinx.com> <1386007357-11956-2-git-send-email-soren.brinkmann@xilinx.com> <529CE36C.4020707@monstr.eu>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0w2N76OdxlLSISqPG4hw1IM9m0L9FhK0T"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <529CE36C.4020707@monstr.eu>
Sender: linux-doc-owner@vger.kernel.org
To: monstr@monstr.eu
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0w2N76OdxlLSISqPG4hw1IM9m0L9FhK0T
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/2013 08:45 PM, Michal Simek wrote:
> On 12/02/2013 07:02 PM, Soren Brinkmann wrote:
>> Add nodes for the Arasan SDHCI controller to Zynq dts files.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>> v2:
>>  - update compatibilty string according to changes in 1/2 (append
>>    '-8.9a' IP version string)
>> ---
>>  arch/arm/boot/dts/zynq-7000.dtsi | 20 ++++++++++++++++++++
>>  arch/arm/boot/dts/zynq-zc702.dts |  4 ++++
>>  arch/arm/boot/dts/zynq-zc706.dts |  4 ++++
>>  arch/arm/boot/dts/zynq-zed.dts   |  4 ++++
>>  4 files changed, 32 insertions(+)
>=20
> Chris: It is up to you if you want to take this through your tree
> or just let me to take it through my tree. It is adding new nodes
> to DTS file that's why it shouldn't be any problem to apply it
> separately.
>=20
> Anyway please let me know what you think.
> If you want to add it to your tree here is my
>=20
> Acked-by: Michal Simek <monstr@monstr.eu>

I have added this patch to my zynq/dt branch.
We discussed this in other patch and these dt changes should go through
arm-soc tree.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--0w2N76OdxlLSISqPG4hw1IM9m0L9FhK0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLKkQMACgkQykllyylKDCGPEQCgk4jgaBt/TlnGXYrkIPIIHSWV
qIgAoIyErAbINWkBamuZz+uXcXQIn/Lm
=qSUk
-----END PGP SIGNATURE-----

--0w2N76OdxlLSISqPG4hw1IM9m0L9FhK0T--
