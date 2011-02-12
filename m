From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/3]mmc: set max_discard_sectors value for mmc queue
Date: Sat, 12 Feb 2011 09:38:16 +0100
Message-ID: <201102120938.16626.arnd@arndb.de>
References: <20110212062214.GB25519@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56725 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab1BLIi1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 03:38:27 -0500
In-Reply-To: <20110212062214.GB25519@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, adrian.hunter@nokia.com

On Saturday 12 February 2011 07:22:14 Chuanxiao Dong wrote:
> max_discard_sectors value is UINT_MAX which means kernel block layer can pass
> down unlimited sectors to MMC driver to erase. But erasing so many sectors may
> delay some other important I/O requests. This is not preferred.
> 
> So use 'pref_erase' to set a suitable max_discard_sectors value for mmc queue to
> avoid erasing too many sectors at one time.
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

I'm not sure about this one. pref_erase on SDHC cards should be the *minimum*
unit you can erase in one request, not the maximum. Erasing an arbitrary
number of allocation units on an SDHC card should complete almost instantly,
because it only needs to update a single table with the allocation units.

Discarding partial allocation units will take a lot longer, because the
card then has to copy over the remaining blocks.

	Arnd
