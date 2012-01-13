From: Dmitry Antipov <dmitry.antipov@linaro.org>
Subject: Re: [PATCH] mmc: use usleep_range() in mmc_delay()
Date: Fri, 13 Jan 2012 17:51:09 +0400
Message-ID: <4F1036CD.3090608@linaro.org>
References: <4EF18310.6080801@linaro.org> <alpine.DEB.2.00.1201131514490.31704@kernel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41625 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2AMNuT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 08:50:19 -0500
In-Reply-To: <alpine.DEB.2.00.1201131514490.31704@kernel.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linaro-dev@lists.linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/13/2012 05:22 PM, Aaro Koskinen wrote:

> Anyway, I think the change is good. On systems with multiple MMC devices
> the boot/probe can spend 100-200 ms alone just doing busylooping delays. I
> think e.g. in mmc_rescan() the code uses frequently mmc_delay(10).

I'm worrying about this:

mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000))

since I have no ideas about typical values for this timeout.
If it may be too small (<=10 us), using usleep_range() makes no sense.

Dmitry
