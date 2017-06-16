From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 2/5] mmc: tmio: add complete to DMA ops
Date: Fri, 16 Jun 2017 12:03:15 +0200
Message-ID: <20170616100314.GD6032@verge.net.au>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
 <1496927368-18897-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUkhkDEqsDZUQ94dFnLU+dFcZ+ed=qHokH3sEWGFdkkuw@mail.gmail.com>
 <20170616060602.GA16534@verge.net.au>
 <CAMuHMdV58Gp+M3eDG3wmgcG6S7L=HBoeFY3gNPVAA1HBWATOcw@mail.gmail.com>
 <20170616070432.GC16534@verge.net.au>
 <CAMuHMdVpE+2QK2WbfyDCCUq1fzHqnuyAKsGgzj+ZonOwc96w3A@mail.gmail.com>
 <20170616071354.GE16534@verge.net.au>
 <CAMuHMdXP8HXxQWfFf=i3j98q529doO7dpfgLBqhZPHeyYzNo_w@mail.gmail.com>
 <20170616073330.GG22158@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616073330.GG22158@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 16, 2017 at 09:33:31AM +0200, Simon Horman wrote:
> On Fri, Jun 16, 2017 at 09:23:15AM +0200, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Fri, Jun 16, 2017 at 9:13 AM, Simon Horman <horms@verge.net.au> wrote:
> > > Sorry for letting this bug creep in to renesas-drivers.
> > > Do you want a patch against your tree? I will plan to post v2 of
> > > this patchset soon in any case.
> > 
> > You can post such a patch to please users of renesas-drivers, but I won't
> > apply it now. I assume the issue will be fixed when next renesas-drivers
> > release is created ;-)
> 
> That is my assumption too :)

Revised patches posted as "[PATCH mmc/next v2 0/4] mmc: renesas_sdhi: add
support for R-Car Gen3 SDHI DMAC"

Pushed to topic/sdhi-gen3-dma-2017-v2 in my renesas tree.
Do you need a fresh pull request?

> I'll see about providing a fix patch too.

Fix is:

From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] mmc: renesas-sdhi: implement complete to DMA op

Implement complete DMA op to resolve regression introduced by
the introduction of that DMA op.

This resolves a panic when initialising SDHI on non Gen3 platforms
which use DMA with SDHI.

This is planned to be squashed into
"mmc: tmio, renesas-sdhi: add complete to DMA ops" for
submission to upstream.

Fixes: f6bcd9f5e392 ("mmc: tmio: add complete to DMA ops")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 90f8d11c4868..2897ee0b444a 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -106,6 +106,11 @@ static void renesas_sdhi_sys_dmac_abort_dma(struct tmio_mmc_host *host)
 	renesas_sdhi_sys_dmac_enable_dma(host, true);
 }
 
+static void renesas_sdhi_sys_dmac_complete_dma(struct tmio_mmc_host *host)
+{
+	complete(&host->dma_dataend);
+}
+
 static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 {
 	struct tmio_mmc_host *host = arg;
@@ -427,6 +432,7 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
 	.request = renesas_sdhi_sys_dmac_request_dma,
 	.release = renesas_sdhi_sys_dmac_release_dma,
 	.abort = renesas_sdhi_sys_dmac_abort_dma,
+	.complete = renesas_sdhi_sys_dmac_complete_dma,
 };
 
 static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
-- 
2.1.4
