From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] mmc: add a cap and a quirk
Date: Tue, 13 Mar 2012 05:35:13 -0400
Message-ID: <m21uowj12m.fsf@bob.laptop.org>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
	<4F5EEBFD.2070606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35948 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760169Ab2CMJfV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Mar 2012 05:35:21 -0400
In-Reply-To: <4F5EEBFD.2070606@intel.com> (Adrian Hunter's message of "Tue, 13
	Mar 2012 08:41:01 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, linus walleij <linus.walleij@linaro.org>

Hi Adrian,

On Tue, Mar 13 2012, Adrian Hunter wrote:
> On 07/02/12 14:48, Adrian Hunter wrote:
>> Hi
>> 
>> Here are patches for Medfield to allow the use of high-capacity erase size
>> and to allow the SDIO host controller to be off when the card is kept on
>> during suspend - replacing the earlier patch "mmc: sdhci: always reset all
>> during resume"
>> 
>> 
>> Adrian Hunter (4):
>>       mmc: core: add high-capacity erase size capability flag
>>       mmc: sdhci-pci: select HC erase size for Medfield eMMC
>>       mmc: sdhci: add quirk for keeping card power during suspend
>>       mmc: sdhci-pci: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for Medfield SDIO
>> 
>>  drivers/mmc/core/mmc.c       |    3 ++-
>>  drivers/mmc/host/sdhci-pci.c |    8 +++++++-
>>  drivers/mmc/host/sdhci.c     |   13 +++++++++++--
>>  include/linux/mmc/host.h     |    1 +
>>  include/linux/mmc/sdhci.h    |    2 ++
>>  5 files changed, 23 insertions(+), 4 deletions(-)
>
> Chris can you take these?
>
> MMC_CAP2_HC_ERASE_SZ needs to move to bit9 but otherwise they apply.

Thanks for the reminder, moved MMC_CAP2_HC_ERASE_SZ to bit9 and pushed
to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
