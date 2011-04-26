From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/6] mmc_block: Allow more than 8 partitions per card
Date: Tue, 26 Apr 2011 15:22:22 +0200
Message-ID: <201104261522.22329.arnd@arndb.de>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org> <1303520502-32171-3-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54864 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab1DZNWZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 09:22:25 -0400
In-Reply-To: <1303520502-32171-3-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: linux-mmc@vger.kernel.org, Colin Cross <ccross@android.com>, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>

On Saturday 23 April 2011, John Stultz wrote:
> From: Colin Cross <ccross@android.com>
> 
> Set the GENHD_FL_EXT_DEVT flag, which will allocate minor numbers
> in major 259 for partitions past disk->minors.
> 
> Also remove the use of disk_devt to determine devidx from md->disk.
> md->disk->first_minor is always initialized from devidx and can
> always be used to recover it.
> 
> CC: Chris Ball <cjb@laptop.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Dima Zavin <dima@android.com>
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

The new code looks reasonable, but wouldn't changing this be incompatible
with existing root file systems that contain static device nodes?

	Arnd
