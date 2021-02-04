Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F3BC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521FC64E50
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhBDMz7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:55:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44710 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236106AbhBDMz6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2021 07:55:58 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114CrClx029752;
        Thu, 4 Feb 2021 13:55:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dDxbuN1M2YXULMXlXW3oAl3FlBg++dDkJnKD4C31Zkk=;
 b=byzEcUJ8cHDnwCvwdROgOgEWLDexyLMhykJ8PLOtkSd25hUH8MJpSUbFHZ7qrO6GBfcr
 sPEE3FsHcjU70c3ifedtjDkniFxMPhmeqQ5h1LYhR/CgiKe26RhnN6rkvIogSN4N/0Sn
 QqGfFK/zhUzkWTuQiNjglg2XgPSRnCZD9QvkE4vESn1YJyJKQji3ssFyStU5odcJVn+f
 JWh8Le4+JWOWcq0uGx2We60/sgdPLnjXp3wtmDRpx5CB3WAaMzB2Ww/HXSElnlQu4poH
 ijDuI08QIUSJQF3spool8wmTEOgHX+G830cxkg9UVMn+iJKFOjys/+qvl2FBpMjiDR3w Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36e7x17xfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 13:55:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D48CE10002A;
        Thu,  4 Feb 2021 13:54:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B6D3324C9AE;
        Thu,  4 Feb 2021 13:54:58 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 13:54:58 +0100
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     Marek Vasut <marex@denx.de>, <ulf.hansson@linaro.org>
CC:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <ludovic.barre@foss.st.com>, <per.forlin@linaro.org>,
        <huyue2@yulong.com>, <wsa+renesas@sang-engineering.com>,
        <vbadigan@codeaurora.org>, <adrian.hunter@intel.com>,
        <p.zabel@pengutronix.de>, <swboyd@chromium.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-2-yann.gautier@foss.st.com>
 <0ac77e8d-9400-abc8-f963-943e9cba94db@denx.de>
From:   Yann GAUTIER <yann.gautier@foss.st.com>
Message-ID: <9fbd2fca-e4f5-d28f-74de-d9906cc232bf@foss.st.com>
Date:   Thu, 4 Feb 2021 13:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ac77e8d-9400-abc8-f963-943e9cba94db@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_07:2021-02-04,2021-02-04 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/4/21 1:26 PM, Marek Vasut wrote:
> On 2/4/21 1:05 PM, yann.gautier@foss.st.com wrote:
>> From: Yann Gautier <yann.gautier@foss.st.com>
>>
>> To properly manage commands awaiting R1B responses, the capability
>> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
>> manage busy detection.
>> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
>> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.
>>
> Shouldn't this have Fixes: tag ?

Hi Marek,

There is no unique patch that brought the issue, but a combination of 
several things:
- The series that brought the MMC_CAP_NEED_RSP_BUSY flag [1]
- The series that enabled MMC_ERASE for all hosts [2] (removal of 
MMC_CAP_ERASE)

But you're right, this patch may go on v5.8.x kernel and newer versions.


Regards,
Yann

  [1] 
https://patchwork.kernel.org/project/linux-mmc/cover/20200310153340.5593-1-ulf.hansson@linaro.org/
  [2] 
https://patchwork.kernel.org/project/linux-mmc/patch/20200508112853.23525-1-ulf.hansson@linaro.org/
