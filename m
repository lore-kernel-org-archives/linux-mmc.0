Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34031E7E631
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 13:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjIZNGY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 09:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjIZNGY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 09:06:24 -0400
X-Greylist: delayed 80 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 06:06:14 PDT
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B94FB
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 06:06:14 -0700 (PDT)
Received: from [172.20.10.9] ([151.38.51.189])
        by Aruba Outgoing Smtp  with ESMTPSA
        id l7kBqhmHIDAHrl7kBqL9ka; Tue, 26 Sep 2023 15:04:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1695733491; bh=kQvyQ076sWogIp9PYYiGAn8pXLcgzTNPmC3tVFbVBhI=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=lKyN33qtSapMuXgWouZGUH7fli1QHcL5I2MBq7YEOUcy1GaRtTL5BwrItEhh/kDV4
         0Ws3MQBRZQzEbY5bhIYGiC1GxLbLA/6c61lxmqApEnurKweHhmzsHCZcfcn/ymAXvn
         h+/XXxGGDUBsDHl6Jmu7Ws2KOW4p7e0CoZbw6EQuprkM1AgqAsaFwx5y2uTivVsAvj
         cqUsl25rCky5iN//mMKhOfLgMuYe4N12i6dqvOjt4IcVu1f/Um75i6FD3I8TItQahN
         dWOFk884ITxNw0fAMCHyzWJGVhwsE5VV0Cs6f9HSnEhCBlveRgFkx9D8+ulaYRjoh+
         +C0mBM27x1FzQ==
Message-ID: <4774ab76-d34d-4103-8aa0-b98ab96188be@benettiengineering.com>
Date:   Tue, 26 Sep 2023 15:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc-utils: fix potential overflow
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20230926071524.3638706-1-giulio.benetti@benettiengineering.com>
 <DM6PR04MB65758D3887318C2F53D033CBFCC3A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <DM6PR04MB65758D3887318C2F53D033CBFCC3A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHhqYfJN+VAD/3vAifeDmaVdYYhBGCQc/OvDkLL700nXcnMUJ25rtrC8YnLKE/G9g1RJSoRWnZi3NWRlJcW5s+KOMitBN9v0zCzrI4+5U91ewxhjrbXE
 aCALKwqDhnV15uGf0egzmNCHxzprBRGBVevmDkft3NVaXx91x7JAMUI+37r5YveYFbZ8zYJYVlwbZ8FGtRdgAVfmG44gpCrGW6x9HBTB3CeydVpkwIcJADis
 EqO3pn6kyVJPdiMItdO/yg==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Avri,

On 26/09/23 11:54, Avri Altman wrote:
>> With fortify enabled gcc throws following error:
>>                   from mmc_cmds.c:20:
>> In function ‘read’,
>>      inlined from ‘do_rpmb_write_key’ at mmc_cmds.c:2233:8:
>> /home/giuliobenetti/br_reproduce/a53922c5db3e605a5e81e53c034f45017e
>> bb7db7/output/host/mipsel-buildroot-linux-
>> gnu/sysroot/usr/include/bits/unistd.h:38:10: error: ‘__read_alias’ writing
>> 228 or more bytes into a region of size 32 overflows the destination [-
>> Werror=stringop-overflow=]
>>     38 |   return __glibc_fortify (read, __nbytes, sizeof (char),
>>        |          ^~~~~~~~~~~~~~~
>> mmc_cmds.c: In function ‘do_rpmb_write_key’:
>> mmc_cmds.c:2087:19: note: destination object ‘key_mac’ of size 32
>>   2087 |         u_int8_t  key_mac[32];
>>        |                   ^~~~~~~
>> /home/giuliobenetti/br_reproduce/a53922c5db3e605a5e81e53c034f45017e
>> bb7db7/output/host/mipsel-buildroot-linux-
>> gnu/sysroot/usr/include/bits/unistd.h:26:16: note: in a call to function
>> ‘__read_alias’ declared with attribute ‘access (write_only, 2, 3)’
>>     26 | extern ssize_t __REDIRECT (__read_alias, (int __fd, void *__buf,
>>        |                ^~~~~~~~~~
>>
>> read() could potentially return more than nbyte so let's check for ret < nbyte.
> No it can't because that would mean buffer overflow.
> See https://pubs.opengroup.org/onlinepubs/9699919799/functions/read.html :
> " this number shall never be greater than nbyte."
> 
> So this seems like a bogus warning to me.

Yes, you're right, and after doing some test this error appear with 
_FORTIFY_SOURCE=3 but it doesn't with _FORTIFY_SOURCE=2 or 1.

So yes. I'm going to reword like:
```
Building with _FORTIFY_SOURCE=3 results in:
                  from mmc_cmds.c:20:
In function ‘read’,
     inlined from ‘do_rpmb_write_key’ at mmc_cmds.c:2233:8:
/home/giuliobenetti/br_reproduce/a53922c5db3e605a5e81e53c034f45017e
bb7db7/output/host/mipsel-buildroot-linux-
gnu/sysroot/usr/include/bits/unistd.h:38:10: error: ‘__read_alias’ writing
228 or more bytes into a region of size 32 overflows the destination [-
Werror=stringop-overflow=]
    38 |   return __glibc_fortify (read, __nbytes, sizeof (char),
       |          ^~~~~~~~~~~~~~~
mmc_cmds.c: In function ‘do_rpmb_write_key’:
mmc_cmds.c:2087:19: note: destination object ‘key_mac’ of size 32
  2087 |         u_int8_t  key_mac[32];
       |                   ^~~~~~~
/home/giuliobenetti/br_reproduce/a53922c5db3e605a5e81e53c034f45017e
bb7db7/output/host/mipsel-buildroot-linux-
gnu/sysroot/usr/include/bits/unistd.h:26:16: note: in a call to function
‘__read_alias’ declared with attribute ‘access (write_only, 2, 3)’
    26 | extern ssize_t __REDIRECT (__read_alias, (int __fd, void *__buf,
       |                ^~~~~~~~~~

To work around this let's check if the return of read() is lower than
the nbyte requested instead of not equal.
```

Does it look good for you?

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

> Thanks,
> Avri
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> ---
>>   mmc_cmds.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 10d063d..ae7b876 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2065,7 +2065,7 @@ int do_sanitize(int nargs, char **argv)
>>                          }                                                                               \
>>                          else if (r > 0)                                                 \
>>                                  ret += r;                                                       \
>> -               } while (r != 0 && (size_t)ret != nbyte);       \
>> +               } while (r != 0 && (size_t)ret < nbyte);        \
>>                                                                                                          \
>>                  ret;                                                                            \
>>          })
>> --
>> 2.34.1
> 

