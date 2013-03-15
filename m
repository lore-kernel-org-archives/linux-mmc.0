From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] wait while adding MMC host to ensure root mounts
Date: Fri, 15 Mar 2013 11:51:22 +0900
Message-ID: <51428CAA.5000302@samsung.com>
References: <1363223183-3772-1-git-send-email-ynvich@gmail.com>
 <1363224194-7366-1-git-send-email-ynvich@gmail.com>
 <CAKYAXd_v5TsMJ+h3Zk4FRDB0jAfF04t4Z65D1kmB1ziOk65+Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKYAXd_v5TsMJ+h3Zk4FRDB0jAfF04t4Z65D1kmB1ziOk65+Vg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>, Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 03/14/2013 01:08 PM, Namjae Jeon wrote:
> 2013/3/14, Sergey Yanovich <ynvich@gmail.com>:
>> MMC hosts are added asynchronously. We need to wait until detect returns to
>> avoid failed root filesystem mounts.
>> ---8<---
>> VFS: Cannot open root device "mmcblk0p1" or unknown-block(0,0): error -6
>> Please append a correct "root=" boot option; here are the available
>> partitions:
>> mmc0: host does not support reading read-only switch. assuming
>> write-enable.
>> 1f00             256 mtdblock0  (driver?)
>> 1f01             256 mtdblock1  (driver?)
>> 1f02            2560 mtdblock2 mmc0: new SDHC card at address b368
>>  (driver?)
>> 1f03           29696 mtdblock3  (driver?)
>> 1f04           16384 mtdblock4 mmcblk0: mmc0:b368 USD   3.72 GiB
>>  (driver?)
>>  mmcblk0: p1
>> b300         3910656 mmcblk0  driver: mmcblk
>>   b301         3906560 mmcblk0p1 00000000-01
>> Kernel panic - not syncing: VFS: Unable to mount root fs on
>> unknown-block(0,0)
>> ---8<---
>>
>> Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
>> ---
> Hi.
> Have you ever tried to use rootwait or rootdelay on command line ?
> If no, You can use them.
I agreed the Namjae's suggestion..if you use the rootwait or rootdelay, it's waiting for mounting rootfs.

Best Regards,
Jaehoon Chung
> 
> Thanks.
> 
