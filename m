From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] mmc: sdhci: fix dma memory leak in sdhci_pre_req()
Date: Fri, 7 Aug 2015 13:05:53 +0200
Message-ID: <55C49111.9080505@suse.cz>
References: <1438939790-28310-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438939790-28310-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>, ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, aisheng.dong@freescale.com, shawn.guo@linaro.org, stable@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 08/07/2015, 11:29 AM, Haibo Chen wrote:
> Currently one mrq->data maybe execute dma_map_sg() twice
> when mmc subsystem prepare over one new request, and the
> following log show up:
> 	sdhci[sdhci_pre_dma_transfer] invalid cookie: 24, next-cookie 25
> 
> In this condition, mrq->date map a dma-memory(1) in sdhci_pre_req
> for the first time, and map another dma-memory(2) in sdhci_prepare_data
> for the second time. But driver only unmap the dma-memory(2), and
> dma-memory(1) never unmapped, which cause the dma memory leak issue.
> 
> This patch use another method to map the dma memory for the mrq->data
> which can fix this dma memory leak issue.
> 
> Fixes: commit 348487cb28e66b0 ("mmc: sdhci: use pipeline mmc requests to improve performance")
> Cc: stable@vger.kernel.org # 4.0+
> Reported-by: Jiri Slaby <jslaby@suse.cz>

Reported-and-tested-by: Jiri Slaby <jslaby@suse.cz>

I also added the mentioned WARN_ON in place and it never triggerred. (As
I expected...)

Thanks!

-- 
js
suse labs
