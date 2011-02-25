From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v4 5/6] OMAP: adapt hsmmc to hwmod framework
Date: Fri, 25 Feb 2011 22:33:26 +0530
Message-ID: <AANLkTi=A6zihqrCmO-yhH8R=XGTVOYoaUNeM4Tw5qFn1@mail.gmail.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
 <1298575614-9388-6-git-send-email-kishore.kadiyala@ti.com> <20110224233215.GX20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51049 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932635Ab1BYRDs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Feb 2011 12:03:48 -0500
In-Reply-To: <20110224233215.GX20560@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com

On Fri, Feb 25, 2011 at 5:02 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Kishore Kadiyala <kishore.kadiyala@ti.com> [110224 11:17]:
>> Changes involves:
>> 1) Remove controller reset in devices.c which is taken care of
>> =A0 =A0by hwmod framework.
>> 2) Omap2420 platform consists of mmc block as in omap1 and not the
>> =A0 =A0hsmmc block as present in omap2430, omap3, omap4 platforms.
>> =A0 =A0Removing all base address macro defines except keeping one fo=
r OMAP2420.
>> 3) Using omap-device layer to register device and utilizing data fro=
m
>> =A0 =A0hwmod data file for base address, dma channel number, Irq_num=
ber,
>> =A0 =A0device attribute.
>> 4) Update the driver to use dev_attr to find whether controller
>> =A0 =A0supports dual volt cards
>
> This patch is too hard to read. Can you please split it into
> more readable patches?

Posted an updated version.

Regards,
Kishore
