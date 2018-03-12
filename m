From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
Date: Mon, 12 Mar 2018 10:14:09 +0530
Message-ID: <1714e1a4-c591-34e6-125e-3eb2e074e698@mentor.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
 <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
 <67491d8c-7eb3-e8c5-7eb0-3006ff668a60@wdc.com>
 <CACRpkdaPk6=DNH_Wk6q-8_Sa8BCCHA28Jr5FO64Q0eeUCFCBXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaPk6=DNH_Wk6q-8_Sa8BCCHA28Jr5FO64Q0eeUCFCBXQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alex Lemberg <Alex.Lemberg@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On Saturday 10 March 2018 05:29 PM, Linus Walleij wrote:
>
> But this patch doesn't hide the partition from userspace does it?
>
> They will still appear in /dev/mmcblk0boot1 etc.
>
> Just not reported as "real" partitions in /proc/partitions.
>
> Or do I misunderstand it?
>
>

You are correct. This patch does not hide partition from userspace.
They will still appear in /dev/. But not reported as "real" partitions in /proc/partiotions.

Thanks,
Harish Jenny K N
