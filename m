From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device tree support
Date: Sat, 11 Feb 2012 16:37:31 -0500
Message-ID: <m2aa4pkq5g.fsf@bob.laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
	<003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35122 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415Ab2BKViG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 11 Feb 2012 16:38:06 -0500
In-Reply-To: <003401cce730$baf979a0$30ec6ce0$%kim@samsung.com> (Kukjin Kim's
	message of "Thu, 09 Feb 2012 22:42:56 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, patches@linaro.org

Hi,

On Thu, Feb 09 2012, Kukjin Kim wrote:
> Looks ok to me and I'd like to pick this series in samsung tree with Chris'
> ack.
>
> Chris, is it ok? If you need to merge this in your tree, please let me know.
> I will provide topic branch for it.
>
> If any problems, please let me know.

I don't have a very strong opinion, but I think it's probably better to
go via the mmc tree since the patch is so large and hence the chance of
conflict before merging is high.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
