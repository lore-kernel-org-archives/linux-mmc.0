Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CD9C2BA83
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C1B2082F
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 13:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vtql9U+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLNwJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:52:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:65248 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727439AbgBLNwJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2020 08:52:09 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CDmZ1V012457;
        Wed, 12 Feb 2020 14:51:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=9E12TqBCb0K4ndg1LL4/Fp7lkxYkSxX5exg+953TBVg=;
 b=vtql9U+GPLAQQOk6WmXpCjlcWAkr0z5lhJiiS+Tb1eXiQtBszBukL5WS8SzUPhjzPMhP
 pSLeBoausHFe0HkzBaKhwe0XYgbdCA6m4acC6tf7/5WiwdWjuVJn8MkgxLJAC7AKcUta
 iV/XX47PY2FDCuS6Ok6693RhmO0s0vZc01fOiL4g8LraIdELKdoTE1RPML6a1mw0FpIL
 44gcWT/rEhmmYbdjjQWLbN5T3cDv2V32JETNSww3ymt01sPHP/YKQiTNfUSppjF8tmOq
 QnnuUOCDexU952zzy4m9uRZOobzrS8vUdejItwgxQD5qKcTdWiGZcZWyuwIMnFv912X+ eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufhevg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 14:51:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10A5810002A;
        Wed, 12 Feb 2020 14:51:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EFA782B3A13;
        Wed, 12 Feb 2020 14:51:44 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.51) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 14:51:44 +0100
Subject: Re: [PATCH 01/12] mmc: core: Throttle polling rate for CMD6
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, <mirq-linux@rere.qmqm.pl>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
 <20200204085449.32585-2-ulf.hansson@linaro.org>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <7d6dc452-6ede-94d5-6bd6-fe1d5f4d28da@st.com>
Date:   Wed, 12 Feb 2020 14:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200204085449.32585-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_07:2020-02-11,2020-02-12 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Le 2/4/20 à 9:54 AM, Ulf Hansson a écrit :
> In mmc_poll_for_busy() we loop continuously, either by sending a CMD13 or
> by invoking the ->card_busy() host ops, as to detect when the card stops
> signaling busy. This behaviour is problematic as it may cause CPU hogging,
> especially when the busy signal time reaches beyond a few ms.
> 
> Let's fix the issue by adding a throttling mechanism, that inserts a
> usleep_range() in between the polling attempts. The sleep range starts at
> 16-32us, but increases for each loop by a factor of 2, up until the range

Just to align comment and code: in the code the first usleep range start 
at 32-64us.

> reaches ~32-64ms. In this way, we are able to keep the loop fine-grained
> enough for short busy signaling times, while also not hogging the CPU for
> longer times.
> 
> Note that, this change is inspired by the similar throttling mechanism that
> we already use for mmc_do_erase().
> 
> Reported-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/mmc_ops.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index da425ee2d9bf..446a37cc2a86 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -456,6 +456,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   	struct mmc_host *host = card->host;
>   	int err;
>   	unsigned long timeout;
> +	unsigned int udelay = 32, udelay_max = 32768;
>   	u32 status = 0;
>   	bool expired = false;
>   	bool busy = false;
> @@ -500,6 +501,13 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   				mmc_hostname(host), __func__);
>   			return -ETIMEDOUT;
>   		}
> +
> +		/* Throttle the polling rate to avoid hogging the CPU. */
> +		if (busy) {
> +			usleep_range(udelay, udelay * 2);
> +			if (udelay < udelay_max)
> +				udelay *= 2;
> +		}
>   	} while (busy);
>   
>   	return 0;
> 
