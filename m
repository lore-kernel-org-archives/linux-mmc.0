From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 33/46] mmc: mmc_test: Disable Command Queue while
 mmc_test is used
Date: Fri, 10 Jun 2016 14:36:55 +0300
Message-ID: <575AA657.9030800@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
 <1465473166-22532-34-git-send-email-adrian.hunter@intel.com>
 <575A9A1E.7010906@intel.com>
 <e9d4f5ef1cd542c3bd9b0397baa26576@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17915 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbcFJLlA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Jun 2016 07:41:00 -0400
In-Reply-To: <e9d4f5ef1cd542c3bd9b0397baa26576@bgmail103.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venu Byravarasu <vbyravarasu@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

On 10/06/16 13:59, Venu Byravarasu wrote:
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>> Sent: Friday, June 10, 2016 4:15 PM
>> To: Ulf Hansson
>> Cc: linux-mmc; Alex Lemberg; Mateusz Nowak; Yuliy Izrailov; Jaehoon Chung;
>> Dong Aisheng; Das Asutosh; Zhangfei Gao; Sujit Reddy Thumma; Dorfman
>> Konstantin; David Griego; Sahitya Tummala; Harjani Ritesh
>> Subject: [PATCH RFC V2 33/46] mmc: mmc_test: Disable Command Queue
>> while mmc_test is used
>>
>> Normal read and write commands may not be used while the command
>> queue is enabled.
> 
> CQ may not be efficient when single rd/wr commands get issued with variable delays in between.
> In such situations, CQ preparation for individual rd/wr cmds would be an unnecessary overhead. 
> Hence even when CQ is supported, prefer CQ only when more than 1 data cmds are to be issued to device.

So you are suggesting toggling CQ on/off depending on whether there is more
than 1 data request?

Does that apply also to using hardware CQ i.e. a v5.1 host controller?

