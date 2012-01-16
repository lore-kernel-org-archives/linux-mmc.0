From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] MMC-4.5 Data Tag Support
Date: Mon, 16 Jan 2012 22:09:30 +0900
Message-ID: <CAH9JG2UxqJAGyxdrmuoc+jpRoRfKcEws=0UjS3u0M-1KE4p9SA@mail.gmail.com>
References: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
	<CANfBPZ9gDkHK01bsMjf_CpkA-8s1U3X4WnAxO_=q9XdGODuf7w@mail.gmail.com>
	<m2ehv4bugv.fsf@bob.laptop.org>
	<CAH9JG2VQ9K7x8_qD1gXbRNAdOB=SgON9w3EEJ4KP9q_qottA8g@mail.gmail.com>
	<CANfBPZ_s3R9-OmCPgXkOeOEOQK5HztDQ9sUfuKd+HvSsBfHNXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:34991 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab2APNJb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2012 08:09:31 -0500
Received: by qadc16 with SMTP id c16so1237497qad.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2012 05:09:31 -0800 (PST)
In-Reply-To: <CANfBPZ_s3R9-OmCPgXkOeOEOQK5HztDQ9sUfuKd+HvSsBfHNXg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

On Mon, Jan 16, 2012 at 7:37 PM, S, Venkatraman <svenkatr@ti.com> wrote=
:
> On Fri, Jan 13, 2012 at 3:40 PM, Kyungmin Park <kmpark@infradead.org>=
 wrote:
>> On 1/13/12, Chris Ball <cjb@laptop.org> wrote:
>>> Hi,
>>>
>>> On Thu, Jan 12 2012, S, Venkatraman wrote:
>>>> On Wed, Dec 21, 2011 at 1:09 PM, Saugata Das <saugata.das@stericss=
on.com>
>>>> wrote:
>>>>> From: Saugata Das <saugata.das@linaro.org>
>>>>>
>>>>> MMC-4.5 data tag feature will be used to store the file system
>>>>> meta-data in the
>>>>> tagged region of eMMC. This will improve the write and subsequent
>>>>> read transfer
>>>>> time for the meta data.
>>>>>
>>>>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>>>
>>>> I tested this on a device which supports a data tag unit size of 8=
K.
>>>> Tested-by: Venkatraman S <svenkatr@ti.com>
>>>
>>> Thanks for testing! =A0I've pushed it to mmc-next.
>>>
>>>> Chris,
>>>> =A0 Can this go into 3.3 ?
>>>
>>> I think 3.4 would be better after a full round of linux-next testin=
g,
>>> since this sounds like it could expose card-dependent quirks that c=
ould
>>> destroy filesystems. =A0Better to be safe.
>> I'm afraid it that it's really required since some features. data ta=
g,
>> context id, and packed command, are not mutual exclusive. so I hope =
to
>> make it select. I mean it's not measured the real performance gain
>> and/or other feature. so hope to enable/disable by platform data.
>>
>> How do you think?
>>
>> Thank you,
>> Kyungmin Park
>
> I don't understand your comment on them not being mutually exclusive.
> As it is, these are core features and they don't belong in platform d=
ata.
> Can you explain a bit more ?
To get the gain these features, data tag, context ID, it requires the
firmware support.
But currently there's no idea to support these feature at firmware. So
we can't get the valuable performance gain.
and now there's no data if it enables the both, data tag, packed
command or other combination, e.g., cache and so on.

So I suggest make it enable/disable these features at platform data,
similarly support pre-defined op by MMC_CAP_CMD23.
and I saw the Saugata's active regards with Context ID.  so it's also
make it configurable.

Thank you,
Kyungmin Park
