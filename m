From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 00/11] mmc: Add Command Queue support
Date: Sun, 25 Jun 2017 22:52:32 +0300
Message-ID: <20554e0f-4c9e-07f3-9e6b-60974db685d2@intel.com>
References: <1497524799-18165-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5445 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbdFYT6m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 25 Jun 2017 15:58:42 -0400
In-Reply-To: <1497524799-18165-1-git-send-email-adrian.hunter@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 06/15/2017 02:06 PM, Adrian Hunter wrote:
> Hi
> 
> Here is V3 of the hardware command queue patches without the software
> command queue patches.
> 
> Is there any chance of this being queued for v4.13?

I really don't see any advantage to delaying these patches.  It just
increases the difficulty of the inevitable backport, something Haibo Chen is
now experiencing.  The new code in the core is pretty small and
self-contained, so it is easy to see that there is little impact to anything
outside cmdq.
