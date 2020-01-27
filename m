Return-Path: <SRS0=8dup=3Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938ABC33CB1
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 13:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B22207FD
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 13:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="X/iiA29C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgA0Nwr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:52:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54272 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726303AbgA0Nwq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jan 2020 08:52:46 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RDqbnt009301;
        Mon, 27 Jan 2020 14:52:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=O6+dl2h2jXKNX+fyEpk/L/rLP8vjpdo1SJpvyPqDs8o=;
 b=X/iiA29CNOrjDNNUARjzkyJpC1jddl3AsBxKBhiHW+SWoftFjY8Gi4idGPQEkJG5183x
 krj9qylWMsE8A6gNOBlZqR6kDZrYQxmgYytDDj5hc2gFbkwdeZXnicL6BmcgfKUmlkS6
 48/Ua5wooQ/Z1K5UN5otgsaMIwZSvUyBejfnvh2CuMlSiLWsNZLH0Cue+aWsDbs2G+xe
 AqvY1Wu2uxfxnMhZ+I30pSzC53NG16S6S8pYprESRWtO5t6nIIDl1SFxMtvJIWY4ugk4
 qa1FE1Yehgv2YPYf1ZJdHV3obXWB/iF8jmS4pOEK97Bk4ybbfI35+Hs/KWOhFRNnm3vu Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdek90x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 14:52:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 15257100038;
        Mon, 27 Jan 2020 14:52:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 00C312B2F22;
        Mon, 27 Jan 2020 14:52:29 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 14:52:29 +0100
Subject: Re: [PATCH 0/9] mmc: mmci: sdmmc: add sdr104 support
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
 <6d859def-351e-abd7-0d5f-962ad935dff2@st.com>
 <CAPDyKFo+4qTZbE=4Zgj3VN9BPYUHGskPSnYEJRo1TpARzg5zJg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <cdc08d8d-ffb1-0fe9-377d-a1e5faf089ce@st.com>
Date:   Mon, 27 Jan 2020 14:52:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo+4qTZbE=4Zgj3VN9BPYUHGskPSnYEJRo1TpARzg5zJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Le 1/24/20 à 2:19 PM, Ulf Hansson a écrit :
> On Fri, 24 Jan 2020 at 13:55, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>> hi Ulf
>>
>> Just a "gentleman ping" on this series
>> https://lkml.org/lkml/2020/1/10/392
> 
> I was just reviewing :-) Thanks for pinging!
> 
> One overall comment is that I think you can try to work a bit on the
> changelogs. In some cases you described what the patch does, which is
> good, but it may lack information about *why* the change is wanted.

Ok, I try to add a comment to *why*

> 
> Overall, the series looks nice.
> 
> Kind regards
> Uffe
> 
