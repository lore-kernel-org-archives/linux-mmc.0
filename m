Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C31C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiK3OQJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 09:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiK3OQJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 09:16:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A574192B0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 06:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669817767; x=1701353767;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BDSlP+PvEvXMu48Tsu0qNj8rp1UqtfnWEZn7upp0mLU=;
  b=Z3rYjmi355+zy+4coce4OY5H+deheRgtiiHTI+bz/mh2wJUJUWn1h58u
   h/q8v9tplyOlJ5iWYq3ahZr/8V0siQLqY+0tbE+/Gr8l7s6le1kstuClw
   ZvoEi9R5cWq2oco7duLihaccHX1AUzuomDgo67AKwh3S1NE6KeHdcvA+C
   WOnlI1ocaToAISY6Ga3d5TJtPSY4WcLWCMsWNHPv7sUV4YgFzZx2SB53i
   g/hqs/Ve4kcacgYjcyA5GKJwOsAXajYKzx8XtKiUNObnmHQx/oPldlZtg
   9WtZGBzr95hoP0qPGlmGCcTX4bZdJoN0jFRXSy71wEoOuY+a9lYyKCLXe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="316556780"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="316556780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 06:15:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="675037870"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="675037870"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 06:15:46 -0800
Message-ID: <26ad873f-b673-3ea0-3039-f61d69939c6f@intel.com>
Date:   Wed, 30 Nov 2022 16:15:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com>
 <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
 <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com>
 <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/11/22 15:00, Robert Marko wrote:
> On Wed, 30 Nov 2022 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 30/11/22 13:54, Robert Marko wrote:
>>>
>>> On 28. 11. 2022. 14:32, Adrian Hunter wrote:
>>>> Avoid re-configuring UHS and preset settings when the settings have not
>>>> changed, irrespective of whether the clock is turning on.
>>>>
>>>> Tested-by: Haibo Chen <haibo.chen@nxp.com>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>
>>> Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
>>> and reverting it makes the eMMC work again.
>>>
>>> I get a lot of:
>>>
>>> [    2.727287] mmc0: tuning execution failed: -5
>>> [    2.727323] mmc0: error -5 whilst initialising MMC card
>>> [    3.846540] mmc0: tuning execution failed: -5
>>> [    3.846564] mmc0: error -5 whilst initialising MMC card
>>> [    4.966517] mmc0: tuning execution failed: -5
>>> [    4.966539] mmc0: error -5 whilst initialising MMC card
>>> [    6.096486] mmc0: tuning execution failed: -5
>>> [    6.096508] mmc0: error -5 whilst initialising MMC card
>>> [    7.206431] mmc0: tuning execution failed: -5
>>> [    7.206454] mmc0: error -5 whilst initialising MMC card
>>
>> Thanks for the report!  Are you able to debug this any more?
>> What transfer mode is it? e.g. HS400?  Can you enable debug
>> messages and get more information?
> 
> With some guidance yes, it's in HS200 as there is an issue with HS400
> to HS200 switch on this SoC so I have HS400 disabled.
> 
> With CONFIG_MMC_DEBUG and loglevel=8 I dont have any new
> messages.

You should get a lot more with:

CONFIG_DYNAMIC_DEBUG=y

and kernel commandline option:

dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"


