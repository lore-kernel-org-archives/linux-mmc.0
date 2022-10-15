Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9367C4332F
	for <linux-mmc@archiver.kernel.org>; Sat, 15 Oct 2022 11:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJOLcC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 15 Oct 2022 07:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJOLcC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Oct 2022 07:32:02 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F254CB0
        for <linux-mmc@vger.kernel.org>; Sat, 15 Oct 2022 04:32:01 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id DFDA5462EBC;
        Sat, 15 Oct 2022 13:31:59 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C1E34462AD8;
        Sat, 15 Oct 2022 13:31:59 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Sat, 15 Oct 2022 13:31:59 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Sat, 15 Oct
 2022 13:31:56 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Sat, 15 Oct 2022 13:31:56 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCHv4 2/2] mmc-utils: Allow for custom sanitize timeout
Thread-Topic: [PATCHv4 2/2] mmc-utils: Allow for custom sanitize timeout
Thread-Index: Adjgh7hSXN/cQvh4SS6ilhYhnV9WngAAcZ6Q
Date:   Sat, 15 Oct 2022 11:31:56 +0000
Message-ID: <b5795a34ab1741aaaba9fce3e75ca3b3@hyperstone.com>
References: <4ddb5a5510d74645b2724d274c96ab02@hyperstone.com>
In-Reply-To: <4ddb5a5510d74645b2724d274c96ab02@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.5]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27202.006
X-TMASE-Result: 10-0.196000-10.000000
X-TMASE-MatchedRID: oCMH03eFz6DUL3YCMmnG4m1hH1h06pC6C/ExpXrHizzIgofMgahPreS9
        slBM8vbuvnCllUJsUcvkBJIJYqRkdzcpdZ3fQiLdEzQnFLEeMUmOtgFHOy/jH7EHSKN6fcoI5MI
        x11wv+CM7AFczfjr/7GKSIw/GX4MBkVcQeFvPu1DV9pHmmI4S0+83C3CeZYL5eqMrHTgoPhA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: f780a4fe-04ab-423e-8b49-bb574b1c6f70-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Some cards with certain preconditioning require a higher timeout when sanitizing. Let the user set the maximum > > timeout.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Forgot to add, my bad.

Regards,
Christian
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

