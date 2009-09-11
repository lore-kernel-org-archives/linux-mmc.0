From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH V3 28/30] omap_hsmmc: ensure all clock enables and disables
 are paired
Date: Fri, 11 Sep 2009 11:31:37 +0300
Message-ID: <4AAA0AE9.2010407@nokia.com>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>	<20090909120003.12833.82537.sendpatchset@ahunter-laptop> <20090910150210.e484afab.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60577 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbZIKIbn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2009 04:31:43 -0400
In-Reply-To: <20090910150210.e484afab.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "pierre@ossman.eu" <pierre@ossman.eu>, "matt@console-pimps.org" <matt@console-pimps.org>

Andrew Morton wrote:
> On Wed, 09 Sep 2009 15:00:03 +0300
> Adrian Hunter <adrian.hunter@nokia.com> wrote:
> 
>> >From baf6574a1b5e7c4fdc4a66d9e038efeee75ea1a0 Mon Sep 17 00:00:00 2001
>> From: Adrian Hunter <adrian.hunter@nokia.com>
>> Date: Sun, 31 May 2009 19:27:36 +0300
>> Subject: [PATCH] omap_hsmmc: ensure all clock enables and disables are paired
>>
> 
> This patch hasn't been updated with
> omap_hsmmc-ensure-all-clock-enables-and-disables-are-paired-fix-for-the-db-clock-failure-message.patch,
> and
> omap_hsmmc-ensure-all-clock-enables-and-disables-are-paired-fix-for-the-db-clock-failure-message.patch
> is not present in the v3 patchset.  What's up with that?

I am not sure what you want here.  madhu's patch should apply cleanly on top of the ones I sent.

> 
> 
> I went through the patchset seeing what you'd done.
> 
> mmc-add-host-capabilities-for-sd-only-and-mmc-only.patch and
> omap_hsmmc-pass-host-capabilities-for-sd-only-and-mmc-only.patch were
> dropped.
> 
> arm-omap-rx51-set-mmc-capabilities-and-power-saving-flag.patch was
> significantly altered (I queued a delta for that).
> 
> omap_hsmmc-make-use-of-new-mmc_cap_nonremovable-host-capability.patch
> was changed a bit to fix rejects (I think).

Yes that is right.
