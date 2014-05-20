From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] s3cmci: port DMA code to dmaengine API
Date: Tue, 20 May 2014 14:55:40 +0300
Message-ID: <CA+E=qVe0GONTbpe4E_dhg7kwUzG4QpTkxGbBQ2Z00M1B_octQw@mail.gmail.com>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com>
 <6897537.JWQLgZ3Zsx@wuerfel> <CA+E=qVcqO9yaMdJABzQXiG4ikWTaB_XjT7GpD_rH6VTeBXYdKw@mail.gmail.com>
 <6873175.VdOFbJiHYM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51933 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbaETL4A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 May 2014 07:56:00 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp4so349474obc.36
        for <linux-mmc@vger.kernel.org>; Tue, 20 May 2014 04:56:00 -0700 (PDT)
In-Reply-To: <6873175.VdOFbJiHYM@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm-linux <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>

On Tue, May 20, 2014 at 2:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Let's just leave channel number hardcoded, how it was before conversion.
>> It doesn't seem to be a good idea to clean non-DT machine code now, since
>> it's better to put some effort into converting s3c2410 and s3c244{0,2} to DT.
>
> Ok, fair enough.
>
> I'm actually more interested in making s3c24xx multiplatform capable than
> moving it to DT, but we that requires a few other patches as well, and
> we can fix this one along with those.

Hm, but s3c2410, s3c2440 and s3c2442 are armv4t. Is it possible at all
to make them multiplatform?

Regards
Vasily

>         Arnd
