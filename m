From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/3] mmc: fixes for aggressive clock gating framework
Date: Fri, 19 Aug 2011 13:13:26 -0400
Message-ID: <m2zkj5miix.fsf@bob.laptop.org>
References: <cover.1313664897.git.mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52515 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743Ab1HSRNd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Aug 2011 13:13:33 -0400
In-Reply-To: <cover.1313664897.git.mika.westerberg@linux.intel.com> (Mika
	Westerberg's message of "Thu, 18 Aug 2011 15:23:46 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org

Hi Mika,

On Thu, Aug 18 2011, Mika Westerberg wrote:
> Hi,
>
> This is an updated series which should fix few races seen when aggressive
> clock gating is active. The first patch actually just renames the gating
> functions to make their use-cases a bit more clear.

Thanks very much!  Pushed to mmc-next for 3.1-rc.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
