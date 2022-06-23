Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5103EC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jun 2022 10:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiFWKff convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiFWKf3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2022 06:35:29 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82F14A3FC
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2022 03:35:25 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 146C8122BA8;
        Thu, 23 Jun 2022 12:35:24 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 042CF12076A;
        Thu, 23 Jun 2022 12:35:24 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Thu, 23 Jun 2022 12:35:23 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 23 Jun
 2022 12:35:23 +0200
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 23 Jun
 2022 12:35:23 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Thu, 23 Jun 2022 12:35:23 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc-utils: dont divide CMD23 count by sector size
Thread-Topic: [PATCH] mmc-utils: dont divide CMD23 count by sector size
Thread-Index: AdiG7NFoW471gNuQTayLmad2s/EH8Q==
Date:   Thu, 23 Jun 2022 10:35:23 +0000
Message-ID: <dc8b93a5c0b24a59b42278c761af1892@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-26972.006
X-TMASE-Result: 10--13.701100-10.000000
X-TMASE-MatchedRID: 2SDSohiwfqTUL3YCMmnG4o61Z+HJnvsOld00Q5SO0q5RXC4cX65cJOzH
        NVsaiyNEUsU2l8Z42eIFFkc0RYTLx1JVOThx4FfxXrBIbmgBxjxDVmiiHQSFeIc5XWJfryop0Am
        pRo8p3xNg73IJeoB8aRLzQdapWbf84acyaNVQ+eMqy6shOlK/48nlJe2gk8vIh78c7tRRuJG7FY
        /sCUPw05ae1E4/dXn5gnSYGvpeKgP5S+IvXI7mDRqkhv3OdF4DBGvINcfHqhfDqO6/8R69QLXip
        9G5gJewEwte8QHPZvfb0YjPwnmCByQYLRCMVJ+BpSXVpBS+ilb0swHSFcVJ6Jm3OIVSf4P5InVh
        PozbL+m1hEo88JH4h05oDy0xSTK5Eb0RuLqy8KF4L+0UwLmbKH0tCKdnhB58nFK7VE/xL0n6C0e
        Ps7A07fk39LXMSri6Uu++KX+IhY6eh7qX8CJ5q38jEEJ8RfqUFVExS23Cqq8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 9a08922c-f92d-4e55-bad4-ea8e3ccae4f7-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hey Avri,
Thanks for the comments.

>dont
>^^^^
>Don't
My bad, will correct in v2

>
>
>> FFU used to divide the fw_size by native sector size.
>> If native sector size is 4K the accesses need to be aligned and a 
>> multiple of 4K, other than that CMD23 SET_BLOCK_COUNT does not change.
>I am not sure what are you fixing, aside of violating a spec requirement:
>" Downloaded firmware bundle must be DATA_SECTOR_SIZE size aligned (internal padding of the bundle might be required)."
>So if the fw fluf is not sector-size aligned, you need to make it so.

So clearly the commit message does not a good job explaining either the problem or the fix, so let me try again.
First of all I only care about 4K native sector size devices here, the rest works fine, the behavior should not be changed by the patch
for 512B sector size devices. (If you think it does, please speak up!)
4k native sector size device FFU is currently broken in mmc-utils.
Why?
We get some firmware of fw_size bytes, we want to tranfer it to the device.

Let's go through the code:
First we have an "alignment" check, which ensures multiple and sets sect_size accordingly.
sect_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
if (fw_size % sect_size) {
	fprintf(stderr, "Firmware data size (%jd) is not aligned!\n", (intmax_t)fw_size);
	goto out;
}
Then there is the following

/* calculate required fw blocks for CMD25 */
blocks = fw_size / sect_size;

for native 4k device this is now the mount of 4k blocks of fw.

The fw is now transferred in one CMD23/25 transfer:
/* send block count */
multi_cmd->cmds[1].opcode = MMC_SET_BLOCK_COUNT;
multi_cmd->cmds[1].arg = blocks;
multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;

Here we have the problem already, it sets blocks, the fw_size / 4k as block count, this is wrong, should also be fw_size / 512, the patch addresses this.

Now we have the transfer, with an incorrectly set CMD23 as we will see.
/* send image chunk */
multi_cmd->cmds[2].opcode = MMC_WRITE_MULTIPLE_BLOCK;
multi_cmd->cmds[2].blksz = sect_size;
multi_cmd->cmds[2].blocks = blocks;
multi_cmd->cmds[2].arg = arg;
multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
multi_cmd->cmds[2].write_flag = 1;
mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);

blocks*sect_size (data and fw_size size in total) is intended to be transferred, but CMD23 has just set it to fw_size/8 sectors.
Furthermore I think since we are transferring everything in one chunk, blksz and blocks should reflect this, even though the kernel does not really care in that case.
The patch addresses this (this part should not change actual 512B sector size behavior).

The error is just a misunderstanding I would say that CMD23 acts in chunks of native sector size, which is not the case, its argument just needs to be divisible by 8 in case of native 4k.

>So if the fw fluf is not sector-size aligned, you need to make it so.
For now the FFU will cancel for non-aligned fw_size, I did not change this behavior, so I'd say that is fine.

Any future comments appreciated, also I will try to make the commit message more understandable, but if you have suggestions, go ahead.

Regards,
Christian
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

