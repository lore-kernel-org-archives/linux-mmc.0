From: Fabio Berton <fabio.berton-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>
Subject: Rockchip RV1108 mainline kernel support
Date: Thu, 19 Jul 2018 10:53:02 -0300
Message-ID: <CAAPZna3aGkUmDeAwM4J6LpeC9m1VA=CUQN_ChiwvTLkaE2zdrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi all!

We're adding support to a custom Rockchip RV1108 in mainline kernel.

Currently this custom board runs fine on the Rockchip 3.10 vendor kernel.

The main problems is that kernel 4.17 can't detect eMMC.

I would appreciate any help on how to make the mainline kernel to
detect eMMC on this board

Here the full log:
https://gist.github.com/fbertux/df5b55928dcb703a28b990b72aa2e6fc

and here the log from Rockchip kernel 3.10:
https://gist.github.com/fbertux/9a476ca6903c2029d3db4ea53076be17

This is dts file that we're using:

https://github.com/OSSystems/linux/blob/wip-rockchip/arch/arm/boot/dts/rv1108-minievb-v10.dts

Rockchip RV1108; http://rockchip.wikidot.com/rk1108
Kernel Fork: https://github.com/OSSystems/linux/tree/wip-rockchip
Rockchip kernel 3.10: https://github.com/rockchip-linux/kernel/tree/release-3.10

Thanks!

Fabio Berton
