From: Andrei Warkentin <andreiw@motorola.com>
Subject: SET_BLOCK_COUNT-bounded multiblock transfers
Date: Wed, 13 Apr 2011 19:38:40 -0500
Message-ID: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:47053 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1DMX77 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 19:59:59 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3DNw70b008755
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 19:58:08 -0400 (EDT)
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com [209.85.213.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3DNw7sJ008745
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 19:58:07 -0400 (EDT)
Received: by yxi11 with SMTP id 11so816883yxi.15
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 16:59:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org

This is a request for comments for a patch set that enables
predefined multiblock transfers if these are supported.

Before this patch set, all multiblock transfers look like (for example)

CMD25 -> [block] [block] [block] [block] -> CMD12 (stop)

...or for controllers with Auto-CMD12

CMD25 -> [block] [block] [block] [block] (host sends CMD12 itself).

We want to enable - 

CMD23(4 blocks) CMD25 [data] [data] [data] [data]

...and for controllers with Auto-CMD23 -

(Host sends CMD23(4 blocks)) CMD25 [data] [data] [data] [data]

The interrupt overhead is the same, but for cards that optimize for predefined transfers
we can see better transfer rates. I've tested this on a Sandisk eMMC where I saw as good as
a 50% improvement on writes, and on a Toshiba eMMC where I saw no improvement at all. Also,
reliable writes use CMD23, so this cleans up that code path as well. Note, that if a transfer
fails, CMD12 must still be sent, so it is not sufficient to just not fill the mrq->stop field
while doing a CMD23-enabled transfer. Due to this error handling and off-loads of Auto-CMD23
(and interaction with Auto-CMD12) handling of SET_BLOCK_COUNT, just like STOP, is left to the host driver.
Host driver now exposes MMC_CAP_CMD23 if it has been changed to handle the new "sbc" field in struct mmc_request.
If a host doesn't expose this capability, open-ended transfers are used, and all functionality
relying on CMD23 (such as reliable writes) is disabled.

The third patch has been only tested on SD cards that don't expose CMD23. Still need to get an SDXC
card and test it out, but I wanted to get eyes on this patch set anyway :-).

I had a fourth patch enabling Auto-CMD23 for SDHCI, but I'll hold off until I can verify it.

Thoughts?

Table of Contents:
[RFC 1/3] MMC: use CMD23 for multiblock transfers when we can.
[RFC 2/3] MMC: Implement MMC_CAP_CMD23 for SDHCI.
[RFC 3/3] MMC: Block CMD23 support for UHS104/SDXC cards.

A
