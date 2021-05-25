Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB8DC2B9F8
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 11:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2CD61408
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 11:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhEYLhs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 07:37:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:49776 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhEYLhs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 May 2021 07:37:48 -0400
IronPort-SDR: Pcbm1r4C/XCIUQ0KZWMTE0IuG1e1rGpTCLIVz0akUjFIRy/VQnpp//tjBtcZR7y4bp706gz8F6
 +2aMsOFnGPWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="201921122"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="201921122"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 04:35:49 -0700
IronPort-SDR: 7psgzB5pEKr5GKM/4gZR/Xh00oq4V0/2/0AbnFv6VazGBSjmFZDVgK2kG5/7rCL4POp8p7ZzZf
 C/vVlKp9XSww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="413992083"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 25 May 2021 04:35:45 -0700
Subject: Re: SDHCI LVS
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
References: <CWXP265MB2680100896E11A69A393F802C4259@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5613a421-e891-385c-392c-815acea13169@intel.com>
Date:   Tue, 25 May 2021 14:36:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CWXP265MB2680100896E11A69A393F802C4259@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/05/21 2:10 pm, Christian Löhle wrote:
> 
> 
> Id like to get a host supporting LVS if possible.
> Are there any, preferably SDHCI-based, ones?
> The corresponding bit 63 of the capabilities register was overridden by e9fb05d5bca7428f2749d059559e9657c710fe53 since 2014 in the driver and is also implemented that way by the hardware out there.

That is only if the driver sets SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400

> So I'm assuming there are no SDHCI based LVS controllers?
> What are the plans for the driver to work around the fact that many controllers set the corresponding bit without actually being LVS hosts?

SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 already indicates that

> (And why would the standard 6.0 define this bit if there is already conflicting hardware out there?)
> Are there any other LVS hosts that anyone knows of?

No idea, sorry.

> 
> Regards,
> Christian
> 
> IMPORTANT NOTICE
> This communication is from Hyperstone GmbH, registered at the local court (Amtsgericht) in Freiburg HRB 381782 with its registered office at Line-Eid-Str. 3, 78467 Konstanz, Germany. Directors: Dr. Jan Peter Berns.
> 

