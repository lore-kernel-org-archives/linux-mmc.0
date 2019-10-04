From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] mmc: sdhci-iproc: fix spurious interrupts on Multiblock
 reads with bcm2711
Date: Fri, 4 Oct 2019 15:07:50 +0200
Message-ID: <aacf6c56-e156-41b4-40b9-e8228ab63fcd@i2se.com>
References: <20191004125226.27037-1-nsaenzjulienne@suse.de>
 <0b544f5bc31857fef2d13bd16275cf09ace58b89.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0b544f5bc31857fef2d13bd16275cf09ace58b89.camel@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <mbrugger@suse.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Am 04.10.19 um 14:59 schrieb Nicolas Saenz Julienne:
> On Fri, 2019-10-04 at 14:52 +0200, Nicolas Saenz Julienne wrote:
>> The Raspberry Pi 4 SDHCI hardware seems to automatically issue CMD12
>> after multiblock reads even when ACMD12 is disabled. This triggers
>> spurious interrupts after the data transfer is done with the following
>> message:
>>
>>   mmc1: Got data interrupt 0x00000002 even though no data operation was in
>> progress.
>>   mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>>   mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
>>   mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
>>   mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
>>   mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
>>   mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
>>   mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>>   mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
>>   mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
>>   mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>   mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
>>   mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00080008
>>   mmc1: sdhci: Resp[0]:   0x00000b00 | Resp[1]:  0x00edc87f
>>   mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
>>   mmc1: sdhci: Host ctl2: 0x00000001
>>   mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf3025208
>>   mmc1: sdhci: ============================================
>>
>> Enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable ACMD12 on multiblock
>> reads and suppress the spurious interrupts.
>>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> Tested-by: Matthias Brugger <mbrugger@suse.com>
> Forgot to add:
>
> Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
>
> I'll resend if needed.

Yes, please and you can add my:

Acked-by: Stefan Wahren <wahrenst@gmx.net>

>
> Regards,
> Nicolas
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
