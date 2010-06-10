From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] s5pc110: SDHCI-s3c can override host capabilities
Date: Thu, 10 Jun 2010 13:43:04 -0700
Message-ID: <20100610134304.c109811a.akpm@linux-foundation.org>
References: <20100605024053.GA23419@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36555 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759722Ab0FJUnw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2010 16:43:52 -0400
In-Reply-To: <20100605024053.GA23419@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org

On Sat, 05 Jun 2010 11:40:53 +0900
Kyungmin Park <kmpark@infradead.org> wrote:

> From: Kyungmin Park <kmpark@infradead.org>
> To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, ben-linux@fluff.org
> Subject: [PATCH] s5pc110: SDHCI-s3c can override host capabilities
> Date: Sat, 05 Jun 2010 11:40:53 +0900
> User-Agent: Mutt/1.5.14 (2007-02-12)
> 
> Each board can override the default sdhci host capabilities.
> Some board has broken features by hardwares and support 8-bit bandwidth.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

The way this patch was presented, it will go into git with an Author:
address of "kmpark@infradead.org", but a Signed-off-by: address of
"kyungmin.park@samsung.com".  Which is a little odd.

The way to prevent that is to put an explicit "From:" line at the top
of the changelog.  If that line is absent, people's tools will fall
back to the From: line in the mail headers, which is what happened
here.

Please let me know if you want me to make any changes to these three
patches.

