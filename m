From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv2] mmc:Add pointer cast to uintptr_t for slave_id_rx and
 tx in the function, sh_mmcif_request_dma_one
Date: Tue, 21 Jul 2015 09:41:30 +0200
Message-ID: <CAPDyKFqccaucMWPVh6nnqoDcuj5+8nwUGopkMgspvTPF9qgBRQ@mail.gmail.com>
References: <1431366550-22045-1-git-send-email-xerofoify@gmail.com>
	<5589FD65.7040807@gmail.com>
	<1435107273.2504.43.camel@perches.com>
	<7719575.AWrtW5tPaL@wuerfel>
	<55953D85.3000507@gmail.com>
	<CAPDyKFqgo9-kFe+HPqG57m_RJytdT-HsLpF2ZDppWyHmOi8RcA@mail.gmail.com>
	<55AD07E6.1060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AD07E6.1060209@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>
>> Let's follow Arnd's suggestion!
>>
>> Kind regards
>> Uffe
>>
> Uffe,
> I also have this patch lying around and wasn't able to get a reply on it.
> From 0c2cd9c7faecf70a5468659845e3561c4ceb4069 Mon Sep 17 00:00:00 2001
> From: Nicholas Krause <xerofoify@gmail.com>
> Date: Thu, 2 Jul 2015 21:08:18 -0400
> Subject: [PATCH] mmc:Fix refcount leak in the function mmc_queue_resume for the semaphone thread_sem
>

I am working through my backlog, been out of office for a while. I
will come to it soon, sorry for the delay.

Kind regards
Uffe
