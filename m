From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH mmc/next v3 4/4] mmc: renesas-sdhi: remove gen3 support
 from SYS-DMAC driver
Date: Fri, 30 Jun 2017 11:59:09 +0200
Message-ID: <20170630095909.GF26710@verge.net.au>
References: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
 <1498053630-7780-5-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498053630-7780-5-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 21, 2017 at 04:00:30PM +0200, Simon Horman wrote:
> Gen3 SoCs are now supported by the internal DMAC variant of the SDHI driver.
> Remove them from the SYS-DMAC variant where only PIO mode is supported
> for those SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Hi,

I have become aware of some potential issues in this patch.
Please hold while I get a better view of things.
