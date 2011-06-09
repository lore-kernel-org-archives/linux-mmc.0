From: Sachin Nikam <Snikam@nvidia.com>
Subject: RE: [PATCH v4 5/5] ARM: mmp2: update mmp2_defconfig to support mmc
Date: Thu, 9 Jun 2011 10:06:35 +0530
Message-ID: <723849F6A4B5A3408299DF1FFE37CA776C09CFC260@BGMAIL02.nvidia.com>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
 <1307526121-12059-6-git-send-email-zhangfei.gao@marvell.com>
 <723849F6A4B5A3408299DF1FFE37CA776C09CFC25F@BGMAIL02.nvidia.com>
 <201106081700.48447.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:14140 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab1FIEgs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 00:36:48 -0400
In-Reply-To: <201106081700.48447.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Zhangfei Gao' <zhangfei.gao@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Thanks for the reply Arnd.
Sure I will start posting the patches.
Regards,
Sachin Nikam.

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Arnd Bergmann
Sent: Wednesday, June 08, 2011 8:31 PM
To: Sachin Nikam
Cc: 'Zhangfei Gao'; Nicolas Pitre; Philip Rakity; Wolfram Sang; Chris Ball; linux-mmc@vger.kernel.org; Jun Nie; Raymond Wu; Haojian Zhuang; Qiming Wu; Eric Miao; linux-arm-kernel
Subject: Re: [PATCH v4 5/5] ARM: mmp2: update mmp2_defconfig to support mmc

On Wednesday 08 June 2011, Sachin Nikam wrote:
> 
> Does anybody knows which kernel version will have the SD 4.0 (UHS-II) support?

The SD 4.0 standard is not yet available, so it cannot be implemented.
I would assume that support will be in the kernel version following the
release of the spec, or one release later if the timing is bad.

If you already have access to the spec, feel free to post patches so
we can include it earlier.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
