From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [v5 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Fri, 20 May 2011 05:38:22 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300011BEA692F@SAUSEXMBP01.amd.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
 <1305841590-26963-5-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:15452
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934962Ab1ETKic convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 May 2011 06:38:32 -0400
In-Reply-To: <1305841590-26963-5-git-send-email-andreiw@motorola.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "malchev@google.com" <malchev@google.com>

Hi Andrei,


[...]
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 596d0b9..efff41d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -203,6 +203,13 @@ static int mmc_decode_scr(struct mmc_card *card)
>  	else
>  		card->erased_byte = 0x0;
> 
> +	if (scr->sda_vsn == SCR_SPEC_VER_2) {
> +
> +		/* Check if Physical Layer Spec v3.0X is supported. */
> +		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
> +		if (scr->sda_spec3)
> +			scr->cmds = UNSTUFF_BITS(resp, 32, 2);
> +	}

There is already this condition checking (== SCR_SPEC_VER_2) in mmc_decode_scr(). So can you please make your changes appropriately?

Thanks,
Arindam

