From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC-4.5 Data Tag Support
Date: Thu, 12 Jan 2012 14:18:24 -0500
Message-ID: <m2ehv4bugv.fsf@bob.laptop.org>
References: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
	<CANfBPZ9gDkHK01bsMjf_CpkA-8s1U3X4WnAxO_=q9XdGODuf7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36721 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926Ab2ALTSf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 14:18:35 -0500
In-Reply-To: <CANfBPZ9gDkHK01bsMjf_CpkA-8s1U3X4WnAxO_=q9XdGODuf7w@mail.gmail.com>
	(Venkatraman S.'s message of "Thu, 12 Jan 2012 19:58:29 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

Hi,

On Thu, Jan 12 2012, S, Venkatraman wrote:
> On Wed, Dec 21, 2011 at 1:09 PM, Saugata Das <saugata.das@stericsson.com> wrote:
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> MMC-4.5 data tag feature will be used to store the file system
>> meta-data in the
>> tagged region of eMMC. This will improve the write and subsequent
>> read transfer
>> time for the meta data.
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>
> I tested this on a device which supports a data tag unit size of 8K.
> Tested-by: Venkatraman S <svenkatr@ti.com>

Thanks for testing!  I've pushed it to mmc-next.

> Chris,
>   Can this go into 3.3 ?

I think 3.4 would be better after a full round of linux-next testing,
since this sounds like it could expose card-dependent quirks that could
destroy filesystems.  Better to be safe.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
