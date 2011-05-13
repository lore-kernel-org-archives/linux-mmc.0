From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Fri, 13 May 2011 09:47:56 -0400
Message-ID: <m3ei42vhir.fsf@pullcord.laptop.org>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
	<m34o4zwo8t.fsf@pullcord.laptop.org>
	<487EBCAC-1795-4C69-ACDF-99EC9D7BF604@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56197 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab1EMNpl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 May 2011 09:45:41 -0400
In-Reply-To: <487EBCAC-1795-4C69-ACDF-99EC9D7BF604@marvell.com> (Philip
	Rakity's message of "Thu, 12 May 2011 15:58:19 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>

Hi,

On Thu, May 12 2011, Philip Rakity wrote:
> All other platform specific code is in the host/ directory.
>
> This moves it to arch/arm
>
> If that is the direction the group wants to go in --> then the patch
> is fine provided the mmc group can review the patches.  Otherwise they
> are handled by the arm maintainer.

Thanks.  Wolfram, do you have any ideas on what the best design is for
these SoC-specific changes to sdhci-pxa?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
