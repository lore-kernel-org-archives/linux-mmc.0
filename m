From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Enable runtime PM management of host devices
Date: Fri, 27 Mar 2015 14:41:42 +0200
Message-ID: <55155006.5080305@intel.com>
References: <1427454915-12893-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10609 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbbC0Mnq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 08:43:46 -0400
In-Reply-To: <1427454915-12893-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, NeilBrown <neil@brown.name>

On 27/03/15 13:15, Ulf Hansson wrote:
> Currently those host drivers which have deployed runtime PM, deals with
> the runtime PM reference counting entirely by themselves.
> 
> Since host drivers don't know when the core will send the next request
> through some of the host_ops callbacks, they need to handle runtime PM
> get/put between each an every request.
> 
> In quite many cases this has some negative effects, since it leads to a
> high frequency of scheduled runtime PM suspend operations. That due to
> the runtime PM reference count will normally reach zero in-between
> every request.
> 
> We can decrease that frequency, by enabling the core to deal with
> runtime PM reference counting of the host device. Since the core often
> knows that it will send a seqeunce of requests, it makes sense for it
> to keep a runtime PM reference count during these periods.
> 
> More exactly, let's increase the runtime PM reference count by invoking
> pm_runtime_get_sync() from __mmc_claim_host(). Restore that action by
> invoking pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend()
> in mmc_release_host(). In this way a runtime PM reference count will be
> kept during the complete cycle of a claim -> release host.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

The downside is that it precludes the possibility of a host driver using
runtime pm for very aggressive pm. However there is anyway MMC_CLKGATE for
that, and otherwise all host drivers are either using autosuspend_delay or
staying active while the card has power. So:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

