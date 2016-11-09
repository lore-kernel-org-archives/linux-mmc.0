From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 12/13] ARM64: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max"
Date: Wed, 09 Nov 2016 15:37:17 +0100
Message-ID: <8752381.WGgomIQVST@phil>
References: <20161103062135.10697-1-jh80.chung@samsung.com> <20161103062135.10697-13-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20161103062135.10697-13-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Am Donnerstag, 3. November 2016, 15:21:34 CET schrieb Jaehoon Chung:
> In drivers/mmc/core/host.c, there is "max-freqeuncy" property.
> It should be same behavior, So Use the "max-frequency" instead of
> "clock-freq-min-max".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

applied to my dts64 branch for 4.10


Thanks
Heiko
