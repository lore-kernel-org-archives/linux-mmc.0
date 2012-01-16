From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] MMC-4.5 Data Tag Support
Date: Mon, 16 Jan 2012 16:07:22 +0530
Message-ID: <CANfBPZ_s3R9-OmCPgXkOeOEOQK5HztDQ9sUfuKd+HvSsBfHNXg@mail.gmail.com>
References: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
 <CANfBPZ9gDkHK01bsMjf_CpkA-8s1U3X4WnAxO_=q9XdGODuf7w@mail.gmail.com>
 <m2ehv4bugv.fsf@bob.laptop.org> <CAH9JG2VQ9K7x8_qD1gXbRNAdOB=SgON9w3EEJ4KP9q_qottA8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:46864 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751841Ab2APKhq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Jan 2012 05:37:46 -0500
Received: by bkbzv3 with SMTP id zv3so1582871bkb.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2012 02:37:43 -0800 (PST)
In-Reply-To: <CAH9JG2VQ9K7x8_qD1gXbRNAdOB=SgON9w3EEJ4KP9q_qottA8g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Chris Ball <cjb@laptop.org>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

On Fri, Jan 13, 2012 at 3:40 PM, Kyungmin Park <kmpark@infradead.org> w=
rote:
> On 1/13/12, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>>
>> On Thu, Jan 12 2012, S, Venkatraman wrote:
>>> On Wed, Dec 21, 2011 at 1:09 PM, Saugata Das <saugata.das@stericsso=
n.com>
>>> wrote:
>>>> From: Saugata Das <saugata.das@linaro.org>
>>>>
>>>> MMC-4.5 data tag feature will be used to store the file system
>>>> meta-data in the
>>>> tagged region of eMMC. This will improve the write and subsequent
>>>> read transfer
>>>> time for the meta data.
>>>>
>>>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>>
>>> I tested this on a device which supports a data tag unit size of 8K=
=2E
>>> Tested-by: Venkatraman S <svenkatr@ti.com>
>>
>> Thanks for testing! =A0I've pushed it to mmc-next.
>>
>>> Chris,
>>> =A0 Can this go into 3.3 ?
>>
>> I think 3.4 would be better after a full round of linux-next testing=
,
>> since this sounds like it could expose card-dependent quirks that co=
uld
>> destroy filesystems. =A0Better to be safe.
> I'm afraid it that it's really required since some features. data tag=
,
> context id, and packed command, are not mutual exclusive. so I hope t=
o
> make it select. I mean it's not measured the real performance gain
> and/or other feature. so hope to enable/disable by platform data.
>
> How do you think?
>
> Thank you,
> Kyungmin Park

I don't understand your comment on them not being mutually exclusive.
As it is, these are core features and they don't belong in platform dat=
a.
Can you explain a bit more ?

Thanks,
Venkat.
