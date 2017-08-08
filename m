From: icenowy-h8G6r0blFSE@public.gmane.org
Subject: Re: Re: [PATCH v2] mmc: sunxi: Fix NULL pointer
 reference on clk_delays
Date: Tue, 08 Aug 2017 15:11:27 +0800
Message-ID: <b9e0274b343e329d82f789a76d62c25c@aosc.io>
References: <20170808070244.27410-1-wens@csie.org>
 <bbd4680dc97d9913ff6a49e68c360d21@aosc.io>
 <CAGb2v65qN9OFCnjSRH-=a-XnKEfOJXh=Gvv02vtPydgVEnKuGw@mail.gmail.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBIGIUXGAKGQE3ZVOLXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v65qN9OFCnjSRH-=a-XnKEfOJXh=Gvv02vtPydgVEnKuGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2017-08-08 15:10=EF=BC=8CChen-Yu Tsai =E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Aug 8, 2017 at 3:07 PM,  <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
>> =E5=9C=A8 2017-08-08 15:02=EF=BC=8CChen-Yu Tsai =E5=86=99=E9=81=93=EF=BC=
=9A
>>>=20
>>> Some SoCs do not support clk delays for MMC in the clock control=20
>>> unit.
>>> These include the old controllers in A10/A10s/A13/R8, and the new=20
>>> eMMC
>>> controller in A64. The config structure for these controllers do not
>>> specify clk_delays, but the check for this was replaced in commit
>>> b0600daebf31 ("mmc: sunxi: Support controllers that can use both old
>>> and new timings").
>>>=20
>>> This patch adds back the check for clk_delays, and also adds comments
>>> for both checks in sunxi_mmc_clk_set_phase().
>>>=20
>>> Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
>>>                       both old and new timings")
>>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>>=20
>>=20
>> Should I add a Tested-by here?
>=20
> If you tested it, then yes. :)

I tested it on A64 MMC2.

So:

Tested-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>

>=20
> ChenYu

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
