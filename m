From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 00/17] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Tue, 22 Apr 2014 14:17:30 +0200
Message-ID: <53565DDA.9020202@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com> <53565B74.4000703@elopez.com.ar>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBZN33GNAKGQEMDLKLBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <53565B74.4000703-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 04/22/2014 02:07 PM, Emilio L=C3=B3pez wrote:
> Hi Hans,
>=20
> El 22/04/14 08:01, Hans de Goede escribi=C3=B3:
>> Hi All,
>>
>> Here is v8 of the sunxi-mmc patch-set David Lanzend=C3=B6rfer and I have=
 been
>> working on.
>>
>> The first 2 patches are depenencies which should go in through the clk t=
ree,
>> Mike can you pick these 2 up please ?  :
>>
>> "clk: sunxi: factors: automatic reparenting support"
>> Is uncontroversial and has been favorably reviewed by various people.
>=20
> I'll pick this one up for 3.16 if you're ok with that. Mike, let me know =
if you have any objection to the patch, but I'm pretty sure you (informally=
?) acked it in the past.
>=20
>> "clk: sunxi: Implement MMC phase control"
>> Is somewhat more controversial as there has been lots of discussion abou=
t
>> adding a generic phase control method to the clk framework. The problem =
is
>> that there has been a lot of talk about such a generic phase control met=
hod
>> but not a single patch. Therefor I would like to move forwards with usin=
g
>> a platform specific method for now. I hereby promise that once we've a g=
eneric
>> method I'll write patches to convert the sunxi code to that method.
>=20
> Mike proposed a RFC for handling this better, and there were talks with A=
llwinner people to see what did these phase controls actually mean. We shou=
ld be able to get a proper solution for it during this cycle. I'd prefer to=
 work towards that instead of merging this, as we have more than a month to=
 get it ready still.

A month will be gone before you know it, and merging sunxi mmc support real=
ly
is long overdue, and is the last thing keeping distros from shipping with s=
unxi
support ootb. So I would really prefer to just get this merged as is for no=
w,
changing it later should be easy, and merging an interim solution will make
some more time for doing the generic clk phase control method properly.

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
