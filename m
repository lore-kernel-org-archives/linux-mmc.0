From: Zach Brown <zach.brown@ni.com>
Subject: Re: [RFC 1/2] sdhci: Add device tree property sd-broken-highspeed
Date: Fri, 7 Oct 2016 13:56:04 -0500
Message-ID: <20161007185603.GA8388@zach-desktop>
References: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
 <1474660869-15532-2-git-send-email-zach.brown@ni.com>
 <CAPDyKFogDKM86XKo1iQE1KU5HpEic23FD5YQGF9QjSFYBDJn4Q@mail.gmail.com>
 <CAL_JsqLjtn2-FaO_h9JWOsZqttQ35yV6KOnQz2Z-cMr=0GHJCg@mail.gmail.com>
 <20161005212223.GK10625@jcartwri.amer.corp.natinst.com>
 <5972c8f4-23b5-7dbb-b87c-7be7ec5b1a17@rock-chips.com>
 <7acb34a9-d323-b112-f796-92c2a962743c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7acb34a9-d323-b112-f796-92c2a962743c@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Julia Cartwright <julia@ni.com>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 06, 2016 at 09:13:24AM +0300, Adrian Hunter wrote:
> On 06/10/16 04:34, Shawn Lin wrote:
> > On 2016/10/6 5:22, Julia Cartwright wrote:
> >> On Wed, Oct 05, 2016 at 03:03:44PM -0500, Rob Herring wrote:
> >>> On Wed, Oct 5, 2016 at 1:33 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>> On 23 September 2016 at 22:01, Zach Brown <zach.brown@ni.com> wrote:
> >>>>> Certain board configurations can make highspeed malfunction due to
> >>>>> timing issues. In these cases a way is needed to force the controller
> >>>>> and card into standard speed even if they otherwise appear to be capable
> >>>>> of highspeed.
> >>>>>
> >>>>> The sd-broken-highspeed property will let the sdhci driver know that
> >>>>> highspeed will not work.
> >>>>>
> >>>>> Signed-off-by: Zach Brown <zach.brown@ni.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt
> >>>>> b/Documentation/devicetree/bindings/mmc/mmc.txt
> >>>>> index 8a37782..59332ea 100644
> >>>>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> >>>>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> >>>>> @@ -52,6 +52,8 @@ Optional properties:
> >>>>>  - no-sdio: controller is limited to send sdio cmd during initialization
> >>>>>  - no-sd: controller is limited to send sd cmd during initialization
> >>>>>  - no-mmc: controller is limited to send mmc cmd during initialization
> >>>>> +- sd-broken-highspeed: Highspeed is broken, even if the controller and
> >>>>> card
> >>>>> +  themselves claim they support highspeed.
> >>>>
> >>>> Regarding a broken card, that is managed via the card quirks and not in DT.
> >>>>
> >>>> If this is about a controller limitation, we already have the option
> >>>> to describe what it supports, so we don't need an option to tell what
> >>>> it *not* supports.
> >>>>
> >>>> For example "cap-sd-highspeed" tells whether the controller supports
> >>>> SD high-speed, please use that instead.
> >>>
> >>> If a controller has a capability register and it lies (perhaps the
> >>> board has limitations that the SoC does not), then you may need to
> >>> disable a feature.
> >>
> >> That's precisely the case here.  This is a board-level problem, not a
> >> card or controller problem.  As Zach mentioned in the cover letter, the
> >> trace length between controller and card on some of our boards is too
> >> long to meet high-speed timings, even though both card and controller
> >> advertise it.
> >
> > IIRC, I saw the same problem while using sdhci to bring up a
> > industrial board for vehicle. The trace length is so long that
> > I have to limit the max-frequency to make it works properly when
> > running at hishspeed.
> >
> > So could you try to limit the max-frequency in your DT to see
> > if it could work for you? I guess it should work as once reducing
> > the frequency, the timing per cycle will be large enough to meet
> > the spec. At least that helped me solve my problem.
> >
> > For further consideration, I deployed a mechanism called "tuning for
> > non UHS or non-hs200/400" for my donwstream tree at that time. The basic
> > concept is to ask devices to send ext_csd(or send status for SD case)
> > *repeatedly*. Some hosts, i.e. sdhci-of-arasan or dw_mmc-rockchip, can
> > manually set rx delay via some clock unit registers to capture the
> > working sample window and select the middle point of the longest good
> > phase region. The same for retune. But it is a little complicated, and
> > could only be applicable to the hosts who could adjust the rx delay
> > manually when claiming the caps of MMC_CAPS_CAN_TUNING_FOR_HS, whatever
> > the name is...
> >
> > I don't know if it is worth to add this, and I don't know if it's
> > a legit way. Anyway, I just share my thought(experience) for you and
> > linux-mmc to think more about how to deal with the case you meet rather
> > than sacrificing the performence by removing highspeed or reducing
> > frequency..
> >
>
> As Shawn points out, using max-frequency is a possibility. Did you consider
> that?
>

I hadn't. So I looked into it and, as I stated the issue using max-frequency
would work, but I forgot to add that, because we pass the signal through an
fpga it has to be standard speed. If the card and controller are not in
standard speed then it won't pass hold time. Specifically we need the data to
change on the falling edge of the clock.

I'll add this justification to the commit message.

> There are 2 high speed caps:
> 	cap-sd-highspeed
> 	cap-mmc-highspeed
>
> Yet patch in 2, the effect of sd-broken-highspeed is to suppress highspeed
> for both SD and MMC.  Should it then be called just broken-highspeed?
>

I agree, broken-highspeed makes more sense. Will change in the next version.
