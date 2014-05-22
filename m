From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH RESEND] mmc: dove: fix missing MACH_DOVE dependency
Date: Thu, 22 May 2014 15:04:07 +0200
Message-ID: <537DF5C7.3010009@gmail.com>
References: <1400522571-10799-1-git-send-email-sebastian.hesselbarth@gmail.com> <CAPDyKFo8CdyDbJEP0GkFTHdzpkyRBZEp-jAyrU4y8qi__zChkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60629 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaEVNEO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 09:04:14 -0400
In-Reply-To: <CAPDyKFo8CdyDbJEP0GkFTHdzpkyRBZEp-jAyrU4y8qi__zChkA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/22/2014 11:09 AM, Ulf Hansson wrote:
> On 19 May 2014 20:02, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>> DT-enabled Dove moved over from ARCH_DOVE in mach-dove to MACH_DOVE in
>> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
>> DT-only MACH_DOVE Kconfig. This slipped through the cracks and now is
>> a fix to allow to build Dove's SDHCI driver for mach-mvebu on v3.15-rc.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>
> Thanks! Picked up for the PR I send to Chris.

Ulf, thanks for picking it up. I noticed it will now end up in v3.16
and not as a fix for v3.15. I'll come back to it, if v3.15 will
ever become a stable version ;)

Anyway, great you are helping Chris to pre-select the mmc patches!

Sebastian

