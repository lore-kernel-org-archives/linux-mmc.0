From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
Date: Wed, 05 Aug 2015 10:45:30 +0200
Message-ID: <2567191.z5Kn3VDlTS@diego>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com> <55C1C8E9.1060808@samsung.com> <55C1CCA8.7040304@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <55C1CCA8.7040304@rock-chips.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, dianders@chromium.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-mmc@vger.kernel.org

Am Mittwoch, 5. August 2015, 16:43:20 schrieb Shawn Lin:
> =E5=9C=A8 2015/8/5 16:27, Krzysztof Kozlowski =E5=86=99=E9=81=93:
> > On 05.08.2015 17:17, Shawn Lin wrote:
> >> synopsys-dw-mshc supports three types of transfer mode. We add bin=
dings
> >> and description for how to use them at runtime. Without idmac and =
edmac
> >> property, pio is the default transfer mode. Make sure that Idmac a=
nd
> >> emdac
> >> should not be used simultaneously.
> >>=20
> >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> ---
> >>=20
> >> Changes in v3: None
> >> Changes in v2: None
> >>=20
> >>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 41
> >>   ++++++++++++++++++++++ 1 file changed, 41 insertions(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-msh=
c.txt
> >> b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt index
> >> 346c609..30369cb 100644
> >> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> >>=20
> >> @@ -75,6 +75,25 @@ Optional properties:
> >>   * vmmc-supply: The phandle to the regulator to use for vmmc.  If=
 this
> >>   is
> >>  =20
> >>     specified we'll defer probe until we can find this regulator.
> >>=20
> >> +* supports-idmac: Enables support for internal DMAC block within =
the
> >> Synopsys +  Designware Mobile Storage IP block. If supports-idmac
> >> property is present, then +  we MUST NOT add supports-edmac proper=
ty
> >> since we'd assume that dw-mshc IP is +  integrated with only one t=
ype of
> >> dma master.
> >> +
> >> +* supports-edmac: Enables support for external DMAC block outside=
 the
> >> Synopsys +  Designware Mobile Storage IP block. If supports-edmac
> >> property is present, then +  we MUST NOT add supports-idmac proper=
ty
> >> since we'd assume that dw-mshc IP is +  integrated with only one t=
ype of
> >> dma master.
> >> +
> >> +  (Without "supports-idmac" and "supports-edmac", use PIO as defa=
ult
> >> transfer mode)>=20
> > Aren't you breaking here backward compatibility with existing DTB?
> >=20
> > Best regards,
> > Krzysztof
>=20
>   Thanks, Krzysztof.
>   I guess you mean that I should keep existing DTB w/o these two
> properties work fine using idmac?

yep


> >> +
> >> +* dmas: List of DMA specifiers with the controller specific forma=
t as
> >> described +  in the generic DMA client binding. This property shou=
ld be
> >> combined with +  supports-edmac. Refer to dma.txt for details.
> >> +
> >> +* dma-names: DMA request names. Must be "rx-tx". And This propert=
y
> >> should be +  combined with supports-edmac. Refer to dma.txt for de=
tails.
> >> +

Similarly the use of an external dmac could simply be detected, by the=20
presence of the dma-* properties. So when the machine defines dma chann=
els use=20
the external dma, otherwise the internal (or none). So you wouldn't nee=
d=20
separate new properties at all.


> >>=20
> >>   Aliases:
> >>  =20
> >>   - All the MSHC controller nodes should be represented in the ali=
ases
> >>   node using>>=20
> >> @@ -95,6 +114,8 @@ board specific portions as listed below.
> >>=20
> >>   		#size-cells =3D <0>;
> >>   =09
> >>   	};
> >>=20
> >> +[board specific internal DMA resources]
> >> +
> >>=20
> >>   	dwmmc0@12200000 {
> >>   =09
> >>   		clock-frequency =3D <400000000>;
> >>   		clock-freq-min-max =3D <400000 200000000>;
> >>=20
> >> @@ -106,4 +127,24 @@ board specific portions as listed below.
> >>=20
> >>   		bus-width =3D <8>;
> >>   		cap-mmc-highspeed;
> >>   		cap-sd-highspeed;
> >>=20
> >> +		supports-idmac;
> >>=20
> >>   	};
> >>=20
> >> +
> >> +[board specific generic DMA request binding]
> >> +
> >> +	dwmmc0@12200000 {
> >> +		clock-frequency =3D <400000000>;
> >> +		clock-freq-min-max =3D <400000 200000000>;
> >> +		num-slots =3D <1>;
> >> +		broken-cd;
> >> +		fifo-depth =3D <0x80>;
> >> +		card-detect-delay =3D <200>;
> >> +		vmmc-supply =3D <&buck8>;
> >> +		bus-width =3D <8>;
> >> +		cap-mmc-highspeed;
> >> +		cap-sd-highspeed;
> >> +		supports-edmac;
> >> +		dmas =3D <&pdma 12>;
> >> +		dma-names =3D "rx-tx";
> >> +	};
> >> +
