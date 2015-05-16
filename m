From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2, 1/2] powerpc/dts: add eSDHC compatible list
Date: Fri, 15 May 2015 19:25:10 -0500
Message-ID: <1431735910.3868.213.camel@freescale.com>
References: <1431657962-42443-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0138.outbound.protection.outlook.com ([157.56.111.138]:36779
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934479AbbEPAlW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 May 2015 20:41:22 -0400
In-Reply-To: <1431657962-42443-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc@vger.kernel.org, chrisball@gmail.com

On Fri, 2015-05-15 at 10:46 +0800, Yangbo Lu wrote:
> Add eSDHC compatible list for P2041/P3041/P4080/P5020/P5040.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
>  5 files changed, 5 insertions(+)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott


