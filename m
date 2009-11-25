From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v3][mmc/host]:Blackfin SD Host Controller Driver
Date: Wed, 25 Nov 2009 01:07:43 -0500
Message-ID: <8bd0f97a0911242207t6facdec7hdbd6af3181bbbbdb@mail.gmail.com>
References: <1259155212-32369-1-git-send-email-cliffcai.sh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:60838 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZKYGH5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2009 01:07:57 -0500
In-Reply-To: <1259155212-32369-1-git-send-email-cliffcai.sh@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cliffcai.sh@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cliff.cai@analog.com, Bryan Wu <cooloney@kernel.org>

On Wed, Nov 25, 2009 at 08:20,  <cliffcai.sh@gmail.com> wrote:
> --- /dev/null
> +++ b/drivers/mmc/host/bfin_sdh.c
> @@ -0,0 +1,634 @@
> +/*
> + * bfin_sdh.c - Analog Devices Blackfin SDH Controller
> + *
> + * Copyright (C) 2009 Analog Device Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */

any reason you dropped '2007-' ?  we developed the code back then and
certainly have copyright domain over it.
-mike
