From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] avr32-linux: at32ap700x: set DMA slave properties for
 MCI dw_dmac
Date: Fri, 31 Aug 2012 16:44:35 -0700
Message-ID: <20120831164435.a1b72191.akpm@linux-foundation.org>
References: <503A8D97.4070403@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <503A8D97.4070403@yahoo.es>
Sender: linux-kernel-owner@vger.kernel.org
To: Hein Tibosch <hein_tibosch@yahoo.es>
Cc: egtvedt@samfundet.no, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "ludovic.desroches" <ludovic.desroches@atmel.com>, Havard Skinnemoen <havard@skinnemoen.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 27 Aug 2012 04:56:55 +0800
Hein Tibosch <hein_tibosch@yahoo.es> wrote:

> The MCI makes use of the dw_dmac driver when DMA is being used.
> Due to recent changes the driver was broken because:
> - the SMS field in the CTLL register received the wrong value 0
> - a patch in dw_dmac allowed for 64-bit transfers on the
> memory side, giving an illegal value of 3 in the SRC/DST_TR_WIDTH
> register.

Please try to avoid vague descriptions such as "recent changes" and "a
patch".  We like to see specifics: commit IDs and titles.

This way we can make more informed decisions about patch scheduling. 
We can ensure that the authors of the earlier commits get to review
these changes.  Maintainers of other trees can determine whether or not
their tree needs the particular fix.
