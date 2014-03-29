From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] workqueue: WQ_NON_REENTRANT is meaningless and going away
Date: Sat, 29 Mar 2014 09:36:22 -0400
Message-ID: <20140329133622.GE5553@htj.dyndns.org>
References: <532BF8BC.5060007@huawei.com>
 <533381DB.2090900@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:42874 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaC2Ng1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 29 Mar 2014 09:36:27 -0400
Received: by mail-qc0-f171.google.com with SMTP id c9so7258108qcz.30
        for <linux-mmc@vger.kernel.org>; Sat, 29 Mar 2014 06:36:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <533381DB.2090900@huawei.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ZhangZhen <zhenzhang.zhang@huawei.com>
Cc: jchapman@katalix.com, linux-mmc@vger.kernel.org, tgih.jun@samsung.com

On Thu, Mar 27, 2014 at 09:41:47AM +0800, ZhangZhen wrote:
> Tejun Heo has  made WQ_NON_REENTRANT useless in the commit:dbf2576e37 ("workqueue: make all
> workqueues non-reentrant"). So remove its usages.
> 
> This patch doesn't introduce any behavior changes.
> 
> Signed-off-by: zhangzhen <zhenzhang.zhang@huawei.com>

Applied to wq/for-3.15.

Thanks.

-- 
tejun
