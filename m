From: Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: RE: [PATCH RFC V2 33/46] mmc: mmc_test: Disable Command Queue while
 mmc_test is used
Date: Fri, 10 Jun 2016 10:59:58 +0000
Message-ID: <e9d4f5ef1cd542c3bd9b0397baa26576@bgmail103.nvidia.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
 <1465473166-22532-34-git-send-email-adrian.hunter@intel.com>
 <575A9A1E.7010906@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16410 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932601AbcFJLAt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jun 2016 07:00:49 -0400
In-Reply-To: <575A9A1E.7010906@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Adrian Hunter
> Sent: Friday, June 10, 2016 4:15 PM
> To: Ulf Hansson
> Cc: linux-mmc; Alex Lemberg; Mateusz Nowak; Yuliy Izrailov; Jaehoon Chung;
> Dong Aisheng; Das Asutosh; Zhangfei Gao; Sujit Reddy Thumma; Dorfman
> Konstantin; David Griego; Sahitya Tummala; Harjani Ritesh
> Subject: [PATCH RFC V2 33/46] mmc: mmc_test: Disable Command Queue
> while mmc_test is used
> 
> Normal read and write commands may not be used while the command
> queue is enabled.

CQ may not be efficient when single rd/wr commands get issued with variable delays in between.
In such situations, CQ preparation for individual rd/wr cmds would be an unnecessary overhead. 
Hence even when CQ is supported, prefer CQ only when more than 1 data cmds are to be issued to device.

> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
