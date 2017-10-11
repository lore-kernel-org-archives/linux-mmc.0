From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 3/3] arm64: renesas: salvator: set driver type for eMMC
Date: Wed, 11 Oct 2017 16:50:23 +0200
Message-ID: <20171011145023.cy4ikcoem5tukavg@verge.net.au>
References: <20171004173920.15232-1-wsa+renesas@sang-engineering.com>
 <20171004173920.15232-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39085 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdJKOu0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Oct 2017 10:50:26 -0400
Content-Disposition: inline
In-Reply-To: <20171004173920.15232-4-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Marek Vasut <marek.vasut@gmail.com>

On Wed, Oct 04, 2017 at 07:39:20PM +0200, Wolfram Sang wrote:
> These boards are known to have eMMC issues with the default driver type.
> Specify a working one.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

