From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 0/5] mmc: renesas_sdhi: add support for R-Car Gen3
 SDHI DMAC
Date: Thu, 8 Jun 2017 15:11:17 +0200
Message-ID: <20170608131114.GA18969@verge.net.au>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 08, 2017 at 03:09:21PM +0200, Simon Horman wrote:
> Hi,
> 
> this series adds support for the internal DMAC used by r8a779[56] SoCs.
> This is achieved by adding a new variant of the SDHI driver for this
> DMA controller with compat strings for the r8a779[56] SoCs.
> Compat strings for these SoCs are also removed from the existing SYS DMAC
> variant of the SDHI driver.

Sorry, I managed to post duplicate patches in this series.
I will repost.
