From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/3] mmc: mediatek: Use data tune for CMD line tune
Date: Fri, 20 Jan 2017 12:49:05 +0800
Message-ID: <201701201248.7sHsjUTB%fengguang.wu@intel.com>
References: <1484821156-20565-4-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484821156-20565-4-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi yong,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.10-rc4 next-20170119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yong-Mao/mmc-mediatek-Use-data-tune-for-CMD-line-tune/20170120-103149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mmc/host/mtk-sd.c:1400:4-5: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
