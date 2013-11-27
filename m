From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 1/2] mmc: arasan: Add driver for Arasan SDHCI
Date: Wed, 27 Nov 2013 06:28:05 +0100
Message-ID: <529582E5.4010809@monstr.eu>
References: <1383151090-13885-1-git-send-email-soren.brinkmann@xilinx.com> <87mwkqeojd.fsf@octavius.laptop.org> <9e92f3b2-5434-4fcf-b7f5-3f634175193c@CO1EHSMHS024.ehs.local>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3tpKEjUrp25SrafhhopaWuCU0Crd3sVDs"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <9e92f3b2-5434-4fcf-b7f5-3f634175193c@CO1EHSMHS024.ehs.local>
Sender: linux-doc-owner@vger.kernel.org
To: =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>
Cc: Chris Ball <cjb@laptop.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3tpKEjUrp25SrafhhopaWuCU0Crd3sVDs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On 11/27/2013 12:39 AM, S=C3=B6ren Brinkmann wrote:
> Hi Chris,
>=20
> On Tue, Nov 26, 2013 at 06:22:46PM -0500, Chris Ball wrote:
>> Hi Soren, sorry for the late review, just trivial changes:
> No problem. Thanks for looking at it.
>=20
>>
>> On Wed, Oct 30 2013, Soren Brinkmann wrote:
>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b=
/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> new file mode 100644
>>> index 000000000000..ef4c5ac753e8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> @@ -0,0 +1,27 @@
>>> +Device Tree Bindings for the Arasan SDCHI Controller
>>
>> SDHCI
> Oops. Will be fixed.
>=20
>>
>>> +
>>> +  The bindings follow the mmc[1], clock[2] and interrupt[3] bindings=
=2E Only
>>> +  deviations are documented here.
>>> +
>>> +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
>>> +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> +  [3] Documentation/devicetree/bindings/interrupt-controller/interru=
pts.txt
>>> +
>>> +Required Properties:
>>> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
>>> +  - reg: From mmc bindings: Register location and length.
>>
>> Actually, reg/interrupts are from the OF core.  There's no need to
>> mention them here.
> Tomasz complained when I left those parts out so I added them in v2.
> Since it's there now, I don't mind either way. Let's just agree on one
> way or the other.
>=20

Binding was Acked-by Rob and that's why I believe this should be fine.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--3tpKEjUrp25SrafhhopaWuCU0Crd3sVDs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKVguUACgkQykllyylKDCGRCgCgjYNKIqoiaIvRGPuX91ipVBXZ
edAAn0FmUq6S2dwEyOoxj28thwTjjRAT
=phuA
-----END PGP SIGNATURE-----

--3tpKEjUrp25SrafhhopaWuCU0Crd3sVDs--
