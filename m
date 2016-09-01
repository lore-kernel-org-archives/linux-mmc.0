From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v5 07/11] arm64: dts: r8a7795: remove unnecessary
 cap-mmc-highspeed property
Date: Thu, 1 Sep 2016 16:32:16 +0200
Message-ID: <20160901143216.GK14300@verge.net.au>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
 <1472591399-13907-8-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52885 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754597AbcIAOce (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 10:32:34 -0400
Content-Disposition: inline
In-Reply-To: <1472591399-13907-8-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Tue, Aug 30, 2016 at 11:09:55PM +0200, Simon Horman wrote:
> Remove cap-mmc-highspeed property from SDHI2 and SDHI3.
> 
> This property is unnecessary as the driver automatically sets
> the highspeed capability. Furthermore its use is inconsistent with SDHI0
> and SDHI1 which are also highspeed capable but do not have this property
> present.
> 
> Found by inspection.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.
