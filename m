From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: add flag for devices that can support
 runtime PM
Date: Mon, 17 Oct 2011 16:59:07 +0300
Message-ID: <4E9C34AB.9000206@intel.com>
References: <1318837964-28654-1-git-send-email-adrian.hunter@intel.com> <m21uub93on.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43469 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086Ab1JQN7J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Oct 2011 09:59:09 -0400
In-Reply-To: <m21uub93on.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 17/10/11 15:56, Chris Ball wrote:
> Hi Adrian,
> 
> On Mon, Oct 17 2011, Adrian Hunter wrote:
>> Only allow runtime PM for devices that specifically indicate
>> that they support it.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>  drivers/mmc/host/sdhci-pci.c |   17 +++++++++++++----
>>  1 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
>> index f49b184..c22d810 100644
>> --- a/drivers/mmc/host/sdhci-pci.c
>> +++ b/drivers/mmc/host/sdhci-pci.c
>> @@ -47,6 +47,7 @@ struct sdhci_pci_slot;
>>  
>>  struct sdhci_pci_fixes {
>>  	unsigned int		quirks;
>> +	unsigned int		allow_runtime_pm:1;
> 
> Thanks -- any objection to using a bool type instead for allow_runtime_pm?

None at all


