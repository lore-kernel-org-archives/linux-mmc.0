Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC8DC4363D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 09:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB53206BE
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 09:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgIYJc0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:32:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:55446 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgIYJcZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Sep 2020 05:32:25 -0400
IronPort-SDR: 5TCn5bchaZvhMeGF4Ajl5ai2RDYyqk5C1NVcNjbUzDpYEgNYJRFCN5nFSVYo4pduAHlaktrjeR
 It5fMFAj2sSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="158868442"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="158868442"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 02:32:25 -0700
IronPort-SDR: Ctg8seOvVT0giCxwqDVdUONMnNbwYOZSZlr2XSUfes904IuJYr24Jo82tfjeHEudbJEDsy7AzP
 PPByKyr2yGYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="310751878"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2020 02:32:20 -0700
Subject: Re: [PATCH v2] mmc: sdhci: Don't enable presets while tuning
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Wang, Chris" <chris.wang@amd.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
References: <20200824122131.v2.1.Id6f3c92fecf4acc60c3b7f57d5f4e4c854ace765@changeid>
 <873b0786-a088-54af-80ad-96d2b041945d@intel.com>
 <CAHQZ30DXUuWKo1n50aX3a86QfLCD4Z3W4CVescRDFcvQrEk3Ww@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c4a886d8-8389-2c50-a40b-e2965ef6c393@intel.com>
Date:   Fri, 25 Sep 2020 12:31:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHQZ30DXUuWKo1n50aX3a86QfLCD4Z3W4CVescRDFcvQrEk3Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/09/20 8:57 pm, Raul Rangel wrote:
> On Tue, Sep 1, 2020 at 4:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 24/08/20 9:21 pm, Raul E Rangel wrote:
>>> SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
>>> used for DDR52. The HS400 retuning sequence is:
>>>
>>>     HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
>>>
>>> This means that when HS400 tuning happens, we transition through DDR52
>>> for a very brief period. This causes presets to be enabled
>>> unintentionally and stay enabled when transitioning back to HS200 or
>>> HS400.
>>>
>>> This patch prevents enabling presets while tuning is in progress.
>>
>> Preset value should not generally have to depend on tuning, so this
>> seems less than ideal.  Also I am not sure you can say some controllers
>> are not accidentally benefiting from the current situation.
>>
>> What about just letting drivers choose the timing modes that support
>> preset values?  e.g. using the change below, a driver could alter
>> host->preset_value_support as needed
> 
> Sorry for the late reply, I'm just getting back to this. I like the
> patch. I have a few other patches I'm
> going to push up soon. Do you want me to include this in the chain, or
> do you want to push it up?

I'm snowed.  You will have to do it I am afraid.
