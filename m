Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9D47F2CC;
	Fri, 18 Sep 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755780; cv=none; b=jwlF1+IuxHqNtnPtunR1kDOgZsxbwFfXrVCrttQnE186fiqcegcpma/dtPotldPMAfC1wUxcAeN0rabi8apoAhLoqSOiY/EbZCccj9LZ/ctUBK4PjN4xTXR2ZqBldvjwWReKA3u7Y15c6daf+3j4AuPQYo+lzhfnztRY13uFzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755780; c=relaxed/simple;
	bh=DQ11aT6chxj+is/hy9hP1fiwgbDJw2XvIWlCzvNSbts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O5RC3Dbs0eckEahp8bTvRX36/wJlDFtiPnveExAg2RFpu++7ZO7QMNwQFIuq9z26zD19ZQNlDq2DuQ7oiV6ERIdxdQppKvkz6iwNQYmeo0VFLhn6pZwxNQm2lPx0Zk4qmwTrCOGPm+EPUBLnziqDmTHCzhQXOpG56l/CvAuUpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Goiz7D5Y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Goiz7D5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789755778; x=1821291778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DQ11aT6chxj+is/hy9hP1fiwgbDJw2XvIWlCzvNSbts=;
  b=Goiz7D5YCakOnpMdIsnQ5jaGlw1mKVEzFBws+ASbkDepwSCFYZIynLZY
   0+CKB6JNSk2dtSovHZ2oqZ4ABtJZjFDDiy/IYW0/bL6x8TIcVIv2Et1DQ
   yvDu8e7DABN26Apkkzc/B/h/GbQjTCHceRAvkgL8SXz5yk4jiOa8sgr4S
   Z+BNo8KyDIGfYMK7KJp8rhk2IIZqu9AtbF0pZzNOm+/Q9MKJ+AJg7mw+X
   L7ZpbJOgTvAcR7fZ7lCjrxHcFrKyRVX8u0rCXytkYEdmfU49SW5akR3s9
   oNbw0arUy1jQc1iR1rhiiroXvHbo1tqXAAYz/k8HZoo0ElELD0dqaPgAJ
   w==;
X-CSE-ConnectionGUID: 5WHnhQZqR6u+GIxmC7mKRA==
X-CSE-MsgGUID: Ee0zJLNUQYqD92MmQl47ag==
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="73905459"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 11:22:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 11:22:57 -0700
Received: from [10.171.248.88] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 11:22:55 -0700
Message-ID: <70fd2e40-ddc1-4e80-9c4b-cf2fa9c3929e@microchip.com>
Date: Fri, 18 Sep 2026 20:22:54 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: use assign_bit() where applicable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>, Peng Fan <peng.fan@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20260918141810.3023069-1-peng.fan@oss.nxp.com>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <20260918141810.3023069-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 18/09/2026 16:18, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.
> 
> Done with Coccinelle semantic patch and manual fixups.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/mmc/host/atmel-mci.c | 5 +----

Acked-by: Aubin Constans <aubin.constans@microchip.com>

>   drivers/mmc/host/ushc.c      | 5 +----
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 8f4df250a77a..98933be5f174 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1677,10 +1677,7 @@ static void atmci_detect_change(struct timer_list *t)
> 
>                  spin_lock(&host->lock);
> 
> -               if (!present)
> -                       clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
> -               else
> -                       set_bit(ATMCI_CARD_PRESENT, &slot->flags);
> +               assign_bit(ATMCI_CARD_PRESENT, &slot->flags, present);
> 
>                  /* Clean up queue if present */
>                  mrq = slot->mrq;
> diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
> index 7e8af5a06ac9..410e5bb62752 100644
> --- a/drivers/mmc/host/ushc.c
> +++ b/drivers/mmc/host/ushc.c
> @@ -388,10 +388,7 @@ static void ushc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>   {
>          struct ushc_data *ushc = mmc_priv(mmc);
> 
> -       if (enable)
> -               set_bit(INT_EN, &ushc->flags);
> -       else
> -               clear_bit(INT_EN, &ushc->flags);
> +       assign_bit(INT_EN, &ushc->flags, enable);
>   }
> 
>   static void ushc_clean_up(struct ushc_data *ushc)
> --
> 2.51.0
> 

