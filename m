From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Sun, 6 Sep 2015 22:14:09 +0800
Message-ID: <55EC4A31.4060605@rock-chips.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com>
 <55EB8508.9030009@rock-chips.com>
 <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
Reply-To: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDGZV5NVQEMRBQMUWGXQKGQEV62LY6A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/9/6 20:09, Yousong Zhou =E5=86=99=E9=81=93:
> Hi,
>
> On 6 September 2015 at 08:12, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> On 2015/9/5 22:58, Hans de Goede wrote:
>>>
>>> Hi Shawn Lin,
>>>
>>> On 05-09-15 16:07, Shawn Lin wrote:
>>>>
>>>> On 2015/9/5 18:19, Yousong Zhou wrote:
>>>>>
>>>>> A SD card with sunxi-mmc can fail with the following error message
>>>>> (RCD for
>>>>> response CRC error) when trying to switch to highspeed mode.  Setting
>>>>> the bus
>>>>> clock before the access mode switch fixed it.
>>>>
>>>>
>>>> No, that's wrong!
>>>>
>>>> Before this card is switched to highspeed, it works under
>>>> identification mode(From spec: bus clock <=3D 400KHz). How could you
>>>> raise bus clock to higher clk rate which I _guess_ is 52MHz before you
>>>> notify sd cards to run into highspeed mode?
>>>>
>>>> Althought it works for this card, this patch will not please the other
>>>> cards that they might not reply CMDs any longer including the
>>>> following CMD6.
>>>
>>>
>>> Thanks for the feedback, this is exactly why I asked Yousong Zhou to
>>> take this
>>> to the mmc list.
>>>
>>> So if this is not the proper fix for the problem that Yousong Zhou is
>>> seeing, then
>>> what might be the proper fix ?
>>>
>>
>>  From my knowledge of mmc, there hadn't have a way to deal with this "br=
oken"
>> case. In another word, IMO,it's ANTI-SPEC. We can't be too spec sometime=
s,
>> but at least we shouldn't violate it.
>>
>
> Maybe the fix is anti-spec.  But the fact is that the card works on
> many other platforms with the builtin card reader (not through an USB
> adapter), including Mac OS X, my old Nokia Symbian phone, and Windows.
>
>>> Could it be that the sunxi-mmc is doing some things in the wrong order
>>> when
>>> changing the clock, or is this all under control of the mmc core ?
>>>
>>
>> all of this is under control of the mmc core.
>> So if Yongsong does want this card to work for any linux-based mmc stack=
, I
>> guess something like that should be "better"?
>>
>> if (switch to HS fail) {
>>          set_bus_clk
>>          goto retry switch to HS
>> }
>>
>> BUT...I admit it seems strange as well.
>>
>
> The SD Specification (simplified version) says "If CRC error occurs on
> the status data, the host should issue a power cycle.", so I guess the
> above approach is anti-spec in some way :)
>

Right=EF=BC=8CI was guessing that way from your intention.

> In case it may help debug this problem, I'd like to add that the card
> previously worked fine with U-Boot before commit [1].  This can also
> be confirmed by Debian Jessie installer image with which the old
> U-Boot there worked fine while the kernel (3.16) did not.
>
>   [1] sunxi: mmc: Properly setup mod-clk and clock sampling phases,
> http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dfc3a832576ce7bb597b1823=
935bfb7dcca235c3c
>

Interesting... but that at least prove your patch is a workaround but=20
not find the root cause.

Anyway, look into commit-sha [1], can you have a test by restoring=20
mod-clk and clock sampling phases before jump to kernel.

I happended to fix some problems which seems *similar* to yours(but I'm=20
not sure just from commit[1]'s msg):

https://patchwork.kernel.org/patch/7119661/

> Cheers
>
>                  yousong
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


--=20
Best Regards
Shawn Lin

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
