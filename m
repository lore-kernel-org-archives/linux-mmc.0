From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: mmc: sunxi: Fix eMMC usage on H5 boards
Date: Sun,  3 Feb 2019 23:56:25 +0800
Message-ID: <20190203155628.16767-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBLU63TRAKGQEQOFYW7I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Blake <chrisrblake93-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi everyone,

Since the HS-DDR mode was enabled for the A64 eMMC controller, there
have been reports of eMMC failing to work on some H5 boards. It seems
that while the H5 and A64 share the same controller for eMMC, some H5
boards don't have trace lengths that work under HS-DDR with the default
delay chain settings. Unfortunately we don't support tuning them at the
moment, and these boards didn't seem to come with any settings either.
Instead HS-DDR just wasn't enabled.

The failure is typically a data CRC error on data reads, such as the
partition scanning when the device is first probed. While this in itself
would result in the device being unusable, there seems to be a timing
issue in the recovery of the MMC controller. After the CRC error, the
driver manually issues a stop command to the device, which also fails.
After this a following command would stall: the MMC subsystem waits for
the completion notice of the request, which never happens. The stall
also blocks udev, which kind of blocks the whole boot process. However
if I turn on debug messages to try to narrow down the issue, it recovers
just fine. Any help on this issue would be much appreciated.

I propose we turn off HS-DDR on the H5 (maybe even the H6, but I don't
have anything to test right now) by default, and enable it per-board
using the common mmc binding properties for speed modes.

Patch 1 disables HS-DDR for H5 eMMC.

Patch 2 adds a check blocking (force disabling) any modes the driver
doesn't support. In retrospect this should have been added a long time
ago.

Patch 3 enables HS-DDR for the Libre Computer ALL-H3-CC H5, which works
normally.

If possible please merge all of them as fixes.


Regards
ChenYu

Chen-Yu Tsai (3):
  mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
  mmc: sunxi: Filter out unsupported modes declared in the device tree
  arm64: dts: allwinner: h5: libretech-all-h3-cc: Mark eMMC HS-DDR 3.3V
    capable

 .../sun50i-h5-libretech-all-h3-cc.dts         |  4 +++
 drivers/mmc/host/sunxi-mmc.c                  | 27 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.20.1
