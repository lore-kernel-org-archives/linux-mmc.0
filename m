From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: rename ddr to uhs in ios structure to indicate
 usage
Date: Mon, 14 Feb 2011 15:51:33 -0800
Message-ID: <7D68A5C4-7546-47FE-B2B6-75DEE75DA454@marvell.com>
References: <52D7AFC3-31CF-4938-90EC-3BB4B701CCD4@marvell.com>
 <20110214220341.GA5235@void.printf.net>
 <42E706F2-7E7B-40DB-9716-7E43E6EF873E@marvell.com>
 <m3oc6ew625.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44929 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456Ab1BNXzB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 18:55:01 -0500
In-Reply-To: <m3oc6ew625.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Feb 14, 2011, at 3:27 PM, Chris Ball wrote:

> Hi,
> 
>>> Noticed that this patch ([PATCH 3/3] in "mmc: core: misc bug
>>> fixes") and [PATCH 1/4] in "mmc: sdhci: Dual Data Rate Support"
>>> do the same thing differently -- please followup to the one of
>>> them that's redundant mentioning that it should be dropped from
>>> the set.
> 
>> I checked these two patches from yesterday and they go together.
>> 
>> [PATCH 3/4] mmc: sdhci: Support for SD/MMC Dual Data Rate and
>> [PATCH 1/4] mmc: rename ddr to uhs in ios structure to indicate
>> usage
> 
> Ah, you're looking at 1/4 and 3/4 in the DDR patchset, whereas I'm
> talking about 1/4 in the DDR patchset vs. 3/3 in the "mmc: core: misc
> bug fixes" patchset.  i.e.:
> 
>   http://article.gmane.org/gmane.linux.kernel.mmc/5959
> vs.
>   http://article.gmane.org/gmane.linux.kernel.mmc/5961
> 
> Since they both contain some of the same hunks, they clearly can't
> both be applied together.
> 
> It looks like it's actually the one that was part of "mmc: core misc
> bug fixes" (5959) that's correct, and the one that's part of "sdhci:
> Dual Data Rate Support" needs to be dropped?

drop 5961 -- not correct


> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>
> One Laptop Per Child

