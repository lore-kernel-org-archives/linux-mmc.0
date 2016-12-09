From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] mmc: pwrseq-simple: add disable-post-power-on option
Date: Fri, 9 Dec 2016 12:09:30 -0600
Message-ID: <20161209180930.nsy2ys66q2thbxpx@rob-hp-laptop>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
 <1480659462-29536-5-git-send-email-matt@ranostay.consulting>
 <CAPDyKFpCY+LHFkJVJGHaSDODVR7_Xr2ohpdOAn9Hd3qZbDTQ6w@mail.gmail.com>
 <B85DDAB6-D86B-4DD9-BF2C-BCB9FA09CD15@ranostay.consulting>
 <CAPDyKFp9t1SEwQZ=uTHegbpgxxevQEy4kC=wPkc8Bo16030MNg@mail.gmail.com>
 <CAJ_EiSQWN0KF1rJDwzOeoi--g1Z0XNYevYzCLG=NngcdgF6VUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33522 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753380AbcLISJc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2016 13:09:32 -0500
Content-Disposition: inline
In-Reply-To: <CAJ_EiSQWN0KF1rJDwzOeoi--g1Z0XNYevYzCLG=NngcdgF6VUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <liam@networkimprov.net>

On Fri, Dec 02, 2016 at 01:06:47AM -0800, Matt Ranostay wrote:
> On Fri, Dec 2, 2016 at 12:28 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 2 December 2016 at 08:22, Matt Ranostay <matt@ranostay.consulting> wrote:
> >>
> >>
> >>> On Dec 1, 2016, at 23:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>
> >>>> On 2 December 2016 at 07:17, Matt Ranostay <matt@ranostay.consulting> wrote:
> >>>> Add optional device-post-power-on parameters to disable post_power_on
> >>>> function from being called since this breaks some device.
> >>>>
> >>>> Cc: Tony Lindgren <tony@atomide.com>
> >>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> >>>> ---
> >>>> Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
> >>>> drivers/mmc/core/pwrseq_simple.c                            | 7 +++++++
> >>>> 2 files changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> >>>> index bea306d772d1..09fa153f743e 100644
> >>>> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> >>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> >>>> @@ -24,6 +24,8 @@ Optional properties:
> >>>>        de-asserting the reset-gpios (if any)
> >>>> - invert-off-state: Invert the power down state for the reset-gpios (if any)
> >>>>        and pwrdn-gpios (if any)
> >>>> +- disable-post-power-on : Avoid post_power_on function from being called since
> >>>> +       this breaks some devices
> >>>
> >>> This is a bit weird. I would like to avoid this, if possible.
> >>>
> >>> Perhaps if you simply describe the sequence in detail for your device
> >>> we can figure out the best option together.
> >>
> >> Yeah I know it is a bit weird but we need to keep that reset pin high for at least some time after pre power on.   So any case it would be another property
> >
> > This went offlist, please resend.
> >
> > Moreover, please try to describe the sequence you need in detail
> > according to your HW spec.
> >
> 
> Yeah oops....
> 
> So basically we need to drive the reset and powerdown lines high with
> a 300 milliseconds delay between both...
> can't have the reset line low with post power on (pretty sure but
> would need a delay anyway), and we need both reset + powerdown line
> set low on powerdown.
> 
> So the power down sequence would need to be reversed for this
> application in pwrseq-simple.

This sounds like you need a device specific sequence to me. Otherwise, 
write a language to describe any power control waveforms rather than 
trying to bolt on more and more properties. (Don't really go write a 
language.) 

Rob
