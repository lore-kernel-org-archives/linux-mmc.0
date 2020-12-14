Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D4FC4361B
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 07:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063B3225A9
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 07:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392940AbgLNHJO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Dec 2020 02:09:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42392 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438873AbgLNHJC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2020 02:09:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BE73rXZ144743;
        Mon, 14 Dec 2020 07:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=s7FDTZIBJKNR9KDMY14+lIuuYdlKTv9NS+Ix6giURYQ=;
 b=SderraMcfpBBIcxAUzDxRWv1UO4RERr989Qzya0I5vquPqCY9fO2FvaPbm7J6185El8J
 yMbTl5SNmKPLIomee1H0V6eMsg7fHOPVNIFz4J3vfyvA8fntIIDsgGSyhxzq/y48eUeJ
 Ko0uYi73QvLi/09rao+PAOE6pt16dIb+LZsQn1WjW4BNJjAbN8qjZ5u89lLkD0rLE97T
 WC8DBGJG1qSkr29qNk7JQJeDhPrxR5M/K2frSslz3lep8tmpGcvj1ZYcLRsYccSCKLQU
 Izp7kGwV3qnn8KEHKF74la2b677ZY9GBIfF+Px3X31hGn/iBR2exUuB6nQoe70szV8EI fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35cntkuna2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 07:08:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BE7628B185250;
        Mon, 14 Dec 2020 07:06:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35d7su3kyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 07:06:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BE75lhQ014580;
        Mon, 14 Dec 2020 07:05:47 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 13 Dec 2020 23:05:46 -0800
Date:   Mon, 14 Dec 2020 10:05:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: mmc: atmel-mci: Reduce =?utf-8?Q?scope?=
 =?utf-8?Q?_for_the_variable_=E2=80=9Cslot=E2=80=9D?= in atmci_request_end()
Message-ID: <20201214070536.GB2809@kadam>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
 <20201210151035.GC1578121@piout.net>
 <20201211083731.GP2789@kadam>
 <e7910b04-4c4a-567b-d87d-d12352a48cfc@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7910b04-4c4a-567b-d87d-d12352a48cfc@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=917 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=934 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140053
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 11, 2020 at 10:08:54AM +0100, Markus Elfring wrote:
> > This makes it hard to review any patches or follow discussion...
> 
> You shared also special software development opinions about extra variable
> initialisations occasionally, didn't you?

I generally put everything at the top of the function...  I don't have
a well developed philosophy for when variables should be declared with
a smaller scope.

	int ret;  <-- this should always be function scope

Probably the other people are right that making scopes shorter is more
important when the function is very long.

regards,
dan carpenter
