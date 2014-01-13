From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 0/6] mmc: sdhci-s3c: Fix base clock source management
Date: Mon, 13 Jan 2014 13:43:59 +0100
Message-ID: <52D3DF8F.4000109@samsung.com>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
 <1704043.sYrCOYas4N@phil> <52D37DE7.1000407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <52D37DE7.1000407@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon, Heiko,

On 13.01.2014 06:47, Jaehoon Chung wrote:
> Hi, All.
>
> On 01/13/2014 06:18 AM, Heiko St=C3=BCbner wrote:
>> Am Samstag, 11. Januar 2014, 22:39:00 schrieb Tomasz Figa:
>>> Tested on S3C6410-based Mini6410 board, with following performance
>>> figures:
>>>
>>> * Before this series (133 MHz HCLK always selected, leading to at m=
ost
>>>    33 MHz card clock):
>>>
>>> root@tiny6410:~# hdparm -t /dev/mmcblk0
>>>
>>> /dev/mmcblk0:
>>>   Timing buffered disk reads:  42 MB in  3.10 seconds =3D  13.54 MB=
/sec
>>
>> # hdparm -t /dev/mmcblk0
>>
>> /dev/mmcblk0:
>>   Timing buffered disk reads: 44 MB in  3.12 seconds =3D  14.11 MB/s=
ec
>
> /dev/mmcblk0:
>   Timing buffered disk reads:  38 MB in  3.14 seconds =3D  12.12 MB/s=
ec
>>
>>
>>> * After this series (48 MHz EPLL clock selected, leading to 48 MHz =
card
>>>    clock):
>>>
>>> root@tiny6410:~# hdparm -t /dev/mmcblk0
>>>
>>> /dev/mmcblk0:
>>>   Timing buffered disk reads:  56 MB in  3.04 seconds =3D  18.41 MB=
/sec
>>
>> # hdparm -t /dev/mmcblk0
>>
>> /dev/mmcblk0:
>>   Timing buffered disk reads: 48 MB in  3.01 seconds =3D  15.94 MB/s=
ec
>
>   /dev/mmcblk0:
>   Timing buffered disk reads:  56 MB in  3.05 seconds =3D  18.35 MB/s=
ec
>>
>>
>> So on a s3c2416:
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
> Tested with exynos4 board.
>
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by; Jaehoon Chung <jh80.chung@samsung.com>

Thank you both for testing and acking.

Best regards,
Tomasz
