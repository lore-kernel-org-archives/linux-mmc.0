Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9DAC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Dec 2022 03:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiLTDmi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Dec 2022 22:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiLTDmg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2022 22:42:36 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CBA6314
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 19:42:34 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4BDE282BCD;
        Tue, 20 Dec 2022 04:42:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671507752;
        bh=fqEMT4F4f2sd1Egb9SnnkEuIKCEN+xtjP6fmKvvoZVk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n7U2FiYlup3zVbxrmgT1kI+YMMmplVcrX7DqLh46CIxv9Xyy+JxHFqxd6ni1bd2p7
         cr2YRAnUel+gcMzsAHLfEbpridqYlhGB7b155d2rMVFTyWqE+Ln8lB5s89rSF1B/ns
         ee8vgieQ2DIQNZATlZrGEGM1G2LjGMgZPZOXIbqz1lzP0GoMAuKZHge4QseJTkk6i6
         VBMGVbKoJva9VlIjtGigYMxXdT6l6iwnD/gAkcMUsmDwnJvSBqfob4tk19Tq/44y/Y
         zoZrrX17AhX5seD0j0b2hpdClL/5vckD5l2ga+Ozc9LOCbDpP+7u+jCtVX1CDLNL02
         ZeLEmHn4axKjg==
Message-ID: <8df08d8d-2cba-71a3-b160-e7d924d3bea1@denx.de>
Date:   Tue, 20 Dec 2022 04:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] [RFC] mmc: sdhci: Always apply sdhci-caps-mask and
 sdhci-caps to caps
Content-Language: en-US
To:     Bough Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zach Brown <zach.brown@ni.com>
References: <20221220015254.796568-1-marex@denx.de>
 <DB7PR04MB4010BE5749B5C9949A691C1990EA9@DB7PR04MB4010.eurprd04.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <DB7PR04MB4010BE5749B5C9949A691C1990EA9@DB7PR04MB4010.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/20/22 04:04, Bough Chen wrote:
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: 2022年12月20日 9:53
>> To: linux-mmc@vger.kernel.org
>> Cc: Marek Vasut <marex@denx.de>; Adrian Hunter <adrian.hunter@intel.com>;
>> Ulf Hansson <ulf.hansson@linaro.org>; Zach Brown <zach.brown@ni.com>
>> Subject: [PATCH] [RFC] mmc: sdhci: Always apply sdhci-caps-mask and
>> sdhci-caps to caps
>>
>> The original implementation in the commit referenced below only modifies
>> caps in case no caps are passed to sdhci_read_caps() via parameter, this does
>> not seem correct. Always modify the caps according to the properties from DT.
>>
>> 92e0c44b92e4 ("mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change
> 
> Need to add Fixes as below:
> Fixes: 92e0c44b92e4 ("mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change the caps read during __sdhci_read_caps")
> 
> I did a grep under the /drivers/mmc/host, seems all callers use NULL for the parameter caps and caps1,
> So maybe we could just simplify the code like this:

That would make backporting harder, so subsequent patch please.

But I am more interested in knowing whether this change even makes 
sense, since it was broken for like 6 years and nobody noticed.
