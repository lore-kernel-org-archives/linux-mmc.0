From: Pavel Machek <pavel@ucw.cz>
Subject: Re: mmc: Add CONFIG_MMC_BLOCK_MAX_SPEED
Date: Wed, 24 Feb 2016 11:56:11 +0100
Message-ID: <20160224105610.GC31302@amd>
References: <1454617771-9842-1-git-send-email-salyzyn@android.com>
 <20160222064551.GA23884@amd>
 <56CB318D.7070403@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CB318D.7070403@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luca Porzio <lporzio@micron.com>, yalin wang <yalin.wang2010@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi!

> >...and you have the /sys interface. Drop the config options?
> 
> I needed a start up default value for boot-time simulations. If just sys
> options, we would be applying the values far too late in the
> operation. I

Ok, use module parameters (aka kernel command line options), then...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
