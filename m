From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume
Date: Wed, 19 Sep 2012 04:05:10 -0400
Message-ID: <m3pq5ih1zd.fsf@pullcord.laptop.org>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org>
	<1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
	<m3fw6eilnk.fsf@pullcord.laptop.org> <505977BF.1010305@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33534 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab2ISIEy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 04:04:54 -0400
In-Reply-To: <505977BF.1010305@samsung.com> (Jaehoon Chung's message of "Wed,
	19 Sep 2012 16:43:59 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

Hi,

On Wed, Sep 19 2012, Jaehoon Chung wrote:
> Looks good to me.
>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, pushed to mmc-next for 3.7.  (The patch didn't merge cleanly
so I applied it by hand; let me know if anything looks wrong.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
