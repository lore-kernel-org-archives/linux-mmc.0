From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH] mmc: dw_mmc: Support predefined multiple block
 transfers.
Date: Mon, 26 Sep 2011 09:35:33 -0700 (PDT)
Message-ID: <992253991.685205.1317054932934.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <001901cc7c42$00147c10$003d7430$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:20419 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415Ab1IZQfd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2011 12:35:33 -0400
In-Reply-To: <001901cc7c42$00147c10$003d7430$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, kgene kim <kgene.kim@samsung.com>, dh han <dh.han@samsung.com>, linux-mmc@vger.kernel.org

Hi Seungwon,

----- Original Message -----
> From: "Seungwon Jeon" <tgih.jun@samsung.com>
> To: linux-mmc@vger.kernel.org
> Cc: "Chris Ball" <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, "kgene kim" <kgene.kim@samsung.com>, "dh han"
> <dh.han@samsung.com>, "Seungwon Jeon" <tgih.jun@samsung.com>
> Sent: Monday, September 26, 2011 7:46:59 AM
> Subject: [PATCH] mmc: dw_mmc: Support predefined multiple block transfers.
> 
> This patch adds the support for predefined multiple block read/write.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Without knowing much about dw_mmc host, your logic otherwise looks ok, given what
I've previously done for SDHCI as far as CMD23/Auto-CMD23 enhancement. 
Just curious, what eMMC cards did you test this on, and what improvement did you see?

Acked-by: Andrei Warkentin <andrey.warkentin@gmail.com>

Thanks,
A
