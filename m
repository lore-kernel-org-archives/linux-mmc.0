From: Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi: fix swiotlb buffer is full
Date: Fri, 3 Nov 2017 09:23:22 -0400
Message-ID: <20171103132322.GA19352@x230.dumpdata.com>
References: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1508225421-25405-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXyY-gvQGn2UxhUDsdhdWUMmTA80z73PF14otvcKuTMaw@mail.gmail.com>
 <20171019002412.GA14493@localhost.localdomain>
 <CAMuHMdUs+dLq8LJTJoUQEUzJAKXCfD0JBtVnHPyN6XdppVy5qQ@mail.gmail.com>
 <TY1PR06MB09928E11C2AFFD55EF68961CD8420@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <TY1PR06MB09929A4BF1E2A5DBD54845DED8430@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <20171101132639.GA24821@x230.dumpdata.com>
 <TY1PR06MB0992CBE1B122C62BD5E1C227D85C0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR06MB0992CBE1B122C62BD5E1C227D85C0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Konrad Rzeszutek Wilk <konrad@darnok.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

..snip..
> > >
> > > Anyway, I made v2 patches by using swiotlb related definitions. Would you check it?
> > 
> > Did I miss that email? As in was I cc-ed?
> 
> This was my fault. When I submitted v2 patches, I didn't include your email and iommu mailing list...

No problem.
> 
> > > https://patchwork.kernel.org/patch/10018879/
> > 
> > Why not use IO_TLB_SEGSIZE << IO_TLB_SHIFT or alternatively
> > swiotlb_max_segment?  See 5584f1b1d73e9
> 
> I already made such a patch as v2 and it was merged into mmc.git / fixes branch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=fixes&id=e90e8da72ad694a16a4ffa6e5adae3610208f73b

What happens if the user has swiotlb=4096 on the command line (meaning
less than the default value)? Your max value will be incorrect. Could you use
swiotlb_max_segment?
