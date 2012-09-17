From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: Fix PM_SLEEP related build warnings
Date: Mon, 17 Sep 2012 03:35:22 -0400
Message-ID: <m3pq5lyudh.fsf@pullcord.laptop.org>
References: <1344504741-12081-1-git-send-email-thierry.reding@avionic-design.de>
	<201208091200.11161.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45799 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab2IQHfL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 03:35:11 -0400
In-Reply-To: <201208091200.11161.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 9 Aug 2012 12:00:10 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 09 2012, Rafael J. Wysocki wrote:
> On Thursday, August 09, 2012, Thierry Reding wrote:
>> Power management callbacks defined by SIMPLE_DEV_PM_OPS are only used if
>> the PM_SLEEP Kconfig symbol has been defined. If not, the compiler will
>> complain about them being unused. However, since the callback for this
>> driver doesn't do anything it can just as well be dropped.
>> 
>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
