From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] mmc: sdhci-iproc: Use defines instead of magic
 numbers
Date: Tue, 5 Jul 2016 09:06:11 +0300
Message-ID: <577B4E53.6030000@intel.com>
References: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
 <577A968C.3020107@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17725 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754189AbcGEGLJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Jul 2016 02:11:09 -0400
In-Reply-To: <577A968C.3020107@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>, Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 04/07/16 20:02, Scott Branden wrote:
> Hi Stefan,
> 
> On 16-07-02 12:23 PM, Stefan Wahren wrote:
>> Hi,
>>
>> this small patch series should make the sdhci-iproc platform data easier
>> to read. Since i don't have the adequate hardware it's only compile tested.
>>
>> Stefan
>>
>> Stefan Wahren (2):
>>    mmc: sdhci: add define for suspend/resume capability
>>    mmc: sdhci-iproc: Use defines instead of magic numbers
>>
>>   drivers/mmc/host/sdhci-iproc.c |   13 +++++++++++--
>>   drivers/mmc/host/sdhci.h       |    1 +
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
> Patch series looks fine.
> 
> Acked-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

