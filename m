From: Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Sun, 6 Sep 2015 22:47:25 +0800
Message-ID: <CAECwjAgLuskgyHv50GOVN8fGOmQz+jo9PLCAr-POpYH6AszWSg@mail.gmail.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
	<55EAF712.8090203@rock-chips.com>
	<55EB02FD.5040403@redhat.com>
	<55EB8508.9030009@rock-chips.com>
	<CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
	<55EC4A31.4060605@rock-chips.com>
Reply-To: yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=047d7b5d58b4187eb3051f153635
Return-path: <linux-sunxi+bncBDE25RXKR4PRBAFEWGXQKGQEDOIHGRQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <55EC4A31.4060605-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--047d7b5d58b4187eb3051f153635
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sep 6, 2015 10:14 PM, "Shawn Lin" <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>
> =E5=9C=A8 2015/9/6 20:09, Yousong Zhou =E5=86=99=E9=81=93:
>>
>> Hi,
>>
>> On 6 September 2015 at 08:12, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote=
:
>>>
>>> On 2015/9/5 22:58, Hans de Goede wrote:
>>>>
>>>>
>>>> Hi Shawn Lin,
>>>>
>>>> On 05-09-15 16:07, Shawn Lin wrote:
>>>>>
>>>>>
>>>>> On 2015/9/5 18:19, Yousong Zhou wrote:
>>>>>>
>>>>>>
>>>>>> A SD card with sunxi-mmc can fail with the following error message
>>>>>> (RCD for
>>>>>> response CRC error) when trying to switch to highspeed mode.  Settin=
g
>>>>>> the bus
>>>>>> clock before the access mode switch fixed it.
>>>>>
>>>>>
>>>>>
>>>>> No, that's wrong!
>>>>>
>>>>> Before this card is switched to highspeed, it works under
>>>>> identification mode(From spec: bus clock <=3D 400KHz). How could you
>>>>> raise bus clock to higher clk rate which I _guess_ is 52MHz before yo=
u
>>>>> notify sd cards to run into highspeed mode?
>>>>>
>>>>> Althought it works for this card, this patch will not please the othe=
r
>>>>> cards that they might not reply CMDs any longer including the
>>>>> following CMD6.
>>>>
>>>>
>>>>
>>>> Thanks for the feedback, this is exactly why I asked Yousong Zhou to
>>>> take this
>>>> to the mmc list.
>>>>
>>>> So if this is not the proper fix for the problem that Yousong Zhou is
>>>> seeing, then
>>>> what might be the proper fix ?
>>>>
>>>
>>>  From my knowledge of mmc, there hadn't have a way to deal with this
"broken"
>>> case. In another word, IMO,it's ANTI-SPEC. We can't be too spec
sometimes,
>>> but at least we shouldn't violate it.
>>>
>>
>> Maybe the fix is anti-spec.  But the fact is that the card works on
>> many other platforms with the builtin card reader (not through an USB
>> adapter), including Mac OS X, my old Nokia Symbian phone, and Windows.
>>
>>>> Could it be that the sunxi-mmc is doing some things in the wrong order
>>>> when
>>>> changing the clock, or is this all under control of the mmc core ?
>>>>
>>>
>>> all of this is under control of the mmc core.
>>> So if Yongsong does want this card to work for any linux-based mmc
stack, I
>>> guess something like that should be "better"?
>>>
>>> if (switch to HS fail) {
>>>          set_bus_clk
>>>          goto retry switch to HS
>>> }
>>>
>>> BUT...I admit it seems strange as well.
>>>
>>
>> The SD Specification (simplified version) says "If CRC error occurs on
>> the status data, the host should issue a power cycle.", so I guess the
>> above approach is anti-spec in some way :)
>>
>
> Right=EF=BC=8CI was guessing that way from your intention.
>
>
>> In case it may help debug this problem, I'd like to add that the card
>> previously worked fine with U-Boot before commit [1].  This can also
>> be confirmed by Debian Jessie installer image with which the old
>> U-Boot there worked fine while the kernel (3.16) did not.
>>
>>   [1] sunxi: mmc: Properly setup mod-clk and clock sampling phases,
>>
http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dfc3a832576ce7bb597b182393=
5bfb7dcca235c3c
>>
>
> Interesting... but that at least prove your patch is a workaround but not
find the root cause.
>
> Anyway, look into commit-sha [1], can you have a test by restoring
mod-clk and clock sampling phases before jump to kernel.
>

Maybe my statement about U-Boot commit [1] above was a little ambiguous,
sorry.  I meant to say that with that commit applied, U-Boot failed
initialising the card the same way as the kernel, i.e. response crc error.

The Debian Jessie installer image's U-Boot worked fine and booted the
kernel because it was before commit [1] happened.  However after that the
3.16 kernel failed initialising the card.

So, with commit [1], U-Boot failed right away without any chance at all
jumping to kernel.

OpenWrt ticket 20387 has more info about the U-Boot failure.

https://dev.openwrt.org/ticket/20387

Anyway, I have no idea what's the effect of those magic numbers on
"sampling phases".  Never played with such things before :)

> I happended to fix some problems which seems *similar* to yours(but I'm
not sure just from commit[1]'s msg):
>
> https://patchwork.kernel.org/patch/7119661/
>
>> Cheers
>>
>>                  yousong
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>
>
> --
> Best Regards
> Shawn Lin
>
> --
> You received this message because you are subscribed to the Google Groups
"linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an
email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--047d7b5d58b4187eb3051f153635
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Sep 6, 2015 10:14 PM, &quot;Shawn Lin&quot; &lt;<a href=3D"mailto:shawn.=
lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org">shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; =E5=9C=A8 2015/9/6 20:09, Yousong Zhou =E5=86=99=E9=81=93:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On 6 September 2015 at 08:12, Shawn Lin &lt;<a href=3D"mailto:shaw=
n.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org">shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 2015/9/5 22:58, Hans de Goede wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Shawn Lin,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 05-09-15 16:07, Shawn Lin wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On 2015/9/5 18:19, Yousong Zhou wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; A SD card with sunxi-mmc can fail with the followi=
ng error message<br>
&gt;&gt;&gt;&gt;&gt;&gt; (RCD for<br>
&gt;&gt;&gt;&gt;&gt;&gt; response CRC error) when trying to switch to highs=
peed mode.=C2=A0 Setting<br>
&gt;&gt;&gt;&gt;&gt;&gt; the bus<br>
&gt;&gt;&gt;&gt;&gt;&gt; clock before the access mode switch fixed it.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; No, that&#39;s wrong!<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Before this card is switched to highspeed, it works un=
der<br>
&gt;&gt;&gt;&gt;&gt; identification mode(From spec: bus clock &lt;=3D 400KH=
z). How could you<br>
&gt;&gt;&gt;&gt;&gt; raise bus clock to higher clk rate which I _guess_ is =
52MHz before you<br>
&gt;&gt;&gt;&gt;&gt; notify sd cards to run into highspeed mode?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Althought it works for this card, this patch will not =
please the other<br>
&gt;&gt;&gt;&gt;&gt; cards that they might not reply CMDs any longer includ=
ing the<br>
&gt;&gt;&gt;&gt;&gt; following CMD6.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thanks for the feedback, this is exactly why I asked Youso=
ng Zhou to<br>
&gt;&gt;&gt;&gt; take this<br>
&gt;&gt;&gt;&gt; to the mmc list.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; So if this is not the proper fix for the problem that Yous=
ong Zhou is<br>
&gt;&gt;&gt;&gt; seeing, then<br>
&gt;&gt;&gt;&gt; what might be the proper fix ?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0From my knowledge of mmc, there hadn&#39;t have a way to=
 deal with this &quot;broken&quot;<br>
&gt;&gt;&gt; case. In another word, IMO,it&#39;s ANTI-SPEC. We can&#39;t be=
 too spec sometimes,<br>
&gt;&gt;&gt; but at least we shouldn&#39;t violate it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Maybe the fix is anti-spec.=C2=A0 But the fact is that the card wo=
rks on<br>
&gt;&gt; many other platforms with the builtin card reader (not through an =
USB<br>
&gt;&gt; adapter), including Mac OS X, my old Nokia Symbian phone, and Wind=
ows.<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt; Could it be that the sunxi-mmc is doing some things in the=
 wrong order<br>
&gt;&gt;&gt;&gt; when<br>
&gt;&gt;&gt;&gt; changing the clock, or is this all under control of the mm=
c core ?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; all of this is under control of the mmc core.<br>
&gt;&gt;&gt; So if Yongsong does want this card to work for any linux-based=
 mmc stack, I<br>
&gt;&gt;&gt; guess something like that should be &quot;better&quot;?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; if (switch to HS fail) {<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bus_clk<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto retry switch to HS<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; BUT...I admit it seems strange as well.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; The SD Specification (simplified version) says &quot;If CRC error =
occurs on<br>
&gt;&gt; the status data, the host should issue a power cycle.&quot;, so I =
guess the<br>
&gt;&gt; above approach is anti-spec in some way :)<br>
&gt;&gt;<br>
&gt;<br>
&gt; Right=EF=BC=8CI was guessing that way from your intention.<br>
&gt;<br>
&gt;<br>
&gt;&gt; In case it may help debug this problem, I&#39;d like to add that t=
he card<br>
&gt;&gt; previously worked fine with U-Boot before commit [1].=C2=A0 This c=
an also<br>
&gt;&gt; be confirmed by Debian Jessie installer image with which the old<b=
r>
&gt;&gt; U-Boot there worked fine while the kernel (3.16) did not.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 [1] sunxi: mmc: Properly setup mod-clk and clock sampling p=
hases,<br>
&gt;&gt; <a href=3D"http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dfc3a8=
32576ce7bb597b1823935bfb7dcca235c3c">http://git.denx.de/?p=3Du-boot.git;a=
=3Dcommit;h=3Dfc3a832576ce7bb597b1823935bfb7dcca235c3c</a><br>
&gt;&gt;<br>
&gt;<br>
&gt; Interesting... but that at least prove your patch is a workaround but =
not find the root cause.<br>
&gt;<br>
&gt; Anyway, look into commit-sha [1], can you have a test by restoring mod=
-clk and clock sampling phases before jump to kernel.<br>
&gt;</p>
<p dir=3D"ltr">Maybe my statement about U-Boot commit [1] above was a littl=
e ambiguous, sorry.=C2=A0 I meant to say that with that commit applied, U-B=
oot failed initialising the card the same way as the kernel, i.e. response =
crc error.</p>
<p dir=3D"ltr">The Debian Jessie installer image&#39;s U-Boot worked fine a=
nd booted the kernel because it was before commit [1] happened.=C2=A0 Howev=
er after that the 3.16 kernel failed initialising the card.</p>
<p dir=3D"ltr">So, with commit [1], U-Boot failed right away without any ch=
ance at all jumping to kernel.</p>
<p dir=3D"ltr">OpenWrt ticket 20387 has more info about the U-Boot failure.=
</p>
<p dir=3D"ltr"><a href=3D"https://dev.openwrt.org/ticket/20387">https://dev=
.openwrt.org/ticket/20387</a></p>
<p dir=3D"ltr">Anyway, I have no idea what&#39;s the effect of those magic =
numbers on &quot;sampling phases&quot;.=C2=A0 Never played with such things=
 before :)</p>
<p dir=3D"ltr">&gt; I happended to fix some problems which seems *similar* =
to yours(but I&#39;m not sure just from commit[1]&#39;s msg):<br>
&gt;<br>
&gt; <a href=3D"https://patchwork.kernel.org/patch/7119661/">https://patchw=
ork.kernel.org/patch/7119661/</a><br>
&gt;<br>
&gt;&gt; Cheers<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0yous=
ong<br>
&gt;&gt; --<br>
&gt;&gt; To unsubscribe from this list: send the line &quot;unsubscribe lin=
ux-mmc&quot; in<br>
&gt;&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TbrhsbdSgBK9A@public.gmane.org=
rg">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt;&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/maj=
ordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; -- <br>
&gt; Best Regards<br>
&gt; Shawn Lin<br>
&gt;<br>
&gt; -- <br>
&gt; You received this message because you are subscribed to the Google Gro=
ups &quot;linux-sunxi&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
 an email to <a href=3D"mailto:linux-sunxi%2Bunsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">=
linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
>https://groups.google.com/d/optout</a>.<br>
</p>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--047d7b5d58b4187eb3051f153635--
