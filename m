From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] tmio_mmc_dma: fix PIO fallback on SDHI
Date: Fri, 09 Aug 2013 22:41:31 +0400
Message-ID: <520537DB.2030909@cogentembedded.com>
References: <201308030233.29446.sergei.shtylyov@cogentembedded.com> <Pine.LNX.4.64.1308040026020.11632@axis700.grange> <51FE60DF.400@cogentembedded.com> <5200291F.2020607@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5200291F.2020607@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-sh@vger.kernel.org, max.filippov@cogentembedded.com
List-Id: linux-mmc@vger.kernel.org

Hello.

On 08/06/2013 02:37 AM, Sergei Shtylyov wrote:

>>>> I'm testing SH-Mobile SDHI driver in DMA mode with  a new DMA controller
>>>> using
>>>> 'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code falls
>>>> back
>>>> to PIO but all commands time out after that.  It turned out that the fallback
>>>> code calls tmio_mmc_enable_dma() with RX/TX channels already freed and
>>>> pointers
>>>> to them cleared, so that the function bails out early instead  of clearing
>>>> the
>>>> DMA bit in the CTL_DMA_ENABLE register. The regression was introduced by
>>>> commit
>>>> 162f43e31c5a376ec16336e5d0ac973373d54c89 (mmc: tmio: fix a deadlock).
>>>> Moving tmio_mmc_enable_dma() calls to the top of the PIO fallback code in
>>>> tmio_mmc_start_dma_{rx|tx}() helps.

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>> Cc: stable@vger.kernel.org # 3.1+

>>> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

>>> Not sure though how far back in stable this really has to go. We don't
>>> have any real-life problem reports with older kernels, do we?

>>     If we did, that error would have been fixed earlier, wouldn't it?

>>> I think
>>> approach to which patches should get into stable changed recently.

>>     Haven't heard about that (or seen any change in the policy). The issue
>> with this bug is its catastrophic consequencies: you can hardly ^C or ^Z out
>> of 'bonnie++' when it happens (in fact, you cannot ^C at all). IIRC you can't
>> even kill it from another shell.

>     Yeah, and the filesystem is seriously corrupt after this (I've tested only
> on VFAT so far).

    Tried running 'bonnie++' on SD card with ext3 couple of times -- no 
problems there. On VFAT the DMA bug reproduced each time I tried to run the 
test (at least without the fix).

>>> Thanks
>>> Guennadi

WBR, Sergei

