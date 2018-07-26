From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [PATCH v2 1/3] dt-binding: mmc: sunxi: add H6
 compatible (with A64 fallback)
Date: Thu, 26 Jul 2018 09:14:26 +0800
Message-ID: <8520892860b672631ffc99f6318c2aeba251dc2e.camel@aosc.io>
References: <20180719042810.6546-1-icenowy@aosc.io>
	 <20180719042810.6546-2-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBB6B4TNAKGQEKYWKXBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180719042810.6546-2-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2018-07-19=E5=9B=9B=E7=9A=84 12:28 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> The MMC controllers on H6 is similar to the ones on A64, but with
> some
> new features.
>=20
> Add compatible strings for them (with the A64 compatible strings as
> fallback, in order to make them to work with A64 drivers).
>=20
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
> Changes in v2:
> - Add A64 fallback.
>=20
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 132e0007d7d6..e9cb3ec5e502 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -16,6 +16,8 @@ Required properties:
>     * "allwinner,sun9i-a80-mmc"
>     * "allwinner,sun50i-a64-emmc"
>     * "allwinner,sun50i-a64-mmc"
> +   * "allwinner,sun50i-h6-emmc", "allwinner.sun50i-a64-emmc"
> +   * "allwinner,sun50i-h6-mmc", "allwinner.sun50i-a64-mmc"

BTW it seems that the driver performs quite bad on H6 when dealing it
as an A64.

I get 1.5MB/s on a card, although the card can reach 20MB/s read speed
(testing on BSP).

>   - reg : mmc controller base registers
>   - clocks : a list with 4 phandle + clock specifier pairs
>   - clock-names : must contain "ahb", "mmc", "output" and "sample"

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
