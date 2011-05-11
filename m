From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-s3c: fixed compiler error for renamed register
Date: Wed, 11 May 2011 10:35:11 -0400
Message-ID: <m3hb912tls.fsf@pullcord.laptop.org>
References: <4DCA3B54.3000607@samsung.com>
	<m3liyd2vl1.fsf@pullcord.laptop.org>
	<6C03668EAF45B747AF947A1603D1B300EBE0327C@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57201 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706Ab1EKPpf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 11:45:35 -0400
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EBE0327C@SAUSEXMBP01.amd.com>
	(Arindam Nath's message of "Wed, 11 May 2011 08:53:04 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Wed, May 11 2011, Nath, Arindam wrote:
> I am okay with your suggestion. I just changed the name as per the
> SDHC3.0 spec.

Great, okay.  I've rebased "mmc: sd: add support for driver type
selection" to remove that HOST_CONTROL->HOST_CONTROL1 change, and
pushed it out to mmc-next now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
