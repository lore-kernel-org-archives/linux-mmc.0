From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 0/6] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr
 not supported on sabresd issues
Date: Thu, 31 Oct 2013 15:04:45 +0800
Message-ID: <20131031070442.GD23549@S2101-09.ap.freescale.net>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <b29396@freescale.com>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wsa@the-dreams.de
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 30, 2013 at 10:09:47PM +0800, Dong Aisheng wrote:
> Dong Aisheng (6):
>   mmc: sdhci: clear auto cmd setting bits for no data cmds
>   mmc: sdhci-esdhc-imx: add SDHCI_TRANSFER_MODE read function
>   ARM: dts: sabresd: add usdhc4 support
>   mmc: sdhci-esdhc-imx: fix cpas over write issue
>   mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR for mx6
>   mmc: core: mmc DDR mode should not depend on UHS_DDR50

For the series:

Acked-by: Shawn Guo <shawn.guo@linaro.org>
