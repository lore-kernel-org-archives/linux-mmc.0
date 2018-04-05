From: Yixun Lan <yixun.lan@amlogic.com>
Subject: Re: [PATCH] ARM64: dts: meson-axg: enable the eMMC controller
Date: Thu, 5 Apr 2018 09:25:06 +0800
Message-ID: <05e90560-46a7-7e4f-c4cf-13d8d6e754b3@amlogic.com>
References: <20180403102651.60340-1-yixun.lan@amlogic.com>
 <201804040211.7wh3FnSx%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201804040211.7wh3FnSx%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: yixun.lan@amlogic.com, kbuild-all@01.org, Kevin Hilman <khilman@baylibre.com>, Nan Li <nan.li@amlogic.com>, Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Kevin

On 04/04/2018 02:26 AM, kbuild test robot wrote:
> Hi Nan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20180403]
> [cannot apply to robh/for-next v4.16 v4.16-rc7 v4.16-rc6 v4.16]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/ARM64-dts-meson-axg-enable-the-eMMC-controller/20180403-224314
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm64/boot/dts/amlogic/meson-axg-s400.dts:49.24-25 syntax error
>    FATAL ERROR: Unable to parse input tree
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

oops, need to add this header (I fail to do a last check when rebase to
the dt64 branch)

+#include <dt-bindings/gpio/meson-axg-gpio.h>

will send a patch v2

Yixun
