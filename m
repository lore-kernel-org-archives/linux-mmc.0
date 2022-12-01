Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4ABC4321E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Dec 2022 08:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLAIkl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 03:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiLAIkk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 03:40:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018198567A
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 00:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669884039; x=1701420039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S1OQmoF2soO/otdJ/1LOtLD7vWIm73Is1QTGSp9iStk=;
  b=M2oLkhQlxrhMt5cTfi7WLWyGX1nIQbnjHx9gncgf0khDXL8MdcI3Zkk6
   Qbiu5yBSBXI4LeYdcW0oyqXicrvBal07FgvQmd0PmDNvABqd33/9/h0jk
   DMZLfgQHNGDpxaCWmM/0f3CYJdpf0pWRpJFLPt9n4bpGMm40sBlpyqqxh
   2I5tIwQA5AtcnrNrcZZA11RXLND+jDohIaRanGW6vuyE91VG7hN+hM3hQ
   ahLyV0IQQSrjr5Go2MZgG4b0+cH9NiXUeP+uzs6DvSNd1OarnY8IvWtwE
   1MeMSQF8H/infjBJB+xfMCOHlcrqDnG4ybxhcwQ3sWgOnqdz6DiFK6lkW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313258245"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="313258245"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 00:40:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="769157203"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="769157203"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.240])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 00:40:32 -0800
Message-ID: <efe523e8-ec02-774b-6348-700e0cfc3345@intel.com>
Date:   Thu, 1 Dec 2022 10:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
To:     Robert Marko <robimarko@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
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
        linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sarthak Garg <sartgarg@codeaurora.org>
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com>
 <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
 <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com>
 <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
 <26ad873f-b673-3ea0-3039-f61d69939c6f@intel.com>
 <CAOX2RU4UQ_xOor3sPBP+fg48EGsCmbw03Dcc0oU5VDDV=7+yzg@mail.gmail.com>
 <962458b5-c891-e552-5469-1dbb650a0f3c@gmail.com>
 <CAOX2RU5OBJyWb_K=b7OO9WKVog8e2kMT50F9PndWcQ+gd=OfPQ@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAOX2RU5OBJyWb_K=b7OO9WKVog8e2kMT50F9PndWcQ+gd=OfPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/11/22 21:56, Robert Marko wrote:
> On Wed, 30 Nov 2022 at 19:39, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 11/30/22 09:24, Robert Marko wrote:
>>> On Wed, 30 Nov 2022 at 15:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 30/11/22 15:00, Robert Marko wrote:
>>>>> On Wed, 30 Nov 2022 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>
>>>>>> On 30/11/22 13:54, Robert Marko wrote:
>>>>>>>
>>>>>>> On 28. 11. 2022. 14:32, Adrian Hunter wrote:
>>>>>>>> Avoid re-configuring UHS and preset settings when the settings have not
>>>>>>>> changed, irrespective of whether the clock is turning on.
>>>>>>>>
>>>>>>>> Tested-by: Haibo Chen <haibo.chen@nxp.com>
>>>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>>>
>>>>>>> Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
>>>>>>> and reverting it makes the eMMC work again.
>>>>>>>
>>>>>>> I get a lot of:
>>>>>>>
>>>>>>> [    2.727287] mmc0: tuning execution failed: -5
>>>>>>> [    2.727323] mmc0: error -5 whilst initialising MMC card
>>>>>>> [    3.846540] mmc0: tuning execution failed: -5
>>>>>>> [    3.846564] mmc0: error -5 whilst initialising MMC card
>>>>>>> [    4.966517] mmc0: tuning execution failed: -5
>>>>>>> [    4.966539] mmc0: error -5 whilst initialising MMC card
>>>>>>> [    6.096486] mmc0: tuning execution failed: -5
>>>>>>> [    6.096508] mmc0: error -5 whilst initialising MMC card
>>>>>>> [    7.206431] mmc0: tuning execution failed: -5
>>>>>>> [    7.206454] mmc0: error -5 whilst initialising MMC card
>>>>>>
>>>>>> Thanks for the report!  Are you able to debug this any more?
>>>>>> What transfer mode is it? e.g. HS400?  Can you enable debug
>>>>>> messages and get more information?
>>>>>
>>>>> With some guidance yes, it's in HS200 as there is an issue with HS400
>>>>> to HS200 switch on this SoC so I have HS400 disabled.
>>>>>
>>>>> With CONFIG_MMC_DEBUG and loglevel=8 I dont have any new
>>>>> messages.
>>>>
>>>> You should get a lot more with:
>>>>
>>>> CONFIG_DYNAMIC_DEBUG=y
>>>>
>>>> and kernel commandline option:
>>>>
>>>> dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
>>>
>>> Unfortunatelly not:
>>
>> Are you sure you have debug messages enabled with your current console
>> loglevel? Might want to add "debug" at the end of your kernel command
>> line and try again.
> 
> Ok, so indeed debug was required, here is the huge bootlog now:
> https://gist.github.com/robimarko/e370bce66d0d2e7e54a2f5daf9784ee4

Thanks for the log!  It shows everything is OK up until the first
(HS200) tuning.

sdhci-msm takes the clock frequency into account when setting UHS
signaling, refer sdhci_msm_set_uhs_signaling(), so that is
presumably why the UHS signalling needs to be re-done even if
only the clock frequency changes.

It would be possible to change sdhci-msm to hook ->set_ios() and
set host->reinit_uhs before calling sdhci_set_ios(), which should
put back the original behaviour for sdhci-msm.

However "mmc: sdhci: Avoid unnecessary re-configuration" is really
a "nice-to-have" and it is not impossible other drivers are affected
by something similar, but just haven't noticed.

Consequently, I tend to think we should just drop the patch
"mmc: sdhci: Avoid unnecessary re-configuration" ?


