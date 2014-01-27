From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [Q] block / zynq: DMA bouncing
Date: Mon, 27 Jan 2014 15:24:57 +0000
Message-ID: <20140127152457.GA1073@trinity.fluff.org>
References: <Pine.LNX.4.64.1401271549280.23931@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1401271549280.23931@axis700.grange>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 27, 2014 at 04:13:56PM +0100, Guennadi Liakhovetski wrote:
> Hi all,
> 
> I'm working on an MMC driver with a DMA capability. All has been working 
> well, until at some point I've got a bus error, when the mmc driver had 
> been handed in a buffer at 0x3000 physical RAM address. The reason is, 
> that on Zynq arch bus masters cannot access RAM below 0x80000. Therefore 
> my question: how shall I configure this in software?
> 
> The way I found was to use ARM-specific struct dmabounce_device_info and 
> implement its .needs_bounce() method to return true for those addresses. 
> Is this the right way or is there a better / more straight-forward one?
> 
> To do the above I have to enable CONFIG_DMABOUNCE, which then selects 
> CONFIG_ZONE_DMA. Having done just that I suddenly discover, that 0x3000 
> buffers aren't used any more, so, I cannot actually verify my 
> implementation :) Looking at ZONE_DMA it looks like it is still covering 
> the whole RAM range (/proc/zoneinfo shows start_pfn=0 in zone DMA), so, I 
> don't see why 0x3000 should be excluded now.
> 
> So, is using the .needs_bounce() method the correct way to support DMA on 
> this arch or is there a better one?

I have a similar issue with Renesas R8A7790 where there is a bus bridge
that can only deal with transactions to one half of the available RAM.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
