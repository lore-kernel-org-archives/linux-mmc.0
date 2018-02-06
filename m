From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mmcif: remove some cruft
Date: Tue, 6 Feb 2018 10:46:35 +0100
Message-ID: <20180206094635.dzhst4rtd4sfqtjh@verge.net.au>
References: <20180205132822.14529-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56914 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFJqk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Feb 2018 04:46:40 -0500
Content-Disposition: inline
In-Reply-To: <20180205132822.14529-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Mon, Feb 05, 2018 at 02:28:22PM +0100, Wolfram Sang wrote:
> The TODO section from 2010 is obsolete. We have DMA and PM meanwhile and
> we always want to handle errors better, if possible. Also DRIVER_VERSION
> is not used anymore these days.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
