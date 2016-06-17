From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 00/12] power: add generic power sequence framework
Date: Sat, 18 Jun 2016 01:29:05 +0200
Message-ID: <576487C1.5050807@maciej.szmigiero.name>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <peter.chen@nxp.com>
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, stephen.boyd@linaro.org, k.kozlowski@samsung.com, festevam@gmail.com, pawel.moll@arm.com, javier@osg.samsung.com, stern@rowland.harvard.edu, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Hi Peter,

On 17.06.2016 12:09, Peter Chen wrote:
> Hi all,
> 
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices. This power
> sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> framework to handle this requirement. The generic code is supplied
> some common helpers from host driver, and individual power sequence
> driver handles kinds of power sequence for devices.
> 
> Since the MMC has already done the similar things, and this power
> sequence handling can be generic, we use mmc power sequence code
> as base to create this framework.
> 
> This patch set is based on Krzysztof Kozlowski's RFC patch set (v4.7-rc1)
> [1], and making some changes which can let it be generic. After that,
> we create a generic power sequence driver for USB devices which handles
> below things, it includes all input signals for devices I can consider.
> 
> - Clock and its frequencies
> - GPIO for reset and the duration time
> - GPIO for enable
> - Regulator for power
> 
> This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> two hot-plug devices to simulate this use case. The udoo board changes
> were tested using my last power sequence patch set. [2]
> 
> @Maciej S. Szmigiero, Oscar, would you please test them on imx6qdl udoo
> boards?

Thanks for the patch set, just tested them on my UDOO Quad board and can
confirm that USB and on-board hub work fine.

Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Maciej
