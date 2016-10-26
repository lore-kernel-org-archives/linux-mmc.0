From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mmc: s3cmci: Use DMA slave map rather than exported DMA filter
Date: Wed, 26 Oct 2016 22:10:49 +0200
Message-ID: <3846769.7mYrNMO473@wuerfel>
References: <1477499453-22549-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1477499453-22549-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: ulf.hansson@linaro.org, linux-samsung-soc@vger.kernel.org, sam.van.den.berge@telenet.be, linux-mmc@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Wednesday, October 26, 2016 6:30:53 PM CEST Sylwester Nawrocki wrote:
> Support for DMA slave map has been added to the s3c24xx-dma
> controller in commit 34681d84a0f7cc22ded1413dc79eef8a2f23d9c3
> "dmaengine: s3c24xx: Add dma_slave_map for s3c2440 devices"
> This patch converts the s3cmci driver to also use it, so we can
> eventually get rid of the exported filter function once all
> related DMA clients are updated.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
