From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: Re: [PATCH] mmc: Added quirks for Ricoh 1180:e823 lower base clock
 frequency
Date: Mon, 11 Jul 2011 17:55:48 -0500 (CDT)
Message-ID: <alpine.DEB.2.02.1107111749370.14531@lazy>
References: <1310419715-13254-1-git-send-email-manoj.iyer@canonical.com> <1310419715-13254-2-git-send-email-manoj.iyer@canonical.com> <m2wrfofpro.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <m2wrfofpro.fsf@bob.laptop.org>
Sender: linux-pci-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Manoj Iyer <manoj.iyer@canonical.com>, Daniel Manrique <daniel.manrique@canonical.com>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, matsumur@nts.ricoh.co.jp, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

>> +
>> +		dev_notice(&dev->dev, "Controller base frequency changed to 50Mhz)\n");
>
> There's an erroneous ")" in this string; I'll replace it with a "." if
> this patch goes in via my tree.  Also, let's make it "MMC controller"
> instead of just "Controller".

Oops, I can fix that and resend, or would you rather make the change 
while (if) applying to your tree?

>
>> +	}
>> +
>>  }
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C832, ricoh_mmc_fixup_r5c832);
>>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C832, ricoh_mmc_fixup_r5c832);
>
> Have you checked to see how SD I/O performance differs after this change?
>
> (If this is significant, perhaps we want to try lowering the frequency
> only after a card starts returning errors, since some cards work fine
> at the higher frequency.)
>

This is something I thought about too, I can try and get some data on the 
cards (that already works) with the patch applied. Do you have any 
specific benchmarks in mind that you would like me to run? Or will timing 
read and write will work?

Thanks a ton!
--
====================
Manoj Iyer
Ubuntu/Canonical
Hardware Enablement
====================
