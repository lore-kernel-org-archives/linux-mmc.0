Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E702C33C9E
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 12:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3958F206DA
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 12:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgAHMAC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:00:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:62784 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgAHMAC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Jan 2020 07:00:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 04:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="370926604"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2020 04:00:00 -0800
Subject: Re: [PATCH 0/3] Fix issues with command queuing in arasan controllers
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, shawn.lin@rock-chips.com
References: <20191230092343.30692-1-faiz_abbas@ti.com>
 <837996b2-c69f-1446-fda4-5577e28ba8e1@ti.com>
 <a1b75d07-17ab-5dec-aa40-b9cff247eabf@intel.com>
 <b2600fd2-bcc9-19f6-8bf8-f3bb51da089f@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9c74c1b9-8ae4-49be-68e3-8e827d07cc66@intel.com>
Date:   Wed, 8 Jan 2020 13:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b2600fd2-bcc9-19f6-8bf8-f3bb51da089f@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/20 1:49 pm, Faiz Abbas wrote:
> Adrian,
> 
> On 08/01/20 5:12 pm, Adrian Hunter wrote:
>> On 8/01/20 1:30 pm, Faiz Abbas wrote:
>>> Hi,
>>>
>>> On 30/12/19 2:53 pm, Faiz Abbas wrote:
>>>> In some Arasan SDHCI controllers, after tuning, the tuning pattern data
>>>> is leftover in the sdhci buffer. This leads to issues with future data
>>>> commands, especially when command queuing is enabled. The following
>>>> patches help fix this issue by resetting data lines after tuning is
>>>> finished. The first two patches have been tested with TI's am65x and
>>>> j721e SoCs using the sdhci_am654 driver.
>>>>
>>>> I have a strong suspicion that this is the same issue with
>>>> the sdhci-of-arasan driver where they are forced to dump data from the
>>>> buffer before enabling command queuing. I need help from someone with a
>>>> compatible platform to test this.
>>>>
>>>
>>> I had some discussions with our hardware team and they say we should be
>>> asserting both SRC and SRD reset after tuning to start from a clean
>>> state. Will update the patches to do that in v2.
>>
>> Can you use the ->execute_tuning() for that instead of a quirk?
>>
> 
> ->platform_execute_tuning() is called before __sdhci_execute_tuning(). I
> need this to be done after that. Should I add a post_tuning() callback?

I meant hook host->mmc_host_ops.execute_tuning and call
sdhci_execute_tuning() and then sdhci_reset(), like in intel_execute_tuning().

