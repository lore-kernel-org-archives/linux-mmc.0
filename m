From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Mon, 19 Oct 2009 16:52:26 +0200
Message-ID: <4ADC7D2A.5090507@googlemail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>	 <4AD81DC2.4080607@googlemail.com>	 <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com>	 <4AD8C959.1000004@googlemail.com>	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com> <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com> <4ADB4604.2090704@googlemail.com> <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: John Rigby <jcrigby@gmail.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Steve Sakoman <sakoman@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Woodruff, Richard wrote:
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>> Sent: Sunday, October 18, 2009 11:45 AM
> 
>>> It would be funny if the TRM was wrong and the CIRQ bit is really
>>> cleared by writing 1 to it.  I'll try that.
> 
> A while back I hunted down a few of the bits for this.  Maybe this will help some.
> 
> SYSCONFIG.ENAWAKEUP = 1 < allow ocp wrapper to generate an interrupt to prcm>
> MMCHS_HCTL.IWE = 1 < route wake up to module ocp wrapper>
> MMCHS_CON.CPTL = 1  < Don't disable input buffer on DAT1 after completion to allow seeing SDIO interrupt>
> MMCHS_HCTL.IWE
> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
> MMCHS_STAT<bit to write for clear of SDIO interrupt>
> CCCCR - IRQ_ENABLE (think host stack will do this)

Thanks!

Do you have any idea about MMCHS_HCTL.IBG?

<This bit is valid only in 4-bit mode of SDIO card to enable interrupt
detection in the interrupt cycle at block gap for a multiple block 
transfer.
For MMC cards and for SD card this bit should be set to 0.
0x0: Disable interrupt detection at the block gap in 4-bit mode
0x1: Enable interrupt detection at the block gap in 4-bit mode>

I saw it neither in the exiting code I looked at, nor in your 
description above. But it sounds to me that it should be set for 4-bit 
mode?

Best regards

Dirk
