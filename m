From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V1] mmc: core: fix still flush cache when eMMC cache off
Date: Mon, 20 Mar 2017 12:35 +0100
Message-ID: <2636452.c51ovjH1JX@amdc3058>
References: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
 <CGME20170320113503epcas1p1115fcb2a974a38a4133230b5b9013fbb@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "axboe@fb.com" <axboe@fb.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zoltan Szubbocsev (zszubbocsev)" <zszubbocsev@micron.com>
List-Id: linux-mmc@vger.kernel.org

On Sunday, March 19, 2017 12:45:40 AM Bean Huo wrote:
> This patch fixes the issue that mmc_blk_issue_rq still
> flushes cache when eMMC cache has already been off
> through user space tool, such as mmc-utils.
> The reason is that card->ext_csd.cache_ctrl isn't reset.
> 
> Signed-off-by: beanhuo <beanhuo@micron.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
