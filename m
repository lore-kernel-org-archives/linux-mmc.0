From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 11/13] ARM: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max"
Date: Wed, 09 Nov 2016 15:05:03 +0100
Message-ID: <9130443.30mF7DGnI2@phil>
References: <20161103062135.10697-1-jh80.chung@samsung.com> <20161103062135.10697-12-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20161103062135.10697-12-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Am Donnerstag, 3. November 2016, 15:21:33 CET schrieb Jaehoon Chung:
> In drivers/mmc/core/host.c, there is "max-frequency" property.
> It should be same behavior. So use the "max-frequency" instead of
> "clock-freq-min-max".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

looks good, my veyron-pinky and rk3036-kylin still seem to work and hopefully 
I haven't missed any spelling errors in the properties :-), so applied to my 
dts32 branch for 4.10


Thanks
Heiko
