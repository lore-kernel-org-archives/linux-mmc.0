From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/3 v2] mmc: tmio: implement a bounce buffer for
 unaligned DMA
Date: Fri, 24 Dec 2010 12:11:00 +0100
Message-ID: <20101224111100.GF27832@sortiz-mobl>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
 <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
 <Pine.LNX.4.64.1012221156580.14483@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1012221156580.14483@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 22, 2010 at 12:02:15PM +0100, Guennadi Liakhovetski wrote:
> For example, with SDIO WLAN cards, some transfers happen with buffers at odd
> addresses, whereas the SH-Mobile DMA engine requires even addresses for SDHI.
> This patch extends the tmio driver with a bounce buffer, that is used for
> single entry scatter-gather lists both for sending and receiving. If we ever
> encounter unaligned transfers with multi-element sg lists, this patch will have
> to be extended. For now it just falls back to PIO in this and other unsupported
> cases.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

for the MFD part.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
