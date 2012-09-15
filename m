From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v11] mmc: support BKOPS feature for eMMC
Date: Sat, 15 Sep 2012 13:01:41 +0900
Message-ID: <5053FDA5.9040108@samsung.com>
References: <500E00E8.7040504@samsung.com>
 <CAEwNFnA0CKaORGJ1TVnjYgLgi6dtgebVZ1xUVeY6MU92LWb9RA@mail.gmail.com>
 <50164D28.4030907@samsung.com>
 <5d379475a64b20988a535fa01213d62a.squirrel@www.codeaurora.org>
 <87ehmsyo07.fsf@octavius.laptop.org> <m3r4q40x8q.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46177 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab2IOEBx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Sep 2012 00:01:53 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MAD00LV1HV08450@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 15 Sep 2012 13:01:52 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MAD004S8HV3J930@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 15 Sep 2012 13:01:51 +0900 (KST)
In-reply-to: <m3r4q40x8q.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: merez@codeaurora.org, Jaehoon Chung <jh80.chung@samsung.com>, Minchan Kim <minchan@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

Hi Chris,

I will send the next version until next Monday.

Best Regards,
Jaehoon Chung

On 09/15/2012 12:40 PM, Chris Ball wrote:
> Hi Jaehoon,
> 
> On Mon, Aug 27 2012, Chris Ball wrote:
>>> I'm not sure it would be a good idea to allocate the buffer every time the
>>> ext_csd is read since with the periodic BKOPs we might do it more often to
>>> see if there is a need for BKOPs.
>>> How about keeping the buffer in the card structure?
>>
>> It's a little large for that, but it would be worth it if we really do
>> use it regularly.  Perhaps go with the kmalloc option for now, add a
>> comment explaining that we should consider storing the entire ext_csd
>> in mmc_card later, and revisit it when the periodic bkops support is
>> submitted and we know how often we need to read the status?
> 
> Do you have an ETA on v12 of this patch?  We're running out of time to
> get it tested before 3.7 opens.  Thanks!
> 
> - Chris.
> 

