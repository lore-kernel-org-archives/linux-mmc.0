Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D444C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Dec 2022 07:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiLVHgq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 02:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiLVHgq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 02:36:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06811900A
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 23:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671694604; x=1703230604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qeOuFgbNfxm90Us5wDbLdsxzZ6yxwL2udgxXYXwPQbA=;
  b=Gmk76/h94f7n1MA7SPEWSrkjBWG+UgbeOuNnHmgPX+Sh3m0RevkKIcSN
   2JdbzV2mycM0qcKbJQFwQMGtSNq08x2vElzv3maBzyAawCwFQrdubHUOR
   ChclBnZ7VQFil9MXj2B1seFepWLjUJj4tHJMeGYlKVTHmpK5wn2byilAW
   rqdBbn86xp8dftVoyYVgqSd0r2zpTOWQD4jYCAfVgIP9zqtY7lvUmQEbx
   lPE302Amf7pM17cQsKwXHGDxGUE9iqB+h/jqwaSxsvTvrJKha73q/HaCV
   UwM1oK3FPalwOjMEJyus558YOE0HoXWGhnviCDPdf0Ze83HyiCWO/Ia73
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="300406928"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="300406928"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 23:36:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="684090963"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="684090963"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 23:36:42 -0800
Message-ID: <3ae217e7-09d9-066a-8006-cb65c792bb64@intel.com>
Date:   Thu, 22 Dec 2022 09:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] [RFC] mmc: sdhci: Always apply sdhci-caps-mask and
 sdhci-caps to caps
To:     Marek Vasut <marex@denx.de>, Bough Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Zach Brown <zach.brown@ni.com>
References: <20221220015254.796568-1-marex@denx.de>
 <DB7PR04MB4010BE5749B5C9949A691C1990EA9@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <8df08d8d-2cba-71a3-b160-e7d924d3bea1@denx.de>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <8df08d8d-2cba-71a3-b160-e7d924d3bea1@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/12/22 05:42, Marek Vasut wrote:
> On 12/20/22 04:04, Bough Chen wrote:
>>> -----Original Message-----
>>> From: Marek Vasut <marex@denx.de>
>>> Sent: 2022年12月20日 9:53
>>> To: linux-mmc@vger.kernel.org
>>> Cc: Marek Vasut <marex@denx.de>; Adrian Hunter <adrian.hunter@intel.com>;
>>> Ulf Hansson <ulf.hansson@linaro.org>; Zach Brown <zach.brown@ni.com>
>>> Subject: [PATCH] [RFC] mmc: sdhci: Always apply sdhci-caps-mask and
>>> sdhci-caps to caps
>>>
>>> The original implementation in the commit referenced below only modifies
>>> caps in case no caps are passed to sdhci_read_caps() via parameter, this does
>>> not seem correct. Always modify the caps according to the properties from DT.
>>>
>>> 92e0c44b92e4 ("mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change
>>
>> Need to add Fixes as below:
>> Fixes: 92e0c44b92e4 ("mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change the caps read during __sdhci_read_caps")
>>
>> I did a grep under the /drivers/mmc/host, seems all callers use NULL for the parameter caps and caps1,
>> So maybe we could just simplify the code like this:
> 
> That would make backporting harder, so subsequent patch please.
> 
> But I am more interested in knowing whether this change even makes sense, since it was broken for like 6 years and nobody noticed.

If all drivers pass NULL then the patch does not change anything
and consequently is not a fix, and a fixes tag is not appropriate.

The caps and caps1 variables were added to allow __sdhci_read_caps()
to be used to remove the use of SDHCI_QUIRK_MISSING_CAPS, so I would
leave them for now and I will try to finally send some patches to
actually do that.

Otherwise the change seems reasonable as is, except for the commit
message which could just be something like:

The original implementation in commit 92e0c44b92e4 ("mmc: sdhci: Use
sdhci-caps-mask and sdhci-caps to change the caps read during
__sdhci_read_caps") only modifies caps in case no caps are passed to
sdhci_read_caps() via parameter, this does not seem correct. Always modify
the caps according to the properties from DT.

