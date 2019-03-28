From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 12/24] dt-bindings: mediatek: infracfg: add support for
 MT8516
Date: Thu, 28 Mar 2019 14:10:36 -0500
Message-ID: <CAL_JsqLCCHd8bs6DZJw3qGRjvx17baQ2v_SiPpBhsjNFOJFCUQ@mail.gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-13-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190323211612.860-13-fparent@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, jjian.zhou@mediatek.com, Wenzhen Yu <wenzhen.yu@mediatek.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, stephane.leprovost@mediatek.com, Sean Wang <sean.wang@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yong Mao <yong.mao@mediatek.com>, linux-spi <linux-spi@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Chaotian Jing <chaotian.jing@mediatek.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-clk <linux-clk@vger.kernel.org>, Hsin-H
List-Id: linux-mmc@vger.kernel.org

On Sat, Mar 23, 2019 at 4:17 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add binding documentation of infracfg for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/arm/mediatek/mediatek,infracfg.txt          | 1 +
>  include/dt-bindings/clock/mt8516-clk.h                   | 9 +++++++++
>  2 files changed, 10 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
