From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6ull: change to use new compatible
 "fsl,imx6ull-usdhc" for usdhc
Date: Tue, 15 Jan 2019 22:56:04 +0800
Message-ID: <20190115145602.GB13895@dragon>
References: <20181228033323.32308-1-haibo.chen@nxp.com>
 <20181228033323.32308-3-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181228033323.32308-3-haibo.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: BOUGH CHEN <haibo.chen@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Dec 28, 2018 at 03:26:16AM +0000, BOUGH CHEN wrote:
> i.MX6ULL has errata ERR010450, there is I/O timing limitation,
> for SDR mode, SD card clock can't exceed 150MHz, for DDR mode,
> SD card clock can't exceed 45MHz. This patch change to use the
> new compatible "fsl,imx6ull-usdhc" to follow this limitation.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied, thanks.
