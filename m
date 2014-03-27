From: James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] workqueue: WQ_NON_REENTRANT is meaningless and going
 away
Date: Thu, 27 Mar 2014 17:08:20 +0000
Message-ID: <53345B04.9080609@katalix.com>
References: <532BF8BC.5060007@huawei.com> <533381DB.2090900@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from katalix.com ([82.103.140.233]:50110 "EHLO bert.katalix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873AbaC0RSz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Mar 2014 13:18:55 -0400
In-Reply-To: <533381DB.2090900@huawei.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ZhangZhen <zhenzhang.zhang@huawei.com>, Tejun Heo <tj@kernel.org>
Cc: linux-mmc@vger.kernel.org, tgih.jun@samsung.com

On 27/03/14 01:41, ZhangZhen wrote:
> Tejun Heo has  made WQ_NON_REENTRANT useless in the commit:dbf2576e37 ("workqueue: make all
> workqueues non-reentrant"). So remove its usages.
> 
> This patch doesn't introduce any behavior changes.
> 
> Signed-off-by: zhangzhen <zhenzhang.zhang@huawei.com>

Acked-by: James Chapman <jchapman@katalix.com>


