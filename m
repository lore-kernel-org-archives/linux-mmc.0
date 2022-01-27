Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA2FC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Jan 2022 21:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiA0VDB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:03:01 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:36558 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiA0VCq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jan 2022 16:02:46 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 166A2205B98C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] mmc: core: sd: use sysfs_emit() in #define
 sdio_info_attr()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
References: <b7dd683f-3856-5760-a16b-43f21f706939@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6de3dd8f-3535-3d27-47b5-70bfaa1698f5@omp.ru>
Date:   Fri, 28 Jan 2022 00:02:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b7dd683f-3856-5760-a16b-43f21f706939@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/25/22 11:31 PM, Sergey Shtylyov wrote:

> sprintf() (still used in #define sdio_info_attr()) is vulnerable to the
> buffer overflow.  Use the new-fangled sysfs_emit() instead.
> 
> While at it, add spaces around the minus sign...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.

   Ignore this one, I've just sent v2...

MBR, Sergey
