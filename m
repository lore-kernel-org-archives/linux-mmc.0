Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D8C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Dec 2022 14:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiLLOBL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiLLOBJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2022 09:01:09 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55AA6468
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 06:01:03 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 67B5F3A29DA
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 15:01:01 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 58AF43A29D5
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 15:01:01 +0100 (CET)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 15:01:01 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclAAACQQLA=
Date:   Mon, 12 Dec 2022 14:00:58 +0000
Message-ID: <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
 <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27320.000
X-TMASE-Result: 10--15.717400-10.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4pTQgFTHgkhZt7k6BDMlB1iOvO+M7U9KcGuJ
        DYJwJ/rlR3kEA5lKXoBhWgNOVfhPTJcLewwAa76f8eSmTJSmEv3maCDCl6abvdr3IdXzKpiPkrI
        9/WPu3jecVp+nbQORkB5HSIAURpXTL/tBTZzO5Q0D2WXLXdz+AZki3iIBA3o/De+i4lPM57YWfU
        d8VhKJgpfzUkBpc072wFIXlLKJ5fzNR0Df05Sd2fCCu8kVj0TRUXlp1FHYSPW3CLdtdG1oCBmJr
        YUF6auekeCxmeCiEeOvJYCsbEmye8FHc8SNEuAxngIgpj8eDcBjZ/Fz4gCyG/oA9r2LThYYKrau
        Xd3MZDUMFsa+1wyh/C//SGDiptuUyV/EwS+msSu2D8aSYlQ4MOU3ug6iw7NJbswxlnHG5Z4=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 3a1d5fbd-2a8d-4791-83bb-f3fb2061ac43-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-----Original Message-----
From: Avri Altman <Avri.Altman@wdc.com> 
Sent: Montag, 12. Dezember 2022 14:45
To: Christian Löhle <CLoehle@hyperstone.com>; ulf.hansson@linaro.org; adrian.hunter@intel.com; linux-mmc@vger.kernel.org
Subject: RE: [PATCH] mmc-utils: Add basic erase error check

>> Check for erase specific R1 errors so e.g. an OOR erase is not 
>> reported as successful when it never executed.
>> 
>> There could be checks for more error bits but R1_ERASE_SEQ_ERROR on 
>> CMD38 should catch all that are reported by hardware anyway.
>> 
>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>> ---
>>  mmc_cmds.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index e6d3273..c00fe5e 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -54,6 +54,7 @@
>>  #define WPTYPE_PWRON 2
>>  #define WPTYPE_PERM 3
>> 
>> +#define ERASE_R1_ERR_MASK (R1_ERASE_SEQ_ERROR | R1_ERASE_PARAM |
>> R1_ERASE_RESET)
>> 
>>  int read_extcsd(int fd, __u8 *ext_csd)  { @@ -2668,6 +2669,23 @@ 
>> static int erase(int dev_fd, __u32 argin, __u32 start,
>> __u32 end)
>>         if (ret)
>>                 perror("Erase multi-cmd ioctl");
>> 
>> +       /* Does not work for SPI cards */
>> +       if (multi_cmd->cmds[0].response[0] & ERASE_R1_ERR_MASK) {
>> +               fprintf(stderr, "Erase start response: %08x\n",
>> +                               multi_cmd->cmds[0].response[0]);
>> +               ret = -EIO;
>> +       }
>> +       if (multi_cmd->cmds[1].response[0] & ERASE_R1_ERR_MASK) {
>> +               fprintf(stderr, "Erase end response: %08x\n",
>> +                               multi_cmd->cmds[1].response[0]);
>> +               ret = -EIO;
>> +       }
>> +       if (multi_cmd->cmds[2].response[0] & ERASE_R1_ERR_MASK) {
>> +               fprintf(stderr, "Erase response: %08x\n",
>> +                               multi_cmd->cmds[2].response[0]);
>> +               ret = -EIO;
>> +       }
>> +
> AFAIK the device will not set those bits in the command responses, but those are only available to read in the status register.
> Let me check.
>
> Thanks,
> Avri

So any R1 response which all of the three are? Or am I misunderstanding you?

Anyway the (eMMC) spec reads:
"If an erase command (either CMD35, CMD36, CMD38) is received out of the defined erase sequence, the Device shall set the ERASE_SEQ_ERROR bit in the status register and reset the whole sequence. If the host provides an out of range address as an argument to CMD35 or CMD36, the Device will reject the command, respond with the ADDRESS_OUT_OF_RANGE bit set and reset the whole erase sequence."
And for the cards that I've tried this holds true.
For SD a CMD13 after CMD38 is required, too.
I guess I can add that.

Regards,
Christian

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

