From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Move files to core
Date: Thu, 8 Dec 2016 13:45:43 +0200
Message-ID: <e0cab491-2902-1931-a14b-75ed7ac3e8af@intel.com>
References: <1481195892-31779-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55311 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbcLHLur (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 06:50:47 -0500
In-Reply-To: <1481195892-31779-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

On 08/12/16 13:18, Ulf Hansson wrote:
> Once upon a time it made sense to keep the mmc block device driver and its
> related code, in a separate directory. Over time, more an more interfaces
> and structures have been exported by the core layer to outsiders. This to
> allow the mmc block device driver to do its job. In other words, the
> relationship between the block code and the core code has become closer.
> 
> Let's not continue this path, but instead let's join the two directories.
> Simply by moving the block files into the core directory, lots of clean ups
> can be made, but more importantly, this change should also enables us
> remove unnecessary exported interfaces.

Don't you still need to export things if they are separate modules?

