From: Pavel Machek <pavel@ucw.cz>
Subject: Re: mmc: Add CONFIG_MMC_BLOCK_MAX_SPEED
Date: Mon, 22 Feb 2016 07:45:52 +0100
Message-ID: <20160222064551.GA23884@amd>
References: <1454617771-9842-1-git-send-email-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51840 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbcBVGpz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Feb 2016 01:45:55 -0500
Content-Disposition: inline
In-Reply-To: <1454617771-9842-1-git-send-email-salyzyn@android.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luca Porzio <lporzio@micron.com>, yalin wang <yalin.wang2010@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, linux-mmc@vger.kernel.org

Hi!

On Thu 2016-02-04 12:29:07, Mark Salyzyn wrote:
> When CONFIG_MMC_BLOCK_MAX_SPEED is enabled, Expose max_read_speed,
> max_write_speed and cache_size controls to simulate a slow eMMC device.
> The boot default values for each respectively are
> CONFIG_MMC_BLOCK_MAX_READ_SPEED, CONFIG_MMC_BLOCK_MAX_WRITE_SPEED and
> CONFIG_MMC_BLOCK_CACHE_SIZE respectively; and if not defined are
> 0 (off), 0, (off) and 4 MB also respectively.

Extra , after 0.

Dunno. At minimum, I'd call the option something like
"MMC_DEBUG_MAX_SPEED" and the speeds should be really controlled via
/sys or something...

...and ... is there reason to limit it to mmc devices? Making
harddrive slow would make it useful for testing, too...

...and you have the /sys interface. Drop the config options?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
