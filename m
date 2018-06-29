From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/2] mmc: renesas_sdhi_internal_dmac: Fix missing
 unmap in error patch
Date: Fri, 29 Jun 2018 16:49:55 +0200
Message-ID: <20180629144953.lxzzkwdhfokvegyf@verge.net.au>
References: <1530266505-19953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1530266505-19953-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530266505-19953-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 29, 2018 at 07:01:44PM +0900, Yoshihiro Shimoda wrote:
> This patch fixes an issue that lacks the dma_unmap_sg() calling in
> the error patch of renesas_sdhi_internal_dmac_start_dma().
> 
> Fixes: 0cbc94daa554 ("mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs")
> Cc: <stable@vger.kernel.org> # v4.17+
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
