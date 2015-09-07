From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Mon, 7 Sep 2015 09:02:45 +0200
Message-ID: <55ED3695.2030101@redhat.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com>
 <55EB8508.9030009@rock-chips.com>
 <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
 <55EC4A31.4060605@rock-chips.com>
 <CAECwjAgLuskgyHv50GOVN8fGOmQz+jo9PLCAr-POpYH6AszWSg@mail.gmail.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060204060109020900010508"
Return-path: <linux-sunxi+bncBDRZXY4CYYORBG7NWSXQKGQEMLA3RDY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAECwjAgLuskgyHv50GOVN8fGOmQz+jo9PLCAr-POpYH6AszWSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------060204060109020900010508
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

On 06-09-15 16:47, Yousong Zhou wrote:
> On Sep 6, 2015 10:14 PM, "Shawn Lin" <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>>
>> =E5=9C=A8 2015/9/6 20:09, Yousong Zhou =E5=86=99=E9=81=93:
>>>
>>> Hi,
>>>
>>> On 6 September 2015 at 08:12, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrot=
e:
>>>>
>>>> On 2015/9/5 22:58, Hans de Goede wrote:
>>>>>
>>>>>
>>>>> Hi Shawn Lin,
>>>>>
>>>>> On 05-09-15 16:07, Shawn Lin wrote:
>>>>>>
>>>>>>
>>>>>> On 2015/9/5 18:19, Yousong Zhou wrote:
>>>>>>>
>>>>>>>
>>>>>>> A SD card with sunxi-mmc can fail with the following error message
>>>>>>> (RCD for
>>>>>>> response CRC error) when trying to switch to highspeed mode.  Setti=
ng
>>>>>>> the bus
>>>>>>> clock before the access mode switch fixed it.
>>>>>>
>>>>>>
>>>>>>
>>>>>> No, that's wrong!
>>>>>>
>>>>>> Before this card is switched to highspeed, it works under
>>>>>> identification mode(From spec: bus clock <=3D 400KHz). How could you
>>>>>> raise bus clock to higher clk rate which I _guess_ is 52MHz before y=
ou
>>>>>> notify sd cards to run into highspeed mode?
>>>>>>
>>>>>> Althought it works for this card, this patch will not please the oth=
er
>>>>>> cards that they might not reply CMDs any longer including the
>>>>>> following CMD6.
>>>>>
>>>>>
>>>>>
>>>>> Thanks for the feedback, this is exactly why I asked Yousong Zhou to
>>>>> take this
>>>>> to the mmc list.
>>>>>
>>>>> So if this is not the proper fix for the problem that Yousong Zhou is
>>>>> seeing, then
>>>>> what might be the proper fix ?
>>>>>
>>>>
>>>>   From my knowledge of mmc, there hadn't have a way to deal with this
> "broken"
>>>> case. In another word, IMO,it's ANTI-SPEC. We can't be too spec
> sometimes,
>>>> but at least we shouldn't violate it.
>>>>
>>>
>>> Maybe the fix is anti-spec.  But the fact is that the card works on
>>> many other platforms with the builtin card reader (not through an USB
>>> adapter), including Mac OS X, my old Nokia Symbian phone, and Windows.
>>>
>>>>> Could it be that the sunxi-mmc is doing some things in the wrong orde=
r
>>>>> when
>>>>> changing the clock, or is this all under control of the mmc core ?
>>>>>
>>>>
>>>> all of this is under control of the mmc core.
>>>> So if Yongsong does want this card to work for any linux-based mmc
> stack, I
>>>> guess something like that should be "better"?
>>>>
>>>> if (switch to HS fail) {
>>>>           set_bus_clk
>>>>           goto retry switch to HS
>>>> }
>>>>
>>>> BUT...I admit it seems strange as well.
>>>>
>>>
>>> The SD Specification (simplified version) says "If CRC error occurs on
>>> the status data, the host should issue a power cycle.", so I guess the
>>> above approach is anti-spec in some way :)
>>>
>>
>> Right=EF=BC=8CI was guessing that way from your intention.
>>
>>
>>> In case it may help debug this problem, I'd like to add that the card
>>> previously worked fine with U-Boot before commit [1].  This can also
>>> be confirmed by Debian Jessie installer image with which the old
>>> U-Boot there worked fine while the kernel (3.16) did not.
>>>
>>>    [1] sunxi: mmc: Properly setup mod-clk and clock sampling phases,
>>>
> http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dfc3a832576ce7bb597b1823=
935bfb7dcca235c3c

Interesting, one thing that patch does is introduce a switch from parent pl=
l
when switching from 400KHz to higher clocks. Can you try the attached patch=
 ?

If reverting u-boot commit fc3a832576ce7bb597b1823935bfb7dcca235c3c fixes
things, then it is probably best to focus on fixing u-boot first, and then
we can likely apply the same fix to the kernel.

With which SoC(s) are you seeing this problem ? I believe that there
may be some differences between the mmc controller used in the A10/13 vs
later SoCs so this may be a SoC specific issue.

Regards,

Hans


> OpenWrt ticket 20387 has more info about the U-Boot failure.
>
> https://dev.openwrt.org/ticket/20387
>
> Anyway, I have no idea what's the effect of those magic numbers on
> "sampling phases".  Never played with such things before :)
>
>> I happended to fix some problems which seems *similar* to yours(but I'm
> not sure just from commit[1]'s msg):
>>
>> https://patchwork.kernel.org/patch/7119661/
>>
>>> Cheers
>>>
>>>                   yousong
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>
>>
>> --
>> Best Regards
>> Shawn Lin
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s
> "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n
> email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
>> For more options, visit https://groups.google.com/d/optout.
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--------------060204060109020900010508
Content-Type: text/x-patch;
 name="0001-sunxi-mmc-Add-a-delay-after-changing-the-PLL-to-allo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-sunxi-mmc-Add-a-delay-after-changing-the-PLL-to-allo.pa";
 filename*1="tch"

>From 1523e6fbd27b5da22b0c3cb4e8eda50bce7562cf Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Mon, 7 Sep 2015 08:56:52 +0200
Subject: [PATCH] sunxi: mmc: Add a delay after changing the PLL to allow clock
 to stabilize

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/sunxi_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 25f18ad..db3c489 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -204,6 +204,8 @@ static int mmc_config_clock(struct mmc *mmc)
 	if (mmc_set_mod_clk(mmchost, mmc->clock))
 		return -1;
 
+	mdelay(100);
+
 	/* Clear internal divider */
 	rval &= ~SUNXI_MMC_CLK_DIVIDER_MASK;
 	writel(rval, &mmchost->reg->clkcr);
--------------060204060109020900010508--
