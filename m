Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00F5C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Nov 2021 15:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbhK2Pst (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Nov 2021 10:48:49 -0500
Received: from smtp.220.in.ua ([89.184.67.205]:52292 "EHLO smtp.220.in.ua"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240931AbhK2Pqs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Nov 2021 10:46:48 -0500
Received: from [10.30.18.189] (unknown [149.255.131.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id 530071A208E7;
        Mon, 29 Nov 2021 17:43:28 +0200 (EET)
Message-ID: <94704b83-75f3-b381-c6ca-c9845d408596@kaa.org.ua>
Date:   Mon, 29 Nov 2021 17:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [EXT] [PATCH v3] Use printf() to extract and print fw version
Content-Language: uk-UA
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Chris Ball <chrisball@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>
References: <20211116105109.3830-1-oleg@kaa.org.ua>
 <20211129124142.15012-1-oleg@kaa.org.ua>
 <PH0PR08MB788953AAE68B7136B52F1A9CDB669@PH0PR08MB7889.namprd08.prod.outlook.com>
From:   Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <PH0PR08MB788953AAE68B7136B52F1A9CDB669@PH0PR08MB7889.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


29.11.21 17:05, Bean Huo (beanhuo) пише:
> Micron Confidential
>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Subject: [EXT] [PATCH v3] Use printf() to extract and print fw version
>>
>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you
>> recognize the sender and were expecting this message.
>>
>>
>> This patch also fixes a compile error with a newer version of GCC:
>> error: '__builtin_strncpy' output may be truncated copying 8 bytes from a string
>> of length 511 [-Werror=stringop-truncation]
>>
>> Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>
> Hi Oleh,
>
> It is better to add the prefix "mmc-utils:" in the Commit subject to distinguish it from Linux kernel changes

Will do it.

> Reviewed-by: Bean Huo <beanhuo@micron.com>

Thanks!

