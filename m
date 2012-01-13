From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] MMC-4.5 Data Tag Support
Date: Fri, 13 Jan 2012 19:10:43 +0900
Message-ID: <CAH9JG2VQ9K7x8_qD1gXbRNAdOB=SgON9w3EEJ4KP9q_qottA8g@mail.gmail.com>
References: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
	<CANfBPZ9gDkHK01bsMjf_CpkA-8s1U3X4WnAxO_=q9XdGODuf7w@mail.gmail.com>
	<m2ehv4bugv.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:53539 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab2AMKKo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 05:10:44 -0500
Received: by qadb10 with SMTP id b10so370308qad.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2012 02:10:43 -0800 (PST)
In-Reply-To: <m2ehv4bugv.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

On 1/13/12, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Jan 12 2012, S, Venkatraman wrote:
>> On Wed, Dec 21, 2011 at 1:09 PM, Saugata Das <saugata.das@stericsson.com>
>> wrote:
>>> From: Saugata Das <saugata.das@linaro.org>
>>>
>>> MMC-4.5 data tag feature will be used to store the file system
>>> meta-data in the
>>> tagged region of eMMC. This will improve the write and subsequent
>>> read transfer
>>> time for the meta data.
>>>
>>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>
>> I tested this on a device which supports a data tag unit size of 8K.
>> Tested-by: Venkatraman S <svenkatr@ti.com>
>
> Thanks for testing!  I've pushed it to mmc-next.
>
>> Chris,
>>   Can this go into 3.3 ?
>
> I think 3.4 would be better after a full round of linux-next testing,
> since this sounds like it could expose card-dependent quirks that could
> destroy filesystems.  Better to be safe.
I'm afraid it that it's really required since some features. data tag,
context id, and packed command, are not mutual exclusive. so I hope to
make it select. I mean it's not measured the real performance gain
and/or other feature. so hope to enable/disable by platform data.

How do you think?

Thank you,
Kyungmin Park
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
