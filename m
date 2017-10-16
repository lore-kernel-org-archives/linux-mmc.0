From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 2/3] mmc: parse new binding for eMMC fixed driver type
Date: Mon, 16 Oct 2017 09:45:05 +0200
Message-ID: <20171016074504.w6xv3jfse34jc7k4@verge.net.au>
References: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
 <20171015124615.31391-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49597 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdJPHpX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Oct 2017 03:45:23 -0400
Content-Disposition: inline
In-Reply-To: <20171015124615.31391-3-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Sun, Oct 15, 2017 at 02:46:14PM +0200, Wolfram Sang wrote:
> Parse the new binding and store it in the host struct after doing some
> sanity checks. The code is designed to support fixed SD driver type if
> we ever need that.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

