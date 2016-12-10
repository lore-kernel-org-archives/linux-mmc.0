From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: Re: [PATCH 4/4] mmc: pwrseq-simple: add disable-post-power-on option
Date: Fri, 9 Dec 2016 21:47:29 -0800
Message-ID: <CAJ_EiSTBmm6HDCCNSTp1moOM3gOQx3eiMEBT0vo6Eawi_cxNcQ@mail.gmail.com>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
 <1480659462-29536-5-git-send-email-matt@ranostay.consulting>
 <CAPDyKFpCY+LHFkJVJGHaSDODVR7_Xr2ohpdOAn9Hd3qZbDTQ6w@mail.gmail.com>
 <B85DDAB6-D86B-4DD9-BF2C-BCB9FA09CD15@ranostay.consulting>
 <CAPDyKFp9t1SEwQZ=uTHegbpgxxevQEy4kC=wPkc8Bo16030MNg@mail.gmail.com>
 <CAJ_EiSQWN0KF1rJDwzOeoi--g1Z0XNYevYzCLG=NngcdgF6VUw@mail.gmail.com> <20161209180930.nsy2ys66q2thbxpx@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209180930.nsy2ys66q2thbxpx@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Dec 9, 2016 at 10:09 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Dec 02, 2016 at 01:06:47AM -0800, Matt Ranostay wrote:
>> On Fri, Dec 2, 2016 at 12:28 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > On 2 December 2016 at 08:22, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org> wrote:
>> >>
>> >>
>> >>> On Dec 1, 2016, at 23:13, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> >>>
>> >>>> On 2 December 2016 at 07:17, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org> wrote:
>> >>>> Add optional device-post-power-on parameters to disable post_power_on
>> >>>> function from being called since this breaks some device.
>> >>>>
>> >>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> >>>> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> >>>> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
>> >>>> ---
>> >>>> Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
>> >>>> drivers/mmc/core/pwrseq_simple.c                            | 7 +++++++
>> >>>> 2 files changed, 9 insertions(+)
>> >>>>
>> >>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> >>>> index bea306d772d1..09fa153f743e 100644
>> >>>> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> >>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> >>>> @@ -24,6 +24,8 @@ Optional properties:
>> >>>>        de-asserting the reset-gpios (if any)
>> >>>> - invert-off-state: Invert the power down state for the reset-gpios (if any)
>> >>>>        and pwrdn-gpios (if any)
>> >>>> +- disable-post-power-on : Avoid post_power_on function from being called since
>> >>>> +       this breaks some devices
>> >>>
>> >>> This is a bit weird. I would like to avoid this, if possible.
>> >>>
>> >>> Perhaps if you simply describe the sequence in detail for your device
>> >>> we can figure out the best option together.
>> >>
>> >> Yeah I know it is a bit weird but we need to keep that reset pin high for at least some time after pre power on.   So any case it would be another property
>> >
>> > This went offlist, please resend.
>> >
>> > Moreover, please try to describe the sequence you need in detail
>> > according to your HW spec.
>> >
>>
>> Yeah oops....
>>
>> So basically we need to drive the reset and powerdown lines high with
>> a 300 milliseconds delay between both...
>> can't have the reset line low with post power on (pretty sure but
>> would need a delay anyway), and we need both reset + powerdown line
>> set low on powerdown.
>>
>> So the power down sequence would need to be reversed for this
>> application in pwrseq-simple.
>
> This sounds like you need a device specific sequence to me. Otherwise,
> write a language to describe any power control waveforms rather than
> trying to bolt on more and more properties. (Don't really go write a
> language.)
>

Yeah I no interest in that as well :).

So I'll resubmit with the patchset comments so far.

> Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
