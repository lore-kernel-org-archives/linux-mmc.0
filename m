Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E4C32771
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Sep 2022 12:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIRMg7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Sep 2022 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRMg6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Sep 2022 08:36:58 -0400
Received: from smtpcmd10101.aruba.it (smtpcmd10101.aruba.it [62.149.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4FC52126C
        for <linux-mmc@vger.kernel.org>; Sun, 18 Sep 2022 05:36:57 -0700 (PDT)
Received: from [192.168.50.173] ([146.241.46.240])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ZtXbo2paSeVWJZtXboUwEA; Sun, 18 Sep 2022 14:36:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1663504616; bh=xHswc+XBTq8EqxA3uhsSbgN0D1idpPbGmLHb94thkt4=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=eRjpAPPTpgxj9xrN4VBT+PJquEBlWFKv2DubW+pphVqa1FNeGUJHwRWw/hl2etdY+
         Bn9ywg80lw90y0Q1ViB1ISVJ95pwTFKUjNYEN8e/2xrUpbRySNeC3vTeBHWLAVrVGW
         +jGoO29EMaYCx6lS+BUhogJB/vkLbV8TdVrlxTpCpt4NhfdH0mbtUU9o2w4H9khu6D
         X+SA9ESDtkBCJyc0iCbax4j3lInG40EfHgg49s4I2ykTBD8ZaVAj6qUOT62c9C2FOA
         Olpj8fCX00LQLC3+U6P1uqVITF0OxSkvViIJf+pigNCsSi63ew+L5TNcGtTKYUBQ9g
         f+FqvZrKvqr5Q==
Message-ID: <1c3d71fe-eee8-afa1-8316-730c2767878f@benettiengineering.com>
Date:   Sun, 18 Sep 2022 14:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mmc_cmds.c: fix warning on uninitialized 'cnt'
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20220918121637.1101135-1-giulio.benetti@benettiengineering.com>
 <DM6PR04MB657537960D8614C467F6708CFC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <DM6PR04MB657537960D8614C467F6708CFC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOXvMbOh+eSnSf8sDpg1lXfv/JriH+CvIUjuyVlfO/bxlDh1uO1B3VS6TxFNfYI+PXeghDMlelXyJ8993N9yQ+jTnb7eWrKLsTF2xCKE0B+75lZt0j8H
 m+u63WpXK7kTTOTTFJOQp7U9egDMDJkDVbfvtB68/TWZXVGBRSEyZZqXfdGHRtCl5Z5tKEKgvRP6AzELnHZhsF2IItTR8sp4d+UIQ2vyc9kUfR/cB1kqNuma
 BOVQxUF8kwNClocfozunIQ==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/09/22 14:34, Avri Altman wrote:
>> Since -Werror is enabled by default build fails with:
>> ```
>> In function '__bswap_32',
>>      inlined from 'do_rpmb_write_block' at mmc_cmds.c:2293:27:
>> /home/autobuild/autobuild/instance-15/output-1/host/aarch64-buildroot-
>> linux-gnu/sysroot/usr/include/bits/byteswap.h:52:10: error: 'cnt' may be
>> used uninitialized [-Werror=maybe-uninitialized]
>>     52 |   return __builtin_bswap32 (__bsx);
>>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~
>> mmc_cmds.c: In function 'do_rpmb_write_block':
>> mmc_cmds.c:2270:22: note: 'cnt' was declared here
>>   2270 |         unsigned int cnt;
>>        |                      ^~~
>> cc1: all warnings being treated as errors ``` So let's fix the warning by
>> initializing cnt local variable.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Please prefix you subject with "mmc-utils:"

Ok, thank you. Going to send V2

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> Thanks,
> Avri
> 
>> ---
>>   mmc_cmds.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 12b7802..777d649 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2436,7 +2436,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>>          int ret, dev_fd, key_fd, data_fd;
>>          unsigned char key[32];
>>          uint16_t addr;
>> -       unsigned int cnt;
>> +       unsigned int cnt = 0;
>>          struct rpmb_frame frame_in = {
>>                  .req_resp    = htobe16(MMC_RPMB_WRITE),
>>                  .block_count = htobe16(1)
>> --
>> 2.34.1
> 

