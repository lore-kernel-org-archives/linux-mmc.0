Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3400FC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 06:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CB3613C8
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 06:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbhI2Gzj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:55:39 -0400
Received: from mail4.swissbit.com ([176.95.1.100]:33800 "EHLO
        mail4.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhI2Gzj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2021 02:55:39 -0400
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 5EAB712259E;
        Wed, 29 Sep 2021 08:53:57 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 4FAA4122566;
        Wed, 29 Sep 2021 08:53:57 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Wed, 29 Sep 2021 08:53:57 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Wed, 29 Sep
 2021 08:53:56 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0792.015; Wed, 29 Sep 2021 08:53:56 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "marten.lindahl@axis.com" <marten.lindahl@axis.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
Thread-Topic: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
Thread-Index: AQHXq5f2H1xcZooo4kGJdi3JsFt1D6uy2hoAgAfLcc8=
Date:   Wed, 29 Sep 2021 06:53:56 +0000
Message-ID: <cfe4476922584dff91bf0fdbec0c0843@hyperstone.com>
References: <CGME20210917075050epcas1p1962cd1c7c388b20ad17cb841461dae1b@epcas1p1.samsung.com>
        <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>,<a8031e66-77a0-ae9b-d78d-daebc1d7dc47@samsung.com>
In-Reply-To: <a8031e66-77a0-ae9b-d78d-daebc1d7dc47@samsung.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26436.006
X-TMASE-Result: 10--8.923600-10.000000
X-TMASE-MatchedRID: 9M69yBZ2Ml7UL3YCMmnG4vGG8F2k2BBVyeUl7aCTy8hntCkewtW30NPW
        omJfPYQZIMBvuronWr9dOsaQOyKqmhLwsVmbC9NrOGTV4fFD6yAlBKvI9NWIX2KBXlPtOqqX+Kc
        0X1niQZ/Zw2EtavuoguktgXE4NG6+/N0WsxWI4Qc4zRqVgiL30+vWkvu/824/qr3CBdU3C2Dy71
        Hqi5zuoEqna2uFlro8j0IvV7jlqDhyPzMTUSO1JKoXHZz/dXlxEf7F4CIBjrgHAA5cb5vjShpOM
        U5lxqhiiAMSTyXyFbpYKJTez2dVw+A4UzWGh1IDqoeab9Xgz8/865QlVwxmG+D0a1g8E91Lpsmo
        b0bsTdbi8zVgXoAltsILlqmfHjNKVnRXm1iHN1bEQdG7H66TyH4gKq42LRYkxE61TJzkcAdC0wa
        nE9fdSCKvjz/0r1QsSnj98gYIwLl+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: ef480ddb-5583-4819-a4e8-456c38ac6e8f-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hey,
so more generally the timeout here can be 41954 up to 167783 ms.
Is 42s too low to view it as invalid here?
Would you prefer the patch exluding the specific timeout values instead of anything above
41954?

Regards,
Christian




From: Jaehoon Chung <jh80.chung@samsung.com>
Sent: Friday, September 24, 2021 11:49 AM
To: Christian Löhle; linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org
Cc: marten.lindahl@axis.com; ulf.hansson@linaro.org
Subject: Re: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
    
Hi,

On 9/17/21 4:50 PM, Christian Löhle wrote:
> 
> Set the limit to 1s if the register is at reset value.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..cd9a6e0a7449 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1983,6 +1983,14 @@ static void dw_mci_set_drto(struct dw_mci *host)
>        /* add a bit spare time */
>        drto_ms += 10;
>  
> +     /*
> +      * If TMOUT register still holds the reset value the above calculation
> +      * would yield a timeout of over 167 seconds, limit it to 1000ms.
> +      * Normal reads/writes should not take anywhere close to 120s.
> +      */
> +     if (drto_ms > 120000)
> +             drto_ms = 1000;
> +

If dtrt_ms is 167sec, it means that bus_hz should be 0 or 1.
What value is your host->bus_hz?

Best Regards,
Jaehoon Chung

>        spin_lock_irqsave(&host->irq_lock, irqflags);
>        if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
>                mod_timer(&host->dto_timer,
> 

    =
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

