From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
Date: Tue, 6 Mar 2018 18:17:36 +0530
Message-ID: <034dc340-149f-dfdf-a2eb-5f15ce9fb412@mentor.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
 <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On Friday 02 March 2018 06:23 PM, Linus Walleij wrote:
> On Tue, Feb 27, 2018 at 12:33 PM, Harish Jenny K N
> <harish_kandiga@mentor.com> wrote:
>
>> From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>>
>> Since RPMB area is accessible via special ioctl only and boot areas
>> are unlikely to contain any partitions, exclude them all from listing
>> in /proc/partitions. This will hide them from various user-level
>> software (e.g. fdisk), thus avoiding unnecessary access attempts.
>>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> Makes sense to me, at least it makes the problem smaller not bigger.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>


Any other comments/inputs on this ?


Thanks,
Harish Jenny K N
