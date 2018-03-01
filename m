From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: correct property names in debug
Date: Thu, 01 Mar 2018 11:57:37 +0100
Message-ID: <2057001.Y3n4QWSv6R@diego>
References: <20180301103625.7285-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180301103625.7285-1-john@metanate.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: John Keeping <john@metanate.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-rockchip@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Am Donnerstag, 1. M=E4rz 2018, 11:36:25 CET schrieb John Keeping:
> Following up the device tree fixed in commits e78c637127ee ("ARM: dts:
> rockchip: Fix DWMMC clocks") and ca9eee95a2de ("arm64: dts: rockchip:
> Fix DWMMC clocks", 2018-02-15), avoid confusion by using the correct
> property name in the debug output if clocks are not found.
> =

> Signed-off-by: John Keeping <john@metanate.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
