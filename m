Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B32C433FE
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Oct 2021 19:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D3B61038
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Oct 2021 19:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbhJQTXH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 Oct 2021 15:23:07 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59393 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhJQTXG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Oct 2021 15:23:06 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MoOIi-1n4sdL3KUy-00op0j; Sun, 17 Oct 2021 21:20:55 +0200
Received: by mail-wm1-f43.google.com with SMTP id y74-20020a1c7d4d000000b00322f53b9bbfso2761251wmc.3;
        Sun, 17 Oct 2021 12:20:55 -0700 (PDT)
X-Gm-Message-State: AOAM53356OjVtO/zPybDPxI7wLLqd9HwheudfyR0lv5V+4c5r0jQfjKe
        Y8oVPtvNqApXxQ7znkqpCRTAndzIDdV0xoI4nJM=
X-Google-Smtp-Source: ABdhPJyUlFebsGacqn/DbORh+me3VGF2rJiA/LeldArqxN3agfF/M3+TgUm3ShSK4jjOvlyCwRLNkS5pXcgtKPXtbJI=
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr27612763wma.98.1634498455480;
 Sun, 17 Oct 2021 12:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211017175949.23838-1-rdunlap@infradead.org>
In-Reply-To: <20211017175949.23838-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 17 Oct 2021 21:20:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1WHPnLNE7=4872iaVcL708NcVmMhRvAR0OLujP=Y3Tjw@mail.gmail.com>
Message-ID: <CAK8P3a1WHPnLNE7=4872iaVcL708NcVmMhRvAR0OLujP=Y3Tjw@mail.gmail.com>
Subject: Re: [PATCH] mmc: winbond: don't build on M68K
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dgM51z9+nGL2NXo3rQT5QdeK+yEbzUWBb84W2OjKXa0py++sBdC
 SF7zsaIeQ9NJqOZZzIeqgnALDGA+xCEzW1KfxxmenkXzwTCy2MM75vgZNogZbaaygwkFul2
 M0hkS6ypdJs0nRqzEkZE/yqVnkn4nBwFPcVSC+0p11ksoB83iBIxqHHxi1FL8PXwWFWT9+8
 LdgiW/ktnM7ElKQwHnGEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g8yRlhRfXJ8=:ypw0LaBLkhA/Pe0Wmq6fme
 7YagyNTCK1nn/BLLXCA0wEmAECNlo4+JqlEe+vDSKzlXsITqKgLv8vVBTw6d2pYCVaCwVNgfq
 wOqiZ5w44tbnrCRgtPn51SnEul7BYx2b9kX0ZeBwKS/uIzeflCU2urVC1eOrWurVBWrAtI3it
 yUW/e4jgMshCrvcZBGTZuvONfDHuDBQtzfva3VLNi+qkwVI8OacbWq/6HRlDUdu791e97mUn5
 9uKMl1u9Sj6ApVLQ41puW0B+THNeqUEibF6V6ywGLc5k0jLk2IwnICZ5x48gEDoQDUtnGO1kO
 CsI2OqdXL5TGa6GUceFL/T0OUA/Fn/X30d2IPEe1e5UCE9egRbisf2S8ikIggkXZ7JEfAfGgV
 nqz3ed+i0FLoAdD2q1oamd64RkkHb598oDwL4yHsRqA7ou/9FRKrXS+KhAPac8jO+QutJyf2k
 1yuW9ofec5OihMuvl/AxZaF+vdo0W0ysbrQWq4scCPN2GEG1CxsYFZJUMq8Y3OxaKP92HGlW+
 JaJQXYHp+te0X5KFOdzpoNDy9uJii+1WWCBoZXol7drDSWe3Ecl9PJdUsr2+I/dTFySdEO7tk
 AUKV/sQUoyDlTHLkjyw2lb9APerU8eWKQzywWxO/kAGbnC9Je2DHvPAXTTcY9JOklNh16vObM
 oQNYdsfBNJ5WpwPTQtR44/8ZYE9rjidIDk5dISsgcM/X6CznVCbfzUqCgyH/gDsxo5Dbq3YAr
 QJLUex2V/Ssrb+Hg+m6LAnz1KtJ8gLvOM35ORcJkaqVcj/H80cCmGk5sBwWrV57Wj5FLn8C3t
 lBRUkk+MH09LzlWBJugDYRLVPLSeM3KMKY4gq5SmoApR1X2OV7wdC8VVm5EGpdJZO113hBZUf
 /B9y9I57lrgql/OD8J/Q==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Oct 17, 2021 at 7:59 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> The Winbond MMC driver fails to build on ARCH=m68k so prevent
> that build config. Silences these build errors:
>
> ../drivers/mmc/host/wbsd.c: In function 'wbsd_request_end':
> ../drivers/mmc/host/wbsd.c:212:28: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
>   212 |                 dmaflags = claim_dma_lock();
> ../drivers/mmc/host/wbsd.c:215:17: error: implicit declaration of function 'release_dma_lock'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
>   215 |                 release_dma_lock(dmaflags);
>

It looks like m68k and sparc declare this function in asm/floppy.h,
while everyone
else has it in asm/dma.h.

Not sure if it's worth fixing in a better way, but I suspect sparc
would have the
same issue here.

      Arnd
