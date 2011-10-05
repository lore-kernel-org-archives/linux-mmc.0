From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 1/2] mmc: core: move ->request() call from atomic context
Date: Wed, 5 Oct 2011 15:56:57 +0200
Message-ID: <4E8C6229.6010302@stericsson.com>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com> <1317645214-12316-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:38093 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932889Ab1JEN5Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 09:57:24 -0400
In-Reply-To: <1317645214-12316-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

Adrian Hunter wrote:
> mmc_request_done() is sometimes called from interrupt
> or other atomic context.  Mostly all mmc_request_done()
> does is complete(), however it contains code to retry
> on error, which uses ->request().  As the error path
> is certainly not performance critical, this may be
> moved to the waiting function mmc_wait_for_req_done().
> 
> This allows ->request() to use runtime PM get_sync()
> and guarantee it is never in an atomic context.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Calling back into the host driver directly from mmc_request_done when 
doing error handling were just plain wrong.

This patch is really great, not just for pm_runtime issues!

Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>


