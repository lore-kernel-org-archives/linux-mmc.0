From: Zach Brown <zach.brown@ni.com>
Subject: Re: [RFC 1/2] mmc: sdhci: dt: Add device tree properties sdhci-caps
 and sdhci-caps-mask
Date: Tue, 1 Nov 2016 10:08:21 -0500
Message-ID: <20161101150801.GA7927@zach-desktop>
References: <1477425538-3315-1-git-send-email-zach.brown@ni.com>
 <1477425538-3315-2-git-send-email-zach.brown@ni.com>
 <CGME20161028081315epcas3p4bea31304360f9a6a4a12c5c54334eaa9@epcas3p4.samsung.com>
 <CAPDyKFpKoXd9yuX5vR-CACtXKGysmV0AqKnjxQ+hTGU+kgwceQ@mail.gmail.com>
 <6031045c-0eb2-7bea-1efd-874dade0f009@samsung.com>
 <7bc4cb38-6864-c87e-390e-7f9f3f133dd6@intel.com>
 <c254c113-8f21-ca71-da5b-02fb95fed412@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c254c113-8f21-ca71-da5b-02fb95fed412@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 01, 2016 at 07:13:29AM +0900, Jaehoon Chung wrote:
> On 10/31/2016 09:34 PM, Adrian Hunter wrote:
> > On 31/10/16 13:59, Jaehoon Chung wrote:
> >> On 10/28/2016 05:12 PM, Ulf Hansson wrote:
> >>> On 25 October 2016 at 21:58, Zach Brown <zach.brown@ni.com> wrote:
> >>>> On some systems the sdhci capabilty registers are incorrect for one
> >>>> reason or another.
> >>>>
> >>>> The sdhci-caps-mask property specifies which bits in the registers
> >>>> are incorrect and should be turned off before using sdhci-caps to turn
> >>>> on bits.
> >>>>
> >>>> The sdhci-caps property specifies which bits should be turned on.
> >>>>
> >>>> Signed-off-by: Zach Brown <zach.brown@ni.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/mmc/mmc.txt | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> >>>> index 8a37782..1415aa0 100644
> >>>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> >>>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> >>>
> >>> The bindings in this document are common mmc DT bindings, not bindings
> >>> specific to a mmc controller.
> >>>
> >>> So unless these bindings are applicable for another controller than
> >>> sdhci, I suggest we create a new file to document these.
> >>> How about Documentation/devicetree/bindings/mmc/sdhci.txt?
> >>>
> >>>> @@ -52,6 +52,13 @@ Optional properties:
> >>>>  - no-sdio: controller is limited to send sdio cmd during initialization
> >>>>  - no-sd: controller is limited to send sd cmd during initialization
> >>>>  - no-mmc: controller is limited to send mmc cmd during initialization
> >>>> +- sdhci-caps-mask: The sdhci capabilities registers are incorrect. This 64bit
> >>>
> >>> /s/registers/register
> >>>
> >>> This applies to some more places below as well.
> >>>
> >>>> +  property corresponds to the bits in the sdhci capabilty registers. If the bit
> >>>> +  is on in the mask then the bit is incorrect in the registers and should be
> >>>> +  turned off.
> >>>> +- sdhci-caps: The sdhci capabilities registers are incorrect. This 64bit
> >>>> +  property corresponds to the bits in the sdhci capability registers. If the
> >>>> +  bit is on in the property then the bit should be on in the reigsters.
> >>>
> >>> /s/reigsters/register
> >>>
> >>>>
> >>>>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
> >>>>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> >>>> --
> >>>> 2.7.4
> >>>>
> >>>
> >>> Overall, I like this idea as it gives us good flexibility. Thus it
> >>> should avoid us to having to add any further new similar "sdhci broken
> >>> cap" DT binding. We could also decide to start deprecate some of the
> >>> existing sdhci bindings, if we think that makes sense.
> >>>
> >>> The downside is that we get a "magic" hex value in the dts. Although,
> >>> people could address this issue by providing some comments about what
> >>> the bits it means in the dts files themselves.
> >>
> >> I think it's not good about getting "magic" hex value.
> >> In my experience, it's too difficult what bits means and calculate..
> >> Because some people who i know had already used like this.(locally..)
> >>
> >> It needs to consider this...otherwise..it should become really complex magic code.
> >
> > The bits we use are listed in sdhci.h and how we use them can be determined
> > from the sdhci source code.  Also, from the hardware perspective, there is
> > the SDHCI specification.  So what the bits mean is readily available.
> >
> > With regard to calculating the values, won't it be obvious from testing if
> > they are wrong?
>
> You're right. But I didn't see the real use case for this properties.
> If it needs to add these properties, why didn't add codes relevant to these in device-tree?
> Otherwise, this code should be dead code.
>

The issue here is the sdhci has a register that is supposed report the
capabilities of the device, but it can be wrong. It might turn on a mode or
behavior that should not be on.

For example, in our use case the sdhci itself is capable of highspeed so it
naturally has the highspeed capable bit set in it's capabilities register.
However due to board setup, the entire system is not actually capable of
highspeed. So we need a way to say the sdhci capabilities register's highspeed
bit is incorrect.

A simple "no-sdhci-highspeed" device tree property might suffice, but there are
roughly ~64 sdhci capabilities represented in the capabilities register.
Instead of creating ~64 device-tree properties to handle each individually this
patch set creates just two that handle them all. In a way that is flexible
enough to correct all ~64 or just 1 or any subset depending on the use case.
