Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D9C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C8720823
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KSCD3oTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgETLOK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 07:14:10 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:4399 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLOJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 07:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589973248; x=1621509248;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=et7/2Wbhr+Tjr3SPQbyGvMvrDUcfwqh+l2hAH+RXOXs=;
  b=KSCD3oTkXhpcp9cQBt3LNay7iIk7hmJ/4kiYcLluV/d06KZK/tNGd7s/
   X7XqdDlZ50kLroOumokiW9VEDBw/Txvf/7bH4UzTCPqoRgezR+6WFu4TN
   pqwKmYd7Tn74PR292kaj8YUdBzCwbh2L+Ixtqq47nm5BPz3vES1Velp89
   o8VPijGzuY1kCZ16KjP4+YzT2krY6rHA2HOo06M54bA6DuxQmEhlV2mcp
   vdfDBI9CrD89zfe/KofqdOd0mpwAe+08VmfF7m5mDjk+tzwhQVqx6nt/D
   TahMIdfd536Pg02evN2DBSqvAASYVSlc8dEpNeO3lD+3+fn5d5+OTFhSz
   w==;
IronPort-SDR: XQ05QwiSvahC4lol82+DSsU7gaK85vSS9KTUzqz0V6Fv0dhJb94Pwfq8RYwgOlcfBmat5Eso8i
 vrNi3tK4nWLrwx9ViY4mK7wslLYL83Tdsdt8x8rnY7+P34a1HtUBz449IVEpEiqKHRqYz5JeHU
 R2wJ9tWcJeqb4cghLc2PdpBhElY0R7DZ1GE6S+OCwBwZ1EYfgramfxrGFOD62sFkwhUxqo+bsJ
 B30RgmdsmOE/nwu5DpF0dmnS8Tkvv6nhUoRp0PCjVBtQYpcPHh15cLIUNgggahDcMQD4WSN+Mk
 sL8=
X-IronPort-AV: E=Sophos;i="5.73,413,1583218800"; 
   d="scan'208";a="77279288"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 May 2020 04:14:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 May 2020 04:14:07 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 May 2020 04:14:05 -0700
References: <20200513133122.25121-1-lars.povlsen@microchip.com> <20200513133122.25121-3-lars.povlsen@microchip.com> <6398c7a6-ce5e-1df6-d5a6-08664a7fc123@intel.com> <87v9ktoc0h.fsf@soft-dev15.microsemi.net>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
List-Id: <soc.lore.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, SoC Team <soc@kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: Re: [PATCH 2/3] sdhci: sparx5: Add Sparx5 SoC eMMC driver
In-Reply-To: <87v9ktoc0h.fsf@soft-dev15.microsemi.net>
Date:   Wed, 20 May 2020 13:14:04 +0200
Message-ID: <87wo56q2o3.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Lars Povlsen writes:

> Adrian Hunter writes:
>
>> On 13/05/20 4:31 pm, Lars Povlsen wrote:
>>> This adds the eMMC driver for the Sparx5 SoC. It is based upon the
>>> designware IP, but requires some extra initialization and quirks.
>>>
>>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>>> ---
{Snip]
>>> +};
>>> +
>>> +static const struct sdhci_pltfm_data sdhci_sparx5_pdata = {
>>> +     .quirks  = 0,
>>> +     .quirks2 = SDHCI_QUIRK2_HOST_NO_CMD23 | /* Card quirk */
>>
>> If this is a card quirk then it should be in drivers/mmc/core/quirks.h not here.
>

Adrian, I had a go at changing the controller quirk to a card quirk.

Unfortunately, SDHCI_QUIRK2_HOST_NO_CMD23 does not directly translate to
MMC_QUIRK_BLK_NO_CMD23, as for 'do_rel_wr' in mmc_blk_rw_rq_prep(), it
will *still* use MMC_SET_BLOCK_COUNT (cmd23), causing the issue.

We are using a ISSI "IS004G" device, and so I have gone through the
motions of adding it to quirks.h. The comment before the list of devices
using MMC_QUIRK_BLK_NO_CMD23 suggest working around a performance issue,
which is not exactly the issue I'm seeing. I'm seeing combinations of
CMD_TOUT_ERR, DATA_CRC_ERR and DATA_END_BIT_ERR whenever a cmd23 is
issued.

I have not been able to test the controller with another eMMC device
yet, but I expect its not the controller at fault.

So, I'm a little bit in doubt of how to proceed - either keep the quirk
as a controller quirk - or make a *new* card quirk (with
SDHCI_QUIRK2_HOST_NO_CMD23 semantics)?

Anybody else have had experience with ISSI eMMC devices?

I have also tried to use DT sdhci-caps-mask, but MMC_CAP_CMD23 is not
read from the controller just (unconditionally) set in sdhci.c - so that
doesn't fly either.

Any suggestions?

> Yes, its supposedly a card quirk. I'll see to use the card quirks
> methods in place.
>

-- 
Lars Povlsen,
Microchip
