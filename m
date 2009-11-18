From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/3 v2] mmc: atmel-mci: New MCI2 module support in	atmel-mci
 driver
Date: Wed, 18 Nov 2009 14:33:00 +0100
Message-ID: <4B03F78C.6070006@atmel.com>
References: <20090930155557.7dae503b@hskinnemoen-d830>	<af570068c8bd25f207dd3a43b8acd7cf645b21af.1256314995.git.nicolas.ferre@atmel.com> <4AEF1466.8090203@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:56346 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756995AbZKRNdn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Nov 2009 08:33:43 -0500
In-Reply-To: <4AEF1466.8090203@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: haavard.skinnemoen@atmel.com, akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Nicolas Ferre :
> Hi,
> 
> What do you think about the rework of this atmel-mci DMA interface ?
> patches:
> [PATCH 1/3 v2] atmel-mci: change use of dma slave interface
> [PATCH 2/3 v2] mmc: atmel-mci: New MCI2 module support in atmel-mci driver
> 
> We may consider them in replacement of the previous ones and dissociate 
> this series from the third one which will be reworked and may goes through 
> using another path.
> (for the record: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc 
> driver in at91sam9g45 chip and board).

Andrew, Haavard,

Ping ?

-- 
Nicolas Ferre

