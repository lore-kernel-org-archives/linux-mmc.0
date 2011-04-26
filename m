From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 00/12] add support for host controller v3.00
Date: Tue, 26 Apr 2011 09:19:09 -0400
Message-ID: <m3liyxrvzm.fsf@pullcord.laptop.org>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
	<m3bp07txrb.fsf@pullcord.laptop.org>
	<6C03668EAF45B747AF947A1603D1B300EB72D340@SAUSEXMBP01.amd.com>
	<m3tydlrxbc.fsf@pullcord.laptop.org>
	<20110426130259.GA2446@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38214 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab1DZNPb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2011 09:15:31 -0400
In-Reply-To: <20110426130259.GA2446@pengutronix.de> (Wolfram Sang's message of
	"Tue, 26 Apr 2011 15:02:59 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "Nath, Arindam" <Arindam.Nath@amd.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "prakity@marvell.com" <prakity@marvell.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Wolfram,

On Tue, Apr 26 2011, Wolfram Sang wrote:
> On Tue, Apr 26, 2011 at 08:50:31AM -0400, Chris Ball wrote:
>> Hi Arindam,
>> 
>> On Tue, Apr 26 2011, Nath, Arindam wrote:
>> Yes, sounds good -- linux-mmc@ folks, would anyone like to give a
>> Tested- or Reviewed-by: on these patches?
>
> Considering this is a rather large changeset (thanks for doing it!),
> what about putting it into an extra -next round (i.e. for-2.6.41) unless
> somebody reviews or tests the series? I sadly can't, no hardware.

I agree we should do this if we don't get reviewers or testers, but
I think we've already got several people testing this out -- I know
prakity has been following it and building a patchset on top of it
for eMMC, and we've had a huge number of review comments already.

So, I expect we'll pick up Tested-by tags and can plan on submitting
for .40 unless we start seeing regressions in mmc-next.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
