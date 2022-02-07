Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B91BC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Feb 2022 20:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiBGUIk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbiBGUIO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Feb 2022 15:08:14 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554FC0401E1
        for <linux-mmc@vger.kernel.org>; Mon,  7 Feb 2022 12:08:13 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru A2D172099DAC
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2] mmc: core: use sysfs_emit() in #define
 sdio_info_attr()
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>
References: <b0d9cdda-33f3-1eb0-a76e-26125089e5c5@omp.ru>
 <CAPDyKFpCH_0Hiq_FhmoUdgY0BXfnK0=jdB+zHQ8e16WKFNJfjA@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <7bb4e55e-a389-e132-a3c4-545b23c7342f@omp.ru>
Date:   Mon, 7 Feb 2022 23:08:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpCH_0Hiq_FhmoUdgY0BXfnK0=jdB+zHQ8e16WKFNJfjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

On 1/31/22 7:14 PM, Ulf Hansson wrote:

>> sprintf() (still used in #define sdio_info_attr()) is vulnerable to the
>> buffer overflow.  Use the new-fangled sysfs_emit() instead.
>>
>> While at it, add spaces around the minus sign...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> Thanks for fixing this!
> 
> However, rather than applying these piece by piece, would you mind
> squashing these "sysfs_emit" fixes into one patch for the mmc core? It
> would be easier for me to handle - and it should still be an easy
> backport, I think.

   OK, just posted!
   Note that in some place I had to reindent the entire function (indented
with spaces) because checkpatch.pl was bitching...

> Kind regards
> Uffe

[...]

MBR, Sergey
