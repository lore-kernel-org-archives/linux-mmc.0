Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FE37C934;
	Wed, 29 Jul 2026 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346355; cv=none; b=gOPqEOfrar2VHQ7ANoxaSQpSnUhbNmZVUNlqSIui0QEudM6OIuLiDrOa24q/lWMsmYG1HDRJvfOLbfFRLMXGVjWgCRW7M0mNoGx+zOMufaZXvbxhpcaMgxNcM9jh99GtGq3bdUvwT0fZfKIIT3RP/v4dj2BzU4TakA7T78qHsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346355; c=relaxed/simple;
	bh=dWpwaixtjSkDkpqhYJ3TVYwhTM5mPzHzRheqXs6aWCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/IeuaZ669Wa/d7RPkTP3DDQfBeg6RgQ7/7q02tOFnjwfgkIXQ54RgsXq0Sl5wGxAL/SuHUtmsv57Y/ANWxakscunEYeffJ2XDyuXBkCSpL8uEsW62+kENUv2VoN5bXNA8TsXb1ZbiyhnBjZgsjTzcUPZVB7l71TZtr/b9NHKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVaWEpg1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVaWEpg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27721F000E9;
	Wed, 29 Jul 2026 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785346351;
	bh=ZBy5MVeU7TQua/dAX5cOUPmb+YsKmk/igucJkOOmXxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DVaWEpg1Hi+BYx06d+Vz1H02BrNUj79KxOnSFnUzesMFZX46gMjDAZiPXpwz7UUNZ
	 iZwczgK++b5cK6/VQaT79PW5TuzQRBUOEXEhFGuv2HzoNeRiUalWL9OAvKffCPuHtE
	 XyS5ThpyhGEy619UVvLesA1pnyIR5AAikNc1ij8p6iUH8+xVxBCsdv8QrVsqo9NyLJ
	 /C2T297fjrLh/hpbJyagSPkq4lGi2OLHEthw5K9ixuDPZ8aXG5CbD8GAkiMsLr3WSL
	 xbtXih+1d84dTXryi43BkwkhOvV250yj5ZL5ZGf4DjdqA6qjvYx6+ujkJhkA14dCcD
	 r5mD0tEdCVBQw==
Date: Wed, 29 Jul 2026 18:32:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Rohan Santosh Joshi <rohan1sj@cadence.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Milind Parab <mparab@cadence.com>,
	Pawel Laszczak <pawell@cadence.com>,
	Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
	Manikandan Karunakaran Pillai <mpillai@cadence.com>,
	"razb@mobileye.com" <razb@mobileye.com>,
	Brad Larson <blarson@amd.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
Message-ID: <20260729-empower-cheddar-abdd64961c6b@spud>
References: <20260722-cdns_sdhci_cqe-support-v3-0-4412856a4488@cadence.com>
 <20260722-cdns_sdhci_cqe-support-v3-1-4412856a4488@cadence.com>
 <20260722-nursing-shrine-9e9196d96f14@spud>
 <CH3PR07MB106257D01FBAA8310F90C02C58CCA2@CH3PR07MB10625.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ggQjqE9E7xunXzdV"
Content-Disposition: inline
In-Reply-To: <CH3PR07MB106257D01FBAA8310F90C02C58CCA2@CH3PR07MB10625.namprd07.prod.outlook.com>

--ggQjqE9E7xunXzdV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 05:05:43AM +0000, Rohan Santosh Joshi wrote:
> Hi Conor,
>=20
> Currently, there is no public domain information that confirms if the elb=
a supports CQE.

Well then modifying it to add CQE is wrong.

> In the last (v2) patch series, Krzysztof mentioned about why the Pensando=
 Elba is NOT being modified/considered for the CQE.

Right, and he's coming at this from the same perspective as me.
We both want to know why you're making (or not making) the changes that
you are to the binding. You didn't explain in v2 why the elba didn't
need the change and now in v3 you haven't actually explained that it
does.

> The current implementation marks CQE as optional space and the related dr=
iver can take the CQE or non-CQE path depending on whether the DT defines i=
t.
> Please refer to the cover letter for additional details on this.
>=20
> Given the above information, can you please confirm if the next patch sho=
uld modify the elba or restrict the new reg entries to device compatibles?=
=20

You need to figure that out, perhaps by CCing the person responsible for
the addition and maintainance of the platform?

Additionally, please fix your quoting.

Thanks,
Conor.

>=20
> Best Regards,
> Rohan=20
>=20
> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>=20
> Sent: Wednesday, July 22, 2026 10:07 PM
> To: Rohan Santosh Joshi <rohan1sj@cadence.com>
> Cc: Ulf Hansson <ulfh@kernel.org>; Rob Herring <robh@kernel.org>; Krzyszt=
of Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Masa=
hiro Yamada <yamada.masahiro@socionext.com>; Adrian Hunter <adrian.hunter@i=
ntel.com>; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-ker=
nel@vger.kernel.org; Milind Parab <mparab@cadence.com>; Pawel Laszczak <paw=
ell@cadence.com>; Swapnil Kashinath Jakhade <sjakhade@cadence.com>; Manikan=
dan Karunakaran Pillai <mpillai@cadence.com>; razb@mobileye.com
> Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
>=20
> EXTERNAL MAIL
>=20
>=20
> On Wed, Jul 22, 2026 at 04:18:37PM +0530, Rohan Joshi via B4 Relay wrote:
> > From: Rohan Joshi <rohan1sj@cadence.com>
> >=20
> > Cadence host controller can optionally support CQE.
> > Add optional CQE register space to cdns sdhci bindings.
> >=20
> > Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
> > ---
> >  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 28 ++++++++++++++=
+++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Do=
cumentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > index 6c7317d13aa6..10bc9ac2073a 100644
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -22,7 +22,14 @@ properties:
> > =20
> >    reg:
> >      minItems: 1
> > -    maxItems: 2
> > +    maxItems: 3
> > +
> > +  reg-names:
> > +    minItems: 1
> > +    items:
> > +      - const: hc
> > +      - enum: [bctl, cqhci]
> > +      - const: cqhci
> > =20
> >    interrupts:
> >      maxItems: 1
> > @@ -131,13 +138,27 @@ allOf:
> >      then:
> >        properties:
> >          reg:
> > +          minItems: 2
> >            items:
> >              - description: Host controller registers
> >              - description: Elba byte-lane enable register for writes
> > +            - description: CQE (Command Queuing Engine) registers (opt=
ional)
>=20
> I see no explanation in your commit message for why the elba is being
> modified.
>=20
> This new reg entry should be restricted to only the device-specific
> compatibles that actually support it.
>=20
> pw-bot: changes-requested
>=20
> Thanks,
> Conor.
>=20
> > +        reg-names:
> > +          minItems: 2
> > +          items:
> > +            - const: hc
> > +            - const: bctl
> > +            - const: cqhci
> >      else:
> >        properties:
> >          reg:
> > -          maxItems: 1
> > +          items:
> > +            - description: Host Controller registers
> > +            - description: CQE (Command Queuing Engine) registers (opt=
ional)
> > +        reg-names:
> > +          items:
> > +            - const: hc
> > +            - const: cqhci
> > =20
> >  unevaluatedProperties: false
> > =20
> > @@ -145,7 +166,8 @@ examples:
> >    - |
> >      emmc: mmc@5a000000 {
> >          compatible =3D "socionext,uniphier-sd4hc", "cdns,sd4hc";
> > -        reg =3D <0x5a000000 0x400>;
> > +        reg =3D <0x5a000000 0x400>, <0x5a000400 0x060>;
> > +        reg-names =3D "hc", "cqhci";
> >          interrupts =3D <0 78 4>;
> >          clocks =3D <&clk 4>;
> >          bus-width =3D <8>;
> >=20
> > --=20
> > 2.43.0
> >=20
> >=20

--ggQjqE9E7xunXzdV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamo5KgAKCRB4tDGHoIJi
0mB+AP9UbEV8Aes+YoGfo3dWw8dRNX6E8w9ofgcKtojSzFB0hgD+Jl3mPtbDm8Pd
R9djyoTluoQWaUxmZksOEGEQQZ3N0AM=
=try9
-----END PGP SIGNATURE-----

--ggQjqE9E7xunXzdV--
