From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC] improve mmc init sequence
Date: Thu, 17 Mar 2016 11:41:12 +0800
Message-ID: <56EA2758.7090200@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:36376 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbcCQDla (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 23:41:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: shawn.lin@rock-chips.com

Hello Ulf,
	I notice we add MMC_CAP2_NO_SDIO to avoid sending sdio commands during 
initialization. So that means we can use it to improve mmc init
sequence if a specific board use one slot just for emmc or sd. But I 
realize that we can move a step further to add more cap2 like NO_SD/
NO_MMC in order to reduce the boot time. Does that make sense? If the
answer is *yes*, I am happy to push some patches for it since I have
been doing it on my local tree and testing for a long time.

-- 
Best Regards
Shawn Lin

