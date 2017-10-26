From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/3] mmc: core: activate pre-erased multiple write support
 for sd card
Date: Thu, 26 Oct 2017 09:19:25 +0800
Message-ID: <699af9d0-c69b-e02b-54c1-7b0dd3f5369c@rock-chips.com>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:39356 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdJZBT0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2017 21:19:26 -0400
In-Reply-To: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org

Hi, Ulf

On 2017/9/27 11:40, Shawn Lin wrote:
> Per SD specification version 4.10, section 4.3.4, it says "pre-erased
> (ACMD23) will make a following Multiple Block Write operation faster
> compared to the same operation without preceding ACMD23". ACMD23 is
> mandatory for all sd cards and the spec also says "Command STOP_TRAN
> (CMD12) shall be used to stop the transmission in Write Multiple Block
> whether or not the preerase (ACMD23) feature is used."

Ping... :)

