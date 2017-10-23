From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Mon, 23 Oct 2017 15:13:07 +0300
Message-ID: <bec93e7f-e225-baff-0b5b-28a92aeed720@intel.com>
References: <20170905194739.GA31241@amd> <20171001093704.GA12626@amd>
 <20171001102647.GA23908@amd>
 <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
 <72c93a69-610f-027e-c028-379b97b6f388@intel.com> <20171002084131.GA24414@amd>
 <CACRpkdbatrt0Uxf8653iiV-OKkgcc0Ziog_L4oDVTJVNqtNN0Q@mail.gmail.com>
 <20171002130353.GA25433@amd> <184b3552-851c-7015-dd80-76f6eebc33cc@intel.com>
 <20171023093109.GI32228@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbdJWMUC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Oct 2017 08:20:02 -0400
In-Reply-To: <20171023093109.GI32228@amd>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Walleij <linus.walleij@linaro.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mm@kvack.org

On 23/10/17 12:31, Pavel Machek wrote:
> Hi!
> 
>>>> Did you use bounce buffers? Those were improving performance on
>>>> some laptops with TI or Ricoh host controllers and nothing else was
>>>> ever really using it (as can be seen from the commit).
>>>
>>> Thinkpad X220... how do I tell if I was using them? I believe so,
>>> because I uncovered bug in them before.
>>
>> You are certainly using bounce buffers.  What does lspci -knn show?
> 
> Here is the output:
> 									Pavel
> 
> 00:00.0 Host bridge [0600]: Intel Corporation 2nd Generation Core Processor Family DRAM Controller [8086:0104] (rev 09)
> 	Subsystem: Lenovo Device [17aa:21da]
> 00:02.0 VGA compatible controller [0300]: Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller [8086:0126] (rev 09)
> 	Subsystem: Lenovo Device [17aa:21da]
> 	Kernel driver in use: i915
> 00:16.0 Communication controller [0780]: Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1 [8086:1c3a] (rev 04)
> 	Subsystem: Lenovo Device [17aa:21da]
> 00:19.0 Ethernet controller [0200]: Intel Corporation 82579LM Gigabit Network Connection [8086:1502] (rev 04)
> 	Subsystem: Lenovo Device [17aa:21ce]
> 	Kernel driver in use: e1000e
> 00:1a.0 USB controller [0c03]: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2 [8086:1c2d] (rev 04)
> 	Subsystem: Lenovo Device [17aa:21da]
> 	Kernel driver in use: ehci-pci
> 00:1b.0 Audio device [0403]: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller [8086:1c20] (rev 04)
> 	Subsystem: Lenovo Device [17aa:21da]
> 	Kernel driver in use: snd_hda_intel
> 00:1c.0 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 1 [8086:1c10] (rev b4)
> 	Kernel driver in use: pcieport
> 00:1c.1 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 2 [8086:1c12] (rev b4)
> 	Kernel driver in use: pcieport
> 00:1c.3 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 4 [8086:1c16] (rev b4)
> 	Kernel driver in use: pcieport
> 00:1c.4 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 [8086:1c18] (rev b4)
> 	Kernel driver in use: pcieport
> 00:1d.0 USB controller [0c03]: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 [8086:1c26] (rev 04)
> 	Subsystem: Lenovo Device [17aa:21da]
> 	Kernel driver in use: ehci-pci
> 00:1f.0 ISA bridge [0601]: Intel Corporation QM67 Express Chipset Family LPC Controller [8086:1c4f] (rev 04)
> 	Subsystem: Lenovo Device [17aa:21da]
> 00:1f.2 SATA controller [0106]: Intel Corporation 6 Series/C200 Series Chipset Family 6 port SATA AHCI Controller [8086:1c03] (rev 04)
> 	Subsystem: Lenovo Device [17aa:21da]
> 	Kernel driver in use: ahci
> 00:1f.3 SMBus [0c05]: Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller [8086:1c22] (rev 04)
> 	Subsystem: Lenovo Device [17aa:21da]
> 03:00.0 Network controller [0280]: Intel Corporation Centrino Wireless-N 1000 [Condor Peak] [8086:0084]
> 	Subsystem: Intel Corporation Centrino Wireless-N 1000 BGN [8086:1315]
> 	Kernel driver in use: iwlwifi
> 0d:00.0 System peripheral [0880]: Ricoh Co Ltd PCIe SDXC/MMC Host Controller [1180:e823] (rev 07)
> 	Subsystem: Lenovo Device [17aa:21da]
> 	Kernel driver in use: sdhci-pci

Yes, the code for Ricoh in sdhci-pci specifies only SDMA which means no
scatter-gather.  That might benefit from bounce buffers, but it seems like
the memory allocation was silently failing anyway if a card was inserted
after memory has fragmented.
