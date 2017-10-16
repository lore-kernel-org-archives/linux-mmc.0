From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 3/3] arm64: renesas: salvator: set driver type for eMMC
Date: Mon, 16 Oct 2017 09:46:02 +0200
Message-ID: <20171016074601.jrcvxxm6minuq7u3@verge.net.au>
References: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
 <20171015124615.31391-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49622 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbdJPHqU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Oct 2017 03:46:20 -0400
Content-Disposition: inline
In-Reply-To: <20171015124615.31391-4-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Sun, Oct 15, 2017 at 02:46:15PM +0200, Wolfram Sang wrote:
> These boards are known to have eMMC issues with the default driver type.
> Specify a working one.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Hi,

I have marked this as deferred pending acceptance of the bindings.
Please repost or otherwise ping me once that dependency has been accepted.
