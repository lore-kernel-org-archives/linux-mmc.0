From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH v3 0/2] Add support for Allwinner A64 mmc controller
Date: Mon,  1 Aug 2016 23:13:49 +0800
Message-ID: <20160801151351.51854-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Michal Suchanek <hramrach@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Allwinner A64 has a slightly modified version of the Allwinner MMC controller.

It do not have "output" or "sample" clock input, instead, it can calibrate the
delay internally.

This series of patch added the calibrate feature to the sunxi-mmc driver. It
is based on works by Andre Przywara <andre.przywara@arm.com>, and now it
depends on the patch set sent recently by Hans de Goede <hdegoede@redhat.com>,
which disabled "output" and "sample" clock on A10/13.
( http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/446187.html )

As the clock and device tree patch for Allwinner A64 is not yet merged, the
patch set contains no patch to enable it.
