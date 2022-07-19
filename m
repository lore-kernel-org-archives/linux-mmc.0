Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F3DC43334
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jul 2022 08:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiGSIHT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jul 2022 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGSIHT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2022 04:07:19 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879A22BDC
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 01:07:18 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7571E122C98;
        Tue, 19 Jul 2022 10:07:16 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 64441122040;
        Tue, 19 Jul 2022 10:07:16 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Tue, 19 Jul 2022 10:07:16 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 19 Jul
 2022 10:07:15 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Tue, 19 Jul 2022 10:07:15 +0200
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add softreset command for issuing CMD0
Thread-Topic: [PATCH] mmc-utils: Add softreset command for issuing CMD0
Thread-Index: AdiaoDZBaBhbwaxFRXm22iF8+GujggAAGungACkaz1A=
Date:   Tue, 19 Jul 2022 08:07:15 +0000
Message-ID: <ca03eef23ff5419692b7e15c2f038640@hyperstone.com>
References: <fee2ce51a200442f90bea0668466a2b1@hyperstone.com>
 <DM6PR04MB6575A42E7EFD93C235BD5AA7FC8C9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575A42E7EFD93C235BD5AA7FC8C9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27024.006
X-TMASE-Result: 10--6.583300-10.000000
X-TMASE-MatchedRID: HXSqh3WYKfv/9O/B1c/Qy/HkpkyUphL9SuH+GfgmQGe/u0i6nZyTEexB
        OxkcP0CfOkfoCUthhUVER/zKfdDkeYdhJvvq7rh/OWUWxTQJdI8XivwflisSrEoLeBActQNSzw5
        qWkMkRCXUF5lcDrnyHfUEJG5wwqiIjGnLhQ6GoquJJ72DuZB0nOio2PgrXLs4yIKHzIGoT61yGA
        ZugQJF1G8B9lA7FWU/ZACetupFJLD4nEvV7HPnW99JA2lmQRNUA9iLXr4BSNObKItl61J/yc4ba
        jgO0kgvXWPmaFoiyJsgBwKKRHe+r0f4kiDVGyx8fEI6H3dDajerQcgvB/lz5MuoV17w7hTXaRQT
        75CPOFk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 7fa95ff0-5a9b-4b9b-ac6d-96d1350ce171-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> CMD0 may be used to see if the hardware can handle a UHS card
>> that completed the voltage switch. If a UHS card has problems
>> coming back up after CMD0 your hardware may not support a hard
>> reset properly.
>I think it's a useful addition, not just for that reason.
>Specifically to test hw-reset support, I think you should use the GO_PRE_IDLE_STATE option.

Makes sense to add both, I can do that.

>
>> +
>> +       memset(&idata, 0, sizeof(idata));
>> +       idata.opcode = MMC_GO_IDLE_STATE;
>> +       idata.flags = MMC_RSP_NONE | MMC_CMD_BC;
>How about adding all 3 flavors of soft-reset: GO_IDLE_STATE, GO_PRE_IDLE_STATE, and BOOT_INITIATION.
>There can be 3 different command, that calls the same __soft_reset helper, or whatever.
>What do you think?  

I'm fine with GO_IDLE_STATE and GO_PRE_IDLE_STATE, but BOOT_INITATION Im not sure about, what purpose would it serve?
If the intention is to be able to get the boot operation done with multi_cmd of GO_PRE_IDLE_STATE and BOOT_INITATION and return the data then that would at least be some more testing effort before I resend.
I have only done the boot operations completely in the driver so far.
Furthermore I think many (most?) host controllers (or our drivers) seem to have issues with the transfer size I'd expect of a normal boot operation (i.e 4-32MB).

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

