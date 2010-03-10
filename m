From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc
	callback
Date: Wed, 10 Mar 2010 20:50:57 +0530
Message-ID: <618f0c911003100720n78ea2765l287631c85de1fe8@mail.gmail.com>
References: <618f0c911003100611q42e7f23cuc3c8d3f116ca7eb3@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C46F13B4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:61785 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab0CJPU6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2010 10:20:58 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C46F13B4@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>

Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> Venkatraman S
>> Sent: Wednesday, March 10, 2010 7:42 PM
>> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-mmc@vger.kernel.org
>> Cc: Adrian Hunter; Chikkature Rajashekar, Madhusudhan; Tony Lindgren
>> Subject: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc callback
>>
>> See previous post http://patchwork.kernel.org/patch/82907/
>> Rebased to 2.6.34-rc1 and fixed comment alignment.
>>
> Why did you dropped change log in all your patches? You should retain that and
> just change the patch version in the subject.
>

My bad. I just edited the merge commit to point to the previous
threads and posted it.
Should I post them again ?

Thanks and regards,
Venkat.
