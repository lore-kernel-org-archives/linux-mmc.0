Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEB7ECDFA1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 14:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiJYOPJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiJYOOV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 10:14:21 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A917FA9263
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 07:14:20 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 830073A1C7C;
        Tue, 25 Oct 2022 16:14:18 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 691FA3A1965;
        Tue, 25 Oct 2022 16:14:18 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Tue, 25 Oct 2022 16:14:18 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 25 Oct
 2022 16:14:17 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Tue, 25 Oct 2022 16:14:17 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Topic: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Index: AdjnzoBSTaQo1pFFRXi0S56OT7wLqgAjLvCgAAfAMnA=
Date:   Tue, 25 Oct 2022 14:14:17 +0000
Message-ID: <ae6767a4abef41cd9068c467947646c9@hyperstone.com>
References: <d4ac7077d94743ed91c1b2b81fc5e164@hyperstone.com>
 <DM6PR04MB6575BC99A106EE2D430CA9BAFC319@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575BC99A106EE2D430CA9BAFC319@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27222.007
X-TMASE-Result: 10--16.197600-10.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4vHkpkyUphL9lKvhkP88iXTfKapXkCLRBRp5
        7Xpv5seJSuXhWUdTj/ZNS9A2Os1y7pk2j/A3wQwFrltvlARhKR1SuvtBzlaEqCt+gViu+UDk9zD
        JVgZmvsidhMZ1dVk8gPNViK/CIo6GqI7FT/qLDci/QNwZdfw3FZbRfsVvs4VIbkvAJoOQ99nm3f
        Y+Pm+oyN6cnt1oYdkR8qpkL5iHG/0yTrSSUnUH2Ih/ebSxR/Hn9Q5EsG01W96JqmTjiHXoLOHTr
        DSrqn2sYKoqOlygJb+80fHCLcecApL1TW+wDc38X9knSHW8uXV9LQinZ4QefLjBOloUqqjh1GcR
        AJRT6POOhzOa6g8KrYrLr64xtHc4bS+e8hk/96a+99IfQFFWtyIrC8ASRIkz9pitG498+XM=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 057daa86-d690-4403-8a07-7061d9435e87-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> @@ -255,6 +255,18 @@ static struct Command commands[] = {
>>           "Issues a CMD0 GO_PRE_IDLE",
>>           NULL
>>         },
>> +       { do_alt_boot_op, -1,
>> +         "boot_operation", "<boot_data_file> <boot_blocks> <device>\n"
>> +         "Does the alternative boot operation and writes the 
>> + specified starting
>> blocks of boot data into the requested file.\n\n"
>> +         "Note some limitations\n:"
>> +         "1. The boot operation must be configured, e.g. for legacy speed:\n"
>> +         "mmc-utils bootbus set single_backward retain x8 /dev/mmcblk2\n"
>> +         "mmc-utils bootpart enable 1 0 /dev/mmcblk2\n"
>> +         "2. The MMC must currently be running at the bus mode that 
>> + is
>> configured for the boot operation (HS200 and HS400 not supported at all).\n"
>> +         "3. Most hosts cannot do transfers of the typical size of 
>> + the boot partition,
>> adjust <boot_blocks> accordingly.\n"
> A redundant arg?
> Since blksz is 512, Maybe just set it to be ext_csd[226] * 256?

As the help above explains this will not work on most hosts.
Limitations of maximum transfers of like 512K to a couple MB are very common.
One could just read the max, but I found it less misleading that way.

>> +       mioc->num_of_cmds = 2;
>> +       mioc->cmds[0].opcode = MMC_GO_IDLE_STATE;
>> +       mioc->cmds[0].arg = MMC_GO_PRE_IDLE_STATE_ARG;
>> +       mioc->cmds[0].flags = MMC_RSP_NONE | MMC_CMD_AC;
>> +       mioc->cmds[0].write_flag = 0;
>> +
>> +       mioc->cmds[1].opcode = MMC_GO_IDLE_STATE;
>> +       mioc->cmds[1].arg = MMC_BOOT_INITIATION_ARG;
>> +       mioc->cmds[1].flags = MMC_RSP_NONE | MMC_CMD_ADTC;
>> +       mioc->cmds[1].write_flag = 0;
>> +       mioc->cmds[1].blksz = 512;
>> +       mioc->cmds[1].blocks = boot_blocks;
>> +       /* Access time of boot part differs wildly, spec mandates 1s */
>> +       mioc->cmds[1].data_timeout_ns = 2 * 1000 * 1000 * 1000;
>> +       mmc_ioc_cmd_set_data(mioc->cmds[1], boot_buf);
> Don't you get "010" prior to the boot content?
> Most cards have their EXT_CSD_PART_CONFIG_ACC_ACK bit set.
> So you need to eliminate it from the boot file?
> But your compare show that the files are identical - how so?

By configuring the card to not send BOOT ACK.
With it enabled there is unfortunately no way to get the transfer through from userspace.
(The host will sample part of the ACK, CRC wont match and so on)

I will address the rest of you comments in v2.

Regards,
Christian
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

