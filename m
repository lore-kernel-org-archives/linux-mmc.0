From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/3]mmc: enable TRIM/ERASE caps for SDHCI host
Date: Sat, 12 Feb 2011 09:34:04 +0100
Message-ID: <201102120934.04679.arnd@arndb.de>
References: <20110212062220.GC25519@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62263 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1BLIeQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 03:34:16 -0500
In-Reply-To: <20110212062220.GC25519@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, adrian.hunter@nokia.com

On Saturday 12 February 2011 07:22:20 Chuanxiao Dong wrote:
> SDHCI host controller has TRIM/ERASE capability, enable these caps for erasing
> purpose.
> 
> ERASE command needs R1B response. So for such command with busy signal, before
> sending command, SDHCI host driver will simply set a maximum value for timeout
> control register which is safe to use.
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Great stuff! I needed this for a project of mine, but couldn't
get it to work reliably without knowing about the timeout logic.

I think, almost no mmc controllers advertice MMC_CAP_ERASE today,
which is a real shame, given that it's extremely useful for performance.

	Arnd
