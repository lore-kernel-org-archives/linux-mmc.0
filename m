From: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Subject: Re: [PATCH v8 00/17] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Tue, 22 Apr 2014 09:07:16 -0300
Message-ID: <53565B74.4000703@elopez.com.ar>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBD73XIMS3EHBBG5X3GNAKGQEYBAPOCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Hans,

El 22/04/14 08:01, Hans de Goede escribi=C3=B3:
> Hi All,
>
> Here is v8 of the sunxi-mmc patch-set David Lanzend=C3=B6rfer and I have =
been
> working on.
>
> The first 2 patches are depenencies which should go in through the clk tr=
ee,
> Mike can you pick these 2 up please ?  :
>
> "clk: sunxi: factors: automatic reparenting support"
> Is uncontroversial and has been favorably reviewed by various people.

I'll pick this one up for 3.16 if you're ok with that. Mike, let me know=20
if you have any objection to the patch, but I'm pretty sure you=20
(informally?) acked it in the past.

> "clk: sunxi: Implement MMC phase control"
> Is somewhat more controversial as there has been lots of discussion about
> adding a generic phase control method to the clk framework. The problem i=
s
> that there has been a lot of talk about such a generic phase control meth=
od
> but not a single patch. Therefor I would like to move forwards with using
> a platform specific method for now. I hereby promise that once we've a ge=
neric
> method I'll write patches to convert the sunxi code to that method.

Mike proposed a RFC for handling this better, and there were talks with=20
Allwinner people to see what did these phase controls actually mean. We=20
should be able to get a proper solution for it during this cycle. I'd=20
prefer to work towards that instead of merging this, as we have more=20
than a month to get it ready still.

Cheers,

Emilio

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
