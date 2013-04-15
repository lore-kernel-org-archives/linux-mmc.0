From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] sdhci-acpi initialization performance regression
Date: Mon, 15 Apr 2013 09:47:30 +0300
Message-ID: <516BA282.2000500@intel.com>
References: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com> <87fvyvfwor.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19409 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab3DOGm6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Apr 2013 02:42:58 -0400
In-Reply-To: <87fvyvfwor.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Namjae Jeon <linkinjeon@gmail.com>, Sergey Yanovich <ynvich@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>

On 12/04/13 21:09, Chris Ball wrote:
> Hi Adrian,
> 
> On Thu, Apr 04 2013, Adrian Hunter wrote:
>> When I submitted the sdhci-acpi driver, it's initialization performance
>> was satisfactory.  Now it is not.  Here are 2 fixes to restore that
>> regression.
>>
>> Adrian Hunter (2):
>>       Revert "mmc: core: wait while adding MMC host to ensure root mounts successfully"
>>       mmc: core: fix performance regression initializing MMC host controllers
>>
>>  drivers/mmc/core/core.c       | 4 ++--
>>  drivers/mmc/host/sdhci-acpi.c | 2 ++
>>  include/linux/mmc/host.h      | 1 +
>>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> Thanks, both pushed to mmc-next (using v4 of patch 2/2) for 3.10.

Thanks you!

It looks like mmc-next and linux-next have the V1 version of patch 2/2.  Can
you replace it with V4?

