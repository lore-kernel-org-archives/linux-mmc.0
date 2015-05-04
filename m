From: Laurent Pinchart <laurent.pinchart@linaro.org>
Subject: Re: [PATCH 3/3 v3] mmc: sh_mmcif: calculate best clock with parent clock
Date: Mon, 04 May 2015 04:04:13 +0300
Message-ID: <2477373.H5ReWsYloq@avalon>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com> <1433253.xXE7ok9ACb@avalon> <87mw21m0ur.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87mw21m0ur.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

Sorry for the late reply.

On Wednesday 22 April 2015 01:05:59 Kuninori Morimoto wrote:
> Hi Laurent
> 
> >>> +struct sh_mmcif_parent_clk {
> > 
> > I'm not sure I would call this parent clock. It refers to the frequency of
> > the functional clock provided to the MMCIF, there's no concept of parent
> > there. True, the clock referenced by the MMCIF DT node is an MSTP gate
> > clock, and frequency control is implemented in the MSTP clock parent, but
> > that hardware architecture is internal to the CPG and shouldn't be
> > considered by the MMCIF.
>
> I couldn't understand about last 2 lines.
> Do you mean I need to add these method in CPG ?
> But, this calculates best clock of parent clock (= from CPG) and divider (=
> on MMC) Why CPG need to care about MMC's divider,
> and how to set it from CPG ??

No, that's not what I meant. The CPG should certainly not care about any MMCIF 
internal divider.

My point was about the name of the structure. However, now that you mention 
the internal MMCIF clock divider, the word "parent" indeed makes sense. Please 
ignore my comment.

> >> Shouldn't this come from private data in the CPG clock driver, which
> >> supplies the parent clock? Then the mmcif driver will be independent
> >> from the parent clock.
> > 
> > The real question is where the constraint comes from. The Gen2 datasheet
> > documents the MMC clocks maximum frequency as 97.5 MHz in the CPG section.
> > However, I have a feeling the constraint doesn't come from the DIV6 which
> > should be able to output higher frequencies, but from the MMCIF, the clock
> > distribution tree, or both.
> > 
> > There's also the option of specifying the admissible clock range in DT,
> > either in the CPG node or the MMCIF node.
> 
> It needs not only max/min range, but also divider's limit.
> I don't know how to do it. but...
> 
>  1) add admissible max/min range on CPG node
>     add admissible divider range on MMC node
>      -> Does this max/min range really from CPG ?
>         but, we can reuse this on other DIV6
> 
>  2) add admissible max/min range on MMC node
>     add admissible divider range on MMC node
>      -> reasonable, but we can't reuse it on other DIV6
>         what is difference between 2) and 3) ?
> 
>  3) add admissible max/min range on MMC driver
>     add admissible divider range on MMC driver
>      -> This is the reason why we have SoC specific compatible name ?
>         These limit came from SoC.
> 
> In my opinion, I can accept 1) or 3).

Once again it really depends where the constraints come from. If the MMC input 
clock frequency range constraint is dictated by the MMCIF IP core only, 
options 2 and 3 are equivalent and just differ by whether they specify the 
range explicitly in DT (option 2) or implicitly through the compatible name 
(option 3).

If the range constraint comes from the CPG, option 1 is the way to go, 
(although the admissible divider range could also be speficied in the MMC 
driver as in option 3).

If the range constraint is a property of the integration of the MMCIF in the 
SoC then I think option 2 is the best. The per-SoC compatible strings can be 
used to express differences between IP core versions found in different SoCs, 
but they shouldn't be used to express integration properties.

To clarify this with an example, it's fine for the DU driver to use the per-
SoC compatible string to know how many display channels the DU contains, but 
it can't be used to hardcode IRQ numbers in the driver, even if we know which 
IRQ the DU is hooked to for each SoC. The former is a property of the DU 
version, the latter is a property of the integration and should be expressed 
in DT.

-- 
Regards,

Laurent Pinchart
