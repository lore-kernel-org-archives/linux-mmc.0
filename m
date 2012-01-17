From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] MMC-4.5 Data Tag Support
Date: Tue, 17 Jan 2012 19:10:19 +0530
Message-ID: <CANfBPZ_DQyWoo1spZJoO+Lo_7Pd7MKNaCHmDKQ-K4SPivhag-w@mail.gmail.com>
References: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
 <CANfBPZ9gDkHK01bsMjf_CpkA-8s1U3X4WnAxO_=q9XdGODuf7w@mail.gmail.com>
 <m2ehv4bugv.fsf@bob.laptop.org> <CAH9JG2VQ9K7x8_qD1gXbRNAdOB=SgON9w3EEJ4KP9q_qottA8g@mail.gmail.com>
 <CANfBPZ_s3R9-OmCPgXkOeOEOQK5HztDQ9sUfuKd+HvSsBfHNXg@mail.gmail.com> <CAH9JG2UxqJAGyxdrmuoc+jpRoRfKcEws=0UjS3u0M-1KE4p9SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50683 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753484Ab2AQNkm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Jan 2012 08:40:42 -0500
Received: by mail-bk0-f51.google.com with SMTP id q10so4668314bka.38
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2012 05:40:41 -0800 (PST)
In-Reply-To: <CAH9JG2UxqJAGyxdrmuoc+jpRoRfKcEws=0UjS3u0M-1KE4p9SA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Chris Ball <cjb@laptop.org>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

On Mon, Jan 16, 2012 at 6:39 PM, Kyungmin Park <kmpark@infradead.org> w=
rote:
> On Mon, Jan 16, 2012 at 7:37 PM, S, Venkatraman <svenkatr@ti.com> wro=
te:
>> On Fri, Jan 13, 2012 at 3:40 PM, Kyungmin Park <kmpark@infradead.org=
> wrote:
>>> On 1/13/12, Chris Ball <cjb@laptop.org> wrote:
>>>> Hi,
>>>>
>>>> On Thu, Jan 12 2012, S, Venkatraman wrote:
>>>>> On Wed, Dec 21, 2011 at 1:09 PM, Saugata Das <saugata.das@sterics=
son.com>
>>>>> wrote:
>>>>>> From: Saugata Das <saugata.das@linaro.org>
>>>>>>
>>>>>> MMC-4.5 data tag feature will be used to store the file system
>>>>>> meta-data in the
>>>>>> tagged region of eMMC. This will improve the write and subsequen=
t
>>>>>> read transfer
>>>>>> time for the meta data.
>>>>>>
>>>>>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>>>>
>>>>> I tested this on a device which supports a data tag unit size of =
8K.
>>>>> Tested-by: Venkatraman S <svenkatr@ti.com>
>>>>
>>>> Thanks for testing! =A0I've pushed it to mmc-next.
>>>>
>>>>> Chris,
>>>>> =A0 Can this go into 3.3 ?
>>>>
>>>> I think 3.4 would be better after a full round of linux-next testi=
ng,
>>>> since this sounds like it could expose card-dependent quirks that =
could
>>>> destroy filesystems. =A0Better to be safe.
>>> I'm afraid it that it's really required since some features. data t=
ag,
>>> context id, and packed command, are not mutual exclusive. so I hope=
 to
>>> make it select. I mean it's not measured the real performance gain
>>> and/or other feature. so hope to enable/disable by platform data.
>>>
>>> How do you think?
>>>
>>> Thank you,
>>> Kyungmin Park
>>
>> I don't understand your comment on them not being mutually exclusive=
=2E
>> As it is, these are core features and they don't belong in platform =
data.
>> Can you explain a bit more ?
> To get the gain these features, data tag, context ID, it requires the
> firmware support.
> But currently there's no idea to support these feature at firmware. S=
o
> we can't get the valuable performance gain.

But that's neither a kernel issue, nor is a 'regression'. At worst,
the card should behave like a 4.41 standard card for an unoptimized fir=
mware.

The platform data is the wrong location to indicate what are
essentially standards
driven features.
I am wondering already the need for CAPS2_BKOPS_SUPPORT and the like,
when the feature has nothing to do with the host controller.

> and now there's no data if it enables the both, data tag, packed
> command or other combination, e.g., cache and so on.
>
> So I suggest make it enable/disable these features at platform data,
> similarly support pre-defined op by MMC_CAP_CMD23.
> and I saw the Saugata's active regards with Context ID. =A0so it's al=
so
> make it configurable.
>
> Thank you,
> Kyungmin Park
