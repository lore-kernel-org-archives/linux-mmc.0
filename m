Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACFAC4167B
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Nov 2023 11:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjKFL5I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Nov 2023 06:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFL5I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2023 06:57:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E794
        for <linux-mmc@vger.kernel.org>; Mon,  6 Nov 2023 03:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699271822; x=1730807822;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ePoN6spqjWBF4gQJvIyZw692UQtYka4nPR77oQgaEe0=;
  b=CTquTeEfSnRJhUjkWO8J43Mn+c6ZlMqylWMViR005w73ZxTOqOFLN2FJ
   NR/hP/9r16jtgGJ3PuN+x6DuatS/hBAyswo8RMVUt4b7sruggK75OGZwB
   EajTzb0TF5U/d+sGQmlEGRhY4UmhVeyIekUThHiofd1d4aOKnJYio85tx
   yoERinks4BmU/7T0yOBtCwhPRkXeiXAQm33okUwxAVEW0HHft4aJug3WD
   hXvErx/PjZbP0tIho+/4IAOmpor4JkT5UvqzrY25Q2iTR2j3amnXgMRmC
   noVNq7qQPu3NZ1K+1sbWxsj+0E9SWp5MMvYRtu3QcKkH18aSJg49ozj3p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="420372426"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="420372426"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:57:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="3427706"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:56:59 -0800
Message-ID: <9238e419-3400-4b70-8537-690db1730cf0@intel.com>
Date:   Mon, 6 Nov 2023 13:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
Content-Language: en-US
To:     Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>
References: <20230830093922.3095850-1-haibo.chen@nxp.com>
 <CAPDyKFpTP-r-eg2L1BoAG5ia2N2640VR2s2Vtbemyyu4MuKS=w@mail.gmail.com>
 <DB7PR04MB4010F86F40CA1E8E0B900D9390DDA@DB7PR04MB4010.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DB7PR04MB4010F86F40CA1E8E0B900D9390DDA@DB7PR04MB4010.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/10/23 14:58, Bough Chen wrote:
>> -----Original Message-----
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Sent: 2023年9月14日 21:03
>> To: Bough Chen <haibo.chen@nxp.com>
>> Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>; hkallweit1@gmail.com
>> Subject: Re: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
>>
>> On Wed, 30 Aug 2023 at 11:35, <haibo.chen@nxp.com> wrote:
>>>
>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>
>>> tuning only support in 4-bit mode or 8 bit mode, so in 1-bit mode,
>>> need to hold retuning.
>>>
>>> Find this issue when use manual tuning method on imx93. When system
>>> resume back, SDIO WIFI try to switch back to 4 bit mode, first will
>>> trigger retuning, and all tuning command failed.
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>
>> Applied for fixes and by adding a fixes tag (Fixes: dfa13ebbe334
>> ("mmc: host: Add facility to support re-tuning")) and a stable tag, thanks!
>>
>> Kind regards
>> Uffe
>>
>>
>>> ---
>>>  drivers/mmc/core/sdio.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c index
>>> f64b9ac76a5c..5914516df2f7 100644
>>> --- a/drivers/mmc/core/sdio.c
>>> +++ b/drivers/mmc/core/sdio.c
>>> @@ -1089,8 +1089,14 @@ static int mmc_sdio_resume(struct mmc_host
>> *host)
>>>                 }
>>>                 err = mmc_sdio_reinit_card(host);
>>>         } else if (mmc_card_wake_sdio_irq(host)) {
>>> -               /* We may have switched to 1-bit mode during suspend */
>>> +               /*
>>> +                * We may have switched to 1-bit mode during suspend,
>>> +                * need to hold retuning, because tuning only supprt
>>> +                * 4-bit mode or 8 bit mode.
>>> +                */
>>> +               mmc_retune_hold_now(host);
>>>                 err = sdio_enable_4bit_bus(host->card);
> 
> Hi Ulf,
> 
> Here still contain one bug, if now in UHS-I mode, card clock maybe is 200MHz, without tuning, sdio_enable_4bit_bus() may return error if host can't sample the cmd response correctly.
> 
> So here, in suspend better to switch out the UHS-I mode first, and downgrade the card clock rate(<50MHz), then switch from 4bit to 1 bit mode.

For eMMC and their host controllers, changing down modes has often required special support in host controller drivers, with the creation of a number of a callbacks.  UHS-I could be just as problematic.

> Then in resume, send command to switch back to 4 bit mode can execute safely without tuning.
> 
> I just meet this issue when do system PM on i.MX6ULL.  usdhc in i.MX6ULL will totally lost power after system suspend, which means the previous tuning status will lost when resume back.
> When send cmd to switch back to 4 bit mode during system resume, without tuning, usdhc can't sample the cmd response correctly under 200MHz, will trigger cmd error, cause the sdio resume fail.
> 
> Just as Adrian mentioned before, here add the mode switch maybe risky. Any concern? Or any way to pre-set the tuning config in host controller resume?

Some drivers do save and restore the tuning value.  That is definitely worth investigating.

Another possibility is to see whether it is possible to make a version of the switch to 4-bit that is resilient to CRC errors so it still works without tuning.

> 
> Best Regards
> Haibo Chen
> 
>>> +               mmc_retune_release(host);
>>>         }
>>>
>>>         if (err)
>>> --
>>> 2.34.1
>>>

