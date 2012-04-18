From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 2/4] mmc: include cd-gpio.h in the source file
Date: Thu, 19 Apr 2012 08:08:46 +0900
Message-ID: <CAKYAXd9petUQETo4cc5aq-U0ngBb6fRZVEtaxomnBgaqBE6-8w@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
	<1334319854-5989-3-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39400 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab2DRXIr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 19:08:47 -0400
Received: by wgbdr13 with SMTP id dr13so7997510wgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 16:08:46 -0700 (PDT)
In-Reply-To: <1334319854-5989-3-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

2012/4/13 Venkatraman S <svenkatr@ti.com>:
> Include the corresponding header file in cd-gpio.c
> for prototype consistency. This gets rid of some
> sparse warnings.
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
This patch is same with H Hartley Sweeten's patch ([PATCH v2] mmc:
cd-gpio.c: Include header to pickup exported symbol prototypes)
Thanks.

> ---
>
