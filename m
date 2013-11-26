From: Hartley Sweeten <HartleyS@visionengravers.com>
Subject: RE: [PATCH] mmc: core: sd: implement proper support for sd3.0 au
 sizes
Date: Tue, 26 Nov 2013 16:26:11 +0000
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8817E073BB@P3PWEX4MB008.ex4.secureserver.net>
References: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from p3plex2out04.prod.phx3.secureserver.net ([184.168.131.18]:47140
	"EHLO p3plex2out04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757183Ab3KZQdr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 11:33:47 -0500
In-Reply-To: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Monday, November 25, 2013 6:16 PM, Wolfram Sang wrote:
> This reverts and updates commit 77776fd0a4cc541b9a528eacc1d31ca47eb1ae7a
> ("mmc: sd: fix the maximum au_size for SD3.0"). The au_size for SD3.0
> cannot be achieved by a simple bit shift, so this needs to be
> implemented differently. Also, don't print the warning in case of 0
> since 'not defined' is different from 'invalid'.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: H Hartley Sweeten <hartleys@visionengravers.com>
>
> ---
>
> Only tested with non SD3.0 cards (au = 0 and au = 9). Testers for 3.0 cards
> much appreciated.

This fixes the warning I have been seeing with cards having an au = 0.

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

