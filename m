Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D7FC33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 12:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D5B206D7
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 12:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgAOMwU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:52:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:4724 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgAOMwU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 07:52:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 04:52:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="256763298"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 04:52:17 -0800
Subject: Re: [PATCH 0/2] mmc: sdhci-acpi: Introduce device specific quirks,
 fix issues on 2 device models
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200108093903.57620-1-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8e599fd1-6bfb-28d3-0eb0-863d0a38b717@intel.com>
Date:   Wed, 15 Jan 2020 14:51:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108093903.57620-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/20 11:39 am, Hans de Goede wrote:
> Hi Adrian,
> 
> I know you have sofar mostly resisted adding device specific (DMI based)
> quirks to the sdhci-acpi.c driver and I agree with you that whenever
> possible, those should be avoided.

Not exactly.  I objected to matching against the string "UNKNOWN" because it
is insufficiently specific.

Matching specific DMI strings to identify board issues is fine.

> 
> But yesterday I was debugging an issue where using the microSD slot
> causes the LCD panel of a tablet to go black. This turns out to be a
> bug in the DSDT which gets triggered when using 1.8V modes, see the first
> patch for details. In this case I really so no other option then disabling
> 1.8V modes and only doing so only on the affected device model.
> 
> Another issue which I had on my TODO list of things to fix is the Acer
> SW5-012 version of the Acer Switch 10 models always reporting the microSD
> as being write-protected. Here too I see no other option then a model
> specific quirk, since some BYT devices may use a normal SD slot with
> actual write-protect capabilities and we do not want to disable
> write-protect checking everywhere just because it is broken on one model.
> The workaround for this is the second patch in this series.
> 
> Regards,
> 
> Hans
> 

