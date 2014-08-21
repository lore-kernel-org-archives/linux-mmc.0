From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 1/1 v8]mmc: Support-FFU-for-eMMC-v5.0
Date: Thu, 21 Aug 2014 14:17:44 +0200
Message-ID: <CAPDyKFqumUdoxnGg8nU9FfqEUOGvBfFNBdfg4kW=V4WF5r_OSg@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE64B934609@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFr52GkJC-2A4b6dy7VYZZsVgCHnT-GdL_9ZkF=Hd4H=Jw@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333AE73534@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFoFq+XkjVqycEorUDU_aKACPQkHvEsdJjJkj+P=FET5cA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333AE8EC81@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:39923 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbaHUMRp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Aug 2014 08:17:45 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so8325765qaq.27
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2014 05:17:44 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333AE8EC81@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, Grant Grundler <grundler@chromium.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "Gwendal Grignou (gwendal@chromium.org)" <gwendal@chromium.org>

[snip]

>> >> By just browsing through the code for preparing and handling the mmc
>> >> data request in the above functions, I find quite some duplication of
>> >> code from the card/*.c files. Could we maybe share some code between
>> >> these layers to avoid duplications, and thus errors?
>> >
>> > Yes, we are aware of some duplications and tried to avoid it.
>> > Eventually, sharing code to avoid duplications will require changes in existing
>> card/*c files.
>> > We preferred not changing existing code as much as possible.
>>
>> Breaking out code and doing re-factoring in sometimes necessary. I certainly
>> think we should give it a try.
>>
>> My concern is not just duplication of code, but also duplication of errors as that
>> follows with it.
>
> Your concern is correct.
> Can we suggest taking this significant step separately from adding this patch of FFU support?
> eMMC 5.0 is already there and vendors would like to start using this feature in order to be able upgrading FW to their eMMC parts.

No, I will only accept good quality code - sorry. But, I have a
suggestion which might simplify this patch significantly. :-) Read
further down.

[snip]

>> >>
>> >> I would, as stated earlier, prefer one FFU operational code. Thus it
>> >> would be possible, before starting the FFU seuquence, to for example
>> >> do cache flushing, stopping BKOPS and suspend/flush the blk queue etc.
>> >> I think this would be more safe.
>> >
>> > Agree, it probably  would be more safe, but:
>> > - as mentioned before, we would like to split the process into two operational
>> codes due
>> >    to different host power implementations
>> > - We implemented FFU as non-blocking procedure, which allows host sending
>> regular R/W commands
>> >    between  downloading FW data process and FW install
>>
>> Is there really a valid use case for that?
>>
>
> As mentioned above, in case we can assure that all hosts will perform eMMC
> card init routine on suspend/resume, we can unify those operations.
>
>
>> The reason we are considering to have this in-kernel is to get robustness and to
>> make sure the procedure don't get interrupted, at least that is how I have
>> interpreted the previous discussions.
>>
>> Maybe you can elaborate on the reasons for in-kernel once more?
>
> - In case FW data cannot be transferred by one singe transaction
> - The host need to be claimed during the FFU process to avoid interruptions by other R/W IOs.
> - Device is set to FFU mode during FFU download operations, and no Normal IOs are allowed during this process.

Thanks for clarifying this. So, clearly we need some additional
support in-kernel to handle the synchronization mechanism.

First, let's consider below snippet pasted from the eMMC5.0 spec:
--------------

Once in FFU Mode the host may send the new firmware bundle to the
device using one or more write
commands.

The host could regain regular functionally of write and read commands
by setting MODE_CONFIG field
in the EXT_CSD back to Normal state. Switching out of FFU Mode may
abort the firmware download
operation. When switched back-in to FFU Mode, the host should check
the FFU Status to get indication
about the number of sectors which were downloaded successfully by reading the
NUMBER_OF_FW_SECTORS_CORRECTLY_PROGRAMMED in the extended CSD. In case the
number of sectors which were downloaded successfully is zero the host
should re-start downloading the
new firmware bundle from its first sector. In case the number of
sectors which were downloaded
successfully is positive the host should continue the download from
the next sector, which would resume
the firmware download operation.
-------------

My conclusion from that is (correct me if I am wrong, since it may be
vendor specific), that only minor modifications should be needed to
the mmc ioctl. We need to add special treatment for when "cmd.opcode
== MMC_FFU_DOWNLOAD_OP". In such scenario the following sequence needs
to be maintained.

1. Claim host etc.
2. Set FFU mode.
3. Write some sectors to the FFU area, but in the same way as any
other mmc ioctl WRITE is done.
4. Set normal mode.
5. Relase host etc.

That sequence then needs to be repeated to write the complete
firmware, depending on buffer size. Between each and every piece of
FFU data that is written, normal READ/WRITE operations can be served.
Right?

User space will thus also be responsible of verifying the FFU
download. It will also have to find out whether
SUPPORTED_MODE_OPERATION_CODES in EXTCSD supported - and take relevant
actions to complete the FFU upgrade process.

[snip]

>> >> Another concern I see, is if the card might change identity due to
>> >> the firmware upgrade. The card identity is validated each system
>> >> resume cycle and failed validation is an error we can't recover from.
>> >
>> > The current assumption is that device will change its identity during the FFU.
>> > But your concern is correct.
>> > In order to support this, the mmc_init_card() function call should be modified
>> and assume that the card is not "oldcard".
>>
>> This will be far more complex to support. It means we actually need to remove
>> the old card's struct device, it's corresponding blk device and the blk device
>> queue and for a NON_REMOVABLE host. Then trigger a new mmc_rescan to
>> detect and initialize the card again. I wondering what upper mounted rootfs file
>> systems thinks about that. :-)
>>
>> So, as for now, we should aim for the simple approach and thus don't do re-
>> initiation/power-cycle. Instead let's leave that to be done by a "manual" power
>> cycle of the platform.
>
> As mentioned above, we wanted to let host vendors to decide.
> If eMMC init is called during suspend/resume - no Power Cycle is required.

I think you missed my point here.

If the card identity changes and it's a NON_REMOVABLE host, we can't
easily just perform a suspend/resume cycle to complete the FFU
upgrade. The best and safest way is to power cycle the complete hw -
always.

Kind regards
Uffe
