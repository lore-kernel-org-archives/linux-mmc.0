From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v3 1/2] mmc: DT: sdhci-brcmstb: Bindings document for common sdhci-brcmstb
Date: Sat, 3 Sep 2016 19:48:09 +0900
Message-ID: <DA8707BB-D3A3-4D77-8D5F-3F39E3FB5009@gmail.com>
References: <20160830063010.10171-1-jaedon.shin@gmail.com> <20160830063010.10171-2-jaedon.shin@gmail.com> <20160902145545.GA14098@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160902145545.GA14098@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

On Sep 2, 2016, at 11:55 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Tue, Aug 30, 2016 at 03:30:09PM +0900, Jaedon Shin wrote:
>> - Renames the DT binding document to common for ARM and MIPS based =
SoCs
>> - Adds a compatible string "brcm,bcm7445-sdhci" that is =
representation
>>  for the Broadcom BCM7445 and family. It is initial and typical 28nm
>>  generation ARM based SoC.
>>=20
>> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> .../mmc/{brcm,bcm7425-sdhci.txt =3D> brcm,sdhci-brcmstb.txt}        | =
8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>> rename Documentation/devicetree/bindings/mmc/{brcm,bcm7425-sdhci.txt =
=3D> brcm,sdhci-brcmstb.txt} (81%)
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt =
b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
>> similarity index 81%
>> rename from =
Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
>> rename to =
Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
>> index 82847174c37d..555229367935 100644
>> --- a/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
>> @@ -8,14 +8,16 @@ on Device Tree properties to enable them for =
SoC/Board combinations
>> that support them.
>>=20
>> Required properties:
>> -- compatible: "brcm,bcm7425-sdhci"
>> +- compatible: should be one of the following
>> +  - "brcm,bcm7425-sdhci"
>> +  - "brcm,bcm7445-sdhci"
>>=20
>> Refer to clocks/clock-bindings.txt for generic clock consumer =
properties.
>>=20
>> Example:
>>=20
>> 	sdhci@f03e0100 {
>> -		compatible =3D "brcm,bcm7425-sdhci";
>> +		compatible =3D "brcm,bcm7445-sdhci";
>> 		reg =3D <0xf03e0000 0x100>;
>> 		interrupts =3D <0x0 0x26 0x0>;
>> 		sdhci,auto-cmd12;
>> @@ -27,7 +29,7 @@ Example:
>> 	sdhci@f03e0300 {
>> 		non-removable;
>> 		bus-width =3D <0x8>;
>> -		compatible =3D "brcm,bcm7425-sdhci";
>> +		compatible =3D "brcm,bcm7445-sdhci";
>=20
> These changes to the example seem pointless. Drop them.

Previously, the compatible string "brcm,bcm7425-sdhci" is representation =
all
MIPS and ARM SoCs including bcm7445. If compatible string is split two =
strings,
the example devicetree node is wrong. It is for bcm7445.

I'll be add commit message this or
Will I need to create a new patch to change example nodes?

Thanks,
Jaedon

>=20
>> 		reg =3D <0xf03e0200 0x100>;
>> 		interrupts =3D <0x0 0x27 0x0>;
>> 		sdhci,auto-cmd12;
>> --=20
>> 2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
