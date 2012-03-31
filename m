From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: swap on eMMC and other flash
Date: Sat, 31 Mar 2012 09:24:19 +0000
Message-ID: <201203310924.19708.arnd@arndb.de>
References: <201203301744.16762.arnd@arndb.de> <201203301850.22784.arnd@arndb.de> <CAJN=5gDBQJc_KXUadqtzmxPqPF71PDcToGo_T-agNey9eN2MQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60093 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2CaJY1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Mar 2012 05:24:27 -0400
In-Reply-To: <CAJN=5gDBQJc_KXUadqtzmxPqPF71PDcToGo_T-agNey9eN2MQA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Pfeffer <zach.pfeffer@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-mm@kvack.org, Alex Lemberg <alex.lemberg@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org, Hyojin Jeong <syr.jeong@samsung.com>, "Luca Porzio (lporzio)" <lporzio@micron.com>, kernel-team@android.com, Yejin Moon <yejin.moon@samsung.com>

On Friday 30 March 2012, Zach Pfeffer wrote:
> Last I read Transparent Huge Pages are still paged in and out a page
> at a time, is this or was this ever the case? If it is the case should
> the paging system be extended to support THP which would take care of
> the big block issues with flash media?
> 

I don't think we ever want to get /that/ big. As I mentioned, going
beyond 64kb does not improve throughput on most flash media. However,
paging out 16MB causes a very noticeable delay of up to a few seconds
on slow drives, which would be inacceptable to users.

Also, that would only deal with the rare case where the data you
want to page out is actually in huge pages, not the common case.

	Arnd
