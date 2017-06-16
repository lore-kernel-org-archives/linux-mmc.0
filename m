From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 5/5] mmc: renesas-sdhi: remove gen3 support from sysc
 dmac driver
Date: Fri, 16 Jun 2017 09:01:52 +0200
Message-ID: <20170616070151.GB16534@verge.net.au>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
 <1496927368-18897-8-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUUXnpXgoO7O8XtQcusTcHPffkKESVbWO54Yo54179u6A@mail.gmail.com>
 <CANqRtoTF-xev1F9nC9a_0oLQSE5-M4SnozTyzrndDrbW8fhurw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANqRtoTF-xev1F9nC9a_0oLQSE5-M4SnozTyzrndDrbW8fhurw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 09, 2017 at 05:40:15PM +0900, Magnus Damm wrote:
> Hi Geert and Simon,
> 
> On Fri, Jun 9, 2017 at 4:40 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Simon,
> >
> > On Thu, Jun 8, 2017 at 3:09 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> >> Gen3 SoCs are now supported by the internal dmac variant of the SDHI driver.
> >> Remove them from the sys dmac variant where only PIO mode is supported.
> >>
> >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > Is it possible to fall back to PIO with the new DMAC driver?
> > If not, is this desirable?
> 
> I believe R-Car Gen3 SDHI may depending on SoC use either on-chip bus
> mastering DMA or SYS-DMAC via DMA Engine. In both cases fall back to
> PIO is most likely valid. For any given SoC which is better of on-chip
> DMA or SYS-DMAC needs to be investigated together with IPMMU.

My answer is a bit different:

With this patchset there are two variants of the SDHI driver, one that
supports SYS-DMAC via DMA Engine and one that supports on-chip bus
mastering DMA.

My understanding is that prior to this patch set the SYS-DMAC and only
variant of the SDHI driver supported fallback to PIO. And as the internal
DMAC variant uses the same core code my assumption is that it should also
have that property.  I would need to investigate things in more detail to
confirm that assumption.

In terms of supporting Gen3 with SYS-DMAC or on-chip bus mastering DMA,
I believe those cases should use compat strings and soc-match in each of
the two variants of the SDHI driver as appropriate.
