From: Arnd Bergmann <arnd.bergmann@linaro.org>
Subject: Re: SD 3.00 Physical layer FULL specification
Date: Sat, 1 Sep 2012 20:19:00 +0000
Message-ID: <201209012019.00183.arnd.bergmann@linaro.org>
References: <20120901022755.10343.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61588 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab2IBSuF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Sep 2012 14:50:05 -0400
In-Reply-To: <20120901022755.10343.qmail@science.horizon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-mmc@vger.kernel.org

On Saturday 01 September 2012, George Spelvin wrote:
> In particular, it documents the FAT update optimizations in SD cards
> (section 4.3.1.7, p. 112).
> 
> If anyone cares, write performance is defined in terms of updates to
> "allocation units" (i.e. erase blocks) 512K-4MiB in size of a card-defined
> size, which are made up of "recording units" (i.e. FAT clusters).
> Table 4-51 on p. 113 gives the limits.

I believe these recommendations are often ignored anyway. A lot of the
SD cards nowadays have erase block sizes of 1.5, 3, 6, or 8 MB. None
of these can be specified with this version of the standard. Even for
the rare cards that have 1MB or 2MB erase block sizes, I've never seen
one that reports anything but 4MB.

	Arnd

