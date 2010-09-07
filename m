From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/8] sdhci: Move real work out of an atomic context
Date: Tue, 7 Sep 2010 15:38:13 -0700
Message-ID: <20100907153813.936db0c6.akpm@linux-foundation.org>
References: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: Matt Fleming <matt@console-pimps.org>, Albert Herranz <albert_herranz@yahoo.es>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>, Pierre Ossman <pierre@ossman.eu>
List-Id: linux-mmc@vger.kernel.org

On Wed, 14 Jul 2010 17:07:28 +0400
Anton Vorontsov <avorontsov@mvista.com> wrote:

> Hi all,
> 
> Currently the sdhci driver does everything in the atomic context.
> And what is worse, PIO transfers are made from the IRQ handler.
> 
> This causes huge latencies (up to 120 ms). On some P2020 SOCs,
> DMA and card detection is broken, which means that kernel polls
> for the card via PIO transfers every second. Needless to say
> that this is quite bad.
> 
> So, this patch set reworks sdhci code to avoid atomic context,
> almost completely. We only do two device memory operations
> in the atomic context, and all the rest is threaded.
> 
> I noticed no throughput drop neither with PIO transfers nor
> with DMA (tested on MPC8569E CPU), while latencies should be
> greatly improved.
> 

This patchset isn't causing any problems yet, but may do so in the
future and will impact the validity of any testing.  It seems to be
kind of stuck.  Should I drop it all?
