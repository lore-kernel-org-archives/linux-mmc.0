From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
Date: Fri, 3 Jun 2011 18:15:49 +0200
Message-ID: <201106031815.50064.arnd@arndb.de>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: Philip Rakity <prakity@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Qiming Wu <wuqm@marvell.com>, Jun Nie <njun@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Raymond Wu <xywu@marvell.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Friday 03 June 2011, Zhangfei Gao wrote:
>         SDHCI driver for pxav2 SoCs, such as pxa910, the driver based on sdhci-pltfm to handle resource etc.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Jun Nie <njun@marvell.com>
> Signed-off-by: Qiming Wu <wuqm@marvell.com>
> ---
>  drivers/mmc/host/Kconfig       |   11 ++
>  drivers/mmc/host/Makefile      |    1 +
>  drivers/mmc/host/sdhci-pxav2.c |  261 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-pxav2.c
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
