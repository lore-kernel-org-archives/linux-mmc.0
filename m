Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC8BC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C42164F53
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhBDM1b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:27:31 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:54715 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhBDM1b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2021 07:27:31 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DWd8F2bZvz1qtxY;
        Thu,  4 Feb 2021 13:26:35 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DWd8C36zBz1t6pZ;
        Thu,  4 Feb 2021 13:26:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id u8ZgwNeMFr2f; Thu,  4 Feb 2021 13:26:33 +0100 (CET)
X-Auth-Info: vcq+rd5OBVdAgvv48NV/nszk9o8hbPbbgOMW59G7lhg=
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  4 Feb 2021 13:26:33 +0100 (CET)
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     yann.gautier@foss.st.com, ulf.hansson@linaro.org
Cc:     linux@armlinux.org.uk, linus.walleij@linaro.org,
        ludovic.barre@foss.st.com, per.forlin@linaro.org,
        huyue2@yulong.com, wsa+renesas@sang-engineering.com,
        vbadigan@codeaurora.org, adrian.hunter@intel.com,
        p.zabel@pengutronix.de, swboyd@chromium.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-2-yann.gautier@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <0ac77e8d-9400-abc8-f963-943e9cba94db@denx.de>
Date:   Thu, 4 Feb 2021 13:26:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204120547.15381-2-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/4/21 1:05 PM, yann.gautier@foss.st.com wrote:
> From: Yann Gautier <yann.gautier@foss.st.com>
> 
> To properly manage commands awaiting R1B responses, the capability
> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
> manage busy detection.
> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.
> 
Shouldn't this have Fixes: tag ?
