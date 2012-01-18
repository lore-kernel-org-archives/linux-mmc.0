From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH] MMC-4.5 Data Tag Support
Date: Wed, 18 Jan 2012 20:20:46 +0530
Message-ID: <CAKLKtzftKSs1zp=8c8A2cu_ippzjt8r7aLzsLR=S+R2p1eggmg@mail.gmail.com>
References: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
	<CANfBPZ9gDkHK01bsMjf_CpkA-8s1U3X4WnAxO_=q9XdGODuf7w@mail.gmail.com>
	<m2ehv4bugv.fsf@bob.laptop.org>
	<CAH9JG2VQ9K7x8_qD1gXbRNAdOB=SgON9w3EEJ4KP9q_qottA8g@mail.gmail.com>
	<CANfBPZ_s3R9-OmCPgXkOeOEOQK5HztDQ9sUfuKd+HvSsBfHNXg@mail.gmail.com>
	<CAH9JG2UxqJAGyxdrmuoc+jpRoRfKcEws=0UjS3u0M-1KE4p9SA@mail.gmail.com>
	<CANfBPZ_DQyWoo1spZJoO+Lo_7Pd7MKNaCHmDKQ-K4SPivhag-w@mail.gmail.com>
	<CAH9JG2Xpz4ZQ6Odk-7LoOeBb_0OY4zC1o-8rgpjsoad1JYzXiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35153 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757783Ab2AROus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2012 09:50:48 -0500
Received: by werb13 with SMTP id b13so418150wer.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2012 06:50:47 -0800 (PST)
In-Reply-To: <CAH9JG2Xpz4ZQ6Odk-7LoOeBb_0OY4zC1o-8rgpjsoad1JYzXiA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

On 18 January 2012 18:45, Kyungmin Park <kmpark@infradead.org> wrote:
> On Tue, Jan 17, 2012 at 10:40 PM, S, Venkatraman <svenkatr@ti.com> wr=
ote:
>> On Mon, Jan 16, 2012 at 6:39 PM, Kyungmin Park <kmpark@infradead.org=
> wrote:
>>> On Mon, Jan 16, 2012 at 7:37 PM, S, Venkatraman <svenkatr@ti.com> w=
rote:
>>>> On Fri, Jan 13, 2012 at 3:40 PM, Kyungmin Park <kmpark@infradead.o=
rg> wrote:
>>>>> On 1/13/12, Chris Ball <cjb@laptop.org> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Thu, Jan 12 2012, S, Venkatraman wrote:
>>>>>>> On Wed, Dec 21, 2011 at 1:09 PM, Saugata Das <saugata.das@steri=
csson.com>
>>>>>>> wrote:
>>>>>>>> From: Saugata Das <saugata.das@linaro.org>
>>>>>>>>
>>>>>>>> MMC-4.5 data tag feature will be used to store the file system
>>>>>>>> meta-data in the
>>>>>>>> tagged region of eMMC. This will improve the write and subsequ=
ent
>>>>>>>> read transfer
>>>>>>>> time for the meta data.
>>>>>>>>
>>>>>>>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>>>>>>
>>>>>>> I tested this on a device which supports a data tag unit size o=
f 8K.
>>>>>>> Tested-by: Venkatraman S <svenkatr@ti.com>
>>>>>>
>>>>>> Thanks for testing! =A0I've pushed it to mmc-next.
>>>>>>
>>>>>>> Chris,
>>>>>>> =A0 Can this go into 3.3 ?
>>>>>>
>>>>>> I think 3.4 would be better after a full round of linux-next tes=
ting,
>>>>>> since this sounds like it could expose card-dependent quirks tha=
t could
>>>>>> destroy filesystems. =A0Better to be safe.
>>>>> I'm afraid it that it's really required since some features. data=
 tag,
>>>>> context id, and packed command, are not mutual exclusive. so I ho=
pe to
>>>>> make it select. I mean it's not measured the real performance gai=
n
>>>>> and/or other feature. so hope to enable/disable by platform data.
>>>>>
>>>>> How do you think?
>>>>>
>>>>> Thank you,
>>>>> Kyungmin Park
>>>>
>>>> I don't understand your comment on them not being mutually exclusi=
ve.
>>>> As it is, these are core features and they don't belong in platfor=
m data.
>>>> Can you explain a bit more ?
>>> To get the gain these features, data tag, context ID, it requires t=
he
>>> firmware support.
>>> But currently there's no idea to support these feature at firmware.=
 So
>>> we can't get the valuable performance gain.
>>
>> But that's neither a kernel issue, nor is a 'regression'. At worst,
>> the card should behave like a 4.41 standard card for an unoptimized =
firmware.
> Basically I agree that implement the codes by Spec. but it doesn't
> mean all features are required for eMMC.
> At some condition. frequent suspend & resume test, power off
> notification makes chip lifespan worse.
> So we decides that don't use this feature for our product. At that
> time, make a spec. they only consider it at power off case. but we
> implement it at suspend & resume.
> Like similarly they think the data tag seems interesting but it also
> uses the some special area at eMMC internally.
> Yes it's firmware dependent. at least. we can't measured it properly
> so we have to verify it at real condition.
> That's reason make it configurable.
>

Power OFF notification should help in improving the device lifespan.
The implementation of using power OFF notification during
suspend/resume was wrong and Girish is working on it to improve it.

The data tag does not cause any additional write which could impact
device lifetime. It should improve throughput if eMMC firmware
implements the feature. Otherwise, it should be just harmless.

But I will still take your recommendation to keep some host specific
configuration to enable any of the MMC-4.5 features.

> Kyungmin Park
>>
>> The platform data is the wrong location to indicate what are
>> essentially standards
>> driven features.
>> I am wondering already the need for CAPS2_BKOPS_SUPPORT and the like=
,
>> when the feature has nothing to do with the host controller.
>>
>>> and now there's no data if it enables the both, data tag, packed
>>> command or other combination, e.g., cache and so on.
>>>
>>> So I suggest make it enable/disable these features at platform data=
,
>>> similarly support pre-defined op by MMC_CAP_CMD23.
>>> and I saw the Saugata's active regards with Context ID. =A0so it's =
also
>>> make it configurable.
>>>
>>> Thank you,
>>> Kyungmin Park
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
