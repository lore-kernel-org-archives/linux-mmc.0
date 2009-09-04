From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP4: MMC driver support on OMAP4
Date: Sat, 5 Sep 2009 00:53:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9B8A526@dbde02.ent.ti.com>
References: <34590.192.168.10.89.1251897876.squirrel@dbdmail.itg.ti.com>
 <20090904121912.4b4e2b5a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35571 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757165AbZIDTYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Sep 2009 15:24:22 -0400
In-Reply-To: <20090904121912.4b4e2b5a.akpm@linux-foundation.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jarkko.lavinen@nokia.com" <jarkko.lavinen@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Andrew/Kishore

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Andrew
>Morton
>Sent: Friday, September 04, 2009 2:19 PM
>
>On Wed, 2 Sep 2009 18:54:36 +0530 (IST)
>"kishore kadiyala" <kishore.kadiyala@ti.com> wrote:
>
>> This Patch adds basic support for all 5 MMC controllers on OMAP4.
>>
>> -Kishore
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> This patch doesn't include mmc-regulator support
>>
>
>This looks like an ARM patch more than an MMC patch.  I grabbed it as
>an MMC thing but hopefully someone else will grab it for a more
>appropriate tree.

A patch split is required:

>>  arch/arm/mach-omap2/devices.c          |   42 +++++++++++++++++++++++++++++----
>>  arch/arm/plat-omap/include/mach/irqs.h |    2 +
>>  arch/arm/plat-omap/include/mach/mmc.h  |    9 ++++++-

These files will go through linux-omap -> arm: to RMK

>>  drivers/mmc/host/Kconfig               |    6 ++--
>>  drivers/mmc/host/omap_hsmmc.c          |   10 +++++++
>>  5 files changed, 60 insertions(+), 9 deletions(-)

These files can go through Andrew.

>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

