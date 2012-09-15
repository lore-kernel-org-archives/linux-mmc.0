From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v11] mmc: support BKOPS feature for eMMC
Date: Fri, 14 Sep 2012 23:40:37 -0400
Message-ID: <m3r4q40x8q.fsf@pullcord.laptop.org>
References: <500E00E8.7040504@samsung.com>
	<CAEwNFnA0CKaORGJ1TVnjYgLgi6dtgebVZ1xUVeY6MU92LWb9RA@mail.gmail.com>
	<50164D28.4030907@samsung.com>
	<5d379475a64b20988a535fa01213d62a.squirrel@www.codeaurora.org>
	<87ehmsyo07.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34680 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab2IODks (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 14 Sep 2012 23:40:48 -0400
In-Reply-To: <87ehmsyo07.fsf@octavius.laptop.org> (Chris Ball's message of
	"Mon, 27 Aug 2012 18:21:44 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Minchan Kim <minchan@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

Hi Jaehoon,

On Mon, Aug 27 2012, Chris Ball wrote:
>> I'm not sure it would be a good idea to allocate the buffer every time the
>> ext_csd is read since with the periodic BKOPs we might do it more often to
>> see if there is a need for BKOPs.
>> How about keeping the buffer in the card structure?
>
> It's a little large for that, but it would be worth it if we really do
> use it regularly.  Perhaps go with the kmalloc option for now, add a
> comment explaining that we should consider storing the entire ext_csd
> in mmc_card later, and revisit it when the periodic bkops support is
> submitted and we know how often we need to read the status?

Do you have an ETA on v12 of this patch?  We're running out of time to
get it tested before 3.7 opens.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
