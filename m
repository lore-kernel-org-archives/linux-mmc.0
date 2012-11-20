From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] mmc: sdhci: apply voltage range check only for
 non-fixed regulators
Date: Tue, 20 Nov 2012 09:42:50 +0100
Message-ID: <50AB428A.3050700@samsung.com>
References: <87fw4dn030.fsf@octavius.laptop.org>
 <1352813534-6795-1-git-send-email-m.szyprowski@samsung.com>
 <87bof1mx9m.fsf@octavius.laptop.org> <50A254A0.8000403@samsung.com>
 <877gppmvyd.fsf@octavius.laptop.org>
 <DB83372B-7C12-4670-8C46-207C4A56F8BD@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:18256 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab2KTInN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Nov 2012 03:43:13 -0500
In-reply-to: <DB83372B-7C12-4670-8C46-207C4A56F8BD@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>


On 11/13/2012 10:23 PM, Philip Rakity wrote:
> Hi Marek,
>
> Is the regulator dedicated ?  or is it shared ?   Is it used for eMMC ?
>
> If it cannot be turned off -- then just don't list it in the regulators list for vmmc.
>
> If it CAN be turned off then need to get back to you.

It is dedicated to eMMC device and can be turned off. Patch "mmc: sdhci: 
apply
voltage range check only for non-fixed regulators" restored sdhci to 
working state
after merging the regulator fix. However there are lots of error 
messages from sdhci
driver:
s3c-sdhci s3c-sdhci.0: could not set regulator OCR (-1)

The only remaining problem is sdhci driver operation with dummy 
regulator. Right now
it simply fails to initialize if dummy regulator is enabled. Do you have 
any idea how
to fix it properly?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


