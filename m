From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 0/3] brcmfmac: sdio: Deal better w/ transmission errors
 waking from sleep
Date: Sat, 18 May 2019 15:09:44 +0000
Message-ID: <SN6PR04MB49258D4FBE0B4D739E8BAF7EFC040@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190517225420.176893-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517225420.176893-1-dianders@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, Double Lo <double.lo@cypress.com>, "briannorris@chromium.org" <briannorris@chromium.org>, Madhan Mohan R <madhanmohan.r@cypress.com>, "mka@chromium.org" <mka@chromium.org>, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>, YueHaibing <yuehaibing@huawei.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Martin Hicks <mort@bork.org>, Ritesh Harjani <riteshh@codeaurora.org>, Michael Trimarchi <michael@amarulasolutions.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>Franky Lin <fra>
List-Id: linux-mmc@vger.kernel.org

>=20
> This series attempts to deal better with the expected transmission
> errors that we get when waking up the SDIO-based WiFi on
> rk3288-veyron-minnie, rk3288-veyron-speedy, and rk3288-veyron-mickey.
>=20
> Some details about those errors can be found in
> <https://crbug.com/960222>, but to summarize it here: if we try to
> send the wakeup command to the WiFi card at the same time it has
> decided to wake up itself then it will behave badly on the SDIO bus.
> This can cause timeouts or CRC errors.
Wake-up itself: as part of a WoWlan, or d0i3?
Looks like this calls for a wifi driver fix, and not WA in the mmc driver.

Thanks,
Avri
