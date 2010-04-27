From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: mmc: sdhci.h compile error
Date: Tue, 27 Apr 2010 11:45:28 +0800
Message-ID: <s2x309424b61004262045q2cf453bay7b2fa62571947e5a@mail.gmail.com>
References: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
	 <87zl0rb20u.fsf@linux-g6p1.site>
	 <g2g309424b61004260046hc2773535o2885383daf414b4b@mail.gmail.com>
	 <87mxwqzcl6.fsf@linux-g6p1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:38966 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0D0Dp3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2010 23:45:29 -0400
Received: by qyk9 with SMTP id 9so18612110qyk.1
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2010 20:45:28 -0700 (PDT)
In-Reply-To: <87mxwqzcl6.fsf@linux-g6p1.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>

Hi, Matt

On Mon, Apr 26, 2010 at 7:18 PM, Matt Fleming <matt@console-pimps.org> wrote:
> On Mon, 26 Apr 2010 15:46:31 +0800, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>> Hi, Matt
>>
>> We also rename the function name to pass compile.
>> Besides, here is typo error drivers/mmc/host/sdhci.h, though it is not
>> a big deal.
>
> Good catch! How did you notice that? Did you see a failure at runtime or
> did you spot it by reading the code? If you were seeing a bug at runtime
> then this patch should also be sent to stable@kernel.org.
>

Fortunately, the typo does not impact the stability.
We found the typo when debugging our silicon issue, however, nothing
impove after the fix :)

> I don't have any hardware to test this patch but the change looks like
> it makes sense.
>
