Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7520C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 30 May 2022 09:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiE3JDF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 May 2022 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiE3JDF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2022 05:03:05 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9AD14D15
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2022 02:03:03 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 79969462FE8;
        Mon, 30 May 2022 11:03:01 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 6884A462FE2;
        Mon, 30 May 2022 11:03:01 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Mon, 30 May 2022 11:03:01 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 30 May
 2022 11:03:00 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Mon, 30 May 2022 11:03:00 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ben.chuang@genesyslogic.com.tw" <ben.chuang@genesyslogic.com.tw>,
        "greg.tu@genesyslogic.com.tw" <greg.tu@genesyslogic.com.tw>,
        "SeanHY.chen@genesyslogic.com.tw" <SeanHY.chen@genesyslogic.com.tw>,
        "jason.lai@genesyslogic.com.tw" <jason.lai@genesyslogic.com.tw>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        "Renius Chen" <reniuschengl@gmail.com>
Subject: Re: [V2] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of
 GL9763E
Thread-Topic: [V2] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of
 GL9763E
Thread-Index: AQHYdAHdmysIIiRbB0OPTjWiaypwSa03Hnri
Date:   Mon, 30 May 2022 09:03:00 +0000
Message-ID: <59ad4f41eeeb4d5cbc4859e59ae2ef26@hyperstone.com>
References: <20220530084702.64943-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220530084702.64943-1-jasonlai.genesyslogic@gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.71]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-26924.006
X-TMASE-Result: 10-1.083900-10.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4vHkpkyUphL91QQ6Jx/fflZffSkyb6LPSFKW
        B9S2dk8OjMLrtfCoBplztxUQS8urp67Ya+mMySIYk3rl+MaNgxCSiza26cvwNEjINjnv2/BMFn1
        HfFYSiYKIuA1iha0SDhLICyaWdvZjhetawz1VSlPIpMSwJEh3Jdsu68CAPfG8myiLZetSf8ksmr
        SSWUk161BIVsvVu9ABec3QM3secWYVeM4c2aVf8ralNtWyB0tfphnypgPUdTxsvE+vSM3jh7IDC
        L4fOe67lExlQIQeRG0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 77f281b9-b784-41cf-b88f-536d53ba32c6-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>This patch is based on patch [1] and adopt Adrian's comment.
>
>Due to flaws in hardware design, GL9763E takes long time to exit from L1
>state. The I/O performance will suffer severe impact if it often enter
>and exit L1 state.
>
>Unfortunately, entering and exiting L1 state is signal handshake in
>physical layer, software knows nothiong about it. The only way to stop
>entering L1 state is to disable hardware LPM negotiation on GL9763E.
>
>To improve read performance and take battery life into account, we reject
>L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enable
>L1 negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.
>

Could you describe the impact for people unfamilar with the GL9763E?
Does this essientially disable low-power mode if the controller serviced a CMD18 last?
(which will be most of the (idle) time for reasonable scenarios, right?)
Or what exactly is the LPM negotation doing?=
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

