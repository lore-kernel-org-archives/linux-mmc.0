From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Wed, 18 Jul 2012 12:53:18 +0530
Message-ID: <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
References: <5006571A.7060103@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42145 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab2GRHXU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 03:23:20 -0400
Received: by lbbgm6 with SMTP id gm6so1710141lbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jul 2012 00:23:18 -0700 (PDT)
In-Reply-To: <5006571A.7060103@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Wohlrab Knut (CM-AI/PJ-CA33)" <Knut.Wohlrab@de.bosch.com>

On 18 July 2012 11:56, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>
> Similar to [1] we have a device which has two mmc block devices connected:
> One external removable and a second internal hard wired one. Depending on
> the availability of the external removable mmc card at boot time, the
> internal hard wired device becomes mmcblk1 (external mmc card available ==
> mmcblk0) or mmcblk0 if the external one is not there. This order is given by
> the hardware.
>
> With older, non-DT kernels, we used the hack from [2] to control the
> initialization order and force the internal hard wired device to mmcblk0.
>
> Now, we are switching to a newer, DT based kernel. With a DT based kernel
> this hack doesn't seem to work an more.
>
> Any idea how we could influence the initialization order of the mmc block
> devices using a DT based kernel? Ensuring that the internal, hard wired mmc
> card is always mapped to mmcblk0?
>
Doesn't it work by simply by moving the "internal" element before
"external" in the array 'struct twl4030_hsmmc_info mmc[]' ?
