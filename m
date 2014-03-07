From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 2/3] regulator: pbias: Convert to use regmap helper functions
Date: Fri, 7 Mar 2014 22:16:10 +0530
Message-ID: <5319F7D2.8040801@ti.com>
References: <1394206897.17867.1.camel@phoenix> <1394206993.17867.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37949 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719AbaCGQq1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Mar 2014 11:46:27 -0500
In-Reply-To: <1394206993.17867.3.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Stefan Roese <sr@denx.de>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Friday 07 March 2014 09:13 PM, Axel Lin wrote:
> This patch converts this driver to use the regmap helper functions provided by
> regulator core.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Balaji T K <balajitk@ti.com>

> ---
>   drivers/regulator/pbias-regulator.c | 74 ++++++++++---------------------------
>   1 file changed, 19 insertions(+), 55 deletions(-)
>
