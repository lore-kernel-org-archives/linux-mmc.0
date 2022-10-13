Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17BCC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 08:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJMIfL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJMIfK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 04:35:10 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8070250532
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 01:35:08 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 1457D3A1927;
        Thu, 13 Oct 2022 10:35:07 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id EE18C3A18E2;
        Thu, 13 Oct 2022 10:35:06 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Thu, 13 Oct 2022 10:35:06 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 13 Oct
 2022 10:35:06 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Thu, 13 Oct 2022 10:35:06 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv2 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Topic: [PATCHv2 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Index: AdjebSjVc+AEAThvQj+uqrbmgvcwAQAZ3tvQAAJKcHA=
Date:   Thu, 13 Oct 2022 08:35:06 +0000
Message-ID: <2aa93912572a46738252f490258489d9@hyperstone.com>
References: <4152c899b638429fb5ec1fb93009b42b@hyperstone.com>
 <BL0PR04MB6564149CA860570CA546E51FFC259@BL0PR04MB6564.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB6564149CA860570CA546E51FFC259@BL0PR04MB6564.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.66]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27198.006
X-TMASE-Result: 10--18.190200-10.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4m1hH1h06pC6C/ExpXrHizx0Vj5gY98rDHzz
        Ot4Kod4UkDxuPhjo/LQB11rlDcR0VuBRuAss+FbmEXjPIvKd74BMkOX0UoduuejMOEZ5AL0SXPh
        Pm3zGFF3hS2D+Cu5xljkV5pWfBy3F3E+Da37cFR7wlvzzUUaf2Z+Z30eyNnRT33lGdNqhdtI52c
        GMrkaUn+bjFO6Bkm8/qJf8Iy3dLA05qS/ZlxNfrOG6e0pKqzZpBpEC0DNwn/qbKItl61J/yeQD/
        sqqL0mZq7rFUcuGp/EgBwKKRHe+r5pFfCPc9Gdo6XVqr16s9nDWT6bxVnuqcZKghzEPO6XNZseV
        exv0610=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 3c732fb2-f8ee-4bbe-898e-1a2a0b6cb858-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> Certain commands require a longer switch timeout.
>> Refactor accordingly to allow e.g. for future sanitize change.
>> 
>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>> ---
>>  mmc_cmds.c | 83 
>> +++++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 54 insertions(+), 29 deletions(-)
>> 
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 2957aa9..8bc7a56 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -54,6 +54,8 @@
>>  #define WPTYPE_PWRON 2
>>  #define WPTYPE_PERM 3
>> 
>> +#define SWITCH_TIMEOUT_MS (10 * 1000)
>Why 10 seconds?
>Maybe add comment or at least explain in your commit log.
>
>> +
>> 
>>  int read_extcsd(int fd, __u8 *ext_csd)  { @@ -76,7 +78,7 @@ int 
>> read_extcsd(int fd, __u8 *ext_csd)
>>         return ret;
>>  }
>> 
>> -int write_extcsd_value(int fd, __u8 index, __u8 value)
>> +int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int
>> +timeout_ms)
>>  {
>>         int ret = 0;
>>         struct mmc_ioc_cmd idata;
>> @@ -89,6 +91,7 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
>>                         (value << 8) |
>>                         EXT_CSD_CMD_SET_NORMAL;
>>         idata.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>> +       idata.cmd_timeout_ms = timeout_ms;
>If cmd_timeout_ms not set, mmc_sanitize will use 240s - MMC_SANITIZE_TIMEOUT_MS.
>I thought that you need more time, or did I get it wrong?
> 
> Also, I am uncomfortable that you are setting this value for all other commands.

Thanks for your comments, I agree.
I will resend a v3 that leaves the cmd_timeout_ms setting to the kernel unless the sanitize user-specified timeout is used.

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

