Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4AEC64ED8
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Feb 2023 07:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjB0HiF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Feb 2023 02:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjB0HiE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2023 02:38:04 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4AD976F
        for <linux-mmc@vger.kernel.org>; Sun, 26 Feb 2023 23:38:02 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EDEBB24E0D7;
        Mon, 27 Feb 2023 15:38:00 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 15:38:00 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 15:38:00 +0800
Message-ID: <4dc6271e-b545-cf5f-dff8-7be8f00ea21d@starfivetech.com>
Date:   Mon, 27 Feb 2023 15:37:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [bug report] mmc: starfive: Add sdio/emmc driver support
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>
CC:     <linux-mmc@vger.kernel.org>
References: <Y/xWiEW/npStWjTF@kili>
 <c32bdbe3-2e3a-d1e1-94c3-9aed2b31afc4@starfivetech.com>
 <Y/xb2nqWVQ8Xc3HI@kadam>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <Y/xb2nqWVQ8Xc3HI@kadam>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 2023/2/27 15:29, Dan Carpenter wrote:
> On Mon, Feb 27, 2023 at 03:26:58PM +0800, William Qiu wrote:
>> 
>> 
>> On 2023/2/27 15:06, Dan Carpenter wrote:
>> > Hello William Qiu,
>> > 
>> > The patch 9e622229bbf4: "mmc: starfive: Add sdio/emmc driver support"
>> > from Feb 15, 2023, leads to the following Smatch static checker
>> > warning:
>> > 
>> > 	drivers/mmc/host/dw_mmc-starfive.c:77 dw_mci_starfive_execute_tuning()
>> > 	error: uninitialized symbol 'prev_err'.
>> > 
>> > drivers/mmc/host/dw_mmc-starfive.c
>> >     47 static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>> >     48                                              u32 opcode)
>> >     49 {
>> >     50         static const int grade  = MAX_DELAY_CHAIN;
>> >     51         struct dw_mci *host = slot->host;
>> >     52         struct starfive_priv *priv = host->priv;
>> >     53         int rise_point = -1, fall_point = -1;
>> >     54         int err, prev_err;
>> >     55         int i;
>> >     56         bool found = 0;
>> >     57         u32 regval;
>> >     58 
>> >     59         /*
>> >     60          * Use grade as the max delay chain, and use the rise_point and
>> >     61          * fall_point to ensure the best sampling point of a data input
>> >     62          * signals.
>> >     63          */
>> >     64         for (i = 0; i < grade; i++) {
>> >     65                 regval = i << priv->syscon_shift;
>> >     66                 err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
>> >     67                                                 priv->syscon_mask, regval);
>> >     68                 if (err)
>> >     69                         return err;
>> >     70                 mci_writel(host, RINTSTS, ALL_INT_CLR);
>> >     71 
>> >     72                 err = mmc_send_tuning(slot->mmc, opcode, NULL);
>> >     73                 if (!err)
>> >     74                         found = 1;
>> >     75 
>> >     76                 if (i > 0) {
>> > --> 77                         if (err && !prev_err)
>> > 
>> > prev_err was never initialized to zero.
>> > 
>> Hi Carpenter,
>> 
>> I will fixed it. But what should I do next，send a new version to fixed 
>> it or send a patch to you?
> 
> Heh?!  No, leave me out of it.  Just send a patch with a Fixes tag to
> the linux-mmc@vger.kernel.org and the maintainers and so on.  Please
> give me a Reported-by: Dan Carpenter <error27@gmail.com> credit though.
> 
> regards,
> dan carpenter
> 

Fine, I'll do it then. Thanks anyway.

Best regards
William
