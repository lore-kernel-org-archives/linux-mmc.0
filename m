From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH v2 0/4] mmc: wii: sdhci controller support
Date: Wed, 16 Dec 2009 23:35:44 +0100
Message-ID: <4B2960C0.1060206@yahoo.es>
References: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es> <20091214224552.GA21934@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp108.mail.ukl.yahoo.com ([77.238.184.40]:28311 "HELO
	smtp108.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932571AbZLPWfv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2009 17:35:51 -0500
In-Reply-To: <20091214224552.GA21934@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

Anton Vorontsov wrote:
> On Mon, Dec 14, 2009 at 11:24:15PM +0100, Albert Herranz wrote:
>> This patch set adds support for the SDHCI controllers found in the
>> "Hollywood" chipset of the Nintendo Wii video game console.
>>
>> First, the existing sdhci-of driver is splitted into a core part and
>> a eSDHC-only part. Then the Nintendo Wii SDHCI support is added as an
>> add-on to that, re-using common code.
> 
> All four patches
> 
> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> 
> Andrew,
> 
> The patches appears to
> 
> - build fine, modular and built-in;
> - sparse clean;
> - checkpatch clean;
> - actually work on a real hardware (tested with eSDHC);
> 
> Would you mind merging them for 2.6.33?
> 

It would be nice, indeed.
Specially now that the Wii patches got pulled in for 2.6.33.

Having SDHCI support enables both storage (mmcblk) and networking (b43-sdio).

> Thanks!
> 

Thanks,
Albert
