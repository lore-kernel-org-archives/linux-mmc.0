From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 1/1] mmc: start removing enable / disable API
Date: Thu, 08 Mar 2012 23:35:21 -0500
Message-ID: <m27gyuqtme.fsf@bob.laptop.org>
References: <1330499841-6879-1-git-send-email-adrian.hunter@intel.com>
	<1330499841-6879-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34539 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934Ab2CIEfe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 23:35:34 -0500
In-Reply-To: <1330499841-6879-2-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Wed, 29 Feb 2012 09:17:21 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Venkatraman S <svenkatr@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Adrian,

On Wed, Feb 29 2012, Adrian Hunter wrote:
> Most parts of the enable / disable API are no longer used and
> can be removed.
>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks very much, pushed to mmc-next for 3.4 (with Tested-by from
Venkatraman and Jaehoon).

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
