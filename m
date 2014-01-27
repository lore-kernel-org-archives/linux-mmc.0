From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [Q] block / zynq: DMA bouncing
Date: Mon, 27 Jan 2014 17:52:31 +0000
Message-ID: <20140127175231.GU15937@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1401271549280.23931@axis700.grange> <20140127170230.GQ15937@n2100.arm.linux.org.uk> <52E69B4E.5010604@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52E69B4E.5010604@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 27, 2014 at 06:45:50PM +0100, Michal Simek wrote:
> Why 0x4000? IRC Linux for ARM is using space for any purpose.
> Russell knows this much better than I.

Probably because as the kernel is loaded at 0x8000, it will place the
swapper page table at 0x4000, thus covering from 0x4000 upwards.

Thus, the majority of your un-DMA-able memory will be kernel text or
swapper page tables.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
