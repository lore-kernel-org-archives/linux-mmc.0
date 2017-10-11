From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/3] mmc: parse new binding for eMMC fixed driver type
Date: Wed, 11 Oct 2017 16:50:11 +0200
Message-ID: <20171011144955.qsi6tgnnqcum3pjn@verge.net.au>
References: <20171004173920.15232-1-wsa+renesas@sang-engineering.com>
 <20171004173920.15232-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39075 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdJKOuQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Oct 2017 10:50:16 -0400
Content-Disposition: inline
In-Reply-To: <20171004173920.15232-3-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Marek Vasut <marek.vasut@gmail.com>

On Wed, Oct 04, 2017 at 07:39:19PM +0200, Wolfram Sang wrote:
> Parse the new binding and store it in the host struct after doing some
> sanity checks. The code is designed to support fixed SD driver type if
> we ever need that.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
