From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Wed, 11 Dec 2013 21:12:52 +0100
Message-ID: <201312112112.52746.arnd@arndb.de>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org> <201312111549.14017.arnd@arndb.de> <52A8868A.3000105@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60461 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab3LKUND (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 15:13:03 -0500
In-Reply-To: <52A8868A.3000105@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org

On Wednesday 11 December 2013, zhangfei wrote:
> >
> > I have not seen "clk-table" and "clk-table-num" before. Are these standard
> > properties? What are the units that are used here, what does the index mean?
> >
> 
> "clk-table" and "clk-table-num" are private properties.
> Instead simply on/off, the ip need different ciu clock for each timing mode.

But aren't the times fixed for each mode? Why do you need to specify them in
the DT? I would expect that the clock rates for each mode are set in the
MMC and SD specifications. When you call clk_set_rate(), it should normally
be enough to ask for the clock you actually want and let the clk subsystem
figure out how to set up the parents and multipliers on the way.

> Take emmc as example,
> clk-table-num = <8>;
> clk-table =
> <13000000 50000000 0 0 13000000 50000000 0 100000000>;
> MMC_TIMING_LEGACY mode, 25M should be set with parent clock 180M,
> MMC_TIMING_MMC_HS mode, 50M is required with parent clock 360M
> 
> "clk-table" list all clocks to be set in all supported timing one by one.
> "clk-table-num" is the table number, since not find function getting 
> table number.
> For example, next version will support MMC_TIMING_MMC_HS200 mode, the 
> clk-table-num = <9> with 9 clocks in the "clk-table"

If you have a property with an array, you can use of_find_property()
to get to the 'struct property' and then read the 'length' member
of that struct, or you can use of_property_for_each_u32() to iterate
through each value.

While I still hope that you don't even need this array as per the reasoning
above, if you actually need it, you should specify exactly what each
value means, such as

1. CIU clock rate in HZ for 20MHz SPI mode operation 
2. CIU clock rate in HZ for 25MHz SD card operation
3. CIU clock rate in HZ for 26MHz MMC card operation
4. CIU clock rate in HZ for 50MHz SD card operation
...

	Arnd
