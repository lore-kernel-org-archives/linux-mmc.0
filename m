Return-Path: <SRS0=OcmH=2C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC7C3F68F
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E74A206C3
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 15:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GUCC284o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfLLPAR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:00:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfLLPAR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2019 10:00:17 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCEsM2Z074246;
        Thu, 12 Dec 2019 15:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=NP5r1uMexMX/0I+0uQ0RAMkaehg9mAbXkjByjTq4ouQ=;
 b=GUCC284oB1Fb0zDQ1PMSPXY5CmjIPMT0+5VUTr5IBqvcwD1v+juRPd4Tkndi4ZBjU8Kp
 YtMNk1bAhrSI4rjdzzNFtxxXbw1cxxTn5ZhD4OXtOt2MNxA4UiMDqaWiod3ztqdYXIoR
 N3Satv1O5MtLudzop0FxsndLCUcGJnc/ZXorRtN9KEA5rqIDX2LIZkm5QCooT8EKDBkd
 1ZWF6k+4oLnzo1HYCxVLX96LrGExZyrAYYiM4S5LgGgrdkiRRWpD8OUl70n4v5PM4Auy
 Ij+N61VsP3sZS4YtHrEjHB189QyKkwrNYWlQzuOVDe7a7ABqcaXMCM8/tzCkr6vaZHEU Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4ngd3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 15:00:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCEvvT6096399;
        Thu, 12 Dec 2019 15:00:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wumvywfe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 15:00:12 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCF0A7f029533;
        Thu, 12 Dec 2019 15:00:11 GMT
Received: from [10.135.79.145] (/10.135.79.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 07:00:10 -0800
Subject: Re: mmc-utils changes for Erase commands.
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     "chrisball@gmail.com" <chrisball@gmail.com>,
        Nachi Nachiappan <nachi.nachiappan@oracle.com>
References: <702f7830-5477-8024-4716-240e263375be@oracle.com>
 <MN2PR04MB69914177DD63B9DB59EDDFE7FC550@MN2PR04MB6991.namprd04.prod.outlook.com>
From:   Kimito Sakata <kimito.sakata@oracle.com>
Organization: Oracle Corporation
Message-ID: <a02eca75-302d-1fd7-fd9d-389cd8861cff@oracle.com>
Date:   Thu, 12 Dec 2019 08:00:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <MN2PR04MB69914177DD63B9DB59EDDFE7FC550@MN2PR04MB6991.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120115
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Avri

Sorry new to this. Is there a doc on the "format" I can reference to?

Kimito

On 12/12/2019 6:43 AM, Avri Altman wrote:
> Please send your patch in the appropriate format,
> So it can be reviewed.
>
> Thanks,
> Avri
>
>>
>> mmc.h
>> 36a37,45
>>   > #define MMC_ERASE_GROUP_START   35    /* ac   [31:0] data addr   R1  */
>>   > #define MMC_ERASE_GROUP_END     36    /* ac   [31:0] data addr   R1  */
>>   > #define MMC_ERASE               38    /* ac   [31] Secure request
>>   >                                               [30:16] set to 0  >                                               [15] Force
>> Garbage Collect request4  >                                               [14:2] set to 0
>>>                                                 [1] Discard Enable  >                                               [0]
>> Identify Write Blocks for Erase (or TRIM Enable)  > R1b */
>>
>> mmc_cmds.h
>> 33a34
>>   > int do_erase(int nargs, char **argv);
>>
>> mmc_cmds.c
>> 226a227,291
>>   > int erase(int fd, __u32 argin, __u32 start, __u32 end)  > {  >         int ret = 0;
>>   >     struct mmc_ioc_cmd idata;
>>   >     __u32  response;
>>   >
>>   >     // Set Start address
>>   >     memset(&idata, 0, sizeof(idata));
>>   >     idata.opcode = MMC_ERASE_GROUP_START;
>>   >     idata.arg = start;
>>   >     idata.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>   >     ret = ioctl(fd, MMC_IOC_CMD, &idata);
>>   >     if (ret)  {
>>   >       perror("ioctl");
>>   >       printf("Erase Group Start Address command failed\n");
>>   >       return ret;
>>   >     }
>>   >     ret = send_status(fd, &response);
>>   >     if (response & 0xFFF900C0) {
>>   >       printf("CMD13 returns: 0x%08x during CMD35\n", response);
>>   >     }
>>   >
>>   >     // Set end address
>>   >     memset(&idata, 0, sizeof(idata));
>>   >     idata.opcode = MMC_ERASE_GROUP_END;
>>   >     idata.arg = end;
>>   >     idata.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>   >     ret = ioctl(fd, MMC_IOC_CMD, &idata);
>>   >     if (ret) {
>>   >       perror("ioctl");
>>   >       printf("Erase Group End Address command failed\n");
>>   >       return ret;
>>   >     }
>>   >     ret = send_status(fd, &response);
>>   >     if (response & 0xFFF900C0)
>>   >       printf("CMD13 returns: 0x%08x during CMD36\n", response);
>>   >
>>   >     // Send Erase Command
>>   >     memset(&idata, 0, sizeof(idata));
>>   >     idata.opcode = MMC_ERASE;
>>   >     idata.arg = argin;
>>   >     idata.cmd_timeout_ms = 60000;
>>   >     idata.data_timeout_ns = 60000000;
>>   >     idata.flags = MMC_RSP_R1B | MMC_CMD_AC;
>>   >     ret = ioctl(fd, MMC_IOC_CMD, &idata);
>>   >     if (ret)  {
>>   >       perror("ioctl");
>>   >       printf("Erase command failed\n");
>>   >       return ret;
>>   >     }
>>   >
>>   >     // Send Status Command
>>   >     // 1098 7654 3210 9876 5432 1098 7654 3210
>>   >     // 3322 2222 2222 1111 1111 1100 0000 0000
>>   >     // 1111 1111 1111 1xx1 xxxx xxxx 11xx xxxx  Device Status Error bits
>>   >     // F    F    F    9    0    0    C    0     0xFFF900C0
>>   >     ret = send_status(fd, &response);
>>   >     if (response & 0xFFF900C0)
>>   >       printf("CMD13 returns: 0x%08x during CMD38\n", response);
>>   >     if (ret)
>>   >       printf("Send Status Command returned 0x%08X\n", response);
>>   >
>>   >     return ret;
>>   > }
>>   >
>> 1150a1216
>>   >
>> 1842a1909,1985
>>   >
>>   >
>>   >
>>   > int do_erase(int nargs, char **argv)
>>   > {
>>   >     int fd, ret;
>>   >     char *device;
>>   >     char **eptr=NULL;
>>   >     __u32  argin, start, end;
>>   >
>>   >
>>   >     if (nargs != 5) {
>>   >         fprintf(stderr, "Usage: mmc erase <arg> <start address> <end
>> address> </path/to/mmcblkX>\n");
>>   >         exit(1);
>>   >     }
>>   >
>>   >     if ((argv[1][0] == '0') && (argv[1][1] == 'x'))
>>   >       argin = strtol(argv[1], eptr, 16);
>>   >     else
>>   >       argin = strtol(argv[1], eptr, 10);
>>   >     if ((argv[2][0] == '0') && (argv[2][1] == 'x'))
>>   >       start = strtol(argv[2], eptr, 16);
>>   >     else
>>   >       start = strtol(argv[2], eptr, 10);
>>   >     if ((argv[3][0] == '0') && (argv[3][1] == 'x'))
>>   >       end   = strtol(argv[3], eptr, 16);
>>   >     else
>>   >       end   = strtol(argv[3], eptr, 10);
>>   >     device = argv[4];
>>   >
>>   >     fd = open(device, O_RDWR);
>>   >     if (fd < 0) {
>>   >         perror("open");
>>   >         exit(1);
>>   >     }
>>   >
>>   >     printf("Executing (0x%08X): ", argin);
>>   >     switch(argin)  {
>>   >     case 0x00000000:
>>   >       printf("Erase ");
>>   >       break;
>>   >     case 0x00000003:
>>   >       printf("Discard ");
>>   >       break;
>>   >     case 0x80000000:
>>   >       printf("Secure Erase ");
>>   >       break;
>>   >     case 0x80008000:
>>   >       printf("Secure Trim Step 2 ");
>>   >       break;
>>   >     case 0x80000001:
>>   >       printf("Secure Trim Step 1 ");
>>   >       break;
>>   >     case 0x00000001:
>>   >       printf("Trim ");
>>   >       break;
>>   >     default:
>>   >       printf("Unknown Argument ");
>>   >     }
>>   >     printf("From:0x%08X To:0x%08X\n", start, end);
>>   >
>>   >     ret = erase(fd, argin, start, end);
>>   >     if (ret) {
>>   >         fprintf(stderr, "Error in Erase Command to %s with Arg=0x%08X
>> Start=0x%08X End=0x%08X\n",
>>   >             device,
>>   >             argin,
>>   >             start,
>>   >             end);
>>   >         exit(1);
>>   >     }
>>   >
>>   >     return ret;
>>   >
>>   > }
>>   >
>>   >
>>   >
>>
>> mmc.c
>> 29c29
>> < #define MMC_VERSION    "0.1"
>> ---
>>   > #define MMC_VERSION    "0.1_KS"
>> 135a136,140
>>   >       NULL
>>   >     },
>>   >     { do_erase, -4,
>>   >       "erase", "<arg> " "<start address> " "<end address> " "<device>\n"
>>   >         "Send Erase command to the <device>.\nThis will delete all
>> user data in the specified region of the device.",
>>
>>

