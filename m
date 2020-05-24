Return-Path: <SRS0=G4HJ=7G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14356C433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 24 May 2020 19:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5C22075F
	for <linux-mmc@archiver.kernel.org>; Sun, 24 May 2020 19:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgEXT1H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 May 2020 15:27:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:57044 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388084AbgEXT1G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 24 May 2020 15:27:06 -0400
IronPort-SDR: By0a9SYhJ4TZ0JTmp34WG8jdU48wtKFiM7XgPJAWNyaaXGepPb8f8+UZ65hsfFwu1lORA67o03
 fJZ0vrn521Jw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 12:27:06 -0700
IronPort-SDR: Jt1wxSweHy/gcVmjApzJ6eqN4bNznRQXVLnIg1IoO4kg/6e/ivSQzfrpA+9iAoRqDLNMEBs8k6
 LYbv/QAMX3Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,430,1583222400"; 
   d="scan'208";a="413310334"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2020 12:27:03 -0700
Subject: Re: [PATCH 2/3] sdhci: sparx5: Add Sparx5 SoC eMMC driver
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20200513133122.25121-1-lars.povlsen@microchip.com>
 <20200513133122.25121-3-lars.povlsen@microchip.com>
 <6398c7a6-ce5e-1df6-d5a6-08664a7fc123@intel.com>
 <87v9ktoc0h.fsf@soft-dev15.microsemi.net>
 <87wo56q2o3.fsf@soft-dev15.microsemi.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <abbd2306-55ed-014c-4b06-a5cb3f34796f@intel.com>
Date:   Sun, 24 May 2020 22:26:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87wo56q2o3.fsf@soft-dev15.microsemi.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/05/20 2:14 pm, Lars Povlsen wrote:
> 
> Lars Povlsen writes:
> 
>> Adrian Hunter writes:
>>
>>> On 13/05/20 4:31 pm, Lars Povlsen wrote:
>>>> This adds the eMMC driver for the Sparx5 SoC. It is based upon the
>>>> designware IP, but requires some extra initialization and quirks.
>>>>
>>>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>>>> ---
> {Snip]
>>>> +};
>>>> +
>>>> +static const struct sdhci_pltfm_data sdhci_sparx5_pdata = {
>>>> +     .quirks  = 0,
>>>> +     .quirks2 = SDHCI_QUIRK2_HOST_NO_CMD23 | /* Card quirk */
>>>
>>> If this is a card quirk then it should be in drivers/mmc/core/quirks.h not here.
>>
> 
> Adrian, I had a go at changing the controller quirk to a card quirk.
> 
> Unfortunately, SDHCI_QUIRK2_HOST_NO_CMD23 does not directly translate to
> MMC_QUIRK_BLK_NO_CMD23, as for 'do_rel_wr' in mmc_blk_rw_rq_prep(), it
> will *still* use MMC_SET_BLOCK_COUNT (cmd23), causing the issue.
> 
> We are using a ISSI "IS004G" device, and so I have gone through the
> motions of adding it to quirks.h. The comment before the list of devices
> using MMC_QUIRK_BLK_NO_CMD23 suggest working around a performance issue,
> which is not exactly the issue I'm seeing. I'm seeing combinations of
> CMD_TOUT_ERR, DATA_CRC_ERR and DATA_END_BIT_ERR whenever a cmd23 is
> issued.
> 
> I have not been able to test the controller with another eMMC device
> yet, but I expect its not the controller at fault.
> 
> So, I'm a little bit in doubt of how to proceed - either keep the quirk
> as a controller quirk - or make a *new* card quirk (with
> SDHCI_QUIRK2_HOST_NO_CMD23 semantics)?
> 
> Anybody else have had experience with ISSI eMMC devices?
> 
> I have also tried to use DT sdhci-caps-mask, but MMC_CAP_CMD23 is not
> read from the controller just (unconditionally) set in sdhci.c - so that
> doesn't fly either.
> 
> Any suggestions?

It is up to you.  In the future, you may want to distinguish devices that
have this problem from ones that do not.

If you are not sure it is the ISSI eMMC, and maybe not the host controller,
then might it be the board?  Perhaps make SDHCI_QUIRK2_HOST_NO_CMD23
conditional on the particular compatibility string?

At a minimum, change the "/* Card quirk */" comment to a fuller explanation.

> 
>> Yes, its supposedly a card quirk. I'll see to use the card quirks
>> methods in place.
>>
> 

