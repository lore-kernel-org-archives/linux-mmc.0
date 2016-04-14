From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [next] Failing Odroid XU3 boot due to missing MMC device
Date: Thu, 14 Apr 2016 11:05:03 +0200
Message-ID: <570F5D3F.1060900@samsung.com>
References: <570F5380.7010103@samsung.com> <570F54B2.2070704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <570F54B2.2070704@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 04/14/2016 10:28 AM, Jaehoon Chung wrote:
> Hi,
> 
> On 04/14/2016 05:23 PM, Krzysztof Kozlowski wrote:
>> Hi,> 
>>
>> Anyone also observed recent failures of linux-next (20160413, 20160414)
>> on booting from SD card? On my Odroid XU3 exynos and multi_v7 configs
>> fail with:
>>
>> Apr 14 07:52:53 starting version 229
>> Apr 14 07:52:53 :: running hook [udev]
>> Apr 14 07:52:53 :: Triggering uevents...
>> Apr 14 07:52:54 Waiting 10 seconds for device /dev/mmcblk0p1 ...
>> Apr 14 07:53:05 ERROR: device '/dev/mmcblk0p1' not found. Skipping fsck.
>> Apr 14 07:53:05 ERROR: Unable to find root device '/dev/mmcblk0p1'.
>> Apr 14 07:53:05 You are being dropped to a recovery shell
>> Apr 14 07:53:05     Type 'exit' to try and continue booting
>> Apr 14 07:53:05 sh: can't access tty; job control turned off
>>
>> I didn't start bisecting yet... maybe this is known?
> 
> Refer to the below thread.
> 
> https://patchwork.kernel.org/patch/8769361/

Thanks! That explains it.

BR,
Krzysztof
