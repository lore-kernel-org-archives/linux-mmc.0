Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E81C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8A260F70
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 09:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhITJgF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Sep 2021 05:36:05 -0400
Received: from mail4.swissbit.com ([176.95.1.100]:55294 "EHLO
        mail4.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhITJgE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2021 05:36:04 -0400
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E4AEA1222A6;
        Mon, 20 Sep 2021 11:34:35 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id CF09B121B6E;
        Mon, 20 Sep 2021 11:34:35 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Mon, 20 Sep 2021 11:34:35 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Mon, 20 Sep
 2021 11:34:35 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0792.015; Mon, 20 Sep 2021 11:34:35 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "marten.lindahl@axis.com" <marten.lindahl@axis.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
Thread-Topic: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
Thread-Index: AQHXq5f2H1xcZooo4kGJdi3JsFt1D6uoGrGAgASR040=
Date:   Mon, 20 Sep 2021 09:34:34 +0000
Message-ID: <0c002d216fa44df39fef87001079ca84@hyperstone.com>
References: <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>,<20210917134123.GL12780@axis.com>
In-Reply-To: <20210917134123.GL12780@axis.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26418.007
X-TMASE-Result: 10--1.266600-10.000000
X-TMASE-MatchedRID: F7tLedRt7ifUL3YCMmnG4vGG8F2k2BBVv5tdwacZEnrfoEW8NyvnbyaC
        jkFKp/+ebb+wP0Qo+N6TH1CW/TkdqldXhVJKmheR52cbj4/WmPsL8TGleseLPEoMHl9co6FPw9M
        1TrvkSYercKMJSOLvFZo4ITanr/FwE29kWrNuieBFM72aEhcbjc0b3CgaR62KEcWQUCNHW2ds5J
        OqCt0EWWQpTLT4bj+xEXcbsy/3gdUYB2fOueQzjxM0JxSxHjFJavP8b9lJtWr6C0ePs7A07V9vM
        TaVNFNz2tl1Zv77sopJpXzj6uHXhHXaLkIcCRk2nXkRk1EvZ8Q=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: f2104eb2-9cd3-4d2d-ab0d-d76412f53db1-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jesper Nilsson <jesper.nilsson@axis.com>
Sent: Friday, September 17, 2021 3:41 PM
To: Christian Löhle
Cc: linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org; marten.lindahl@axis.com; jh80.chung@samsung.com; ulf.hansson@linaro.org
Subject: Re: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid

>One second could be to short, we have seen some cards take up
>to 10s on write operations. Although that was quite a few years ago.
>
>TMOUT is only used for reads if I understand correctly,
>so it should be ok anyways.
>
>/Jesper

Yes, apart from it only affecting reads, the calculated timeout is only that high if the register still holds the reset value.
I've only seen and would expect this for initialization 'read' commands, like ACMD13, or ACMD51.
I have chosen 1s to hit an expectation that I would consider normal, that a card is initialized in a couple of seconds after plugging in, or never.

Regards,
Christian=
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

