Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B55C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Nov 2021 12:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhK3MKb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:10:31 -0500
Received: from smtp.220.in.ua ([89.184.67.205]:38308 "EHLO smtp.220.in.ua"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233232AbhK3MKa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 Nov 2021 07:10:30 -0500
Received: from [10.30.18.189] (unknown [149.255.131.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id 95DE51A20D0A;
        Tue, 30 Nov 2021 14:07:09 +0200 (EET)
Message-ID: <42135dd8-c326-7607-acc9-3d55e9b98dad@kaa.org.ua>
Date:   Tue, 30 Nov 2021 14:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4] mmc-utils: Use printf() to extract and print fw
 version
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Bean Huo <beanhuo@micron.com>, Chris Ball <chrisball@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20211116105109.3830-1-oleg@kaa.org.ua>
 <20211129154826.23595-1-oleg@kaa.org.ua>
 <DM6PR04MB657569E423F95B4151E56C80FC679@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <DM6PR04MB657569E423F95B4151E56C80FC679@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Avri!

30.11.21 09:42, Avri Altman пише:
> Hi,
>> This patch also fixes a compile error with a newer version of GCC:
>> error: '__builtin_strncpy' output may be truncated copying 8 bytes from a
>> string of length 511 [-Werror=stringop-truncation]
> You are reverting commit 0eea71e4f2 (mmc-utils: Fix for Firmware Version string printing).
> Please use git revert and add an explanation in your commit log.

I'm not reverting this commit.
It's similar but not.

>
> You might also would like to take a look at the correspondence concerning a different approach to the same issue here - https://lore.kernel.org/lkml/20211114204331.39555-2-huobean@gmail.com/

Thank you.
I didn't know that.

>
> Thanks,
> Avri
>
>> Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>
>> Reviewed-by: Bean Huo <beanhuo@micron.com>
>> ---
>>   mmc_cmds.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> PATCH v4
>> Update commit message.
>>
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 73bd32a..e07ec94 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -1392,7 +1392,6 @@ int do_read_extcsd(int nargs, char **argv)
>>          __u32 regl;
>>          int fd, ret;
>>          char *device;
>> -       char lbuf[10];
>>          const char *str;
>>
>>          if (nargs != 2) {
>> @@ -1834,9 +1833,7 @@ int do_read_extcsd(int nargs, char **argv)
>>          }
>>
>>          if (ext_csd_rev >= 7) {
>> -                memset(lbuf, 0, sizeof(lbuf));
>> -               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
>> -               printf("eMMC Firmware Version: %s\n", lbuf);
>> +               printf("eMMC Firmware Version: %.8s\n",
>> + (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
>>                  printf("eMMC Life Time Estimation A
>> [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
>>                          ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
>>                  printf("eMMC Life Time Estimation B
>> [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
>> --
>> 2.32.0
