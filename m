From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/3 v2] mmc: atmel-mci: New MCI2 module support in atmel-mci
 driver
Date: Mon, 02 Nov 2009 18:18:30 +0100
Message-ID: <4AEF1466.8090203@atmel.com>
References: <20090930155557.7dae503b@hskinnemoen-d830> <af570068c8bd25f207dd3a43b8acd7cf645b21af.1256314995.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756242AbZKBRTG@vger.kernel.org>
In-Reply-To: <af570068c8bd25f207dd3a43b8acd7cf645b21af.1256314995.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, haavard.skinnemoen@atmel.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel@avr32linux.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

What do you think about the rework of this atmel-mci DMA interface ?
patches:
[PATCH 1/3 v2] atmel-mci: change use of dma slave interface
[PATCH 2/3 v2] mmc: atmel-mci: New MCI2 module support in atmel-mci driver

We may consider them in replacement of the previous ones and dissociate 
this series from the third one which will be reworked and may goes through 
using another path.
(for the record: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc 
driver in at91sam9g45 chip and board).

Thanks,

Bye,
-- 
Nicolas Ferre
