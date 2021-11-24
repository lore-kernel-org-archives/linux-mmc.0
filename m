Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E50DC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 13:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348402AbhKXNJR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 08:09:17 -0500
Received: from mail4.swissbit.com ([176.95.1.100]:56766 "EHLO
        mail4.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347321AbhKXNG3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 08:06:29 -0500
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 08:06:28 EST
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 6349B12309D;
        Wed, 24 Nov 2021 13:52:49 +0100 (CET)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 50F3412135E;
        Wed, 24 Nov 2021 13:52:49 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Wed, 24 Nov 2021 13:52:49 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 24 Nov
 2021 13:52:48 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.014; Wed, 24 Nov 2021 13:52:48 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Keeping <john@metanate.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem
Thread-Topic: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem
Thread-Index: AQHX2xySGVxdpK/hyE2/b74u5aNE2qwRezsAgADwPwCAAEFK9g==
Date:   Wed, 24 Nov 2021 12:52:48 +0000
Message-ID: <3b78d0e4656f4df6bf548cd9f7557ec0@hyperstone.com>
References: <20211116190244.1417591-1-john@metanate.com>
        <20211116190244.1417591-3-john@metanate.com>
        <CGME20211123193506epcas1p49d0d0a2d66c6e560ee26077da9c0202b@epcas1p4.samsung.com>
        <CAPDyKFp1zMBUfK7LteW0yEfTpqtU+P+EybLsJBFx_r54HwFdMg@mail.gmail.com>,<315972c2-2253-ad10-b712-2d2c96b3da26@samsung.com>
In-Reply-To: <315972c2-2253-ad10-b712-2d2c96b3da26@samsung.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26548.007
X-TMASE-Result: 10--1.407700-10.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4gCNFKULxGCZW6IdALvH8VNwE7NCfvba3GUS
        rm6wRiNd2cNhLWr7qILpLYFxODRuvjM9BBRuZZ1vB8FxO/BQHsIfQ0DEYgUiKqq9wgXVNwtgdIJ
        YUTzuXUUHATBTVJGV5ZSttLtHP+zpmaTQpcNd9EZLQaU8f2RHcsuCYrT3WeZNIyM6bqaAlyvx/h
        K2QE5rfkjQI6DCLKphKsS+56gpTfPUPdM50hQuqtjoQZHeT+6KaVixrzjDaFMvfU/riSJXkSRHy
        YWCHVT1kPI1/ZdqoS3Yx3U2V+RyvEaLFcw9F5OfR4PPMO+JjQ5BmlBF/IJ0fJj+eLysI+/go8WM
        kQWv6iUig6xaCvyzXY6HM5rqDwqtGLbAfzBTMDNxtffbMaCwB3yI7GSJwtUAUqUQlXIvT29q3RL
        sD9jjz0MMprcbiest
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 0417d7b1-9dd2-4d05-8304-a21658566d83-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sorry for hijacking this thread.


From: Jaehoon Chung <jh80.chung@samsung.com>
Sent: Wednesday, November 24, 2021 10:54 AM
To: Ulf Hansson; John Keeping
Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem

>>> The old "mshc" lookup is kept for backwards compatibility.
>> 
>> The mshc alias is really weird!
>> 
>> It looks like some leftover from when the dw_mmc controller supported
>> multiple slots. This support was dropped a long time ago, simply
>> because it never really worked - and it was not worth trying to. Only
>> one slot per controller is supported.
>
>As Ulf mentioned, dw_mmc controller can be supported multiple slot.
>But I didn't see its case to use multiple slot. And I had been done to drop a long time ago.
>
>mshc was used because of Mobile Storage Host Controller.

I assume this means you are open to a rework for dw_mmc?
I have a bigger patch for dw_mmc that I work on myself.
I removed the slot functionality at the start because there is no way for me to verify that I did not break this feature in the meantime.
But if it never worked and there is no platform for it, then removing this is fine for everyone?
Otherwise I probably would submit my rework for staging.

Regards,
Christian=
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

