From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Wed, 18 Jul 2012 19:17:32 +0530
Message-ID: <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
References: <5006571A.7060103@de.bosch.com>
	<CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
	<50068696.8070408@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32828 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab2GRNrd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 09:47:33 -0400
Received: by lbbgm6 with SMTP id gm6so2120176lbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jul 2012 06:47:32 -0700 (PDT)
In-Reply-To: <50068696.8070408@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Behme Dirk (CM-AI/PJ-CF32)" <Dirk.Behme@de.bosch.com>

On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:

> If a SD card is inserted at boot time, its "mmcblk0", the embedded
> MMC (eMMC) device "mmcblk1".  This makes it difficult to give the kernel the
> correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
>
How about  root=UUID=<eMMC-partition>  ?
