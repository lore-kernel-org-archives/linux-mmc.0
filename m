From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in /proc/partitions
Date: Sat, 10 Mar 2018 12:59:08 +0100
Message-ID: <CACRpkdaPk6=DNH_Wk6q-8_Sa8BCCHA28Jr5FO64Q0eeUCFCBXQ@mail.gmail.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
 <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com> <67491d8c-7eb3-e8c5-7eb0-3006ff668a60@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <67491d8c-7eb3-e8c5-7eb0-3006ff668a60@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@wdc.com>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 8, 2018 at 9:36 PM, Alex Lemberg <Alex.Lemberg@wdc.com> wrote:
> On 3/2/18 4:53 AM, Linus Walleij wrote:

>> What we need to do is make the "special partitions" part of the
>> main block device and stop spawning these special block
>> devices for each boot partions or general partitions. In addition,
>> each of these boot partitions or general partitions will get their
>> own block queue and state container which is not cheap in
>> runtime memory footprint terms.
>>
>> So what I want to do (unless someone beats me to it) it to come
>> up with some way making boot and general partitions part
>> of the main block device. Possibly the core kernel partitioning
>> code needs to be augmented. The tentative idea is to just
>> put the sectors representing these partitions after the main
>> block device and access them from there, with an offset.
>
> I don't think that hiding the Boot and RPMB will resolve the problem
> described above.

Me neither. I'm just trying to discuss the problem lurking behind
these partitions.

> Boot partition (same as RPMB) in eMMC device is a separate
> "physical" partition.
> It has its own logical address range and different from general
> partition characteristics.

Yep.

> From the protocol - the access to this partition it requires switch
> partition command.

Yeah I saw that as well... it's a bit funny.

> From the device side - it can be managed in totally different manner
> (SLC vs. MLC blocks, etc.)
> I think it completely makes sense to allow access to Boot partition from the
> user space. For example - to allow R/W the boot image.

But this patch doesn't hide the partition from userspace does it?

They will still appear in /dev/mmcblk0boot1 etc.

Just not reported as "real" partitions in /proc/partitions.

Or do I misunderstand it?

> AFAIK, in case of SCSI/UFS devices - Boot LUN's are represented as
> separate block
> device partitions (/dev/sdb, dev/sdc...).
> Shouldn't we have the same for eMMC?

I think we should, but we have the problem with the boot partitions
and general partitions that they do not work anything like SCSCI
LUNs.

On a SCSI device dd from the whole device will copy all data on
the device, the partition table and contents of all partitions.

For say /dev/mmcblk0 this is not true of the device contains
boot or general partitions, those other partitions will not be
copied.

Yours,
Linus Walleij
