From: Liu Qiang-B32616 <B32616@freescale.com>
Subject: RE: [PATCH] SD/MMC: fix the issue of SDHC performance regression
Date: Tue, 8 Nov 2011 02:17:58 +0000
Message-ID: <8F012AA59EAB7D4F89C0AE6C20D45709112374@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320658589-13143-1-git-send-email-b32616@freescale.com>
 <m2ipmw133p.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:45856
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214Ab1KHCSD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Nov 2011 21:18:03 -0500
In-Reply-To: <m2ipmw133p.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Li Yang-R58472 <r58472@freescale.com>, Gala Kumar-B11780 <B11780@freescale.com>



-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chris Ball
Sent: Monday, November 07, 2011 9:20 PM
To: Liu Qiang-B32616
Cc: linux-mmc@vger.kernel.org; Li Yang-R58472; Gala Kumar-B11780
Subject: Re: [PATCH] SD/MMC: fix the issue of SDHC performance regression

Hi,

On Mon, Nov 07 2011, Qiang Liu wrote:
> Low performance of SDHC (half of before) due to its frequency was set 
> to 25MHz, but not 50MHz (involved by commit id 
> 013909c4ffd16ded4895528b856fd8782df04dc6,
> add support for query function modes for uhs cards according to 
> Physical Layer SPEC V3.01).
>
> Set high speed max frequency according to response status of CMD6, but 
> not for SPEC Version. Response of switch command is first 
> consideration factor when set SDHC max working frequency. TRAN_SPEED 
> in CSD register will be seemed as the second factor.
>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>

Have you seen:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=f2815f68dabbb373fd1c9f0fd4a609d486697c2b
("mmc: sd: Handle SD3.0 cards not supporting UHS-I bus speed mode")

which is already in mainline?  I think your patch is identical.
[Liu Qiang] Yes, they are identical. Thanks a lot.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


