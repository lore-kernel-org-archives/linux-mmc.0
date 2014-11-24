From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: RE: [PATCH 3/3] mmc: Support FFU for eMMC v5.0
Date: Mon, 24 Nov 2014 14:23:13 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE64F6D8C0D@SACMBXIP02.sdcorp.global.sandisk.com>
References: <1415896362-28343-1-git-send-email-avi.shchislowski@sandisk.com>
 <loom.20141124T142342-222@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0077.outbound.protection.outlook.com ([65.55.169.77]:38016
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753652AbaKXOXV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 09:23:21 -0500
In-Reply-To: <loom.20141124T142342-222@post.gmane.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bean Huo <bpqw@micron.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Bean Huo
> Sent: Monday, November 24, 2014 3:26 PM
> To: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH 3/3] mmc: Support FFU for eMMC v5.0
> 
> Avi Shchislowski <avi.shchislowski <at> sandisk.com> writes:
> 
> >
> >  Add support of FFU for eMMC v5.0
> >
> > Signed-off-by: Avi Shchislowski <avi.shchislowski <at> sandisk.com>
> > ---
> hi,
> How about your this patch?I think,it'd better be enabled and done in the
> bootloader,just as uboot.
> 
> --
Hi Bean
Vendors will like to use the FFU feature to update the eMMC OTA (over the air)
Other reason is because vendor uses different u-boots it will be hard to maintain the code.

> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
