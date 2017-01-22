From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 04/14] GPIO: Add gpio-ingenic driver
Date: Mon, 23 Jan 2017 01:49:25 +0800
Message-ID: <201701230130.T42P6EcW%fengguang.wu@intel.com>
References: <20170122144947.16158-5-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7073 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbdAVRty (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 22 Jan 2017 12:49:54 -0500
Content-Disposition: inline
In-Reply-To: <20170122144947.16158-5-paul@crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>

Hi Paul,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.10-rc4 next-20170120]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Cercueil/Ingenic-JZ4740-JZ4780-pinctrl-driver/20170122-232326


coccinelle warnings: (new ones prefixed by >>)

>> drivers/gpio/gpio-ingenic.c:101:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
