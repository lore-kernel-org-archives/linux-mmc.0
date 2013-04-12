From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] sdhci-acpi initialization performance regression
Date: Fri, 12 Apr 2013 14:09:08 -0400
Message-ID: <87fvyvfwor.fsf@octavius.laptop.org>
References: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57293 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab3DLSJR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Apr 2013 14:09:17 -0400
In-Reply-To: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Thu, 4 Apr 2013 16:41:04 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Namjae Jeon <linkinjeon@gmail.com>, Sergey Yanovich <ynvich@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Adrian,

On Thu, Apr 04 2013, Adrian Hunter wrote:
> When I submitted the sdhci-acpi driver, it's initialization performance
> was satisfactory.  Now it is not.  Here are 2 fixes to restore that
> regression.
>
> Adrian Hunter (2):
>       Revert "mmc: core: wait while adding MMC host to ensure root mounts successfully"
>       mmc: core: fix performance regression initializing MMC host controllers
>
>  drivers/mmc/core/core.c       | 4 ++--
>  drivers/mmc/host/sdhci-acpi.c | 2 ++
>  include/linux/mmc/host.h      | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)

Thanks, both pushed to mmc-next (using v4 of patch 2/2) for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
