From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: SET_BLOCK_COUNT-bounded multiblock transfers
Date: Wed, 13 Apr 2011 19:03:35 -0500
Message-ID: <BANLkTikFWhDhCjGKBBE4PP9sNa2ynVEOtg@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:57338 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1DNADh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 20:03:37 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3E01kWa009845
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 20:01:46 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3E008k8009450
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 20:01:46 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1538201wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 17:03:35 -0700 (PDT)
In-Reply-To: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org, "Gao, Yunpeng" <yunpeng.gao@intel.com>

On Wed, Apr 13, 2011 at 7:38 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> This is a request for comments for a patch set that enables
> predefined multiblock transfers if these are supported.
>
> Before this patch set, all multiblock transfers look like (for example)
>
> CMD25 -> [block] [block] [block] [block] -> CMD12 (stop)
>
> ...or for controllers with Auto-CMD12
>
> CMD25 -> [block] [block] [block] [block] (host sends CMD12 itself).
>
> We want to enable -
>
> CMD23(4 blocks) CMD25 [data] [data] [data] [data]
>
> ...and for controllers with Auto-CMD23 -
>
> (Host sends CMD23(4 blocks)) CMD25 [data] [data] [data] [data]
>
> The interrupt overhead is the same, but for cards that optimize for predefined transfers
> we can see better transfer rates. I've tested this on a Sandisk eMMC where I saw as good as
> a 50% improvement on writes, and on a Toshiba eMMC where I saw no improvement at all. Also,
> reliable writes use CMD23, so this cleans up that code path as well. Note, that if a transfer
> fails, CMD12 must still be sent, so it is not sufficient to just not fill the mrq->stop field
> while doing a CMD23-enabled transfer. Due to this error handling and off-loads of Auto-CMD23
> (and interaction with Auto-CMD12) handling of SET_BLOCK_COUNT, just like STOP, is left to the host driver.
> Host driver now exposes MMC_CAP_CMD23 if it has been changed to handle the new "sbc" field in struct mmc_request.
> If a host doesn't expose this capability, open-ended transfers are used, and all functionality
> relying on CMD23 (such as reliable writes) is disabled.
>
> The third patch has been only tested on SD cards that don't expose CMD23. Still need to get an SDXC
> card and test it out, but I wanted to get eyes on this patch set anyway :-).
>
> I had a fourth patch enabling Auto-CMD23 for SDHCI, but I'll hold off until I can verify it.
>
> Thoughts?
>
> Table of Contents:
> [RFC 1/3] MMC: use CMD23 for multiblock transfers when we can.
> [RFC 2/3] MMC: Implement MMC_CAP_CMD23 for SDHCI.
> [RFC 3/3] MMC: Block CMD23 support for UHS104/SDXC cards.
>
> A
>

+ Yunpeng
