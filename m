From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 4/4] sdhci: add regulator support
Date: Thu, 29 Jul 2010 10:21:29 -0700
Message-ID: <20100729172128.GB24781@opensource.wolfsonmicro.com>
References: <1280406875-31830-1-git-send-email-m.szyprowski@samsung.com>
 <1280406875-31830-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1280406875-31830-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 29, 2010 at 02:34:35PM +0200, Marek Szyprowski wrote:
> This patch adds support for regulator API to sdhci core driver. Regulators
> can be used to disable power in suspended state to reduce dissipated
> energy.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks good from a regulator point of view.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
