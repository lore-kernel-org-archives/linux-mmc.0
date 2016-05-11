From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add rockchip,default-drv-phase
Date: Wed, 11 May 2016 14:42:40 -0700
Message-ID: <CAD=FV=V1dOsZkcFCd50N7F5qCVFMn789n3Hsopd7MDmdupim3Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36707 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcEKVmm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2016 17:42:42 -0400
Received: by mail-vk0-f51.google.com with SMTP id s184so74420279vkb.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 May 2016 14:42:41 -0700 (PDT)
In-Reply-To: <2994d365-2cf2-0990-6c10-2abeebb42eef@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Shawn,

On Wed, May 11, 2016 at 1:25 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2016/5/11 11:50, Doug Anderson wrote:
>>
>> Hi,
>>
>> On Tue, May 10, 2016 at 7:50 PM, Shawn Lin <shawn.lin@rock-chips.com>
>> wrote:
>>>>>
>>>>> maybe. But I think 180(downside) is the better.
>>>
>>>
>>>
>>> NAK my previous comments here. Downside is better for SRD, but won't
>>> work for DDR mode. When running in DDR mode, we should use 90 instead.
>>>
>>> So let me elaborate a bit more here.
>>> For DDR mode, one single clk cycle should sending two data bits outside
>>> to the devices. We need a hold time for both. If 180 is used, the first
>>> bit occurs around the downside area, which won't be sampled by devices
>>> on the upside.  So on the upside, the devices will see a zero bit if you
>>> actually send a one-bit, which makes the devices  generate CRC finally.
>>>
>>>
>>> For this above, 180 for all SDR mode is ok, but 90 should be deployed
>>> for DDR mode. So simply checking the timing to hardcode it should be
>>> fine.
>>
>>
>> OK, I sent out a patch for 180 always.  I can send v2 to use 90 for
>> DDR modes tomorrow.  ...or feel free to post that yourself if you
>> want.
>>
>> We want 90 for all DDR modes?  So MMC_TIMING_UHS_DDR50,
>> MMC_TIMING_MMC_DDR52, MMC_TIMING_MMC_HS400? (not that we support HS400
>> in dw_mmc on Rockchip).
>
>
> Right.

OK, so I dug into this more.  I don't think it's actually quite that
simple.  The Designware databook explicitly states that 'MMC DDR
8-bit' should use 180, not 90.  ...but that's probably explained by
the fact that "cclk_in" for MMC-DDR 8-bit is double what you'd expect.
You can see that in code:

if (ios->bus_width == MMC_BUS_WIDTH_8 &&
    ios->timing == MMC_TIMING_MMC_DDR52)
      cclkin = 2 * ios->clock * RK3288_CLKGEN_DIV;

---

tl;dr of all the below:

* For SD: use 180 for SDR104 to get margin, use 90 elsewhere.
* For mmc, use 180 for DDR52 to meet timings, use 180 for HS200 to get
margin, use 90 elsewhere


The nice thing about this is, at least for rk3288, things don't change
much from today where we use 90 degrees for most SD cards.

---

For new patch, see: <https://patchwork.kernel.org/patch/9075141/>

---

Details:

So assuming measurements I saw from an EE are correct, measured
"delay_o_ns" is ~ .5 ns for rk3399.  With that, we can do some math.
Please correct any mistakes.  Math is hard.  Note that on all Rockchip
devices I've seen pins are limited to 150 MHz and when we choose 150
MHz we end up at 148.5 MHz.  Calculations aren't too different if we
use 150 for that case.


MMC_TIMING_MMC_DDR52:
  min hold time = 2.5 ns
  min data delay = 2.5 ns + .5 ns = 3 ns
  with 100 MHz clock, 90 degree: 2.5 ns
  with 100 MHz clock, 180 degree: 5.0 ns

  ...need 180 degree

--

SD DDR50:
  min hold time = .8 ns
  min data delay = .8 ns + .5 ns = 1.3 ns
  with 50 MHz clock, 90 degree: 5 ns
  with 50 MHz clock, 180 degree: 10 ns

  ...90 degree is good and 180 is massive overkill.  Use 90.

--

SD SDR104 (limited to 148.5 MHz on existing Rockchip parts):
  min hold time = .8 ns
  min data delay = .8 ns + .5 ns = 1.3 ns
  with 148.5 MHz clock, 90 degree: 1.68 ns
  with 148.5 MHz clock, 180 degree: 3.37 ns

  ...so 90 degrees would probably work OK, but 180 degrees gives more margin.
  ...probably explains why existing rk3288 devices w/ 90 degree work OK.

  if we had 200 MHz clock, 90 degree: 1.25 ns
  if we had 200 MHz clock, 180 degree: 2.50 ns

--

SD SDR50:
  min hold time = .8 ns
  min data delay = .8 ns + .5 ns = 1.3 ns
  with 100 MHz clock, 90 degree: 2.5 ns
  with 100 MHz clock, 180 degree: 5.0 ns

  ...90 degree is great w/ plenty of margin

--

SD SDR25:
  min hold time = 2 ns
  min data delay = 2 ns + .5 ns = 2.5 ns
  with 50 MHz clock, 90 degree: 5 ns
  with 50 MHz clock, 180 degree: 10 ns

 ...90 degree is good and 180 is massive overkill.  Use 90.

--

SD SDR12 (databook shows cclk_in as 50 MHz here we'll get 25 MHz):
  min hold time = 5 ns
  min data delay = 5 ns + .5 ns = 5.5 ns
  with 25 MHz clock, 90 degree: 10 ns
  with 25 MHz clock, 180 degree: 20 ns

  ...90 degree is good (databook suggests 180 for this mode due to cclk_in = 50)

--

ID Mode
  min hold time = 5 ns
  min data delay = 5 ns + .5 ns = 5.5 ns
  with 400 kHz clock, 90 degree: 625 ns
  with 400 kHz clock, 180 degree: 1250 ns

  ...90 degree is good  (databook suggests 180 for this mode due to
cclk_in = 50)

--

MMC High speed:
  min hold time = 2.5 ns
  min data delay = 2.5 ns + .5 ns = 3 ns
  with 50 MHz clock, 90 degree: 5 ns
  with 50 MHz clock, 180 degree: 10 ns

  ...90 degree is good

--

HS200:
  min hold time (tIH from JEDEC spec):  .8 ns
  ...math all works out the same as SDR104.

--

HS400:
  we don't support it anyway
