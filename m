Return-Path: <SRS0=0j+4=CX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD95C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 06:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180562192A
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 06:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgINGgc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Sep 2020 02:36:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:5622 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgINGga (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Sep 2020 02:36:30 -0400
IronPort-SDR: qUQVRwYCqeeDo2iVqK2wEy0OvdT4Z+LUSDqmp/L6NzdLwqVxD2163atD9t10THoHRrYIAwtpS/
 7QyfdBrB53+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="156427340"
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; 
   d="scan'208";a="156427340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 23:36:30 -0700
IronPort-SDR: +NXA1uT6k9Cy9jdPgS8Cm0Qg72jTm41S2Q5F7VrJc4ChQ3JCB6gu3N2WP0iJZH2Y96RjsEGOji
 KjniniGqAB5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; 
   d="scan'208";a="408770350"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2020 23:36:28 -0700
Subject: Re: [RFC PATCH V3 15/21] mmc: sdhci: UHS-II support, modify
 set_power() to handle vdd2
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111140.29725-1-benchuanggli@gmail.com>
 <97c43596-a18f-4c7a-c226-5209772d91d1@intel.com>
 <20200914054537.GA2738017@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f0ff6c0a-4029-72a9-559c-8930ef0ea8bb@intel.com>
Date:   Mon, 14 Sep 2020 09:36:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914054537.GA2738017@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/09/20 8:45 am, AKASHI Takahiro wrote:
> Adrian,
> 
> On Fri, Aug 21, 2020 at 05:11:18PM +0300, Adrian Hunter wrote:
>> On 10/07/20 2:11 pm, Ben Chuang wrote:
>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>
>>> VDD2 is used for powering UHS-II interface.
>>> Modify sdhci_set_power_and_bus_voltage(), sdhci_set_power_noreg()
>>> and sdhci_set_power_noreg() to handle VDD2.
>>
>> vdd2 is always 1.8 V and I suspect there may never be support for anything
>> else, so we should start with 1.8 V only.
> 
> What do you mean here?
> You don't want to add an extra argument, vdd2, to sdhci_set_power().
> Correct?

Yes

> 
>> Also can we create uhs2_set_power_reg() and uhs2_set_power_noreg() and use
>> the existing ->set_power() callback
> 
> Again what do you expect here?
> 
> Do you want to see any platform-specific mmc driver who supports UHS-II
> to implement its own call back like:

Not exactly.  I expect there to be a common implementation in sdhci-uhs2.c
called sdhci_uhs2_set_power() for example, that drivers can use by setting
their .set_power = sdhci_uhs2_set_power.  If they need platform-specific
code as well then their platform-specific code can call
sdhci_uhs2_set_power() if desired.

> 
> void sdhci_foo_set_power(struct sdhci_host *host, unsigned char mode,
>                                   unsigned short vdd)
> {
>         sdhci_set_power(host, mode,vdd);
> 
>         /* in case that sdhci_uhs2 module is not inserted */
>         if (!(mmc->caps & MMC_CAP_UHS2))
>                 return;
> 
>         /* vdd2 specific operation */
>         if (IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
>                 sdhci_uhs2_set_power_noreg(host, mode);
>         else
>                 sdhci_uhs2_set_power_reg(host, mode);
> 
>         /* maybe more platform-specific initialization */
> }
> 
> struct sdhci_ops sdhci_foo_ops = {
>         .set_power = sdhci_foo_set_power,
>         ...
> }
> 
> Is this what you mean?
> (I'm not quite sure yet that sdhci_ush2_set_power_noreg() can be split off
> from sdhci_set_power_noreg().)
> 
> -Takahiro Akashi
