From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 15/27] mmc: mxs-mmc: Move away from using deprecated APIs
Date: Fri, 27 Sep 2013 09:30:05 +0800
Message-ID: <20130927013003.GC25146@S2101-09.ap.freescale.net>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
 <1380207292-16968-16-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1380207292-16968-16-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 26, 2013 at 04:54:40PM +0200, Ulf Hansson wrote:
> Suspend and resume of cards are being handled from the protocol layer
> and consequently the mmc_suspend|resume_host APIs are deprecated.
> 
> This means we can simplify the suspend|resume callbacks by removing the
> use of the deprecated APIs.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
