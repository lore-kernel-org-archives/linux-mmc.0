From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Mon, 29 Aug 2016 13:21:41 +0200
Message-ID: <CAPDyKFpGJ=0y3B5dsQZsaU41pzEoU5PuwWi9R-zXtKet7O87ZA@mail.gmail.com>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825105640.GA5439@remoulade> <20160825171539.GA13571@zach-desktop>
 <20160825180959.GA14705@remoulade> <20160825182621.GA14817@zach-desktop>
 <20160825182852.GB15000@remoulade> <20160825204645.GA19450@zach-desktop>
 <CAPDyKFpcFus1oysdRuK6vUALXXdy8_SsDZ3n8LkyM1AZLZY+QQ@mail.gmail.com> <20160826222945.GA6679@zach-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38019 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756135AbcH2LWE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2016 07:22:04 -0400
Received: by mail-wm0-f45.google.com with SMTP id o80so86419426wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2016 04:21:43 -0700 (PDT)
In-Reply-To: <20160826222945.GA6679@zach-desktop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lars-Peter Clausen <lars@metafoo.de>

On 27 August 2016 at 00:29, Zach Brown <zach.brown@ni.com> wrote:
> On Fri, Aug 26, 2016 at 09:42:38AM +0200, Ulf Hansson wrote:
>> On 25 August 2016 at 22:46, Zach Brown <zach.brown@ni.com> wrote:
>> > On Thu, Aug 25, 2016 at 07:28:55PM +0100, Mark Rutland wrote:
>> >> On Thu, Aug 25, 2016 at 01:26:22PM -0500, Zach Brown wrote:
>> >> > On Thu, Aug 25, 2016 at 07:10:00PM +0100, Mark Rutland wrote:
>> >> > > On Thu, Aug 25, 2016 at 12:15:44PM -0500, Zach Brown wrote:
>> >> > > > In cases where the card is non-removable then polling doesn't make sense.
>> >> > >
>> >> > > We have the non-removable property to describe that, so we can also look at that.
>> >> > >
>> >> > > > So it doesn't make sense to tie the test mode workaround into the broken-cd
>> >> > > > property, even though I agree the nature of the defect fits under the notion
>> >> > > > of the CD being broken.
>> >> > >
>> >> > > Maybe not solely on broken-cd, but I think that we dont necessarily need a new
>> >> > > DT property. As above, broken-cd, non-removable, and the compatible string may
>> >> > > together give the kernel enough information to choose the right thing to do.
>> >> > >
>> >> > > Thanks,
>> >> > > Mark.
>> >> >
>> >> > I'm not sure if I understand your suggestion completely. Are you suggesting
>> >> > setting both the broken-cd and non-removable properties? That would make sense,
>> >> > but my understanding was that the two properities are not meant to co-exist. In
>> >> > /Documentation/devicetree/bindings/mmc/mmc.txt it states that only one should
>> >> > be supplied. Don't the two properties conflict with each other?
>> >>
>> >> They do for the cases that exist today, but given we're updating the document
>> >> anyway, we could simply clarify the cases in which the two can sanely co-exist
>> >> (e.g.  for this particular IP block).
>>
>> No, please!
>>
>> Depending on the SDHCI variant there is already some difference on how
>> broken-cd is treated.
>>
>> Let's not add yet another, as I think it will be too complicated for
>> people to understand the bindings.
>>
>
> Shawn Lin pointed out that there might be instances of the arasan controller
> that don't have the behavior the patch addresses. Having a new DT binding
> specific for this case would avoid needing to maintain a list of controllers
> that need the fix.
>

Okay!

>> >>
>> >> Thanks,
>> >> Mark.
>> >
>> > That makes sense. I'll change the documentation for broken-cd and non-removable
>> > in the IP specific document and change the driver accordingly.
>>
>> I rather have a new DT binding specific for this case.
>>
>> Perhaps there's a better name than "fake-cd". How about "force-cd", or
>> if someone can come up with a better name.
>>
>> Kind regards
>> Uffe
>
> I've been trying to come up with a better name. Here are a few ideas
> cd-not-wired
> needs-test-cd
> fails-without-force-cd

Yeah, we could probably announce a naming competition for this. :-)

Just select one of them and try to get an ack from Rob/Mark then I
will pick up the change.

Kind regards
Uffe
