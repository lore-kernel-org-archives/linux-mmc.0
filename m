From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mxcmmc: use dmaengine API
Date: Wed, 12 Jan 2011 20:25:42 +0800
Message-ID: <20110112122541.GA6569@freescale.com>
References: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
	<1294826996-13764-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1294826996-13764-2-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

It seems all the tabs were turned into spaces.

On Wed, Jan 12, 2011 at 11:09:56AM +0100, Sascha Hauer wrote:
> This switches the mxcmmc driver to use the dmaengine API. Unlike
> the old one this one is always present in the tree, even if no DMA
> is implement, hence we can remove all the #ifdefs in from the driver.
> The driver automatically switches to PIO mode if no DMA support or no
> suitable channel is available.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mmc/host/mxcmmc.c |  172 +++++++++++++++++++++++++--------------------
>  1 files changed, 97 insertions(+), 75 deletions(-)
> 
[...]

-- 
Regards,
Shawn
