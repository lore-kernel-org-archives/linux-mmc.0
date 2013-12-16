From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH 2/5] ARM: dts: sun4i: Add support for mmc
Date: Mon, 16 Dec 2013 13:32:12 +0100
Message-ID: <52AEF2CC.7010901@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <20131215135854.GF3651@lukather> <52ADBD41.4050104@redhat.com> <11015171.YHkHMOrD9M@pagira.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBUPFXOKQKGQEJGEQBCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <11015171.YHkHMOrD9M-pgFh0Jf6HD9Xzn/AsuzBOg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 12/16/2013 10:04 AM, David Lanzend=F6rfer wrote:

<snip>

>> Yes and no. The pullups are enabled by uboot and the allwinner
>> sources, most of my testing has been done without them, which
>> seems to work fine. I've enabled them to be consisten with the
>> allwinner sources and u-boot.
> Ok
>
>> As for drive =3D <3>, we need drive =3D <2> for normal modes,
>> and drive =3D <3> for ddr mode. I simply picked <3> to keep
>> things KISS. It should not matter much in power usage, as
>> it will only make the flanks of the signal more steep. Once the
>> desired output level is reached the current will drop off. It will
>> use more current when changing the level, but for half the time,
>> so the effective power usage (current * time) is the same.
> In this case lets implement a switch which enables the pull ups for DDR
> mode and lets disable it by default in turn.

I assume you mean enable drive =3D <3> mode and use drive =3D <2> mode
by default? Changing drive level at runtime, rather the at dts configure
time seems to be non trivial.

Also see Maxime's mail further down in this thread where he says he
is fine with keeping drive level at <3> but suggest disabling
the pull-ups by default. I'm fine with disabling the pull-ups by
default, so lets disable the pull-ups and keep the drive level at 3.

> This way we can make sure that we don't have doubled pull up,
> since this could actually mess up some circuitry.
>
>>> Ideally, I'd like this patch to be splitted into three:
>>>     - One that adds the MMC controller nodes to the DTSI
>>>     - One that adds the muxing options you need to the pinctrl node
>>>     - One that enables the controller on the boards
>> Sounds like a good job for David. Note I've a lot more boards for
>> which I would like to add mmc support or dts files in general
>> (will do so as time permits).
> Ok. I will work on it this evening.
>
>> For those boards which already have a dts I'll send mmc adding dts
>> patches to David for now so he can add the changes to the patch-set.
> Ok. I will create another branch and will incorporate your DTS files.
>
>> How do you want to deal with new boards ? Send the addition of the
>> base board to you (and CC David as he will need them in his tree too),
>> and then send a patch to add mmc to the dts to David ?
> Sounds good to me...

In Maxime's reply I was talking about above he suggests to simply
send complete dts files with the new mmc node present to him, so I'll do
that instead if / when I add dts files for new boards.

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
