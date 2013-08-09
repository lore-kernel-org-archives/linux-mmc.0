From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] tmio_mmc_dma: fix PIO fallback on SDHI
Date: Fri, 09 Aug 2013 22:32:12 +0400
Message-ID: <520535AC.6000200@cogentembedded.com>
References: <201308030233.29446.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201308030233.29446.sergei.shtylyov@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, cjb@laptop.org
Cc: linux-sh@vger.kernel.org, max.filippov@cogentembedded.com
List-Id: linux-mmc@vger.kernel.org

Hello.

On 08/03/2013 02:33 AM, Sergei Shtylyov wrote:

> I'm testing SH-Mobile SDHI driver in DMA mode with  a new DMA controller  using

    The driver for this controller is using drivers/dma/sh/shdma-base.c framework.

> 'bonnie++' and getting DMA error

    And I suspect some bug/race in shdma-base.c. The S/G request that fails 
seems to always consist of 32 segments (maximum for shdma-base.c) and it fails 
like this:

hpb-dma-engine hpb-dma-engine: No free link descriptor available

which is a message that shdma_add_desc() prints when shdma_get-desc() returns 
NULL. When I turn on all dev_dbg() calls (via #define DEBUG) in shdma-base.c. 
the error is *gone*...

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: stable@vger.kernel.org # 3.1+

WBR, Sergei

