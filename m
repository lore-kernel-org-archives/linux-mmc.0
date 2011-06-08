From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/5] ARM: mmp2: update mmp2_defconfig to support mmc
Date: Wed, 8 Jun 2011 17:00:48 +0200
Message-ID: <201106081700.48447.arnd@arndb.de>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com> <1307526121-12059-6-git-send-email-zhangfei.gao@marvell.com> <723849F6A4B5A3408299DF1FFE37CA776C09CFC25F@BGMAIL02.nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54652 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab1FHPA5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 11:00:57 -0400
In-Reply-To: <723849F6A4B5A3408299DF1FFE37CA776C09CFC25F@BGMAIL02.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Nikam <Snikam@nvidia.com>
Cc: 'Zhangfei Gao' <zhangfei.gao@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wednesday 08 June 2011, Sachin Nikam wrote:
> 
> Does anybody knows which kernel version will have the SD 4.0 (UHS-II) support?

The SD 4.0 standard is not yet available, so it cannot be implemented.
I would assume that support will be in the kernel version following the
release of the spec, or one release later if the timing is bad.

If you already have access to the spec, feel free to post patches so
we can include it earlier.

	Arnd
