Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC5C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 12:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiK3MqK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 07:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiK3MqI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 07:46:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB0E4B753
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 04:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669812365; x=1701348365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v0K5Z+fNortxwiP+ekS3lUj0FXp5pXXc8aMN4BxSh0s=;
  b=RJ1uZPXZ5FtdOKinnSwsbsJXx5Xi8E6kviFEYrweQdnIs/KnKfb+FfaX
   jkBHB9IvktCWZM7IRUVZh4/mp0G5UdOHtKo3RNesDf8l2JEOxxng5jyFe
   kj1G5qxnpgxVgd0p19y4k6rnLxkf0GQZMBF68btXNu21eC3GzSFo8h1q1
   Cc5XFGX2eE7nWb5BahTatEZ/xTJfZs3KQQDexIIICs7m6f6BpyOFVDMr7
   WtUBE+SM3f1Pzm1/Q1l4o7rufC0mT7KRy29S6lmcAnN5BgMJtwwA/Ezvv
   UR6HK39O3r1crBKaw8U7wUbL13XMaiiLVX5DsWjFpJsLLu2HQsX7Cjo5u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="316538449"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="316538449"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 04:46:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="594650211"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="594650211"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.75])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 04:45:55 -0800
Message-ID: <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com>
Date:   Wed, 30 Nov 2022 14:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/11/22 13:54, Robert Marko wrote:
> 
> On 28. 11. 2022. 14:32, Adrian Hunter wrote:
>> Avoid re-configuring UHS and preset settings when the settings have not
>> changed, irrespective of whether the clock is turning on.
>>
>> Tested-by: Haibo Chen <haibo.chen@nxp.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
> and reverting it makes the eMMC work again.
> 
> I get a lot of:
> 
> [    2.727287] mmc0: tuning execution failed: -5
> [    2.727323] mmc0: error -5 whilst initialising MMC card
> [    3.846540] mmc0: tuning execution failed: -5
> [    3.846564] mmc0: error -5 whilst initialising MMC card
> [    4.966517] mmc0: tuning execution failed: -5
> [    4.966539] mmc0: error -5 whilst initialising MMC card
> [    6.096486] mmc0: tuning execution failed: -5
> [    6.096508] mmc0: error -5 whilst initialising MMC card
> [    7.206431] mmc0: tuning execution failed: -5
> [    7.206454] mmc0: error -5 whilst initialising MMC card

Thanks for the report!  Are you able to debug this any more?
What transfer mode is it? e.g. HS400?  Can you enable debug
messages and get more information?

