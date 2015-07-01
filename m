From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is
 used
Date: Wed, 1 Jul 2015 10:02:14 +0000
Message-ID: <1435744933.4689.31.camel@synopsys.com>
References: <1435220707-7250-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37452 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751090AbbGAKCW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2015 06:02:22 -0400
In-Reply-To: <1435220707-7250-1-git-send-email-abrodkin@synopsys.com>
Content-Language: en-US
Content-ID: <E5B39F7C5A1CB74F9DD6C25C1EC72137@internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Jaehoon, Seungwon, Ulf,

On Thu, 2015-06-25 at 11:25 +-0300, Alexey Brodkin wrote:
+AD4- As per DW MobileStorage databook +ACI-each descriptor can transfer up to 
+AD4- 4kB
+AD4- of data in chained mode+ACI-, moreover buffer size that is put in +ACI-des1+ACI- 
+AD4- is
+AD4- limited to 13 bits, i.e. for example on attempt to
+AD4- IDMAC+AF8-SET+AF8-BUFFER1+AF8-SIZE(desc, 8192) size value that's effectively 
+AD4- written
+AD4- will be 0.
+AD4- 
+AD4- On the platform with 8kB PAGE+AF8-SIZE I see dw+AF8-mmc gets data blocks in
+AD4- SG-list of 8kB size and that leads to unpredictable behavior of the
+AD4- SD/MMC controller.
+AD4- 
+AD4- In particular on write to FAT partition of SD-card the controller 
+AD4- will
+AD4- stuck in the middle of DMA transaction.
+AD4- 
+AD4- Solution to the problem is simple - we need to pass large (+AD4- 4kB) 
+AD4- data
+AD4- buffers to the controller via multiple descriptors. And that's what
+AD4- that change does.
+AD4- 
+AD4- What's interesting I did try original driver on same platform but
+AD4- configured with 4kB PAGE+AF8-SIZE and may confirm that data blocks passed
+AD4- in SG-list to dw+AF8-mmc never exeed 4kB limit - that explains why nobody
+AD4- ever faced a problem I did.
+AD4- 
+AD4- Signed-off-by: Alexey Brodkin +ADw-abrodkin+AEA-synopsys.com+AD4-
+AD4- Cc: Seungwon Jeon +ADw-tgih.jun+AEA-samsung.com+AD4-
+AD4- Cc: Jaehoon Chung +ADw-jh80.chung+AEA-samsung.com+AD4-
+AD4- Cc: Ulf Hansson +ADw-ulf.hansson+AEA-linaro.org+AD4-
+AD4- Cc: arc-linux-dev+AEA-synopsys.com
+AD4- Cc: linux-kernel+AEA-vger.kernel.org
+AD4- ---
+AD4-  drivers/mmc/host/dw+AF8-mmc.c +AHw- 109 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-------
+AD4- ----------

I'm wondering if there're any comments on that patch or if it could be
applied?

It fixes a real problem on systems on 4K PAGE+AF8-SIZE so would be good to
have it in upstream. In particular this is the case with ARC AXS board
which made its way in upstream kernel recently.

Regards,
Alexey