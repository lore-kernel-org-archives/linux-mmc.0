From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 1/1]sdhci-pxa: support tune_timming for various cards
Date: Wed, 10 Nov 2010 00:58:46 -0800
Message-ID: <E8C182D3-90EE-4A2B-BE63-905E85F9AF54@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:60853 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753196Ab0KJJCj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Nov 2010 04:02:39 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Eric Miao <eric.y.miao@gmail.com>


<snip>

> +#define SD_CLOCK_AND_BURST_SIZE_SETUP          0x10A

This offset is only for MMP2.  On other pxa processors use a  different offset.  sdhci-pxa.c needs changing to support other pxa soc chips.

The value only needs setting at initialization time or sdhci reset (RESET_ALL)


