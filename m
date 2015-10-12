From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 1/7] mmc: core: move ocr-bit to voltage translation into separate function
Date: Mon, 12 Oct 2015 15:44:35 +0200
Message-ID: <1669315.MIcYHSjc3k@diego>
References: <201510122154.fUL0WlRf%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:52555 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbbJLNoq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Oct 2015 09:44:46 -0400
In-Reply-To: <201510122154.fUL0WlRf%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, ulf.hansson@linaro.org, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org

Hi,

Am Montag, 12. Oktober 2015, 21:26:04 schrieb kbuild test robot:
> [auto build test WARNING on rockchip/for-next -- if it's inappropriate base,
> please suggest rules for selecting the more suitable base]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Heiko-Stuebner/mmc-dw_mmc-rockchip
> -allow-tuning-using-the-clk-phase-api/20151012-205613 config:
> x86_64-randconfig-x011-10121751 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All warnings (new ones prefixed by >>):
> >> drivers/mmc/core/core.c:1277:12: warning: 'mmc_ocrbitnum_to_vdd' defined
> >> but not used [-Wunused-function]
>     static int mmc_ocrbitnum_to_vdd(int vdd_bit, int *min_uV, int *max_uV)
>                ^

I'm not 100% sure I understand that warning. Is it just because we're ignoring 
the return value in the current first user of the function? [Which is done, 
because we already tested for the vdd_bit != 0 just before invoking 
mmc_ocrbitnum_to_vdd .

The second user added in the following patch then checks the return value. So 
I guess this should stay as it is? I guess Ulf's call - maybe he wants it 
differently anyway ;-) .


Heiko
