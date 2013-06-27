From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: dw: don't check resource with devm_ioremap_resource
Date: Thu, 27 Jun 2013 11:25:49 -0400
Message-ID: <87fvw3poci.fsf@octavius.laptop.org>
References: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<001701ce61f5$220667d0$66133770$%jun@samsung.com>
	<1370441659.29283.295.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52447 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab3F0PZx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:25:53 -0400
In-Reply-To: <1370441659.29283.295.camel@smile> (Andy Shevchenko's message of
	"Wed, 05 Jun 2013 17:14:19 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org

Hi Andy,

On Wed, Jun 05 2013, Andy Shevchenko wrote:
> On Wed, 2013-06-05 at 23:01 +0900, Seungwon Jeon wrote: 
>> On 06/05/13 6:24 PM, Andy Shevchenko wrote:
>> > devm_ioremap_resource does sanity checks on the given resource. No need to
>> > duplicate this in the driver.
>> > 
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> 
>> Looks good to me.
>> 'dw_mmc'(instead of 'dw') as a prefix of subject is expected with other patches, though.
>> Specially, dw_mmc-pci is for PATCH 3/3.
>
> Shall I resubmit patches?
> I think no-one can mess up with this, because we fortunately have only
> one mmc designware driver there.

Thanks, I pushed all three patches to mmc-next for 3.11 and corrected
the titles.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
