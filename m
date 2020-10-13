Return-Path: <SRS0=f1/V=DU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E89C433E7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624FF22CAE
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 13:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgJMNX5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 09:23:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:4786 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgJMNX5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Oct 2020 09:23:57 -0400
IronPort-SDR: MKp5WzwCOrArh5iYmZE2G3EMgD4ZUnDV+qll4evJuH4PoD1cxc29MhGzUxvvNVleIaYOV59kzw
 /lYwCE+Ty5tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="183385158"
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="183385158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 06:23:56 -0700
IronPort-SDR: Km2AzzYP3D7woTkSWuxQQ/9lLE4thVbSDWmy6FxtdT85iZbRTSUZS3Onsp/m6xqr9p/Fz5tZZd
 3XA/y2/QQnkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="299568616"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga007.fm.intel.com with ESMTP; 13 Oct 2020 06:23:54 -0700
Subject: Re: eMMC performance regression caused by 427b6514d0953bf
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20201013190851.715df9ad@xhacker.debian>
 <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
Date:   Tue, 13 Oct 2020 16:23:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/10/20 3:32 pm, Ulf Hansson wrote:
> + Adrian
> 
> On Tue, 13 Oct 2020 at 13:09, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>>
>> Hi,
>>
>> I found an emmc performance regression with below simple benchmark cmd:
>>
>> dd if=/dev/mmcblk0 of=/dev/null bs=8192 count=100000
>>
>> This regression has been bisected to commit
>> 427b6514d0953bf (“mmc: sdhci: Add Auto CMD Auto Select support”)
>>
>> If I revert this commit, the performance is good now.
>>
>> I’m not sure whether this is common issue or not.
> 
> Can you provide some data, like how much is the regression and how
> many tests did you run?
> 
> Did you try different block sizes of the dd command?

Also what is the SDHCI version?  The patch in question is for version >= 4.1

What driver?

Can you tell if the patch changed which auto command is used?
