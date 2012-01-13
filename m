From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] mmc: use usleep_range() in mmc_delay()
Date: Fri, 13 Jan 2012 16:52:16 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1201131633580.31704@kernel.research.nokia.com>
References: <4EF18310.6080801@linaro.org> <alpine.DEB.2.00.1201131514490.31704@kernel.research.nokia.com> <4F1036CD.3090608@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:61323 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482Ab2AMOzF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Jan 2012 09:55:05 -0500
In-Reply-To: <4F1036CD.3090608@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Antipov <dmitry.antipov@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Jan 2012, Dmitry Antipov wrote:
> On 01/13/2012 05:22 PM, Aaro Koskinen wrote:
>
>> Anyway, I think the change is good. On systems with multiple MMC devices
>> the boot/probe can spend 100-200 ms alone just doing busylooping delays. I
>> think e.g. in mmc_rescan() the code uses frequently mmc_delay(10).
>
> I'm worrying about this:
>
> mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000))
>
> since I have no ideas about typical values for this timeout.
> If it may be too small (<=10 us), using usleep_range() makes no sense.

Hmm, but the code above is rounding it up to at least 1 ms?

A.
