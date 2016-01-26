From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v4 05/13] mmc: sdhci-of-arasan: fix clk issue in
 sdhci_arasan_remove()
Date: Tue, 26 Jan 2016 10:30:56 -0800
Message-ID: <20160126183056.GH12716@xsjsorenbubuntu>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
 <1453803353-6266-6-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453803353-6266-6-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com, kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2016-01-26 at 06:15PM +0800, Jisheng Zhang wrote:
> sdhci_pltfm_unregister() could operate host's registers, it will caus=
e
> problems if the clk is already disabled and unprepared. Fix this issu=
e
> by moving the clk_disable_unprepare() call to the end of remove
> function.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>

	S=C3=B6ren
