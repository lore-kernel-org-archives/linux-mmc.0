From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/24] MMC/SDHCI fixes
Date: Mon, 21 Dec 2015 14:23:17 +0100
Message-ID: <CAPDyKFrxJBAiic44VRWRW-53vz6GqosH+6_qbFSgQnJ5aew=BQ@mail.gmail.com>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
	<CAPDyKFogxmczEzXbXACrfn4F2wfM=ZKPVnpK8WSLJA3UT5SKiw@mail.gmail.com>
	<20151221125120.GZ8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34005 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbLUNXS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 08:23:18 -0500
Received: by mail-yk0-f181.google.com with SMTP id p130so130206212yka.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Dec 2015 05:23:18 -0800 (PST)
In-Reply-To: <20151221125120.GZ8644@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 21 December 2015 at 13:51, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 21, 2015 at 01:35:36PM +0100, Ulf Hansson wrote:
>> I decided to try to apply it for my next branch, to get some good test
>> coverage. Although, it failed when reaching patch 8. Would you mind
>> posting yet another new re-based version, please.
>
> Given that these are _fixes_ and need to be applied to -rc kernels, they
> are based on -rc6.  I don't see the point of rebasing them onto non-rc
> kernels to test, because then you're not testing against where they
> should be applied.

I see your point, but I would rather not aim for rcs with these
changes, unless you insist.

Not because they aren't fixes, but because it's old errors. Instead we
can "cc stable" or use the fixes tag as we are in quite late stage of
the rc. This approach will also allow us to get a bit better test
coverage.

What do you think?

Kind regards
Uffe
