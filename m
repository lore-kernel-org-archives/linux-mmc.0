From: Saeed Bishara <saeed@marvell.com>
Subject: RE: [PATCH v3 2/2] [ARM] Dove: rename SDCHI devices to "sdhci-dove"
Date: Thu, 28 Oct 2010 14:28:23 +0200
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FE14774394C@IL-MB01.marvell.com>
References: <cover.1288268453.git.mike@compulab.co.il>
 <0fa1fabd6da74c84e98a44ecfad099f207154aa7.1288268453.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35175 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754250Ab0J1M2q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Oct 2010 08:28:46 -0400
In-Reply-To: <0fa1fabd6da74c84e98a44ecfad099f207154aa7.1288268453.git.mike@compulab.co.il>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>

 

>-----Original Message-----
>From: Mike Rapoport [mailto:mike@compulab.co.il] 
>Sent: Thursday, October 28, 2010 2:25 PM
>To: linux-mmc@vger.kernel.org
>Cc: linux-arm-kernel@lists.infradead.org; Chris Ball; Saeed 
>Bishara; Mike Rapoport
>Subject: [PATCH v3 2/2] [ARM] Dove: rename SDCHI devices to 
>"sdhci-dove"
>
>Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>CC: Saeed Bishara <saeed@marvell.com>
>---
> arch/arm/mach-dove/common.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
>index f7a1258..fe627ab 100644
>--- a/arch/arm/mach-dove/common.c
>+++ b/arch/arm/mach-dove/common.c
>@@ -770,7 +770,7 @@ static struct resource dove_sdio0_resources[] = {
> };
> 
> static struct platform_device dove_sdio0 = {
>-	.name		= "sdhci-mv",
>+	.name		= "sdhci-dove",
> 	.id		= 0,
> 	.dev		= {
> 		.dma_mask		= &sdio_dmamask,
>@@ -798,7 +798,7 @@ static struct resource dove_sdio1_resources[] = {
> };
> 
> static struct platform_device dove_sdio1 = {
>-	.name		= "sdhci-mv",
>+	.name		= "sdhci-dove",
> 	.id		= 1,
> 	.dev		= {
> 		.dma_mask		= &sdio_dmamask,
>-- 
>1.7.3.1
>
>
Looks fine to me