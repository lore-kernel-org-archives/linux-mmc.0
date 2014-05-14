From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v13 2/2] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Wed, 14 May 2014 14:06:34 +0200
Message-ID: <53735C4A.70502@redhat.com>
References: <1399896288-5826-1-git-send-email-hdegoede@redhat.com>	<1399896288-5826-3-git-send-email-hdegoede@redhat.com>	<5370C5D1.2070901@broadcom.com> <CAPDyKFrq=v1SU0+rC5_tCJ1D5jUOd3vwLXpxgpzB9X5NQd-deg@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORBVFYZWNQKGQEETVHAYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAPDyKFrq=v1SU0+rC5_tCJ1D5jUOd3vwLXpxgpzB9X5NQd-deg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 05/14/2014 02:03 PM, Ulf Hansson wrote:
> On 12 May 2014 15:00, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> On 05/12/2014 02:04 PM, Hans de Goede wrote:
>>>
>>> From: David Lanzend=C3=B6rfer<david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>>>
>>> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-=
in
>>> designware idmac controller, which is identical to the one found in the
>>> mmc-dw
>>> hosts. However the rest of the host is not identical to mmc-dw, it deal=
s
>>> with
>>> sending stop commands in hardware which makes it significantly differen=
t
>>> from the mmc-dw devices.
>>>
>>> HdG: Various cleanups and fixes.
>>
>>
>> Just nitpicking, but usually the above line should be added below the
>> original signoff, so:
>>
>>> Signed-off-by: David Lanzend=C3=B6rfer<david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>>
>> [hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org: various cleanups and fixes]
>>
>>> Signed-off-by: Hans de Goede<hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>
>>
>> As is documented in SubmittingPatches.
>>
>> Gr. AvS
>=20
>=20
> This looks good to me, thanks Hans!
>=20
> I will include this in the next PR I send to Chris, I will also take
> the liberty to fixup the commit msg as pointed out by Arend.

Great, thanks!

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
