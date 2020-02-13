Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905BEC2BA83
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4882073C
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Q5Wn6q/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBMOm3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:42:29 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44352 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgBMOm3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 09:42:29 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DESilX030559;
        Thu, 13 Feb 2020 15:42:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=F1hCHr6bdW6m/n0eZT4RuE2/vXUEzJWVa6XvNXXYy0Y=;
 b=Q5Wn6q/3mZWoG1VWt+jORMULocgFj4tnLRJqIey1ifrPqHmn7RkfNaUrB+sap2FIshzv
 kUGi0NZgNg3FlICIGiZrl9uAQvO5uwBI2Fm8YRFfKCmNDhn1cGGfrjhJX4TrF7f1CJIt
 A7ZC8kyb4yGf5Iw2A47w0GTJ4pNv6a1s+C+GkaG62lV/WbJe5Vve7eTGBBEtMwA40sEQ
 eZVFzwYyCVddPvRrE360ZNVctRRXHJEWuBlyVOVAsymPsAjQZlMMe6E9DvOEvcCxVmX5
 GgCFwtJltW9vTuZ/avZGjWgk05iOuhNrPTARBIlTGNnjSn2z8HF+L97AL1Pl169CZbdr PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufhnupd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 15:42:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F25C8100034;
        Thu, 13 Feb 2020 15:42:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D89B42BAEF2;
        Thu, 13 Feb 2020 15:42:05 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Feb
 2020 15:42:05 +0100
Subject: Re: [PATCH 00/12] mmc: core: Improve code for polling and HW busy
 detect
To:     Baolin Wang <baolin.wang7@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, <mirq-linux@rere.qmqm.pl>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
 <CADBw62o+9aasHDJtOLAXkhvV3DSVXHePwqy707DMQNo2O-+YmQ@mail.gmail.com>
 <CADBw62rXMEq2mE43aJn=rq8CKX=1sM6hMBKuiqUbwmsDGJM5pw@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <69d3dff7-fd00-2c17-885f-785ecee573a3@st.com>
Date:   Thu, 13 Feb 2020 15:42:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CADBw62rXMEq2mE43aJn=rq8CKX=1sM6hMBKuiqUbwmsDGJM5pw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf

Le 2/13/20 à 7:23 AM, Baolin Wang a écrit :
> On Tue, Feb 11, 2020 at 9:17 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>>
>> Hi Ulf,
>>
>> On Tue, Feb 4, 2020 at 4:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> There exists several separate variants of polling loops, used to detect when
>>> the card stop signals busy for various operations, in the mmc core. All of them
>>> have different issues that needs to be fixed.
>>>
>>> The intent with this series, is to address some of these problems, via first
>>> improving the mmc_poll_for_busy() function, then consolidate code by moving
>>> more users to it.
>>>
>>> While I was working on this, I stumbled over some code here and there, that
>>> deserved some cleanup, hence I also folded in a couple of patches for this.
>>>
>>> So far, I have only managed to extensively test the updated mmc_poll_for_busy()
>>> function for CMD6 commands. Some tests for erase/trim/discard and for
>>> HPI+sanitize are needed.
>>>
>>> Note that, there are still separate polling loops in the mmc block layer, but
>>> moving that to mmc_poll_for_busy() involves some additional work. I am looking
>>> into that as a next step.
>>>
>>> Please help review and test!
>>
>> That will be help if you can supply one git branch to fetch these
>> patches :), and I will help to do some testing on my platform.
> 
> I've tested on my platform, incuding reading, writing, mounting and
> running all cases in mmc_test.c, and I did not find any problem. So
> please feel free to add my test tag. Thanks.
> 

Tested on mmci: sdmmc variant with/out MMC_CAP_WAIT_WHILE_BUSY
and I see no regression.
After series review, I've just a comment on patch 01/12
(code/comment alignment 32-64)

Tested-by: Ludovic Barre <ludovic.barre@st.com>
Reviewed-by: Ludovic Barre <ludovic.barre@st.com>

> Tested-by: Baolin Wang <baolin.wang7@gmail.com>
> 
>>> Ulf Hansson (12):
>>>    mmc: core: Throttle polling rate for CMD6
>>>    mmc: core: Drop unused define
>>>    mmc: core: Extend mmc_switch_status() to rid of __mmc_switch_status()
>>>    mmc: core: Drop redundant in-parameter to __mmc_switch()
>>>    mmc: core: Split up mmc_poll_for_busy()
>>>    mmc: core: Enable re-use of mmc_blk_in_tran_state()
>>>    mmc: core: Update CMD13 busy check for CMD6 commands
>>>    mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard
>>>    mmc: core: Drop redundant out-parameter to mmc_send_hpi_cmd()
>>>    mmc: core: Convert to mmc_poll_for_busy() for HPI commands
>>>    mmc: core: Fixup support for HW busy detection for HPI commands
>>>    mmc: core: Re-work the error path for the eMMC sanitize command
>>>
>>>   drivers/mmc/core/block.c   |  55 +++++--------
>>>   drivers/mmc/core/core.c    |  53 +------------
>>>   drivers/mmc/core/mmc.c     |  38 ++++-----
>>>   drivers/mmc/core/mmc_ops.c | 159 ++++++++++++++++++++++---------------
>>>   drivers/mmc/core/mmc_ops.h |  13 ++-
>>>   include/linux/mmc/core.h   |   3 -
>>>   include/linux/mmc/mmc.h    |  10 +++
>>>   7 files changed, 157 insertions(+), 174 deletions(-)
>>>
>>> --
>>> 2.17.1
>>>
