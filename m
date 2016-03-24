From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] mmc: Provide tracepoints for request processing
Date: Thu, 24 Mar 2016 08:08:53 -0600
Message-ID: <56F3F4F5.8050200@fb.com>
References: <05d6338bddae751c1755e7825d4179658e78cc71.1458819912.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47621 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751927AbcCXOK0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 10:10:26 -0400
In-Reply-To: <05d6338bddae751c1755e7825d4179658e78cc71.1458819912.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, rostedt@goodmis.org, mingo@redhat.com
Cc: adrian.hunter@intel.com, yangbo.lu@freescale.com, akpm@linux-foundation.org, JBottomley@Odin.com, lporzio@micron.com, jonathanh@nvidia.com, grundler@chromium.org, fabf@skynet.be, yunpeng.gao@intel.com, dan.j.williams@intel.com, rabin.vincent@axis.com, chuanxiao.dong@intel.com, shawn.lin@rock-chips.com, heiko@sntech.de, dianders@chromium.org, david@protonic.nl, broonie@kernel.org, linus.walleij@linaro.org, takahiro.akashi@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 03/24/2016 05:54 AM, Baolin Wang wrote:
> This patch provides some tracepoints for the lifecycle of a request from
> fetching to completion to help with performance analysis of MMC subsystem.

Most of these already exist as block layer trace points, why do we need 
mmc specific ones?


-- 
Jens Axboe

