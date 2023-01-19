Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D30C678D4
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjASSV7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjASSV6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2023 13:21:58 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538679373B
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2023 10:21:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaLvlHb/URUAAAT3LtJ7dCGSBw2U26kRHHtelTFmCiSgqZkm53KR1Obcl+UFK68VMmpNJ1qLfS6G6pgScfhtBdJLY+Bini9r61wJUqcvmM1cASJbk76a3xzEzc7FkKpQL1wKUgbUW4aK+Rkm+4M+DRdg1NdV3F3/q+TFk6uzkO79t4s6ueBtmvAL/nAlMZiKPNJE72qXo4RlMHXGB63JDYRU1pVgQzGdZLbMGBlmQjl/XVuxIP9pgEIasjNX0Fm6OkCMgWCRW1dJsCo0vPq5nCpJxpCTYPXeiuJfL0R4bt9Zjmm28bRBT2ZfZZr3AO6J/jaIx1Lxbk0N0Q1MVBV7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsjNULeOH+Ni6sU6JO9nlGbIsaOygBj+YrVVCKA+qaE=;
 b=H+8mDZdcoK5V629Hh0ut69KAKWuk22OIu4UO8B8nb8Lx75GBgMpxBZcg+ZWioQSjX/xmy/MJzP8cR5+MYvDovOlNJYlChLHDFXIpdopCAUS3i1huvx+TYOOlfSHFWbaaTfDNP/APnW9vYY4hU1gJ2TH8RBVZCMj2l/RHVVikIYq2gJTeTKpt3FupGfXF9s6rTb46ZgEfUNlZWoXnJ1Fi2OSOmY60OWpwcKdFsF9+M3VVgTvRsbSyFQ3Ej51qsphA3fy1fJRxom/iAN7oEO1J5ozWUfxtZ7AXw5fGIXvtf7q/rM7zbua+JQ8x7Abq+Z32htZMAntajrOZYYCXe0EBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsjNULeOH+Ni6sU6JO9nlGbIsaOygBj+YrVVCKA+qaE=;
 b=YNKT8EaFroLp9Hy+zcz9ttlLxK17rMPWPTRvCOIlU15QjmaiAKi1baxaVexxrUyuieD59WOWCelf0YjzQ3hrKmEsrMjTlvUKlUZkxNnx6UhIpvWY0n6oUypdtBRNJD+kpZYlabAKgQ50540TLWqCWNaEBAtH+c/+Kb8pYoE87gmjdLHU3Y0xphWVikO0ME9YciCnCbK5l68ah5OdkU7SwwG5+wqlLfaHn0xIGog28sJl0lYEgU2PKYJuL+f9y5/5GdkckynLwj8WW07wwSC2EaH4q3qq5XjA2rCbrsA85zW31ttCZO7rTkaF0xuHMVasKd3T8KlHq1kwcGZ2gZ/PIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB9077.eurprd03.prod.outlook.com (2603:10a6:10:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 18:21:52 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6b03:ac16:24b5:9166]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6b03:ac16:24b5:9166%2]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 18:21:51 +0000
Message-ID: <7f3dabe5-20d6-78f1-f043-818beebcf377@seco.com>
Date:   Thu, 19 Jan 2023 13:21:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] Add a command to write extcsd registers
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org,
        Philippe Reynes <philippe.reynes@sagemcom.com>
References: <20221216161625.2924013-1-sean.anderson@seco.com>
 <CAPDyKFoKZ165m1Fy5FJAv1WWPLT488LyRHhCdzw2mLOotSaPuA@mail.gmail.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <CAPDyKFoKZ165m1Fy5FJAv1WWPLT488LyRHhCdzw2mLOotSaPuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU0PR03MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 71af72e4-b801-4ff7-e565-08dafa4a0935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5ntDzofUtlDscpa2vvErtMSH26b8F9BN+xuiJtXnRPvFJ2ei5b9SnAulwVQTTZ/q1xQylbcFGDsEaw2mYHDO8jdoYkIF+F9MOycBebEgrUYIjGG0Kn9f5S1DGq04NEZDw+rnPwfguA20IVwcRtHuIuvqLBXNCkR1qc5nc2ILIYqxvG407d3DMJZjAqlpTOAp3is16A6oA3lO5+lARyLOQSEKWSxzKU7dy3hAxUBnFxDwKIwVN9q9CFG3q5s6xJRIRzuR9YczEbenpQQC1G+ysNePX3p+EHvh588IQWXggrjyP4czYqxCyCyzUrwVfoWiubfdijmSn5CN/Y0ClgI6PM9X08y0cxzhs3EJ3FmeFxKxTfnhhpiYIrGndGTqIffvXkiXN4W2anpverugwXQ9bHDuN2puR93G41x2z2lVvlXEQsOZbr8pr8J2RNdYL223KaqDrScBpwDcAJbZmj+g+I5m7zENHAkmp4kqgnUqjeQfF4TfU1YX1K/GSMf9DkEh7InRztvWfL3JGL1W41Nk8j2mpn9C+DvzLA58xjS8BXX4adTOA5XedBHrm4EYtBEr8j6+5EjY+jscWq5gVIis/miO0qcPbps7orhznzb6xTwi2VAGhFmbQ9SvCK8t/TpqAjiOGb30W0Nlth1wBMC21GOidD7mKX3WpzUEoGjsn5Rnx9InOjjx08tALL7tQVbvndMngaSpn81MbKlRZBX9viOyoDw/6z8nuxV7rZN1BIkC3H0bTUSG9UkamhLcLPL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39850400004)(136003)(451199015)(86362001)(31696002)(6506007)(53546011)(52116002)(6486002)(6666004)(36756003)(478600001)(8936002)(5660300002)(316002)(38100700002)(66946007)(66476007)(4326008)(66556008)(38350700002)(8676002)(26005)(41300700001)(6512007)(186003)(2906002)(83380400001)(110136005)(44832011)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3IxN2ljM1BURTlFamdVMGJpanBFK3ovR3Uyb21Ka2YzZUYrWVpPM0IxYkds?=
 =?utf-8?B?WlRXY0swTnRVZHZOUkhQZjZoajliMlpUWVVjUnVqMXUxd0oyYU0rRkxzdm52?=
 =?utf-8?B?aVh4UVEzRHdOczliM3RRbWw2b1hDNndhYjlBdTQ4RzBYd2R4dnp4QTdtbDhq?=
 =?utf-8?B?QytOQlBvUWVMVE04VDBIYkFEaldBK3pmTUgxYU9ESzFSeFBKckcvQkF0NWFQ?=
 =?utf-8?B?NStIV0tyMzZPTVRFT09iRjU1SC9ybmY4cTg2NTNtdkNqRU5Eay8zN3ZDemYy?=
 =?utf-8?B?T2R1RC9OTFhxdVlZcU0xUlpudnNPSThXS2h2Yks2WWI0V2ROMWxwcm94OG8w?=
 =?utf-8?B?SXBJZ1BESTQzU05xbWl2TVpLM21KRU1tRG0wNDFoSUdYMFkxVlpMRjI1MFo3?=
 =?utf-8?B?THgwUUhpV3RxdlRlR1JBNU52R01leWd0SDg2NkY4MmtmdzJUTHJ0RkxCeFBR?=
 =?utf-8?B?b1htRmJyTUdCaW1ZVWtMdjdZcWYzMmVPZTZwRzRzZUZMWnJEV2czN3NQUHln?=
 =?utf-8?B?bzZpSkdjb09uN2N3ZHBvMjR5V1IyMHF5M3pRMHhrV25ERWJUYzZVWG1sYXBP?=
 =?utf-8?B?Z1ZmWlZRNlBnTlNsVEh0bGlOV0dKNjFCTDlPU3oyeFBVQ0gvUUZZdkhyUFVx?=
 =?utf-8?B?cEp0OGt6N3IyVmdqWWo4YmZsbE9FdkhPQTBXNWVtazBnR3N4dzhaU2F3RjZw?=
 =?utf-8?B?OUFCZlNCRzFWMVVPYzdIOHVqaDJISnFhVGdySnFwRGVickV4dHdTTWFkSFhE?=
 =?utf-8?B?ZHl4QzlMaStjQnRuQ1g3b1AyWHJDL0Z3eTBIUXh0REtPd3pNZzhaZkVCeGE2?=
 =?utf-8?B?TGRnR1VsQnZsNG9DT1h3U3J5cHhtYWdrRFpaU2NLL2JmeTJtem9oMkJ4RFNG?=
 =?utf-8?B?V2NIUGlyanNBZUo4ZGFSSEJuTEhLc0xmM2JBaG9zc1RNcWhqZDFBS3RJN1BM?=
 =?utf-8?B?RVpmSCt5YW1HUUpYODZMVHdkZHNDK0FRbjZCVnNFeDJrVGg3N3pxcXd4UExI?=
 =?utf-8?B?ZEN5aUxvemxyVFEyZnFmR2VFOGZEZUpQaml1SXhwQnJoSThITTFQa0V1b0c4?=
 =?utf-8?B?Wm5qRXFkMjRmelVEM2dXcFpFVWR5eVY1ZE1EclUwK0VCUFVKS1dvQXFlTWQv?=
 =?utf-8?B?Y0Z0ZW5UWmlKdEVvY0dnRjlUK2lScXAyc04vTzd0YXpvQ25EaXJWS21kUXh4?=
 =?utf-8?B?YmhCdUNQRjhCSzR1TGVMTHVwL2FMbElyUmVSWU00NnZ6K0pTZXdHaXR5dFJV?=
 =?utf-8?B?WHVOMGNmTjk0aklvalB4ZW0vNDMrTGp5d0FuRkswTmdDTTZXeXJhTHIwU2Vl?=
 =?utf-8?B?bzJWRFNmcmkvVW13YnFjWXlaUVVydnFYamgydGNDT1lTTHUvQkpIZ2cydnN4?=
 =?utf-8?B?SGp1ZWVzSitnNWpLMjkvdXF5RGZhQXFjRUNMQlFMNGZGaEp5YXdzUzlrcGpX?=
 =?utf-8?B?bE94OEQ5UzBNemJYb2Mrd2k0blU3QWplVjRsaFZwUmNrVEsvYVAxZFgwSS94?=
 =?utf-8?B?bFhqVHhtU0RDbk04ODd1aDZJSDZLZW5idGtYS2N6bTYvZnAveVJlSTFhTDNm?=
 =?utf-8?B?bDN5Ykp1RzJJNjh3OVgyaWNobGpLVjNNNWdFYmJId1hWekFNWTV3ZnllcDBM?=
 =?utf-8?B?aGh1MGFkTEgxdU9uSTduYjFsSlRWRkJnbThPS0dhaUtjWFpSZEZObnJBWWFm?=
 =?utf-8?B?bHBKTVJXTWV3Y0FYUmdJNnZ5S2h4akI5SHl1RjBTU1N0a094V2pMKzN2TnUv?=
 =?utf-8?B?NWMwNXdhOGtvSGlBZDk2a2JHWnlNU2dNUVU1R1RFdTRtREpnYlJ4TnFmem9v?=
 =?utf-8?B?T0svZDdGaHIvT0JIUTYzSFZzYmFSWllmQnN2ckRlcXNJTXVuMVM5VUdoT3Bh?=
 =?utf-8?B?OVhKdUo5NXZOdG4xdkNOWEwwL1VleTJ2QTd4RXdQRFhDS3pyRkdIcU9Henl4?=
 =?utf-8?B?WExwNjlhei9WeFpHWkFiR0VIcTN5eW0zZS9JTlhQVm9qR2EvdGxZNWN3dVBF?=
 =?utf-8?B?WENIZ2lZcFFTMmEvVVJmeVJ1L1AwWVhVcVptcllQYkcwZHJXTHQ5UE51SUlz?=
 =?utf-8?B?VmYwL3FyaTRqSERXV3F4S0ROODVzVHMyVUEwR0pzR1EzV3JkeDRCYmZ2U0Yr?=
 =?utf-8?B?YWxEY2xqNUg2US9EWVpHQm94Ymp6bEdLUUNKSFpndXR3N0lpczg2bGx4RGRu?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71af72e4-b801-4ff7-e565-08dafa4a0935
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 18:21:51.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBK78hhHE0Ow9Iut3Sn3xu70RP5EuTLgYli1Yhn29Q8YpLoRPdpdg0xoVYuSHNeBEChGCZUMHjZoz4Qax1u4Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9077
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/2/23 08:06, Ulf Hansson wrote:
> On Fri, 16 Dec 2022 at 17:16, Sean Anderson <sean.anderson@seco.com> wrote:
>>
>> There is a command to read the extcsd and some commands to configure
>> particular features, but no generic write extcsd command. Such a command
>> may be useful for not-yet-supported features and manufacturer-specific
>> registers.
> 
> In a way this seems reasonable to me, while I am also a bit reluctant
> to provide a too easy interface to allow the user to write any extcsd
> value to the device. Note that, if these changes affect the behaviour
> of the device, the kernel will not be aware of it.

This is mainly to add an easy way to use vendor features, or to play around
with unimplemented registers.

For example, I wanted to determine the behavior of CD_PERM_WP_DIS
(whether it persisted across power cycles, as the spec is unclear). With
this command I was quickly able to set it and test things out.

--Sean

> Anyway, I will defer to Avri to make the call.

>>
>> Signed-off-by: Philippe Reynes <philippe.reynes@sagemcom.com>
>> [ rebased onto latest master and updated commit message ]
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> 
> Kind regards
> Uffe
> 
>> ---
>>
>>  mmc.c      |  5 +++++
>>  mmc_cmds.c | 32 ++++++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/mmc.c b/mmc.c
>> index adcd814..b9aa478 100644
>> --- a/mmc.c
>> +++ b/mmc.c
>> @@ -58,6 +58,11 @@ static struct Command commands[] = {
>>                 "Print extcsd data from <device>.",
>>           NULL
>>         },
>> +       { do_write_extcsd, 3,
>> +         "extcsd write", "<offset> <value> <device>\n"
>> +                 "Write <value> at offset <offset> to <device>'s extcsd.",
>> +         NULL
>> +       },
>>         { do_writeprotect_boot_get, -1,
>>           "writeprotect boot get", "<device>\n"
>>                 "Print the boot partitions write protect status for <device>.",
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index e6d3273..33b9e43 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -1982,6 +1982,38 @@ out_free:
>>         return ret;
>>  }
>>
>> +int do_write_extcsd(int nargs, char **argv)
>> +{
>> +       int fd, ret;
>> +       int offset, value;
>> +       char *device;
>> +
>> +       if (nargs != 4) {
>> +               fprintf(stderr, "Usage: mmc extcsd write <offset> <value> </path/to/mmcblkX>\n");
>> +               exit(1);
>> +       }
>> +
>> +       offset = strtol(argv[1], NULL, 0);
>> +       value  = strtol(argv[2], NULL, 0);
>> +       device = argv[3];
>> +
>> +       fd = open(device, O_RDWR);
>> +       if (fd < 0) {
>> +               perror("open");
>> +               exit(1);
>> +       }
>> +
>> +       ret = write_extcsd_value(fd, offset, value, 0);
>> +       if (ret) {
>> +               fprintf(stderr,
>> +                       "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
>> +                       value, offset, device);
>> +               exit(1);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>  int do_sanitize(int nargs, char **argv)
>>  {
>>         int fd, ret;
>> --
>> 2.35.1.1320.gc452695387.dirty
>>
