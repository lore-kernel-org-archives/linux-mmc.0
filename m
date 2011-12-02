From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Build breakage in sdhci-s3c
Date: Fri, 2 Dec 2011 13:04:12 +0000
Message-ID: <20111202130412.GP8245@opensource.wolfsonmicro.com>
References: <20111202115807.GJ8245@opensource.wolfsonmicro.com>
 <CADPsn1aRwUfP+TjDXisoFqJUxg+H7m+OE3GVBE3PF1JZq-_PfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55203 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756087Ab1LBNEP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 08:04:15 -0500
Content-Disposition: inline
In-Reply-To: <CADPsn1aRwUfP+TjDXisoFqJUxg+H7m+OE3GVBE3PF1JZq-_PfA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sangwook Lee <sangwook.lee@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Dec 02, 2011 at 12:59:42PM +0000, Sangwook Lee wrote:

> and I found out that the following patch wasn't applied This  patch
> was acked by you and Thomas.

> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/7832
> This patch has the title : [PATCH v2 1/2] ARM: SAMSUNG: Add pm_caps
> into platform data

> Could you help me to solve the below problem ?

Probably the simplest/best solution here is for Chris to apply this
patch with Kukjin and Thomas' acks to the mmc tree.
