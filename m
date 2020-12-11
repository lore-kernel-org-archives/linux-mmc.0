Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EF2C2BB48
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A8023F33
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 08:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436907AbgLKIjZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:39:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36474 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392142AbgLKIis (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2020 03:38:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BB8ZQuI131659;
        Fri, 11 Dec 2020 08:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=IL/xX1pqQ+FwJTcRHs69J+NvLTwdwVVEJfd2g66opUA=;
 b=cWYi/zQOoX8hJ8NF5ANNdNO4n4NWz6h0q2WRNeyYzsdnfRIrTBOdZryatjmZAQiMSZ8a
 /+zALT5wCo4oucU4wYRmbNtjATArXvbYEQiGFDQp1EejblfUcBOTF6PqPrXjq6JWHige
 Fc95vrPNp5etIzrVC0Ip+a8vxfluaWWM4zAL9ACjlH18zhMvQOIZ0iOPaRXTXPkq17TW
 9dD9tlCfPh2dRP7IenzC10kJZHxjhl/fY0L4L063k5MhgWx1o1WZ2VUuC7w97rLFf5Zo
 ZhP4V1mZ3CtY7WaCJXvOCUM5fNUjQaA1nwdZ7BAsdH2kCnJeMzfGCJm/4psZMF24WQ29 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35825mhc3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 08:37:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BB8UdRL180916;
        Fri, 11 Dec 2020 08:37:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 358m433uy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 08:37:48 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BB8bdwV018287;
        Fri, 11 Dec 2020 08:37:40 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Dec 2020 00:37:39 -0800
Date:   Fri, 11 Dec 2020 11:37:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mmc: atmel-mci: =?utf-8?Q?Redu?=
 =?utf-8?Q?ce_scope_for_the_variable_=E2=80=9Cslot?= =?utf-8?B?4oCd?= in
 atmci_request_end()
Message-ID: <20201211083731.GP2789@kadam>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
 <20201210151035.GC1578121@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210151035.GC1578121@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=893
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=923 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110054
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Markus was banned from vger at the end of July after ignoring repeated
warnings.  This makes it hard to review any patches or follow
discussion...

regards,
dan carpenter

