From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add
 rockchip,default-drv-phase
Date: Thu, 12 May 2016 11:03:55 +0800
Message-ID: <d4447e52-81de-0ab6-7bd9-016a59f915a5@kernel-upstream.org>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
 <1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=WSkBwBjVsRoDsfjD+sNfR70mKGRA0khjPKKW0zS2=PTw@mail.gmail.com>
 <b15dcb4f-1584-8219-2fe0-97eecb0c64a6@rock-chips.com>
 <CAD=FV=XToSzqSh=SShHuQU9W_m7gfyQn8wRXkLy79t+tnqZknA@mail.gmail.com>
 <1f2f43c7-2672-e448-eddb-2d613bb8dc48@rock-chips.com>
 <CAD=FV=UGbrJRyUbbgzbcYf9GjPG+Fh_gpQ3rX2G=wi2w5Lw=Sg@mail.gmail.com>
 <e202f663-88d7-693b-a765-c130e68d1c2d@rock-chips.com>
 <CAD=FV=UyYCqMYKScjVEASrbzO75014kPCEt39uOSTsgq9M==YQ@mail.gmail.com>
 <2994d365-2cf2-0990-6c10-2abeebb42eef@rock-chips.com>
 <CAD=FV=V1dOsZkcFCd50N7F5qCVFMn789n3Hsopd7MDmdupim3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:14218 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcELDEm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2016 23:04:42 -0400
In-Reply-To: <CAD=FV=V1dOsZkcFCd50N7F5qCVFMn789n3Hsopd7MDmdupim3Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

=E5=9C=A8 2016/5/12 5:42, Doug Anderson =E5=86=99=E9=81=93:
> Shawn,
>
> On Wed, May 11, 2016 at 1:25 AM, Shawn Lin <shawn.lin@rock-chips.com>=
 wrote:
>> On 2016/5/11 11:50, Doug Anderson wrote:
>>>
>>> Hi,
>>>
>>> On Tue, May 10, 2016 at 7:50 PM, Shawn Lin <shawn.lin@rock-chips.co=
m>
>>> wrote:
>>>>>>
>>>>>> maybe. But I think 180(downside) is the better.
>>>>
>>>>
>>>>
>>>> NAK my previous comments here. Downside is better for SRD, but won=
't
>>>> work for DDR mode. When running in DDR mode, we should use 90 inst=
ead.
>>>>
>>>> So let me elaborate a bit more here.
>>>> For DDR mode, one single clk cycle should sending two data bits ou=
tside
>>>> to the devices. We need a hold time for both. If 180 is used, the =
first
>>>> bit occurs around the downside area, which won't be sampled by dev=
ices
>>>> on the upside.  So on the upside, the devices will see a zero bit =
if you
>>>> actually send a one-bit, which makes the devices  generate CRC fin=
ally.
>>>>
>>>>
>>>> For this above, 180 for all SDR mode is ok, but 90 should be deplo=
yed
>>>> for DDR mode. So simply checking the timing to hardcode it should =
be
>>>> fine.
>>>
>>>
>>> OK, I sent out a patch for 180 always.  I can send v2 to use 90 for
>>> DDR modes tomorrow.  ...or feel free to post that yourself if you
>>> want.
>>>
>>> We want 90 for all DDR modes?  So MMC_TIMING_UHS_DDR50,
>>> MMC_TIMING_MMC_DDR52, MMC_TIMING_MMC_HS400? (not that we support HS=
400
>>> in dw_mmc on Rockchip).
>>
>>
>> Right.
>
> OK, so I dug into this more.  I don't think it's actually quite that
> simple.  The Designware databook explicitly states that 'MMC DDR
> 8-bit' should use 180, not 90.  ...but that's probably explained by
> the fact that "cclk_in" for MMC-DDR 8-bit is double what you'd expect=
=2E
> You can see that in code:
>
> if (ios->bus_width =3D=3D MMC_BUS_WIDTH_8 &&
>     ios->timing =3D=3D MMC_TIMING_MMC_DDR52)
>       cclkin =3D 2 * ios->clock * RK3288_CLKGEN_DIV;

Yes, this requirment is from dw_mmc databook(v270a), table 10-5.

But you can see that we didn't handle MMC_TIMING_UHS_SDR12.
As recommended, MMC_TIMING_UHS_SDR12 mode need to 50M here to make
the internal devider to be "1".
Because Figure 10-3 (Clock Structure for Host Controller) assumes Soc=20
only supplies 50M/100M/200M, these three frequency selection, to=20
cclk_in. So SDR12 should be 50M/2 =3D 25M. But for Rockchip Socs, we ha=
ve=20
RK3288_CLKGEN_DIV before cclk_in that means we don't follow this table.

=46or DDR52-8bit, it's a mandatory requirment to use 100M as cclk_in.

>
> ---
>
> tl;dr of all the below:
>
> * For SD: use 180 for SDR104 to get margin, use 90 elsewhere.
> * For mmc, use 180 for DDR52 to meet timings, use 180 for HS200 to ge=
t
> margin, use 90 elsewhere

yes, see the comments blow.

>
>
> The nice thing about this is, at least for rk3288, things don't chang=
e
> much from today where we use 90 degrees for most SD cards.
>
> ---
>
> For new patch, see: <https://patchwork.kernel.org/patch/9075141/>
>
> ---
>
> Details:
>
> So assuming measurements I saw from an EE are correct, measured
> "delay_o_ns" is ~ .5 ns for rk3399.  With that, we can do some math.

Soc specific. But it's a trivial margin.

> Please correct any mistakes.  Math is hard.  Note that on all Rockchi=
p
> devices I've seen pins are limited to 150 MHz and when we choose 150
> MHz we end up at 148.5 MHz.  Calculations aren't too different if we
> use 150 for that case.
>
>
> MMC_TIMING_MMC_DDR52:
>   min hold time =3D 2.5 ns
>   min data delay =3D 2.5 ns + .5 ns =3D 3 ns
>   with 100 MHz clock, 90 degree: 2.5 ns
>   with 100 MHz clock, 180 degree: 5.0 ns
>
>   ...need 180 degree
>

When running in DDR52-8bit, 2 cycle of cclk_in is used
for a single data bit internally. When shifting cclk_in_drv to 180,
we can see:

cclk_in    ____      ____      ____      ____      ___
	__|    |____|    |____|    |____|    |____|

cclk_in_drv-180
                 ____      ____      ____      ____      ___
	     __|    |____|    |____|    |____|    |____|

cclk_in_for_DDR52-8bit
            _________           _____
         __|         |_________|



So cclk_in_drv shifts 180 from cclk_in, which means it's just in the
90 degrees of cclk_in_for_DDR52-8bit. That is what I'd expect that when
running in DDR mode, the cclk_in_drv should be in the 90 degree of
*Actual Internal CLK*, not cclk_in always.

But fot SD DDR50-4bit, it just use cclk_in internlly, so 90 should
be okay.

So we were not in the same page of what the ref-clk is. But I think now
we are in.

Agree on all the calculation below.

> --
>
> SD DDR50:
>   min hold time =3D .8 ns
>   min data delay =3D .8 ns + .5 ns =3D 1.3 ns
>   with 50 MHz clock, 90 degree: 5 ns
>   with 50 MHz clock, 180 degree: 10 ns
>
>   ...90 degree is good and 180 is massive overkill.  Use 90.
>
> --
>
> SD SDR104 (limited to 148.5 MHz on existing Rockchip parts):
>   min hold time =3D .8 ns
>   min data delay =3D .8 ns + .5 ns =3D 1.3 ns
>   with 148.5 MHz clock, 90 degree: 1.68 ns
>   with 148.5 MHz clock, 180 degree: 3.37 ns
>
>   ...so 90 degrees would probably work OK, but 180 degrees gives more=
 margin.
>   ...probably explains why existing rk3288 devices w/ 90 degree work =
OK.
>
>   if we had 200 MHz clock, 90 degree: 1.25 ns
>   if we had 200 MHz clock, 180 degree: 2.50 ns
>
> --
>
> SD SDR50:
>   min hold time =3D .8 ns
>   min data delay =3D .8 ns + .5 ns =3D 1.3 ns
>   with 100 MHz clock, 90 degree: 2.5 ns
>   with 100 MHz clock, 180 degree: 5.0 ns
>
>   ...90 degree is great w/ plenty of margin
>
> --
>
> SD SDR25:
>   min hold time =3D 2 ns
>   min data delay =3D 2 ns + .5 ns =3D 2.5 ns
>   with 50 MHz clock, 90 degree: 5 ns
>   with 50 MHz clock, 180 degree: 10 ns
>
>  ...90 degree is good and 180 is massive overkill.  Use 90.
>
> --
>
> SD SDR12 (databook shows cclk_in as 50 MHz here we'll get 25 MHz):
>   min hold time =3D 5 ns
>   min data delay =3D 5 ns + .5 ns =3D 5.5 ns
>   with 25 MHz clock, 90 degree: 10 ns
>   with 25 MHz clock, 180 degree: 20 ns
>
>   ...90 degree is good (databook suggests 180 for this mode due to cc=
lk_in =3D 50)
>
> --
>
> ID Mode
>   min hold time =3D 5 ns
>   min data delay =3D 5 ns + .5 ns =3D 5.5 ns
>   with 400 kHz clock, 90 degree: 625 ns
>   with 400 kHz clock, 180 degree: 1250 ns
>
>   ...90 degree is good  (databook suggests 180 for this mode due to
> cclk_in =3D 50)
>
> --
>
> MMC High speed:
>   min hold time =3D 2.5 ns
>   min data delay =3D 2.5 ns + .5 ns =3D 3 ns
>   with 50 MHz clock, 90 degree: 5 ns
>   with 50 MHz clock, 180 degree: 10 ns
>
>   ...90 degree is good
>
> --
>
> HS200:
>   min hold time (tIH from JEDEC spec):  .8 ns
>   ...math all works out the same as SDR104.
>
> --
>
> HS400:
>   we don't support it anyway
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

